using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace bandasproject
{
    public partial class RegistroBanda : System.Web.UI.Page
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
        public void insertarBandaBDD(string nombre,string nombre_banda, string email, string telefono, string contrasena, string generos, string slogan, int integrantes)
        {
            SqlCommand comandoInsercion = new SqlCommand("sp_crear_usuario_banda", conexion); //Proceso almcenado en la bdd
            //Pasamos los parametros del proceso almacenado de la bdd
            comandoInsercion.CommandType = CommandType.StoredProcedure;
            comandoInsercion.Parameters.AddWithValue("@nombre", nombre);
            comandoInsercion.Parameters.AddWithValue("@nombre_banda", nombre_banda);
            comandoInsercion.Parameters.AddWithValue("@email", email);
            comandoInsercion.Parameters.AddWithValue("@telefono", telefono);
            comandoInsercion.Parameters.AddWithValue("@contrasena", contrasena);
            comandoInsercion.Parameters.AddWithValue("@generos_banda", generos);
            comandoInsercion.Parameters.AddWithValue("@slogan_banda", slogan);
            comandoInsercion.Parameters.AddWithValue("@numero_integrantes_banda", integrantes);
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
            string nombre_banda = txt_nombre_banda.Text;
            string email = txt_email_usuario.Text;
            string telefono = txt_telefono_usuario.Text;
            string contrasena = txt_contrasena_usuario.Text;
            string generos = txt_generos_banda.Text;
            string slogan = txt_slogan_banda.Text;
            int integrantes = int.Parse(txt_numero_integrantes_banda.Text); 

            insertarBandaBDD(nombre,nombre_banda, email, telefono, contrasena, generos,slogan,integrantes);
        }

    }
}