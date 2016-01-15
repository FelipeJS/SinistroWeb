using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using System.Web.Security;
using System.Configuration;
using System.Data;

namespace Sinistros
{
    public partial class acesso : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                preencheGrid();
            }

        }

        public void preencheGrid()
        {
            OracleConnection conn = new OracleConnection();

            conn.ConnectionString = ConfigurationManager.ConnectionStrings["DB"].ToString();

            conn.Open();

            string sqlString = "select s.*, a.*, p.*, 'Single Sign-on' fl_login, CASE FL_VIGENTE WHEN 1 THEN 'SIM' ELSE 'NÃO' END bl_vigente from sto_usuario s, adm_usuario a, sto_perfil p where a.id_usuario = s.id_usuario and p.id_perfil = s.id_perfil AND s.id_usuario <> 888 AND s.id_usuario <> 1060 AND s.id_usuario <> 1061 AND s.id_usuario <> 1062 AND s.id_usuario <> 1063 AND s.id_usuario <> 1064 AND s.id_usuario <> 1065 order by a.ds_usuario";

            OracleCommand executeQuery = new OracleCommand(sqlString, conn);

            OracleDataReader dr = executeQuery.ExecuteReader();

            DataTable dt = new DataTable();

            dt.Load(dr);

            UsuarioGridView.DataSource = dt;
            UsuarioGridView.DataBind();

        }

        protected void UsuarioGridView_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            UsuarioGridView.EditIndex = e.NewEditIndex;
            preencheGrid();
        }

        protected void UsuarioGridView_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            UsuarioGridView.EditIndex = -1;
            preencheGrid();
        }

        protected void UsuarioGridView_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
        {
/*            //Obtem cada valor único do DataKeyNames
            int id = Convert.ToInt32(ClienteGridView.DataKeys[e.RowIndex].Value.ToString());
            //Obtem o valor do TextBox no EditItemTemplet da linha clicada
            string nome = ((TextBox)ClienteGridView.Rows[e.RowIndex].FindControl("txtnome")).Text;
            string endereco = ((TextBox)ClienteGridView.Rows[e.RowIndex].FindControl("txtendereco")).Text;
            string email = ((TextBox)ClienteGridView.Rows[e.RowIndex].FindControl("txtemail")).Text;
            //abre a conexão
            SqlConnection con = new SqlConnection(strConexao);
            con.Open();
            //Utiliza a stored procedure sproc_AtualizaCliente na conexão
            SqlCommand cmd = new SqlCommand("sproc_AtualizaCliente", con);
            //define o tipo de comando 
            cmd.CommandType = CommandType.StoredProcedure;
            //passa os parâmetros para a stored procedure
            cmd.Parameters.AddWithValue("@id ", id);
            cmd.Parameters.AddWithValue("@nome ", nome);
            cmd.Parameters.AddWithValue("@endereco ", endereco);
            cmd.Parameters.AddWithValue("@email ", email);
            //Método que retorna as linhas afetadas
            cmd.ExecuteNonQuery(); */
            //nenhuma linha no modo de edição
            UsuarioGridView.EditIndex = -1;
            //preenche o grid nomvanete
            preencheGrid();
        }
    }
}