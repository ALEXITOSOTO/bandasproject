using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace bandasproject
{
    public partial class Cancion : System.Web.UI.Page
    {
        private string cadenaConexion;
        private SqlConnection conexion;

        protected void Page_Load(object sender, EventArgs e)
        {
            cadenaConexion = ConfigurationManager.ConnectionStrings["conexionbddBandas"].ConnectionString;
            conexion = new SqlConnection(cadenaConexion);

            if (!IsPostBack)
            {
                consultarCancionesBDD();
            }
        }

        private void insertarCancionBDD(string nombre, string descripcion, string autor, byte[] portada, byte[] cancion, int id_usuario)
        {
            // Validaciones básicas
            if (string.IsNullOrEmpty(nombre) || string.IsNullOrEmpty(autor))
            {
                throw new ArgumentException("El nombre y autor son obligatorios");
            }

            using (SqlCommand comandoInsercion = new SqlCommand("sp_crear_cancion", conexion))
            {
                comandoInsercion.CommandType = CommandType.StoredProcedure;
                comandoInsercion.Parameters.AddWithValue("@id_usuario", id_usuario);
                comandoInsercion.Parameters.AddWithValue("@nombre", nombre);
                comandoInsercion.Parameters.AddWithValue("@descripcion", descripcion);
                comandoInsercion.Parameters.AddWithValue("@autor", autor);

                if (portada == null || portada.Length == 0)
                    comandoInsercion.Parameters.AddWithValue("@portada", DBNull.Value);
                else
                    comandoInsercion.Parameters.AddWithValue("@portada", portada);

                if (cancion == null || cancion.Length == 0)
                    comandoInsercion.Parameters.AddWithValue("@archivo", DBNull.Value);
                else
                    comandoInsercion.Parameters.AddWithValue("@archivo", cancion);

                try
                {
                    conexion.Open();
                    int resultado = comandoInsercion.ExecuteNonQuery();

                    if (resultado <= 0)
                    {
                        throw new Exception("No se pudo insertar la canción en la base de datos");
                    }
                }
                catch (SqlException ex)
                {
                    throw new Exception($"Error de base de datos: {ex.Message}", ex);
                }
                finally
                {
                    if (conexion.State == ConnectionState.Open)
                        conexion.Close();
                }
            }
        }

        protected void btn_crear_cancion_Click(object sender, EventArgs e)
        {
            lblError.Visible = true;

            try
            {
                if (!fu_archivo_cancion.HasFile)
                {
                    lblError.Text = "Debe seleccionar un archivo de música";
                    return;
                }

                string nombre = txt_nombre_cancion.Text;
                string descripcion = txt_descripcion_cancion.Text;
                string autor = txt_autor_cancion.Text;
                byte[] portada = null;
                if (fu_portada_cancion.HasFile)
                {
                    portada = fu_portada_cancion.FileBytes;
                }

                byte[] cancion = null;
                if (fu_archivo_cancion.HasFile)
                {
                    cancion = fu_archivo_cancion.FileBytes;
                }

                int id_usuario = 1;

                insertarCancionBDD(nombre, descripcion, autor, portada, cancion, id_usuario);
                consultarCancionesBDD();
                LimpiarFormulario();

                lblError.Text = "¡Canción guardada correctamente!";
                lblError.ForeColor = System.Drawing.Color.Green;
            }
            catch (Exception ex)
            {
                lblError.Text = $"Error: {ex.Message}";
                lblError.ForeColor = System.Drawing.Color.Red;
            }
        }

        public void LimpiarFormulario()
        {
            txt_nombre_cancion.Text = string.Empty;
            txt_descripcion_cancion.Text = string.Empty;
            txt_autor_cancion.Text = string.Empty;
        }

        public void consultarCancionesBDD()
        {
            using (SqlCommand comandoConsulta = new SqlCommand("sp_consultar_cancion", conexion))
            {
                comandoConsulta.CommandType = CommandType.StoredProcedure;
                try
                {
                    using (SqlDataAdapter adaptadorCancion = new SqlDataAdapter(comandoConsulta))
                    {
                        DataTable tablaDatos = new DataTable();
                        adaptadorCancion.Fill(tablaDatos);
                        grid_cancion.DataSource = tablaDatos;
                        grid_cancion.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    lblError.Text = "Error al cargar las canciones: " + ex.Message;
                    lblError.Visible = true;
                }
            }
        }

        protected void DownloadMusic(object sender, EventArgs e)
        {
            try
            {
                LinkButton lnkDownload = (LinkButton)sender;
                GridViewRow gridRow = (GridViewRow)((LinkButton)sender).Parent.Parent;

                // Obtener el ID de la canción
                int idCancion = Convert.ToInt32(grid_cancion.DataKeys[gridRow.RowIndex].Value);

                using (SqlCommand cmd = new SqlCommand("SELECT archivo_cancion, nombre_cancion FROM tblCancion WHERE id_cancion = @id", conexion))
                {
                    cmd.Parameters.AddWithValue("@id", idCancion);
                    conexion.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            byte[] bytes = (byte[])reader["archivo_cancion"];
                            string nombreArchivo = reader["nombre_cancion"].ToString() + ".mp3";

                            Response.Clear();
                            Response.ContentType = "audio/mpeg";
                            Response.AddHeader("Content-Disposition", "attachment; filename=" + nombreArchivo);
                            Response.BinaryWrite(bytes);
                            Response.End();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error al descargar la música: " + ex.Message;
                lblError.Visible = true;
            }
            finally
            {
                if (conexion.State == ConnectionState.Open)
                    conexion.Close();
            }
        }

        protected void grid_cancion_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Manejar la imagen de portada
                Image imgPortada = (Image)e.Row.FindControl("imgPortada");
                if (imgPortada != null)
                {
                    byte[] imageBytes = DataBinder.Eval(e.Row.DataItem, "portada_cancion") as byte[];
                    if (imageBytes != null && imageBytes.Length > 0)
                    {
                        string base64String = Convert.ToBase64String(imageBytes);
                        imgPortada.ImageUrl = "data:image/jpeg;base64," + base64String;
                    }
                    else
                    {
                        imgPortada.ImageUrl = "~/Images/default-album.png";
                    }
                }
            }
        }
        private void EliminarCancionBDD(int idCancion)
        {
            using (SqlCommand comandoEliminar = new SqlCommand("sp_eliminar_cancion", conexion))
            {
                comandoEliminar.CommandType = CommandType.StoredProcedure;
                comandoEliminar.Parameters.AddWithValue("@id_cancion", idCancion);

                try
                {
                    conexion.Open();
                    int filasAfectadas = comandoEliminar.ExecuteNonQuery();

                    if (filasAfectadas <= 0)
                    {
                        throw new Exception("No se pudo eliminar la canción.");
                    }
                }
                catch (Exception ex)
                {
                    lblError.Text = "Error al eliminar la canción: " + ex.Message;
                    lblError.Visible = true;
                }
                finally
                {
                    if (conexion.State == ConnectionState.Open)
                        conexion.Close();
                }
            }
        }
        protected void grid_cancion_id(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Eliminar")
            {
                int idCancion = Convert.ToInt32(e.CommandArgument);
                EliminarCancionBDD(idCancion);
                consultarCancionesBDD();
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
                // Si no hay sesión activa, redirigir a la página de login
                return -1;
            }
        }
        protected void btn_actualizar_cancion_Click(object sender, EventArgs e)
        {
            try
            {
                // Validación de campos obligatorios
                if (string.IsNullOrEmpty(txtEditNombreCancion.Text))
                {
                    lblError.Text = "El nombre de la canción es obligatorio.";
                    lblError.Visible = true;
                    return;
                }

                // Obtén los datos del formulario
                int idCancion = int.Parse(hfEditIdCancion.Value);

                using (SqlCommand cmd = new SqlCommand("sp_actualizar_cancion", conexion))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Parámetros básicos
                    cmd.Parameters.Add("@id_cancion", SqlDbType.Int).Value = idCancion;
                    cmd.Parameters.Add("@nombre", SqlDbType.NVarChar, 100).Value = txtEditNombreCancion.Text;

                    // Manejo de descripción
                    var descripcionParam = cmd.Parameters.Add("@descripcion", SqlDbType.NVarChar, 500);
                    if (string.IsNullOrEmpty(txtEditDescripcionCancion.Text))
                    {
                        descripcionParam.Value = DBNull.Value;
                    }
                    else
                    {
                        descripcionParam.Value = txtEditDescripcionCancion.Text;
                    }

                    // Manejo de autor
                    var autorParam = cmd.Parameters.Add("@autor", SqlDbType.NVarChar, 100);
                    if (string.IsNullOrEmpty(txtEditAutorCancion.Text))
                    {
                        autorParam.Value = DBNull.Value;
                    }
                    else
                    {
                        autorParam.Value = txtEditAutorCancion.Text;
                    }

                    cmd.Parameters.Add("@id_usuario", SqlDbType.Int).Value =1;

                    // Manejo de la portada
                    var portadaParam = cmd.Parameters.Add("@portada", SqlDbType.VarBinary, -1);
                    if (fuEditPortada.HasFile)
                    {
                        portadaParam.Value = fuEditPortada.FileBytes;
                    }
                    else
                    {
                        portadaParam.Value = DBNull.Value;
                    }

                    // Manejo del archivo
                    var archivoParam = cmd.Parameters.Add("@archivo", SqlDbType.VarBinary, -1);
                    if (fuEditArchivo.HasFile)
                    {
                        archivoParam.Value = fuEditArchivo.FileBytes;
                    }
                    else
                    {
                        archivoParam.Value = DBNull.Value;
                    }

                    conexion.Open();
                    cmd.ExecuteNonQuery();
                    conexion.Close();

                    // Llamdo de funcion de actualizacion de tabla y muestra de mensaje 
                    consultarCancionesBDD();
                    lblError.Text = "Canción actualizada con éxito.";
                    lblError.Visible = true;
                    lblError.ForeColor = System.Drawing.Color.Green;

                    // Cerrar el moal usando JS
                    ScriptManager.RegisterStartupScript(this, GetType(), "closeModal",
                        "var modal = bootstrap.Modal.getInstance(document.getElementById('editModal')); if(modal) modal.hide();", true);
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error al actualizar la canción: " + ex.Message;
                lblError.Visible = true;
                lblError.ForeColor = System.Drawing.Color.Red;
            }
        }

    }
}