using System;
using System.Data.SqlClient;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace bandasproject
{
    public partial class CompraBoleto : System.Web.UI.Page
    {
        private string cadenaConexion;
        private SqlConnection conexion;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Inicializar la cadena de conexión
            cadenaConexion = System.Configuration.ConfigurationManager.ConnectionStrings["conexionbddBandas"].ConnectionString;
            conexion = new SqlConnection(cadenaConexion);

            if (!IsPostBack)
            {
                CargarConciertos();
            }
        }

        // Método para cargar los conciertos disponibles en el dropdown
        private void CargarConciertos()
        {
            SqlCommand comando = new SqlCommand("sp_obtener_conciertos", conexion);
            comando.CommandType = CommandType.StoredProcedure;

            try
            {
                conexion.Open();
                SqlDataReader reader = comando.ExecuteReader();

                ddl_conciertos.DataSource = reader;
                ddl_conciertos.DataTextField = "nombre_concierto";
                ddl_conciertos.DataValueField = "id_concierto";
                ddl_conciertos.DataBind();

                reader.Close();
                conexion.Close();
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error al cargar los conciertos: {ex.Message}');</script>");
            }
        }

        // Método para realizar la compra del boleto
        protected void btn_comprar_boleto_Click(object sender, EventArgs e)
        {
            int idConcierto = int.Parse(ddl_conciertos.SelectedValue);
            int cantidadBoleto = int.Parse(txt_cantidad_boleto.Text);

            // Obtener el ID de usuario de la sesión
            int idUsuario = ObtenerUsuarioId();

            if (idUsuario == -1)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            string estadoCompra = "Pendiente"; // O "Pagado", dependiendo del flujo de tu aplicación

            // Registrar la compra en la base de datos
            RegistrarCompra(idUsuario, idConcierto, cantidadBoleto, estadoCompra);
        }

        // Función para registrar la compra de boletos
        public void RegistrarCompra(int idUsuario, int idConcierto, int cantidadBoleto, string estadoCompra)
        {
            SqlCommand comandoInsercion = new SqlCommand("sp_registrar_compra_boleto", conexion);
            comandoInsercion.CommandType = CommandType.StoredProcedure;

            comandoInsercion.Parameters.AddWithValue("@id_usuario", idUsuario);
            comandoInsercion.Parameters.AddWithValue("@id_concierto", idConcierto);
            comandoInsercion.Parameters.AddWithValue("@cantidad_boleto", cantidadBoleto);
            comandoInsercion.Parameters.AddWithValue("@estado_compra", estadoCompra);
            comandoInsercion.Parameters.AddWithValue("@fecha_compra", DateTime.Now);

            try
            {
                conexion.Open();
                comandoInsercion.ExecuteNonQuery(); // Ejecutar el procedimiento almacenado
                conexion.Close();

                lbl_mensaje.Text = "Compra realizada exitosamente. ¡Disfruta el concierto!";

                LimpiarCampos();
            }
            catch (Exception ex)
            {
                lbl_mensaje.Text = $"Error al realizar la compra: {ex.Message}";
                lbl_mensaje.ForeColor = System.Drawing.Color.Red;
            }
        }

        // Método para obtener el ID del usuario autenticado desde la sesión
        private int ObtenerUsuarioId()
        {
            if (Session["UsuarioLogueado"] != null && Session["UsuarioLogueado"] is int)
            {
                return (int)Session["UsuarioLogueado"];
            }
            else
            {
                // Si no hay sesión activa, redirigir a la página de login -dafault
                return -1;
            }
        }

        public void LimpiarCampos()
        {
            txt_cantidad_boleto.Text = string.Empty;
            ddl_conciertos.SelectedIndex = 0;
        }
    }
}
