using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebGrease.Activities;

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

            if (!IsPostBack)
            {
                // Llamar a un método para cargar los conciertos en el GridView
                CargarConciertos();
            }
        }

        protected void grid_concierto_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                try
                {
                    // Intentar obtener el precio y formatearlo
                    var precioBoletoStr = e.Row.Cells[5].Text; // Asumimos que "Precio Boleto" está en la columna 5

                    // Verificar si el valor no está vacío y si es un número válido
                    if (!string.IsNullOrEmpty(precioBoletoStr) && decimal.TryParse(precioBoletoStr, out decimal precioBoleto))
                    {
                        e.Row.Cells[5].Text = string.Format("{0:C}", precioBoleto); // Formatear como moneda
                    }
                    else
                    {
                        e.Row.Cells[5].Text = "Precio no válido"; // O cualquier mensaje de error apropiado
                    }
                }
                catch (Exception ex)
                {
                    Response.Write($"<script>alert('Error en el formato del precio: {ex.Message}');</script>");
                }
            }
        }
        protected void grid_concierto_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                // Obtener el ID del concierto desde el CommandArgument
                int idConcierto = Convert.ToInt32(e.CommandArgument);

                // Llamar al método para eliminar el concierto
                EliminarConciertoBDD(idConcierto);

                // Recargar los conciertos después de la eliminación
                CargarConciertos();
                grid_concierto.DataBind(); // Asegurarse de que los datos se actualizan
            }
        }
        private void EliminarConciertoBDD(int idConcierto)
        {
            using (SqlCommand comandoEliminar = new SqlCommand("sp_eliminar_concierto", conexion))
            {
                comandoEliminar.CommandType = CommandType.StoredProcedure;
                comandoEliminar.Parameters.AddWithValue("@id_concierto", idConcierto);

                try
                {
                    conexion.Open();
                    int filasAfectadas = comandoEliminar.ExecuteNonQuery();

                    if (filasAfectadas <= 0)
                    {
                        throw new Exception("No se pudo eliminar el concierto.");
                    }
                    else
                    {
                        Response.Write("<script>alert('Concierto eliminado exitosamente');</script>");
                    }
                }
                catch (Exception ex)
                {
                    Response.Write($"<script>alert('Error al eliminar el concierto: {ex.Message}');</script>");
                }
                finally
                {
                    if (conexion.State == ConnectionState.Open)
                        conexion.Close();
                }
            }
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
            int usuarioId = ObtenerUsuarioId();

            SqlCommand comandoInsercion = new SqlCommand("sp_crear_concierto", conexion);
            comandoInsercion.CommandType = CommandType.StoredProcedure;

            comandoInsercion.Parameters.AddWithValue("@nombre_concierto", nombre);
            comandoInsercion.Parameters.AddWithValue("@fecha_concierto", fecha);
            comandoInsercion.Parameters.AddWithValue("@hora_concierto", hora);
            comandoInsercion.Parameters.AddWithValue("@lugar_concierto", lugar);
            comandoInsercion.Parameters.AddWithValue("@precio_boleto", precio);
            comandoInsercion.Parameters.AddWithValue("@cantidad_boleto", cantidad);
            comandoInsercion.Parameters.AddWithValue("@descripcion_concierto", descripcion);
            comandoInsercion.Parameters.AddWithValue("@fk_id_usuario", usuarioId);

            try
            {
                conexion.Open();
                comandoInsercion.ExecuteNonQuery();
                conexion.Close();
                Response.Write("<script>alert('Concierto creado exitosamente');</script>");
                LimpiarCampos();
                CargarConciertos();
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error al crear el concierto: {ex.Message}');</script>");
            }
        }
        public void CargarConciertos()
        {
            SqlCommand comandoConsulta = new SqlCommand("sp_consultar_conciertos", conexion);
            comandoConsulta.CommandType = CommandType.StoredProcedure;

            try
            {
                conexion.Open();
                SqlDataAdapter dataAdapter = new SqlDataAdapter(comandoConsulta);
                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);
                grid_concierto.DataSource = dataTable;
                grid_concierto.DataBind();
                conexion.Close();
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error al cargar los conciertos: {ex.Message}');</script>");
            }
        }
        private int ObtenerUsuarioId()
        {
            if (Session["UsuarioLogueado"] != null && Session["UsuarioLogueado"] is int)
            {
                return (int)Session["UsuarioLogueado"];
            }
            else
            {
                Response.Redirect("Default.aspx");
                return -1;
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
