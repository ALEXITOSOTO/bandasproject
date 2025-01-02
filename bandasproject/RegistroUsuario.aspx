<%@ Page Title="Registro Usuario" Language="C#" AutoEventWireup="true" CodeBehind="RegistroUsuario.aspx.cs" Inherits="bandasproject.RegistroUsuario" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
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
            <form id="form1" runat="server" class="form-container active">
                <h2 class="text-center">Registro Usuario</h2>
                
                <asp:Panel ID="pnlMensajes" runat="server" Visible="false" CssClass="alert alert-danger">
                    <asp:Label ID="lblMensaje" runat="server"></asp:Label>
                </asp:Panel>

                <div class="mb-3">
                    <asp:Label ID="lbl_nombre_usuario" runat="server" Text="Nombre de Usuario:" Font-Bold="True"></asp:Label>
                    <asp:TextBox ID="txt_nombre_usuario" runat="server" placeholder="Ej. Alexander" CssClass="form-control" Required="true"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNombre" runat="server" 
                        ControlToValidate="txt_nombre_usuario" 
                        ErrorMessage="El nombre es requerido" 
                        CssClass="text-danger" Display="Dynamic">
                    </asp:RequiredFieldValidator>
                </div>

                <div class="mb-3">
                    <asp:Label ID="lbl_email_usuario" runat="server" Text="Correo Electrónico:" Font-Bold="True"></asp:Label>
                    <asp:TextBox ID="txt_email_usuario" runat="server" placeholder="Ej. alex@hotmail.com" CssClass="form-control" TextMode="Email" Required="true"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                        ControlToValidate="txt_email_usuario" 
                        ErrorMessage="El email es requerido" 
                        CssClass="text-danger" Display="Dynamic">
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                        ControlToValidate="txt_email_usuario"
                        ErrorMessage="Ingrese un email válido" 
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                        CssClass="text-danger" Display="Dynamic">
                    </asp:RegularExpressionValidator>
                </div>

                <div class="mb-3">
                    <asp:Label ID="lbl_telefono_usuario" runat="server" Text="Teléfono:" Font-Bold="True"></asp:Label>
                    <asp:TextBox ID="txt_telefono_usuario" runat="server" placeholder="Ej. 0991234567" CssClass="form-control" Required="true"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" 
                        ControlToValidate="txt_telefono_usuario" 
                        ErrorMessage="El teléfono es requerido" 
                        CssClass="text-danger" Display="Dynamic">
                    </asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revTelefono" runat="server" 
                        ControlToValidate="txt_telefono_usuario"
                        ErrorMessage="Ingrese un número válido de 10 dígitos" 
                        ValidationExpression="^[0-9]{10}$"
                        CssClass="text-danger" Display="Dynamic">
                    </asp:RegularExpressionValidator>
                </div>

                <div class="mb-3">
                    <asp:Label ID="lbl_contrasena_usuario" runat="server" Text="Contraseña:" Font-Bold="True"></asp:Label>
                    <asp:TextBox ID="txt_contrasena_usuario" runat="server" placeholder="Ingresa una contraseña" CssClass="form-control" TextMode="Password" Required="true"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvContrasena" runat="server" 
                        ControlToValidate="txt_contrasena_usuario" 
                        ErrorMessage="La contraseña es requerida" 
                        CssClass="text-danger" Display="Dynamic">
                    </asp:RequiredFieldValidator>
                </div>

                <div class="d-grid gap-2">
                    <asp:Button ID="btn_crear_usuario" runat="server" Text="Guardar" CssClass="btn btn-primary btn-block" OnClick="btn_crear_usuario_Click" />
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Default.aspx" CssClass="btn btn-secondary btn-block">Volver</asp:HyperLink>
                    <a class="btn btn-primary btn-block" runat="server" href="~/RegistroBanda">Registrarme como Banda</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>