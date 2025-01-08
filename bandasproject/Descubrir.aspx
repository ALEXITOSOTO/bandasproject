<%@ Page Title="Descubrir Conciertos y Música" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Descubrir.aspx.cs" Inherits="bandasproject.Descubrir" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="feed-container">
        <h2 class="page-title">Descubre los Conciertos y Música</h2>
        
        <!-- Controles de búsqueda -->
        <div class="search-container">
            <div class="search-section">
                <asp:TextBox ID="txtBusqueda" runat="server" CssClass="search-input" placeholder="Buscar por nombre..." />
                <asp:DropDownList ID="ddlTipoBusqueda" runat="server" CssClass="search-select">
                    <asp:ListItem Text="Todos" Value="todos" />
                    <asp:ListItem Text="Conciertos" Value="conciertos" />
                    <asp:ListItem Text="Música" Value="musica" />
                </asp:DropDownList>
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="search-button" OnClick="btnBuscar_Click" />
            </div>
        </div>

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
                        <asp:Image ID="imgPortada" runat="server" 
                            ImageUrl='<%# "data:image/png;base64," + Convert.ToBase64String((byte[])Eval("portada_cancion")) %>' 
                            CssClass="img-thumbnail" Width="100px" />
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
            color: black;
            border-radius: 10px;
        }
        .search-container {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f5f5f5;
            border-radius: 10px;
        }
        .search-section {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        .search-input {
            flex: 1;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .search-select {
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .search-button {
            padding: 8px 20px;
            background-color: #0a1175;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .search-button:hover {
            background-color: #034c8c;
        }
    </style>
</asp:Content>