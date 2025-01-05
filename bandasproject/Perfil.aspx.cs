using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace bandasproject
{
    public partial class Perfil : System.Web.UI.Page
    {
        string cadenaConexion;
        SqlConnection conexion;

        protected void Page_Load(object sender, EventArgs e)
        {
            this.cadenaConexion = ConfigurationManager.ConnectionStrings["conexionbddBandas"].ConnectionString;
            this.conexion = new SqlConnection(cadenaConexion);

            if (Session["UsuarioLogueado"] == null)
            {
                Response.Redirect("~/Default.aspx");
            }
            else
            {
                int usuarioId = (int)Session["UsuarioLogueado"]; // Usar el ID de usuario

                if (!IsPostBack)
                {
                    CargarDatosPerfil(usuarioId);
                }
            }
        }

        public void CargarDatosPerfil(int usuarioId)
        {
            SqlCommand comando = new SqlCommand("sp_ver_perfil", conexion);
            comando.CommandType = CommandType.StoredProcedure;
            comando.Parameters.AddWithValue("@id_usuario", usuarioId);  // Usar el ID del usuario

            try
            {
                using (this.conexion)
                {
                    this.conexion.Open();
                    using (SqlDataReader reader = comando.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Asignar los valores a los controles
                            txt_nombre_usuario.Text = reader["nombre_usuario"].ToString();
                            txt_email_usuario.Text = reader["email_usuario"].ToString();
                            txt_telefono_usuario.Text = reader["telefono_usuario"].ToString();
                            txt_estado_usuario.Text = reader["estado_usuario"].ToString();
                            txt_nombre_banda.Text = reader["nombre_banda"]?.ToString();
                            txt_generos_banda.Text = reader["generos_banda"]?.ToString();
                            txt_slogan_banda.Text = reader["slogan_banda"]?.ToString();
                            txt_integrantes_banda.Text = reader["numero_integrantes_banda"]?.ToString();
                        }
                        else
                        {
                            Response.Write("<script>alert('No se encontraron datos para este usuario.');</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error al cargar datos del perfil: {ex.Message}');</script>");
            }
        }

        protected void btn_actualizar_usuario_Click(object sender, EventArgs e)
        {
            try
            {
                // Obtener el ID de usuario de la sesión (debe ser un entero)
                int usuarioActual = (int)Session["UsuarioLogueado"];

                if (usuarioActual == 0) // Si no existe un ID válido en sesión
                {
                    Response.Write("<script>alert('No hay usuario en sesión');</script>");
                    return;
                }

                string nombreUsuario = txt_nombre_usuario.Text;
                string emailUsuario = txt_email_usuario.Text;
                string telefonoUsuario = txt_telefono_usuario.Text;
                string estadoUsuario = txt_estado_usuario.Text;
                string nombreBanda = txt_nombre_banda.Text;
                string generosBanda = txt_generos_banda.Text;
                string sloganBanda = txt_slogan_banda.Text;
                string textoIntegrantes = txt_integrantes_banda.Text;

                int integrantesBanda;
                if (!int.TryParse(textoIntegrantes, out integrantesBanda))
                {
                    Response.Write("<script>alert('Error: El valor de integrantes no es válido');</script>");
                    return;
                }

                using (SqlConnection conn = new SqlConnection(cadenaConexion))
                {
                    conn.Open();
                    using (SqlCommand comando = new SqlCommand("sp_actualizar_perfil", conn))
                    {
                        comando.CommandType = CommandType.StoredProcedure;

                        comando.Parameters.AddWithValue("@id_usuario", usuarioActual);  // Usar el ID de usuario (int)
                        comando.Parameters.AddWithValue("@nombre_usuario", nombreUsuario);
                        comando.Parameters.AddWithValue("@email_usuario", emailUsuario);
                        comando.Parameters.AddWithValue("@telefono", telefonoUsuario);
                        comando.Parameters.AddWithValue("@estado_usuario", estadoUsuario);
                        comando.Parameters.AddWithValue("@nombre_banda", string.IsNullOrEmpty(nombreBanda) ? DBNull.Value : (object)nombreBanda);
                        comando.Parameters.AddWithValue("@generos_banda", string.IsNullOrEmpty(generosBanda) ? DBNull.Value : (object)generosBanda);
                        comando.Parameters.AddWithValue("@slogan_banda", string.IsNullOrEmpty(sloganBanda) ? DBNull.Value : (object)sloganBanda);
                        comando.Parameters.AddWithValue("@numero_integrantes_banda", integrantesBanda);

                        try
                        {
                            var result = comando.ExecuteNonQuery();

                            if (result > 0)
                            {
                                Response.Write("<script>alert('Perfil actualizado correctamente');</script>");
                                Response.Redirect(Request.RawUrl);  // Recargar la página actual para ver los cambios
                            }
                            else
                            {
                                Response.Write("<script>alert('No se pudo actualizar el perfil. Usuario no encontrado.');</script>");
                            }
                        }
                        catch (SqlException sqlEx)
                        {
                            Response.Write($"<script>alert('Error SQL: {sqlEx.Message}');</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write($"<script>alert('Error general: {ex.Message}');</script>");
            }
        }
    }
}
