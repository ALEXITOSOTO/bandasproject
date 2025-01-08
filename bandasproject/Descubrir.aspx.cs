using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace bandasproject
{
    public partial class Descubrir : System.Web.UI.Page
    {
        private string cadenaConexion;
        private SqlConnection conexion;

        protected void Page_Load(object sender, EventArgs e)
        {
            cadenaConexion = ConfigurationManager.ConnectionStrings["conexionbddBandas"].ConnectionString;
            conexion = new SqlConnection(cadenaConexion);

            if (!IsPostBack)
            {
                CargarConciertos();
                CargarMusica();
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            string terminoBusqueda = txtBusqueda.Text.Trim();
            string tipoBusqueda = ddlTipoBusqueda.SelectedValue;

            if (tipoBusqueda == "todos" || tipoBusqueda == "conciertos")
            {
                CargarConciertos(terminoBusqueda);
            }

            if (tipoBusqueda == "todos" || tipoBusqueda == "musica")
            {
                CargarMusica(terminoBusqueda);
            }
        }

        private void CargarConciertos(string filtro = "")
        {
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                try
                {
                    using (SqlCommand cmd = new SqlCommand("sp_descubrir_concierto", conexion))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        if (!string.IsNullOrEmpty(filtro))
                        {
                            cmd.Parameters.AddWithValue("@filtro", filtro);
                        }

                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            repeaterConciertos.DataSource = dt;
                            repeaterConciertos.DataBind();
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write($"<script>console.log('Error en CargarConciertos: {ex.Message}');</script>");
                }
            }
        }

        private void CargarMusica(string filtro = "")
        {
            using (SqlConnection conexion = new SqlConnection(cadenaConexion))
            {
                try
                {
                    using (SqlCommand cmd = new SqlCommand("sp_descubrir_cancion", conexion))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        if (!string.IsNullOrEmpty(filtro))
                        {
                            cmd.Parameters.AddWithValue("@filtro", filtro);
                        }

                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            adapter.Fill(dt);
                            repeaterMusica.DataSource = dt;
                            repeaterMusica.DataBind();
                        }
                    }
                }
                catch (Exception ex)
                {
                    Response.Write($"<script>console.log('Error en CargarMusica: {ex.Message}');</script>");
                }
            }
        }
    }
}