using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace bandasproject
{
    public partial class Concierto : System.Web.UI.Page
    {
        private string cadenaConexion;
        private SqlConnection conexion;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Inicializar la cadena de conexión
            cadenaConexion = System.Configuration.ConfigurationManager.ConnectionStrings["conexionbddBandas"].ConnectionString;
            conexion = new SqlConnection(cadenaConexion);
        }

        protected void btn_crear_concierto_Click(object sender, EventArgs e)
        {
            // Recoger los valores del formulario
            string nombreConcierto = txt_nombre_concierto.Text;
            DateTime fechaConcierto = DateTime.Parse(txt_fecha_concierto.Text);
            string horaConcierto = txt_hora_concierto.Text;
            string lugarConcierto = txt_lugar_concierto.Text;
            decimal precioBoleto = decimal.Parse(txt_precio_boleto.Text);
            int cantidadBoleto = int.Parse(txt_cantidad_boleto.Text);
            string descripcionConcierto = txt_descripcion_concierto.Text;

            // Llamar al método para insertar el concierto
            CrearConcierto(nombreConcierto, fechaConcierto, horaConcierto, lugarConcierto, precioBoleto, cantidadBoleto, descripcionConcierto);
        }

        public void CrearConcierto(string nombre, DateTime fecha, string hora, string lugar, decimal precio, int cantidad, string descripcion)
        {
            SqlCommand comandoInsercion = new SqlCommand("sp_crear_concierto", conexion);
            comandoInsercion.CommandType = CommandType.StoredProcedure;

            comandoInsercion.Parameters.AddWithValue("@nombre_concierto", nombre);
            comandoInsercion.Parameters.AddWithValue("@fecha_concierto", fecha);
            comandoInsercion.Parameters.AddWithValue("@hora_concierto", hora);
            comandoInsercion.Parameters.AddWithValue("@lugar_concierto", lugar);
            comandoInsercion.Parameters.AddWithValue("@precio_boleto", precio);
            comandoInsercion.Parameters.AddWithValue("@cantidad_boleto", cantidad);
            comandoInsercion.Parameters.AddWithValue("@descripcion_concierto", descripcion);

            try
            {
                conexion.Open();
                comandoInsercion.ExecuteNonQuery(); // Ejecutar el procedimiento almacenado
                conexion.Close();
                Response.Write("<script>alert('Concierto creado exitosamente');</script>");
                LimpiarCampos();
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error al crear el concierto: {ex.Message}');</script>");
            }
        }
        public void LimpiarCampos()
        {
            txt_nombre_concierto.Text = string.Empty;
            txt_fecha_concierto.Text = string.Empty;
            txt_hora_concierto.Text = string.Empty;
            txt_lugar_concierto.Text = string.Empty;
            txt_precio_boleto.Text = string.Empty;
            txt_cantidad_boleto.Text = string.Empty;
            txt_descripcion_concierto.Text = string.Empty;
        }
    }
}