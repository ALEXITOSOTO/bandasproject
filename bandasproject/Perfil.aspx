<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Perfil.aspx.cs" Inherits="bandasproject.Perfil" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="login-div">
        <div class="login-div2">
            <div class="row">
                <div class="col-md-6">
                    <div class="text-center" style="align-items:center;display:grid; place-items:center">
                        <asp:Label ID="lbl_nombre_usuario" runat="server" Text="Nombre" Font-Size="10pt"></asp:Label>
                        <asp:TextBox ID="txt_nombre_usuario" runat="server" CssClass="form-control" BackColor="transparent" BorderColor="transparent" Font-Size="25pt" ForeColor="White"></asp:TextBox><br />
                    </div>
                    <asp:Image ID="Image1" runat="server" ImageUrl="https://fotografias.lasexta.com/clipping/cmsimages02/2019/11/14/66C024AF-E20B-49A5-8BC3-A21DD22B96E6/default.jpg?crop=1300,731,x0,y0&amp" Width="650px" BorderWidth="10px" CssClass="g-0" ImageAlign="Top" /><br />
                    <asp:Button ID="btn_actualizar_usuario" OnClick="btn_actualizar_usuario_Click" runat="server" Text="Actualizar Datos" />
                </div>
                <br />
                <div class="col-md-6">
                    <h1>Datos Personales</h1>
                    <hr />
                    <asp:Label ID="lbl_email_usuario" runat="server" Text="Email"></asp:Label>
                    <asp:TextBox ID="txt_email_usuario" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:Label ID="lbl_telefono_usuario" runat="server" Text="Telefono"></asp:Label>
                    <asp:TextBox ID="txt_telefono_usuario" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:Label ID="lbl_estado_usuario" runat="server" Text="Estado de Perfil"></asp:Label>
                    <asp:TextBox ID="txt_estado_usuario" runat="server" CssClass="form-control" ReadOnly="True"></asp:TextBox>
                    <h1>Datos Adicionales</h1>
                    <hr />
                    <asp:Label ID="lbl_nombre_banda" runat="server" Text="Nombre de Banda"></asp:Label>
                    <asp:TextBox ID="txt_nombre_banda" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:Label ID="lbl_generos_banda" runat="server" Text="Generos de tu Banda"></asp:Label>
                    <asp:TextBox ID="txt_generos_banda" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:Label ID="lbl_slogan_banda" runat="server" Text="Slogan"></asp:Label>
                    <asp:TextBox ID="txt_slogan_banda" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:Label ID="lbl_integrantes_banda" runat="server" Text="N. Integrantes"></asp:Label>
                    <asp:TextBox ID="txt_integrantes_banda" runat="server" CssClass="form-control" 
    Text='<%# Bind("numero_integrantes_banda") %>'
    onkeypress="return (event.charCode >= 48 && event.charCode <= 57)" 
    EnableViewState="true"></asp:TextBox>
                </div>
            </div>
        </div>
    </div>

    <style>
        .login-div2 {
            color: white;
            background-image: linear-gradient(to right, #0a1175 0%, #034c8c 100%);
            width: 100%;
            padding: 10px;
            border-radius: 8px;
        }
    </style>
</asp:Content>
