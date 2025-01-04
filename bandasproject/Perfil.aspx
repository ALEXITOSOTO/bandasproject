<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Perfil.aspx.cs" Inherits="bandasproject.Perfil" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="login-div">
            <div class="login-div2">
                <h1>Mi Perfil</h1>
                <asp:Label ID="lbl_nombre_usuario" runat="server" Text="Nombre"></asp:Label>
                <asp:TextBox ID="txt_nombre_usuario" runat="server" CssClass="form-control" ></asp:TextBox>
                <asp:Label ID="lbl_email_usuario" runat="server" Text="Email"></asp:Label>
                <asp:TextBox ID="txt_email_usuario" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:Label ID="lbl_telefono_usuario" runat="server" Text="Telefono"></asp:Label>
                <asp:TextBox ID="txt_telefono_usuario" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:Label ID="lbl_estado_usuario" runat="server" Text="Estado de Perfil"></asp:Label>
                <asp:TextBox ID="txt_estado_usuario" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:Label ID="lbl_nombre_banda" runat="server" Text="Nombre de Banda"></asp:Label>
                <asp:TextBox ID="txt_nombre_banda" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:Label ID="lbl_generos_banda" runat="server" Text="Generos de tu Banda"></asp:Label>
                <asp:TextBox ID="txt_generos_banda" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:Label ID="lbl_slogan_banda" runat="server" Text="Slogan"></asp:Label>
                <asp:TextBox ID="txt_slogan_banda" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:Label ID="lbl_integrantes_banda" runat="server" Text="N. Integrantes"></asp:Label>
                <asp:TextBox ID="txt_integrantes_banda" runat="server" CssClass="form-control"></asp:TextBox>
                <br />
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
