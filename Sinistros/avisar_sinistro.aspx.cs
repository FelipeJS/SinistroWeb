using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using System.Configuration;
using System.Data;
using System.Web.Security;

namespace Sinistros
{
    public partial class avisar_sinistro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            Model.Value = "0";

            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
                return;
            }

            try
            {
                txtUsuario.Value = Session["usuario"].ToString();
                txtPerfil.Value = Session["perfil"].ToString();
            }
            catch
            {
                FormsAuthentication.RedirectToLoginPage();
                return;
            }

            lblMsgSeguro.Visible = false;

        }

        protected void On_Inserting(Object sender, SqlDataSourceCommandEventArgs e)
        {

//            e.Command.Prepare();
            //the parameters names and values are in e.Command.Parameters
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            Session["FormXYZSubmitted"] = false;

            dsSeguroSeleciona.SelectCommand = dsSeguroSeleciona.SelectCommand.Replace(":CPF", TextBoxCPF.Text).Replace(":dtOcorrencia", TextBoxDtOcorre.Text);

            DataView view = (DataView)dsSeguroSeleciona.Select(DataSourceSelectArguments.Empty);

            DataTable dt = view.ToTable();

            if (dt.Rows.Count == 0)
            {
                lblMsgSeguro.Visible = true;
                lblMsgSeguro.Text = "NÃO LOCALIZADO O SEGURADO DENTRO DO PERÍODO DE OCORRENCIA";
            }

            ViewState["dtSeguro"] = dt;

            pnSeguro.Visible = true;

        }

        protected void btnSelecionarSeguro_Click(object sender, EventArgs e)
        {

            DataTable dt = new DataTable();

//            TextBoxDtAviso.Text = DateTime.Today.ToShortDateString();
            TextBoxDtAviso.Text = DateTime.Today.ToString("dd/MM/yyyy");
            dt = (DataTable)ViewState["dtSeguro"];

            DataRow row = dt.Rows[int.Parse(ddSeguroSeleciona.SelectedValue) - 1];

            TextBoxAPO.Text = row["NR_APOLI_OFIC"].ToString();

            if (TextBoxAPO.Text == "SEM APOLICE") return;

            if (row["ID_SEGURO"].ToString().Length == 0)
                lblSeguro.Visible = true; //Incluir segurado na base do SIMASS
            else
                TextBoxSeguro.Text = row["ID_SEGURO"].ToString();

            if (TextBoxAPO.Text.Trim().Length == 0)
            {
                TextBoxAPO.Text = row["ID_APOLICE"].ToString();
                ProcessarBilhete();
            }
            else
                ProcessarApolice();

        }

        protected void btnSalvar_Click(object sender, EventArgs e)
        {

            // Evitando postback
            if ((bool)Session["FormXYZSubmitted"] == true)
            {
                return;
            }

            Session["FormXYZSubmitted"] = true;

            OracleConnection conn = new OracleConnection();

            conn.ConnectionString = ConfigurationManager.ConnectionStrings["DB1"].ToString();

            conn.Open();

            OracleTransaction transaction = conn.BeginTransaction();

            string strIds = "";

            try
            {

                DataTable dt = new DataTable();

                dt = (DataTable)ViewState["dtSeguro"];

                foreach (ListItem listItem in ddSeguroSeleciona.Items)
                {
                    if (listItem.Selected == true)
                    {

                        DataRow row = dt.Rows[int.Parse(listItem.Value) - 1];

                        TextBoxAPO.Text = row["NR_APOLI_OFIC"].ToString();

                        TextBoxSeguro.Text = row["ID_SEGURO"].ToString();

                        if (row["ID_SEGURO"] == DBNull.Value) 
                        {
                            TextBoxSeguro.Text = IncluirSegurado(row, conn); 
                        }

                        string sql = SMA_SINISTRO.InsertCommand;

                        if (TextBoxAPO.Text.Trim().Length == 0) { 
                            TextBoxAPO.Text = row["ID_APOLICE"].ToString();
                            sql = sql.Replace("nr_apoli_ofic = :APO", "id_apolice = :APO").Replace("and t.cd_tipo_motivo_endos = 220 ", "");
                        }

                        sql = sql.Replace(":APO", "'" + TextBoxAPO.Text + "'");
                        sql = sql.Replace(":tpSinistro", ddTpSinistro.Text);
                        sql = sql.Replace(":dtOcorrencia", "'" + TextBoxDtOcorre.Text + "'");
                        sql = sql.Replace(":dtAviso", "'" + TextBoxDtAviso.Text + "'");
                        sql = sql.Replace(":nmReclamante", "'" + TextBoxNmReclamante.Text + "'");
                        sql = sql.Replace(":cpfReclamante", "'" + TextBoxCPFReclamante.Text + "'");
                        sql = sql.Replace(":tpReclamante", ddReclamante.Text);
                        sql = sql.Replace(":cdCober", ddCobertura.Text);
                        sql = sql.Replace(":idCausa", ddCausa.Text);
                        sql = sql.Replace(":idSeguro", TextBoxSeguro.Text);
                        sql = sql.Replace(":idUsuario", txtUsuario.Value);
                        OracleCommand command = new OracleCommand(sql, conn);
                        command.ExecuteNonQuery();

                        sql = RESERVA.InsertCommand;
                        sql = sql.Replace(":vlReserva", TextBoxValor.Text.Replace(",", "."));
                        sql = sql.Replace(":tpSinistro", ddTpSinistro.Text);
                        sql = sql.Replace(":idUsuario", txtUsuario.Value);
                        command = new OracleCommand(sql, conn);
                        command.ExecuteNonQuery();

                        sql = STATUS.InsertCommand;
                        sql = sql.Replace(":idUsuario", txtUsuario.Value);
                        command = new OracleCommand(sql, conn);
                        command.ExecuteNonQuery();

                        sql = "INSERT INTO SMA_SINISTRO_STATUS (ID_SINISTRO, FL_STATUS, DT_ENVIO, DT_ENTRADA, ID_USUARIO) VALUES ((select max(id_sinistro) from sma_sinistro where id_sinistro < 900000), 'A', sysdate, sysdate, :idUsuario)";
                        sql = sql.Replace(":idUsuario", txtUsuario.Value);
                        command = new OracleCommand(sql, conn);
                        command.ExecuteNonQuery();

                        sql = SMA_SINISTRO.UpdateCommand;
                        sql = sql.Replace(":APO", "'" + TextBoxAPO.Text + "'");
                        command = new OracleCommand(sql, conn);
                        command.ExecuteNonQuery();

                        command = new OracleCommand("select max(id_sinistro) from sma_sinistro where id_sinistro < 900000", conn);
                        string strIdCriado = command.ExecuteScalar().ToString();
                        strIds = strIds + strIdCriado + ",";

                        command = new OracleCommand("begin" +
                                                    "  pa_sinistros.prgrabacomentario(vnidsiniestro => " + strIdCriado + "," +
                                                    "                                 vnidusuario => " + txtUsuario.Value + "," +
                                                    "                                 vctexto => '" + TextBoxDesc.Text + "'," +
                                                    "                                 vnevento => " + 250 + ");" +
                                                    "end;", conn);
                        command.ExecuteNonQuery();

                    }
                }

                transaction.Commit();

            }
            catch (Exception ex)
            {

                transaction.Rollback();

                lblMsgErro.Text = ex.Message;
                lblErro.Visible = true;
                lblMsgErro.Visible = true;
                lblMsg.Visible = false;
                Panel2.Visible = true;
                GridView3.Visible = false;
                Model.Value = "1";
                return;
            }

            //Refresh
            SMA_SINISTRO.SelectCommand = "SELECT S.*, TO_CHAR(ID_SINISTRO) ID_SINISTRO_S FROM SMA_SINISTRO S WHERE S.ID_SINISTRO IN(" + strIds + "-9999)";
            SMA_SINISTRO.Select(DataSourceSelectArguments.Empty);
            SMA_SINISTRO.DataBind();

            Panel1.Visible = false;
            Panel2.Visible = true;
//            FormView1.Visible = true;

            TextBoxDtOcorre.Text = "";
            TextBoxAPO.Text = "";
            TextBoxCPF.Text = "";
            TextBoxCPFReclamante.Text = "";
            TextBoxNmReclamante.Text = "";
            TextBoxDesc.Text = "";

            lblErro.Visible = false;
            lblMsgErro.Visible = false;
            lblMsg.Visible = true;

            Model.Value = "1";

        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            Panel2.Visible = false;
            pnSeguro.Visible = false;

            TextBoxDtOcorre.Text = "";
            TextBoxAPO.Text = "";
            TextBoxCPF.Text = "";
            TextBoxCPFReclamante.Text = "";
            TextBoxNmReclamante.Text = "";
            TextBoxDesc.Text = "";
            lblErro.Visible = false;
            lblMsgErro.Visible = false;
            lblMsg.Visible = false;

        }

        protected void Button3_Click(object sender, EventArgs e)
        {

            OracleConnection conn = new OracleConnection();

            conn.ConnectionString = ConfigurationManager.ConnectionStrings["DB1"].ToString();
            conn.Open();

//            String sql = "update sma_sinistro s set s.nr_sinistro = '" + ((TextBox)this.FormView1.FindControl("TextBox2")).Text + "' where s.id_sinistro = " + ((TextBox)this.FormView1.FindControl("TextBox1")).Text;

//            OracleCommand executeQuery = new OracleCommand(sql, conn);

//            executeQuery.ExecuteNonQuery();

        }

        private void ProcessarApolice()
        {
            Int32 tipoOrigem = 0;
            string sql = "";

            lblSeguro.Visible = false;

            OracleConnection conn = new OracleConnection();

            conn.ConnectionString = ConfigurationManager.ConnectionStrings["DB1"].ToString();

            conn.Open();

            sql = "SELECT ID_APOLICE, to_char(CD_TIPO_ORIGEM) CD_TIPO_ORIGEM FROM TB_EMI_APOLI A WHERE A.NR_APOLI_OFIC = :APO";
            if (TextBoxAPO.Text.Trim().Length == 0)
                sql = sql.Replace(":APO", "null");
            else
                sql = sql.Replace(":APO", TextBoxAPO.Text);

            OracleCommand executeQuery = new OracleCommand(sql, conn);

            OracleDataReader dr = executeQuery.ExecuteReader();

            Boolean ehVazio = true;

            while (dr.Read())
            {
                ehVazio = false;
                tipoOrigem = Int32.Parse((string)dr["CD_TIPO_ORIGEM"]);
                Console.WriteLine(tipoOrigem);
            }

            if (ehVazio)
            {
                Panel2.Visible = true;
                lblMsg.Visible = false;
                lblMsgErro.Visible = false;
//                FormView1.Visible = false;
                lblErro.Visible = true;
                lblErro.Text = "Não foi encontrada Apólice com o Nr. informado.";

                Model.Value = "1";

                return;
            }

            sql = "SELECT SS.*,  " +
"S.DS_CLIENTE, S.CPF, P.DS_PRODUTO,  " +
"to_char(SS.NR_SEGURO, '0000') || ' - ' || S.CD_CLIENTE_ETP || ' - ' || P.DS_PRODUTO SEGURO,    " +
"E.cd_estipulante, E.ds_estipulante, E.cd_estipulante || ' - ' || E.ds_estipulante ESTIPULANTE  " +
"FROM SMA_SEGURO SS, SMA_SEGURADO S, SMA_PRODUTO P, SMA_ESTIPULANTE E, " +
"( SELECT sp.CD_ESTIPULANTE, sp.id_produto, sp.ds_produto, e.ds_estipulante   " +
"FROM Tb_Emi_Apoli a, TB_CAD_PRODT cP, sma_produto sp, sma_estipulante e  " +
"WHERE NR_APOLI_OFIC = :APO and a.id_prod_unif = cp.id_prod_unif and cp.id_produto = sp.id_produto and e.cd_estipulante = sp.cd_estipulante ) a " +
"WHERE SS.ID_SEGURADO IN  " +
"(SELECT ID_SEGURADO FROM SMA_SEGURADO WHERE  CPF =  :CPF ) " +
"AND SS.ID_SEGURADO = S.ID_SEGURADO AND SS.ID_PRODUTO = P.ID_PRODUTO AND E.CD_ESTIPULANTE = P.CD_ESTIPULANTE";

            sql = sql.Replace(":CPF", "'" + TextBoxCPF.Text + "'");
            if (TextBoxAPO.Text.Trim().Length == 0)
                sql = sql.Replace(":APO", "null");
            else
                sql = sql.Replace(":APO", TextBoxAPO.Text);

            //            OracleCommand executeQuery = new OracleCommand(sql, conn);
            executeQuery.CommandText = sql;

            SEGURADO.SelectCommand = sql;

            SEGURADO.Select(DataSourceSelectArguments.Empty);

            dr = executeQuery.ExecuteReader();

            ehVazio = true;

            while (dr.Read())
            {
                ehVazio = false;
            }

            if (ehVazio)
            {

                sql = "SELECT S.DS_PESSOA DS_CLIENTE, D.NR_DOCTO CPF, a.ID_PRODUTO, '000000' NR_SEGURO, '000000' ID_SEGURO, a.DS_PRODUTO, to_char('0000') || ' - ' || a.DS_PRODUTO SEGURO,  " +
"     a.cd_estipulante, a.ds_estipulante, a.cd_estipulante || ' - ' || a.ds_estipulante ESTIPULANTE " +
"    FROM ( " +
"    SELECT sp.CD_ESTIPULANTE, sp.id_produto, sp.ds_produto, e.ds_estipulante  " +
"    FROM Tb_Emi_Apoli a, TB_CAD_PRODT cP, sma_produto sp, sma_estipulante e " +
"    WHERE NR_APOLI_OFIC = :APO and a.id_prod_unif = cp.id_prod_unif and cp.cd_produto = sp.cd_produto and e.cd_estipulante = sp.cd_estipulante " +
"    ) a, " +
"    CRP_PESSOA S, CRP_DOCTO D " +
"    WHERE " +
"    D.NR_DOCTO =  :CPF  " +
"    and S.ID_PESSOA = D.Id_Pessoa ";


                sql = sql.Replace(":CPF", "'" + TextBoxCPF.Text + "'");
                if (TextBoxAPO.Text.Trim().Length == 0)
                    sql = sql.Replace(":APO", "null");
                else
                    sql = sql.Replace(":APO", TextBoxAPO.Text);

                SEGURADO.SelectCommand = sql;

                SEGURADO.Select(DataSourceSelectArguments.Empty);

                sql = sql.Replace(":CPF", "'" + TextBoxCPF.Text + "'");
                if (TextBoxAPO.Text.Trim().Length == 0)
                    sql = sql.Replace(":APO", "null");
                else
                    sql = sql.Replace(":APO", TextBoxAPO.Text);

                executeQuery.CommandText = sql;

                dr = executeQuery.ExecuteReader();

                ehVazio = true;

                while (dr.Read())
                {
                    ehVazio = false;
                    string myField = (string)dr["DS_CLIENTE"];
                    TextBoxNmReclamante.Text = (string)dr["DS_CLIENTE"];
                    TextBoxCPFReclamante.Text = TextBoxCPF.Text;
                    Console.WriteLine(myField);
                }

                if (!ehVazio)
                {
                    lblSeguro.Visible = true;
                }

            }

            sql = "SELECT ID_ENDOSSO FROM TB_EMI_APOLI A, TB_EMI_ENDOS E WHERE A.NR_APOLI_OFIC = :APO AND E.ID_APOLICE = A.ID_APOLICE AND to_date(:dtOcorrencia, 'DD/MM/YYYY') BETWEEN E.DT_INI_VIG AND E.DT_FIM_VIG";
            sql = sql.Replace(":dtOcorrencia", "'" + TextBoxDtOcorre.Text + "'");

            if (TextBoxAPO.Text.Trim().Length == 0)
                sql = sql.Replace(":APO", "null");
            else
                sql = sql.Replace(":APO", TextBoxAPO.Text);

            //            OracleCommand executeQuery = new OracleCommand(sql, conn);
            executeQuery.CommandText = sql;

            dr = executeQuery.ExecuteReader();

            ehVazio = true;

            while (dr.Read())
            {
                ehVazio = false;
            }

            if (ehVazio && tipoOrigem != 3)
            {
                Panel2.Visible = true;
                lblMsg.Visible = false;
                lblMsgErro.Visible = false;
//                FormView1.Visible = false;
                lblErro.Visible = true;
                lblErro.Text = "Esta 'e uma Apólice de massificados. Não foi encontrado um endosso para a data informada.";

                Model.Value = "1";

                return;
            }

            if (ehVazio && tipoOrigem == 3)
            {
                Panel2.Visible = true;
                lblMsg.Visible = false;
                lblMsgErro.Visible = false;
//                FormView1.Visible = false;
                lblErro.Visible = true;
                lblErro.Text = "Data de ocorrencia fora do período de vigência.";

                Model.Value = "1";

                return;
            }

            //        }
            //        catch { }

            Panel1.Visible = true;
            Panel2.Visible = false;
        }

        private void ProcessarBilhete()
        {

            SEGURADO.SelectCommand = "select null id_apolice, null nr_apoli_ofic, null DS_CLIENTE, null SEGURO, null ESTIPULANTE, null ID_SEGURO from sma_segurado where id_segurado = -99";

            SEGURADO.Select(DataSourceSelectArguments.Empty);

            Panel1.Visible = true;
            Panel2.Visible = false;

        }

        private string IncluirSegurado(DataRow row, OracleConnection conn)
        {

            string sql = "insert into sma_segurado s (s.id_segurado, s.cd_estipulante, s.cd_cliente_aon, s.cd_cliente_etp, s.cpf, s.ds_cliente, s.id_pessoa) " +
                                                "SELECT seq_sma_segurado.nextval, a.cd_estipulante, substr('" + row["CPF"].ToString() + "',1,8), " + 
                                                "a.nr_idtfc_neg, '" + row["CPF"].ToString() + "', p.ds_pessoa, p.id_pessoa " +
                                                "  FROM crp_pessoa p, tb_emi_endos e, tb_emi_apoli a " +
                                                " WHERE p.id_pessoa = e.id_pessoa " +
                                                "   and a.id_apolice = e.id_apolice " +
                                                "   and e.id_endosso = " + row["ID_ENDOSSO"].ToString();

            OracleCommand command = new OracleCommand(sql, conn);
            command.ExecuteNonQuery();

            sql = "insert into sma_seguro ss (ss.id_seguro, ss.nr_seguro, ss.id_segurado, ss.id_produto) " +
                                        "SELECT seq_sma_seguro.nextval, 1, seq_sma_segurado.currval, a.id_produto " +
                                        "  FROM (     SELECT sp.CD_ESTIPULANTE, sp.id_produto, sp.ds_produto      " +
                                        "               FROM Tb_Emi_Apoli a, TB_CAD_PRODT cP, sma_produto sp     " +
                                        "              WHERE  a.ID_APOLICE = " + row["ID_APOLICE"].ToString() + 
                                        "                AND a.id_prod_unif = cp.id_prod_unif and cp.cd_produto = sp.cd_produto and " +
                                        "                    a.cd_estipulante = sp.cd_estipulante     ) a";
            command = new OracleCommand(sql, conn);
            command.ExecuteNonQuery();

            command = new OracleCommand("SELECT seq_sma_seguro.currval from dual", conn);
            return command.ExecuteScalar().ToString();

        }

        protected void btnPreAviso_Click(object sender, EventArgs e)
        {
            Response.Redirect("pre-aviso.aspx");
        }
    }
}