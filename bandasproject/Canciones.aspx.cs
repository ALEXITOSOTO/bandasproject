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
    public partial class Canciones : System.Web.UI.Page
    {
        //Variables de la clase
        string cadenaConexion;
        SqlConnection conexion;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Conexion
            this.cadenaConexion = ConfigurationManager.ConnectionStrings["conexionbddBandas"].ConnectionString;
            this.conexion = new SqlConnection(cadenaConexion);
            if (!IsPostBack)
            {

            }
        }
        public void insertarCancionBDD(string nombre, string descripcion, string autor, byte[] portada, byte[]cancion, int id_usuario)
        {
            SqlCommand comandoInsercion = new SqlCommand("sp_crear_cancion", conexion);
            comandoInsercion.CommandType = CommandType.StoredProcedure;
            comandoInsercion.Parameters.AddWithValue("@id_usuario", id_usuario);
            comandoInsercion.Parameters.AddWithValue("@nombre", nombre);
            comandoInsercion.Parameters.AddWithValue("@descripcion", descripcion);
            comandoInsercion.Parameters.AddWithValue("@portada", portada);
            comandoInsercion.Parameters.AddWithValue("@archivo", cancion);
            //Codigo error try catch para que no se cuelgue el sistema
            try
            {
                this.conexion.Open(); //Abrir conexion
                comandoInsercion.ExecuteNonQuery();
                conexion.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Tienes un error" + ex.Message); //Error que se vea en la consola
            }
        }

        protected void btn_crear_cancion_Click(object sender, EventArgs e)
        {
            //Leer los datos de cada textbox  y guardar en la base de datos
            string nombre = txt_nombre_cancion.Text;
            string descripcion = txtDescripcionDisco.Text;
            string autor = txtAutoresDisco.Text;

            byte[] portada = fuPortadaDisco.HasFile ? fuPortadaDisco.FileBytes : null;
            byte[] cancion = fuArchivoDisco.HasFile ? fuArchivoDisco.FileBytes : null;

            if (string.IsNullOrWhiteSpace(nombre) || string.IsNullOrWhiteSpace(descripcion) || string.IsNullOrWhiteSpace(autor))
            {
                lblError.Text = "Todos los campos son obligatorios.";
                lblError.Visible = true;
                return;
            }

            int id_usuario = 1; // Obtén este valor de la sesión o la autenticación del usuario.
            insertarCancionBDD(nombre, descripcion, autor, portada, cancion, id_usuario);
        }
    }
}