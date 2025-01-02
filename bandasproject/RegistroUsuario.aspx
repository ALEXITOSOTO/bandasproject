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
        }
        .form-container {
            display: none;
            color: white;
            background-image: linear-gradient(to right, #0a1175 0%, #034c8c 100%);
            width: 70vh;
            padding: 20px;
            border-radius: 8px;
        }
        .active {
            display: block;
        }
        .login-div {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-div">
            <div id="form1" class="form-container active">
                <h2 class="text-center">Registro Usuario</h2>
                <form runat="server">
                    <asp:Label ID="lbl_nombre_usuario" runat="server" Text="Nombre de Usuario:" Font-Bold="True"></asp:Label>
                    <asp:TextBox ID="txt_nombre_usuario" runat="server" placeholder="Ej. Alexander" CssClass="form-control" ReadOnly="False"></asp:TextBox>
                    <br />

                    <asp:Label ID="lbl_email_usuario" runat="server" Text="Correo Electrónico:" Font-Bold="True"></asp:Label>
                    <asp:TextBox ID="txt_email_usuario" runat="server" placeholder="Ej. alex@hotmail.com" CssClass="form-control" ReadOnly="False"></asp:TextBox>
                    <br />

                    <asp:Label ID="lbl_telefono_usuario" runat="server" Text="Teléfono:" Font-Bold="True"></asp:Label>
                    <asp:TextBox ID="txt_telefono_usuario" runat="server" placeholder="Ej. 0991234567" CssClass="form-control" ReadOnly="False"></asp:TextBox>
                    <br />

                    <asp:Label ID="lbl_contrasena_usuario" runat="server" Text="Contraseña:" Font-Bold="True"></asp:Label>
                    <asp:TextBox ID="txt_contrasena_usuario" runat="server" placeholder="Ingresa una contraseña" CssClass="form-control mb-3" TextMode="Password" ReadOnly="False"></asp:TextBox>

                    <asp:Button ID="btn_guardar_usuario" runat="server" Text="Guardar" CssClass="btn btn-primary" />
                    <asp:HyperLink ID="hl_banda" runat="server" NavigateUrl="~/RegistroBanda.aspx" CssClass="btn btn-primary">Registrarme como Banda</asp:HyperLink>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Default.aspx" CssClass="btn btn-secondary">Volver</asp:HyperLink>

                </form>
                
            </div>
        </div>
    </div>
</body>
</html>
