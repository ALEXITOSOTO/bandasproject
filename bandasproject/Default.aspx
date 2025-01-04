<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="bandasproject._Default" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <title>Inicio de sesión</title>
</head>
<body> 
    <form id="form1" runat="server">
        <div class="login-div"> 
            <div class="login-div2"> 
                <h1 class="titulo text-center">Inicio de sesión</h1> 
                <h5 class="text-center">Ingresa tu usuario y contraseña</h5> 
                <div class="text-center">
                    <img src="https://cdn-icons-png.flaticon.com/512/1754/1754185.png" alt="Bandas" style="width: 50%; height: auto;"/> 
                </div>
                <div class="mb-3">
                    <asp:Label ID="lbl_usuario" runat="server" Text="Usuario" CssClass="form-label"></asp:Label>
                    <asp:TextBox ID="txt_usuario" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="mb-3">
                    <asp:Label ID="lbl_contrasena" runat="server" Text="Contraseña" CssClass="form-label"></asp:Label>
                    <asp:TextBox ID="txt_contrasena" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                </div>
                <div class="text-center">
                    <asp:Button ID="btn_iniciar" runat="server" Text="Iniciar Sesión" OnClick="btn_iniciar_Click" CssClass="btn btn-primary" />
                    <a class="btn btn-secondary" href="RegistroUsuario.aspx">Registrarme</a>
                </div>
            </div> 
        </div>
    </form>
</body>
<style>
    body {
        background-image: linear-gradient(to right, #1f2def 0%, #0083f5 100%);
    }
    .login-div {
        display: flex;
        align-items: center; 
        justify-content: center; 
        height: 100vh;
    }
    .login-div2 {
        color: white;
        background-image: linear-gradient(to right, #0a1175 0%, #034c8c 100%);
        width: 70vh; 
        padding: 20px; 
        border-radius: 8px;
    }
</style>
</html>
