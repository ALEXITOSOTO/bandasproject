<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CompraBoleto.aspx.cs" Inherits="bandasproject.CompraBoleto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="login-div">
        <div class="login-div2">
            <h2>Compra de Boletos</h2>
            <asp:Label ID="lbl_concierto" runat="server" Text="Busca y selecciona el concierto"></asp:Label>
            <asp:DropDownList ID="ddl_conciertos" runat="server" CssClass="form-control" AutoPostBack="true">
                <asp:ListItem Text="Seleccione un concierto" Value="0" />
            </asp:DropDownList><br />

            <asp:Label ID="lbl_cantidad_boleto" runat="server" Text="Cantidad de boletos a adquirir"></asp:Label>
            <asp:TextBox ID="txt_cantidad_boleto" runat="server" CssClass="form-control"></asp:TextBox><br />

            <asp:Button ID="btn_comprar_boleto" runat="server" Text="Comprar Boleto" CssClass="btn btn-primary" OnClick="btn_comprar_boleto_Click" />

            <asp:Label ID="lbl_mensaje" runat="server" ForeColor="Green"></asp:Label>
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
