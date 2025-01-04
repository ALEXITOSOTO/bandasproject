<%@ Page Title="Descubrir Conciertos y Música" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Descubrir.aspx.cs" Inherits="bandasproject.Descubrir" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="feed-container">
        <h2 class="page-title">Descubre los Conciertos y Música</h2>
        
        <!-- Sección de Conciertos -->
        <div class="section-title">Próximos Conciertos</div>
        <asp:Repeater ID="repeaterConciertos" runat="server">
            <ItemTemplate>
                <div class="feed-item">
                    <div class="concert-info">
                        <h3><%# Eval("nombre_concierto") %></h3>
                        <p>Fecha: <%# Convert.ToDateTime(Eval("fecha_concierto")).ToString("dd/MM/yyyy") %></p>
                        <p>Hora: <%# Eval("hora_concierto") %></p>
                        <p>Lugar: <%# Eval("lugar_concierto") %></p>
                        <p>Precio: $<%# Eval("precio_boleto") %></p>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <!-- Sección de Música -->
        <div class="section-title">Músicas</div>
        <asp:Repeater ID="repeaterMusica" runat="server">
            <ItemTemplate>
                <div class="feed-item">
                    <div class="music-info">
                        <h3><%# Eval("nombre_cancion") %></h3>
                        <p>Autor: <%# Eval("autor_cancion") %></p>
                        <img src='<%# Eval("portada_cancion") %>' alt="Portada" class="music-cover"/>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <style>
        .feed-container {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
        }

        .section-title {
            font-size: 20px;
            margin: 20px 0;
            padding: 10px;
            background-image: linear-gradient(to right, #0a1175 0%, #034c8c 100%);
            color: white;
        }

        .feed-item {
            background-color: white;
            margin-bottom: 15px;
            padding: 15px;
            border: 3px solid #0a1175;
            color:black;
            border-radius: 10px;
        }



    </style>
</asp:Content>