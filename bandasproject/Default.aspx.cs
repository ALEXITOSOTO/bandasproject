using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace bandasproject
{
    public partial class _Default : Page
    {
        // Variables de clase
        private string cadenaConexion;
        private SqlConnection conexion;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Inicializar conexión
            cadenaConexion = ConfigurationManager.ConnectionStrings["conexionbddBandas"].ConnectionString;
            conexion = new SqlConnection(cadenaConexion);

            if (!IsPostBack)
            {
                
            }
        }

        protected void btn_iniciar_Click(object sender, EventArgs e)
        {
            string usuario = txt_usuario.Text;
            string contrasena = txt_contrasena.Text;

            if (ValidarUsuario(usuario, contrasena))
            {
                Response.Redirect("Cancion.aspx");
            }
            else
            {
                // Mostrar mensaje de error
                Response.Write("<script>alert('Usuario o contraseña incorrectos');</script>");
            }
        }

        public bool ValidarUsuario(string usuario, string contrasena)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(cadenaConexion))
                {
                    using (SqlCommand comandoLogin = new SqlCommand("sp_login", connection))
                    {
                        comandoLogin.CommandType = CommandType.StoredProcedure;
                        comandoLogin.Parameters.AddWithValue("@nombre_usuario", usuario);
                        comandoLogin.Parameters.AddWithValue("@contrasena_usuario", contrasena);

                        connection.Open(); // Abrir conexión
                        using (SqlDataReader reader = comandoLogin.ExecuteReader())
                        {
                            if (reader.HasRows) // Si el usuario es válido
                            {
                                // Guardar en sesión el nombre de usuario
                                Session["UsuarioLogueado"] = usuario;
                                return true;
                            }
                            else
                            {
                                return false; // Si usuario no vale
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Tienes un error: " + ex.Message); // Error en consola
                Response.Write($"<script>alert('Error: {ex.Message}');</script>"); // Mostrar en el navegador
                return false;
            }
        }

    }
}
