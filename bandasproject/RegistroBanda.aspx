<%@ Page Title="Registro Usuario" Language="C#" AutoEventWireup="true" CodeBehind="RegistroUsuario.aspx.cs" Inherits="bandasproject.Contact" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
        body {
            background-image: linear-gradient(to right, #1f2def 0%, #0083f5 100%);
            color: white;
        }
        .form-container {
            background-color: rgba(10, 17, 117, 0.9);
            border-radius: 8px;
            padding: 20px;
            max-width: 800px;
        }
        .form-header {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="form-container">
            <h2 class="form-header text-center">Registro de Banda</h2>
            <form runat="server">
                <div class="row">
                    <div class="col-md-6">
                        <asp:Label ID="lbl_nombre_usuario" runat="server" Text="Nombre de Usuario:" Font-Bold="True"></asp:Label>
                        <asp:TextBox ID="txt_nombre_usuario" runat="server" placeholder="Ej. Alexander" CssClass="form-control mb-3" ReadOnly="False"></asp:TextBox>
                        
                        <asp:Label ID="lbl_email_usuario" runat="server" Text="Correo Electrónico:" Font-Bold="True"></asp:Label>
                        <asp:TextBox ID="txt_email_usuario" runat="server" placeholder="Ej. alex@hotmail.com" CssClass="form-control mb-3" ReadOnly="False"></asp:TextBox>

                        <asp:Label ID="lbl_telefono_usuario" runat="server" Text="Teléfono:" Font-Bold="True"></asp:Label>
                        <asp:TextBox ID="txt_telefono_usuario" runat="server" placeholder="Ej. 0991234567" CssClass="form-control mb-3" ReadOnly="False"></asp:TextBox>

                        <asp:Label ID="lbl_contrasena_usuario" runat="server" Text="Contraseña:" Font-Bold="True"></asp:Label>
                        <asp:TextBox ID="txt_contrasena_usuario" runat="server" placeholder="Ingresa una contraseña" CssClass="form-control mb-3" TextMode="Password" ReadOnly="False"></asp:TextBox>
                    </div>

                    <div class="col-md-6">
                        <asp:Label ID="lbl_nombre_banda" runat="server" Text="Nombre de la Banda:" Font-Bold="True"></asp:Label>
                        <asp:TextBox ID="txt_nombre_banda" runat="server" placeholder="Ej. Los Rolling" CssClass="form-control mb-3" ReadOnly="False"></asp:TextBox>
                        
                        <asp:Label ID="lbl_genero_banda" runat="server" Text="Género Musical:" Font-Bold="True"></asp:Label>
                        <asp:TextBox ID="txt_genero_banda" runat="server" placeholder="Ej. Rock" CssClass="form-control mb-3" ReadOnly="False"></asp:TextBox>

                        <asp:Label ID="lbl_slogan_banda" runat="server" Text="Eslogan de la Banda:" Font-Bold="True"></asp:Label>
                        <asp:TextBox ID="txt_slogan_banda" runat="server" placeholder="Ej. ¡Rockeando sin parar!" CssClass="form-control mb-3" ReadOnly="False"></asp:TextBox>

                        <asp:Label ID="lbl_numero_integrantes_banda" runat="server" Text="Número de Integrantes:" Font-Bold="True"></asp:Label>
                        <asp:TextBox ID="txt_numero_integrantes_banda" runat="server" placeholder="Ej. 5" CssClass="form-control mb-3" TextMode="Number" ReadOnly="False"></asp:TextBox>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <asp:Button ID="btn_guardar" runat="server" Text="Guardar" CssClass="btn btn-primary" />
                    <asp:HyperLink ID="hl_banda" runat="server" NavigateUrl="~/RegistroUsuario.aspx" CssClass="btn btn-primary">Regitrarme como usuario</asp:HyperLink>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
