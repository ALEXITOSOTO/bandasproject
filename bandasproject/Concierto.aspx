<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Concierto.aspx.cs" Inherits="bandasproject.Concierto" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
            <div class="row">
                <div class="col-md-6">
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
                </div>

                <div class="col-md-6">

                    <asp:GridView ID="grid_concierto" runat="server" CssClass="table table-bordered table-striped"
                        AutoGenerateColumns="False" DataKeyNames="id_concierto" OnRowDataBound="grid_concierto_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="id_concierto" HeaderText="ID" SortExpression="id_concierto" />
                            <asp:BoundField DataField="nombre_concierto" HeaderText="Nombre" SortExpression="nombre_concierto" />
                            <asp:BoundField DataField="fecha_concierto" HeaderText="Fecha" SortExpression="fecha_concierto" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="hora_concierto" HeaderText="Hora" SortExpression="hora_concierto" />
                            <asp:BoundField DataField="lugar_concierto" HeaderText="Lugar" SortExpression="lugar_concierto" />
                            <asp:BoundField DataField="precio_boleto" HeaderText="Precio Boleto" SortExpression="precio_boleto" DataFormatString="{0:C}" />
                            <asp:BoundField DataField="cantidad_boleto" HeaderText="Cantidad Boleto" SortExpression="cantidad_boleto" />
                            <asp:BoundField DataField="descripcion_concierto" HeaderText="Descripción" SortExpression="descripcion_concierto" />
                            <asp:TemplateField HeaderText="Acciones">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkEliminar" runat="server" 
                                        CommandName="Eliminar" 
                                        CommandArgument='<%# Eval("id_concierto") %>' 
                                        CssClass="btn btn-danger btn-sm" 
                                        CausesValidation="false"
                                        OnClientClick="return confirm('¿Está seguro de que desea eliminar esta concierto?');">
                                        <i class="fas fa-trash-alt"></i>
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

<style>

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
