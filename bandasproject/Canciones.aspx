<%@ Page Title="Canciones" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Canciones.aspx.cs" Inherits="bandasproject.Canciones" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row">
            <!-- Lista de repertorios -->
            <div class="col-md-6">
                <h3 class="text-white">Mis Repertorios</h3>
            </div>

            <!-- Formulario para subir nuevo disco -->
            <div class="col-md-6">
                <h3 class="text-white text-center">Subir Nuevo Disco</h3>
                <form id="form1" runat="server" class="form-container">
                    <div class="mb-3">
                        <asp:Label ID="lblNombreDisco" runat="server" Text="Nombre del Disco:" Font-Bold="True"></asp:Label>
                        <asp:TextBox ID="txt_nombre_cancion" runat="server" placeholder="Ej. Mi Primer Disco" CssClass="form-control" Required="true"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvNombreDisco" runat="server" 
                            ControlToValidate="txt_nombre_cancion" 
                            ErrorMessage="El nombre del disco es obligatorio" 
                            CssClass="text-danger" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="mb-3">
                        <asp:Label ID="lblDescripcionDisco" runat="server" Text="Descripción:" Font-Bold="True"></asp:Label>
                        <asp:TextBox ID="txtDescripcionDisco" runat="server" placeholder="Descripción breve" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <asp:Label ID="lblAutoresDisco" runat="server" Text="Autor/es:" Font-Bold="True"></asp:Label>
                        <asp:TextBox ID="txtAutoresDisco" runat="server" placeholder="Ej. Banda XYZ" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <asp:Label ID="lblPortadaDisco" runat="server" Text="Portada del Disco:" Font-Bold="True"></asp:Label>
                        <asp:FileUpload ID="fuPortadaDisco" runat="server" CssClass="form-control" />
                    </div>

                    <div class="mb-3">
                        <asp:Label ID="lblArchivoDisco" runat="server" Text="Archivo Multimedia:" Font-Bold="True"></asp:Label>
                        <asp:FileUpload ID="fuArchivoDisco" runat="server" CssClass="form-control" />
                    </div>

                    <div class="d-grid gap-2">
                        <asp:HyperLink ID="hlCancelar" runat="server" NavigateUrl="~/Default.aspx" CssClass="btn btn-secondary btn-block">Cancelar</asp:HyperLink>
                    </div>
                </form>
            </div>
        </div>
    </div>
</asp:Content>
