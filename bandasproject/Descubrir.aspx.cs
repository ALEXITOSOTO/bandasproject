using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace bandasproject
{
    public partial class Descubrir : System.Web.UI.Page
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
                CargarMusica();
            }
        }



        private void CargarConciertos()
        {
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                try
                {
                    using (SqlCommand cmd = new SqlCommand("sp_descubrir_concierto", conexion))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);

                            Response.Write($"<script>console.log('Filas recuperadas de sp_descubrir_concierto: {dt.Rows.Count}');</script>");

                            repeaterConciertos.DataSource = dt;
                            repeaterConciertos.DataBind();
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write($"<script>console.log('Error en CargarConciertos: {ex.Message}');</script>");
                    Response.Write($"<script>alert('Error al cargar conciertos: {ex.Message}');</script>");
                }
            }
        }

        private void CargarMusica()
        {
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                try
                {
                    using (SqlCommand cmd = new SqlCommand("sp_descubrir_cancion", conexion))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);

                            Response.Write($"<script>console.log('Filas recuperadas de sp_descubrir_cancion: {dt.Rows.Count}');</script>");

                            repeaterMusica.DataSource = dt;
                            repeaterMusica.DataBind();
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write($"<script>console.log('Error en CargarMusica: {ex.Message}');</script>");
                    Response.Write($"<script>alert('Error al cargar música: {ex.Message}');</script>");
                }
            }
        }
    }
}