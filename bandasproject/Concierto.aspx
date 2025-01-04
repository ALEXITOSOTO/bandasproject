<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Concierto.aspx.cs" Inherits="bandasproject.Concierto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="login-div">
        <div class="login-div2">
            <h1>Crear Nuevo Concierto</h1>
            <asp:Label ID="lbl_nombre_concierto" runat="server" Text="Nombre del Concierto"></asp:Label>
            <asp:TextBox ID="txt_nombre_concierto" runat="server" CssClass="form-control"></asp:TextBox>

            <asp:Label ID="lbl_fecha_concierto" runat="server" Text="Fecha del Concierto"></asp:Label>
            <asp:TextBox ID="txt_fecha_concierto" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>

            <asp:Label ID="lbl_hora_concierto" runat="server" Text="Hora del Concierto"></asp:Label>
            <asp:TextBox ID="txt_hora_concierto" runat="server" TextMode="Time" CssClass="form-control"> </asp:TextBox>

            <asp:Label ID="lbl_lugar_concierto" runat="server" Text="Lugar del Concierto"></asp:Label>
            <asp:TextBox ID="txt_lugar_concierto" runat="server" CssClass="form-control"></asp:TextBox>

            <asp:Label ID="lbl_precio_boleto" runat="server" Text="Precio del Boleto $"></asp:Label>
            <asp:TextBox ID="txt_precio_boleto" runat="server" TextMode="Number" CssClass="form-control"></asp:TextBox>

            <asp:Label ID="lbl_cantidad_boleto" runat="server" Text="Cantidad de Boletos"></asp:Label>
            <asp:TextBox ID="txt_cantidad_boleto" runat="server" TextMode="Number" CssClass="form-control"></asp:TextBox>

            <asp:Label ID="lbl_descripcion_concierto" runat="server" Text="Descripción del Concierto"></asp:Label>
            <asp:TextBox ID="txt_descripcion_concierto" runat="server" TextMode="MultiLine" CssClass="form-control"></asp:TextBox> <br />

            <asp:Button ID="btn_crear_concierto" runat="server" Text="Crear Concierto" CssClass="btn btn-primary" OnClick="btn_crear_concierto_Click" />
        </div>
    </div>
<style>
.login-div {
    display: flex;
    align-items: center; 
    justify-content: center; 
}
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
