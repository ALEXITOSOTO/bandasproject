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
    public partial class RegistroUsuario : System.Web.UI.Page
    {
        //Variables de clase
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
        public void insertarUsuarioBDD(string nombre, string email, string telefono, string contrasena)
        {
            SqlCommand comandoInsercion = new SqlCommand("sp_crear_usuario_normal", conexion); //Proceso almcenado en la bdd
            //Pasamos los parametros del proceso almacenado de la bdd
            comandoInsercion.CommandType = CommandType.StoredProcedure;
            comandoInsercion.Parameters.AddWithValue("@nombre", nombre);
            comandoInsercion.Parameters.AddWithValue("@email", email);
            comandoInsercion.Parameters.AddWithValue("@telefono", telefono);
            comandoInsercion.Parameters.AddWithValue("@contrasena", contrasena);
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
        protected void btn_crear_usuario_Click(object sender, EventArgs e)
        {
            //Leer los datos de cada textbox  y guardar en la base de datos
            string nombre = txt_nombre_usuario.Text;
            string email = txt_email_usuario.Text;
            string telefono = txt_telefono_usuario.Text;
            string contrasena = txt_contrasena_usuario.Text;

            insertarUsuarioBDD(nombre, email, telefono, contrasena);
            Response.Redirect("~/Default.aspx");
        }
    }
}