<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cancion.aspx.cs" Inherits="bandasproject.Cancion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <!-- Lista de repertorios -->
            <div class="col-md-6">
                <h3>Mis Repertorios</h3>
                <asp:GridView ID="grid_cancion" runat="server" CssClass="table table-bordered table-striped"
                    AutoGenerateColumns="False" DataKeyNames="id_cancion" 
                    OnRowDataBound="grid_cancion_RowDataBound" 
                    OnRowCommand="grid_cancion_id">
                    <Columns>
                        <asp:BoundField DataField="id_cancion" HeaderText="ID" SortExpression="id_cancion" />
                        <asp:BoundField DataField="nombre_cancion" HeaderText="Nombre" SortExpression="nombre_cancion" />
                        <asp:BoundField DataField="descripcion_cancion" HeaderText="Descripción" SortExpression="descripcion_cancion" />
                        <asp:BoundField DataField="autor_cancion" HeaderText="Autor/es" SortExpression="autor_cancion" />
                        <asp:TemplateField HeaderText="Portada">
                            <ItemTemplate>
                                <asp:Image ID="imgPortada" runat="server" 
                                           ImageUrl='<%# "data:image/png;base64," + Convert.ToBase64String((byte[])Eval("portada_cancion")) %>' 
                                           CssClass="img-thumbnail" Width="100px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Música">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkMusica" runat="server" 
                                               Text="Descargar Música" 
                                               CommandName="DownloadFile" 
                                               CommandArgument='<%# Eval("archivo_cancion") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkEditar" runat="server" 
                CommandName="Editar" 
                CommandArgument='<%# Eval("id_cancion") %>' 
                CssClass="btn btn-primary btn-sm" 
                OnClientClick='<%# "openEditModal(" + Eval("id_cancion") + ",\"" + Eval("nombre_cancion") + "\",\"" + Eval("descripcion_cancion") + "\",\"" + Eval("autor_cancion") + "\"); return false;" %>'>
    <i class="fa-solid fa-pen"></i>
</asp:LinkButton>

                                <asp:LinkButton ID="lnkEliminar" runat="server" 
                                    CommandName="Eliminar" 
                                    CommandArgument='<%# Eval("id_cancion") %>' 
                                    CssClass="btn btn-danger btn-sm" 
                                    CausesValidation="false"
                                    OnClientClick="return confirm('¿Está seguro de que desea eliminar esta canción?');">
                                    <i class="fas fa-trash-alt"></i>
                                </asp:LinkButton>

                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <!-- Formulario para subir nueva música -->
            <div class="col-md-6">
                <div class="login-div">
                    <div class="login-div2">
                        <h1>Sube una Nueva Música</h1>
                        <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="False" />
                        <div class="mb-3">
                            <asp:Label ID="lblNombreCancion" runat="server" Text="Nombre de la Cancion:" Font-Bold="True"></asp:Label>
                            <asp:TextBox ID="txt_nombre_cancion" runat="server" placeholder="Ej. Mi Primera Cancion" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNombreCancion" runat="server" 
                                ControlToValidate="txt_nombre_cancion" 
                                ErrorMessage="El nombre de la canción es obligatorio" 
                                CssClass="text-danger" Display="Dynamic"
                                ValidationGroup="SubirCancion">
                            </asp:RequiredFieldValidator>
                        </div>
                        <div class="mb-3">
                            <asp:Label ID="lblDescripcionCancion" runat="server" Text="Descripción:" Font-Bold="True"></asp:Label>
                            <asp:TextBox ID="txt_descripcion_cancion" runat="server" placeholder="Descripción breve" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <asp:Label ID="lblAutoresCancion" runat="server" Text="Autor/es:" Font-Bold="True"></asp:Label>
                            <asp:TextBox ID="txt_autor_cancion" runat="server" placeholder="Ej. Banda XYZ" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <asp:Label ID="lblPortadaCancion" runat="server" Text="Portada de la Cancion:" Font-Bold="True"></asp:Label>
                            <asp:FileUpload ID="fu_portada_cancion" runat="server" CssClass="form-control" />
                        </div>
                        <div class="mb-3">
                            <asp:Label ID="lblArchivoCancion" runat="server" Text="Archivo Multimedia:" Font-Bold="True"></asp:Label>
                            <asp:FileUpload ID="fu_archivo_cancion" runat="server" CssClass="form-control" />
                        </div>
                        <div class="d-grid gap-2">
                            <asp:Button ID="btn_crear_cancion" runat="server" Text="Subir a Repertorio" CssClass="btn btn-primary btn-block" OnClick="btn_crear_cancion_Click" ValidationGroup="SubirCancion" />
                            <asp:HyperLink ID="hlCancelar" runat="server" NavigateUrl="~/Default.aspx" CssClass="btn btn-secondary btn-block">Cancelar</asp:HyperLink>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal para editar -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Editar Canción</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfEditIdCancion" runat="server" />
                    <div class="mb-3">
                        <label for="editNombreCancion" class="form-label">Nombre de la Canción</label>
                        <asp:TextBox ID="txtEditNombreCancion" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="editDescripcionCancion" class="form-label">Descripción</label>
                        <asp:TextBox ID="txtEditDescripcionCancion" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="editAutorCancion" class="form-label">Autor/es</label>
                        <asp:TextBox ID="txtEditAutorCancion" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="editPortadaCancion" class="form-label">Actualizar Portada</label>
                        <asp:FileUpload ID="fuEditPortada" runat="server" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <label for="editArchivoCancion" class="form-label">Actualizar Archivo</label>
                        <asp:FileUpload ID="fuEditArchivo" runat="server" CssClass="form-control" />
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnGuardarCambios" runat="server" Text="Guardar Cambios" CssClass="btn btn-primary" OnClick="btn_actualizar_cancion_Click" />
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <style>
        .login-div2 {
            color: white;
            background-image: linear-gradient(to right, #0a1175 0%, #034c8c 100%);
            width: 100%; 
            padding: 20px; 
            border-radius: 8px;
            display: grid;
            place-items: center;
        }
    </style>

    <script>
        function openEditModal(id, nombre, descripcion, autor) {
            document.getElementById('<%= hfEditIdCancion.ClientID %>').value = id;
            document.getElementById('<%= txtEditNombreCancion.ClientID %>').value = nombre;
            document.getElementById('<%= txtEditDescripcionCancion.ClientID %>').value = descripcion;
            document.getElementById('<%= txtEditAutorCancion.ClientID %>').value = autor;
            new bootstrap.Modal(document.getElementById('editModal')).show();
        }
    </script>

</asp:Content>
