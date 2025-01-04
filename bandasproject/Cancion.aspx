<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cancion.aspx.cs" Inherits="bandasproject.Cancion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <!-- Lista de repertorios -->
            <div class="col-md-6">
                <h3>Mis Repertorios</h3>
                <asp:GridView ID="grid_cancion" runat="server" CssClass="table table-bordered table-striped" AutoGenerateColumns="False" DataKeyNames="id_cancion" Width="619px" OnRowDataBound="grid_cancion_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="id_cancion" HeaderText="ID" SortExpression="id_cancion" />
                        <asp:BoundField DataField="nombre_cancion" HeaderText="NOMBRE" SortExpression="nombre_cancion" />
                        <asp:BoundField DataField="descripcion_cancion" HeaderText="DESCRIPCION" SortExpression="descripcion_cancion" />
                        <asp:BoundField DataField="autor_cancion" HeaderText="AUTOR/ES" SortExpression="autor_cancion" />
                        <asp:TemplateField HeaderText="PORTADA">
                            <ItemTemplate>
                                <asp:Image ID="imgPortada" runat="server" 
                                           ImageUrl='<%# "data:image/png;base64," + Convert.ToBase64String((byte[])Eval("portada_cancion")) %>' 
                                           CssClass="img-thumbnail" Width="100px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="MUSICA">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkMusica" runat="server" 
                                               Text="Descargar Música" 
                                               CommandName="DownloadFile" 
                                               CommandArgument='<%# Eval("archivo_cancion") %>' 
                                               OnClick="DownloadMusic" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <!-- Formulario para subir nuevo disco -->
            <div class="col-md-6">
                <div class="login-div">
                    <div class="login-div2">
                        <h1>Sube una Nueva Música</h1>
                            <!-- Control para mostrar mensajes de error -->
                            <asp:Label ID="lblError" runat="server" ForeColor="Red" Visible="False" />

                            <div class="mb-3">
                                <asp:Label ID="lblNombreDisco" runat="server" Text="Nombre del Disco:" Font-Bold="True"></asp:Label>
                                <asp:TextBox ID="txt_nombre_cancion" runat="server" placeholder="Ej. Mi Primer Disco" CssClass="form-control"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvNombreDisco" runat="server" 
                                    ControlToValidate="txt_nombre_cancion" 
                                    ErrorMessage="El nombre del disco es obligatorio" 
                                    CssClass="text-danger" Display="Dynamic">
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="mb-3">
                                <asp:Label ID="lblDescripcionDisco" runat="server" Text="Descripción:" Font-Bold="True"></asp:Label>
                                <asp:TextBox ID="txt_descripcion_cancion" runat="server" placeholder="Descripción breve" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="mb-3">
                                <asp:Label ID="lblAutoresDisco" runat="server" Text="Autor/es:" Font-Bold="True"></asp:Label>
                                <asp:TextBox ID="txt_autor_cancion" runat="server" placeholder="Ej. Banda XYZ" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="mb-3">
                                <asp:Label ID="lblPortadaDisco" runat="server" Text="Portada del Disco:" Font-Bold="True"></asp:Label>
                                <asp:FileUpload ID="fu_portada_cancion" runat="server" CssClass="form-control" />
                            </div>

                            <div class="mb-3">
                                <asp:Label ID="lblArchivoDisco" runat="server" Text="Archivo Multimedia:" Font-Bold="True"></asp:Label>
                                <asp:FileUpload ID="fu_archivo_cancion" runat="server" CssClass="form-control" />
                            </div>

                            <div class="d-grid gap-2">
                                <asp:Button ID="btn_crear_cancion" runat="server" Text="Subir a Repertorio" CssClass="btn btn-primary btn-block" OnClick="btn_crear_cancion_Click" />
                                <asp:HyperLink ID="hlCancelar" runat="server" NavigateUrl="~/Default.aspx" CssClass="btn btn-secondary btn-block">Cancelar</asp:HyperLink>
                            </div>
                    </div>
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
