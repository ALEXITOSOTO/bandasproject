<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Concierto.aspx.cs" Inherits="bandasproject.Concierto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-md-6">
            <div class="login-div">
                <div class="login-div2">
                    <h1>Crear Nuevo Concierto</h1>
                    <asp:Label ID="lbl_nombre_concierto" runat="server" Text="Nombre del Concierto"></asp:Label>
                    <asp:TextBox ID="txt_nombre_concierto" runat="server" CssClass="form-control"></asp:TextBox>

                    <asp:Label ID="lbl_fecha_concierto" runat="server" Text="Fecha del Concierto"></asp:Label>
                    <asp:TextBox ID="txt_fecha_concierto" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>

                    <asp:Label ID="lbl_hora_concierto" runat="server" Text="Hora del Concierto"></asp:Label>
                    <asp:TextBox ID="txt_hora_concierto" runat="server" TextMode="Time" CssClass="form-control"></asp:TextBox>

                    <asp:Label ID="lbl_lugar_concierto" runat="server" Text="Lugar del Concierto"></asp:Label>
                    <asp:TextBox ID="txt_lugar_concierto" runat="server" CssClass="form-control"></asp:TextBox>

                    <asp:Label ID="lbl_precio_boleto" runat="server" Text="Precio del Boleto $"></asp:Label>
                    <asp:TextBox ID="txt_precio_boleto" runat="server" TextMode="Number" Step="0.01" CssClass="form-control"></asp:TextBox>

                    <asp:Label ID="lbl_cantidad_boleto" runat="server" Text="Cantidad de Boletos"></asp:Label>
                    <asp:TextBox ID="txt_cantidad_boleto" runat="server" TextMode="Number" CssClass="form-control"></asp:TextBox>

                    <asp:Label ID="lbl_descripcion_concierto" runat="server" Text="Descripción del Concierto"></asp:Label>
                    <asp:TextBox ID="txt_descripcion_concierto" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                    <br />

                    <asp:Button ID="btn_crear_concierto" runat="server" Text="Crear Concierto" CssClass="btn btn-primary" OnClick="btn_crear_concierto_Click" />
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="table table-responsive navbar-nav-scroll">
                <asp:GridView ID="grid_concierto" runat="server" CssClass="table table-bordered table-striped"
                    AutoGenerateColumns="False" DataKeyNames="id_concierto" 
                    OnRowCommand="grid_concierto_RowCommand"
                    OnRowDataBound="grid_concierto_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="id_concierto" HeaderText="ID" SortExpression="id_concierto" />
                        <asp:BoundField DataField="nombre_concierto" HeaderText="Nombre" SortExpression="nombre_concierto" />
                        <asp:BoundField DataField="fecha_concierto" HeaderText="Fecha" SortExpression="fecha_concierto" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="hora_concierto" HeaderText="Hora" SortExpression="hora_concierto" />
                        <asp:BoundField DataField="lugar_concierto" HeaderText="Lugar" SortExpression="lugar_concierto" />
                        <asp:BoundField DataField="precio_boleto" HeaderText="Precio Boleto" SortExpression="precio_boleto" DataFormatString="{0:C}" />
                        <asp:BoundField DataField="cantidad_boleto" HeaderText="Cantidad Boleto" SortExpression="cantidad_boleto" />
                        <asp:BoundField DataField="descripcion_concierto" HeaderText="Descripción" SortExpression="descripcion_concierto" />
                        <asp:TemplateField HeaderText="Acciones">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkEliminar" runat="server" 
                                    CommandName="Eliminar" 
                                    CommandArgument='<%# Eval("id_concierto") %>' 
                                    CssClass="btn btn-danger btn-sm"
                                    OnClientClick="return confirm('¿Está seguro de que desea eliminar este concierto?');">
                                    <i class="fas fa-trash-alt"></i> Eliminar
                                </asp:LinkButton>
                                <asp:LinkButton ID="lnkEditar" runat="server" 
                                    CommandName="Editar" 
                                    CommandArgument='<%# Eval("id_concierto") %>' 
                                    CssClass="btn btn-primary btn-sm">
                                    <i class="fas fa-edit"></i> Editar
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <!-- Modal para editar -->
    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Editar Concierto</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <asp:HiddenField ID="hfEditIdConcierto" runat="server" />
                    
                    <div class="mb-3">
                        <label for="txtEditNombreConcierto" class="form-label">Nombre del Concierto</label>
                        <asp:TextBox ID="txtEditNombreConcierto" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtEditFechaConcierto" class="form-label">Fecha del Concierto</label>
                        <asp:TextBox ID="txtEditFechaConcierto" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtEditHoraConcierto" class="form-label">Hora del Concierto</label>
                        <asp:TextBox ID="txtEditHoraConcierto" runat="server" TextMode="Time" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtEditLugarConcierto" class="form-label">Lugar del Concierto</label>
                        <asp:TextBox ID="txtEditLugarConcierto" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtEditPrecioBoleto" class="form-label">Precio del Boleto $</label>
                        <asp:TextBox ID="txtEditPrecioBoleto" runat="server" TextMode="Number" Step="0.01" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtEditCantidadBoleto" class="form-label">Cantidad de Boletos</label>
                        <asp:TextBox ID="txtEditCantidadBoleto" runat="server" TextMode="Number" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="txtEditDescripcionConcierto" class="form-label">Descripción del Concierto</label>
                        <asp:TextBox ID="txtEditDescripcionConcierto" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
                <div class="modal-footer">
                    <asp:Button ID="btnActualizarConcierto" runat="server" Text="Guardar Cambios" 
                        CssClass="btn btn-primary" OnClick="btn_actualizar_concierto_Click" />
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
            place-items:center;
        }
    </style>
</asp:Content>