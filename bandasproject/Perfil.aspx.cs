using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace bandasproject
{
    public partial class Perfil : System.Web.UI.Page
    {
        // Variables de clase
        string cadenaConexion;
        SqlConnection conexion;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Inicializar conexión
            this.cadenaConexion = ConfigurationManager.ConnectionStrings["conexionbddBandas"].ConnectionString;
            this.conexion = new SqlConnection(cadenaConexion);

            if (Session["UsuarioLogueado"] == null)
            {
                Response.Write("No hay usuario logueado"); 
                Response.Redirect("~/Default.aspx");
            }
            else
            {
                string usuarioLogueado = Session["UsuarioLogueado"].ToString();
                Response.Write("Usuario logueado: " + usuarioLogueado); // Imprimo el usuario
                CargarDatosPerfil(usuarioLogueado);
            }
        }

        public void CargarDatosPerfil(string nombreUsuario)
        {
            SqlCommand comando = new SqlCommand("sp_ver_perfil", conexion);
            comando.CommandType = CommandType.StoredProcedure;
            comando.Parameters.AddWithValue("@nombre_usuario", nombreUsuario);

            try
            {
                this.conexion.Open(); // Abrir conexión
                SqlDataReader reader = comando.ExecuteReader();

                if (reader.Read())
                {
                    // Llenar los campos con los datos obtenidos
                    txt_nombre_usuario.Text = reader["nombre_usuario"].ToString();
                    txt_email_usuario.Text = reader["email_usuario"].ToString();
                    txt_telefono_usuario.Text = reader["telefono_usuario"].ToString();
                    txt_estado_usuario.Text = reader["estado_usuario"].ToString();
                    txt_nombre_banda.Text = reader["nombre_banda"]?.ToString();
                    txt_generos_banda.Text = reader["generos_banda"]?.ToString();
                    txt_slogan_banda.Text = reader["slogan_banda"]?.ToString();
                    txt_integrantes_banda.Text = reader["numero_integrantes_banda"]?.ToString();
                }

                reader.Close();
                this.conexion.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Tienes un error: " + ex.Message); // Error en consola
                Response.Write($"<script>alert('Error al cargar datos del perfil: {ex.Message}');</script>");
            }
        }
    }
}
