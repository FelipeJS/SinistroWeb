using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using System.Configuration;
using System.Data;

namespace Sinistros
{
    public partial class aviso : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Model.Value = "0";
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            Session["FormXYZSubmitted"] = false;

            Int32 tipoOrigem = 0;
            string sql = "";

            ddSeguro.Visible = true;
            lblSeguro.Visible = false;

            //        try
            //        {
            OracleConnection conn = new OracleConnection();

//            conn.ConnectionString = "Data Source=HOMOLOGACAO;Persist Security Info=True;User ID=userqbe001;Password=siemens";
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
                FormView1.Visible = false;
                lblErro.Visible = true;
                lblErro.Text = "Não foi encontrada Apólice com o Nr. informado.";

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
                //                Panel2.Visible = true;
                //                lblMsg.Visible = false;
                //                lblMsgErro.Visible = false;
                //                FormView1.Visible = false;
                //                lblErro.Visible = true;
                //                lblErro.Text = "Não foi encontrado seguro para este CPF com o poduto da Apólice informada.";

                //                return;


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


                //                System.Data.SqlClient.SqlDataReader sReader = (System.Data.SqlClient.SqlDataReader)SEGURADO.Select(DataSourceSelectArguments.Empty);
                //                if (sReader.HasRows)
                //                {
                //                   while (sReader.Read())
                //                    {
                //                        TextBoxNmReclamante.Text = sReader["DS_CLIENTE"].ToString();
                //                    }
                //                }


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
                    ddSeguro.Visible = false;
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
                FormView1.Visible = false;
                lblErro.Visible = true;
                lblErro.Text = "Esta 'e uma Apólice de massificados. Não foi encontrado um endosso para a data informada.";

                return;
            }


            //        }
            //        catch { }

            Panel1.Visible = true;
            Panel2.Visible = false;

        }

        protected void Button2_Click(object sender, EventArgs e)
        {

            // Evitando postback
            if ((bool)Session["FormXYZSubmitted"] == true)
            {
                return;
            }
            Session["FormXYZSubmitted"] = true;

            OracleConnection conn = new OracleConnection();

//            conn.ConnectionString = "Data Source=HOMOLOGACAO;Persist Security Info=True;User ID=userqbe001;Password=siemens";
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["DB1"].ToString();

            conn.Open();

            try
            {
                if (lblSeguro.Visible)  //Incluir segurado
                {
                    SEGURADO.InsertCommand = "insert into sma_segurado s (s.id_segurado, s.cd_estipulante, s.cd_cliente_aon, s.cd_cliente_etp, s.cpf, s.ds_cliente, s.id_pessoa) SELECT seq_sma_segurado.nextval, a.cd_estipulante, substr(:CPF,1,8), :CPF, :CPF, S.DS_PESSOA, s.id_pessoa FROM (     SELECT sp.CD_ESTIPULANTE, sp.id_produto, sp.ds_produto, e.ds_estipulante FROM Tb_Emi_Apoli a, TB_CAD_PRODT cP, sma_produto sp, sma_estipulante e WHERE NR_APOLI_OFIC = :APO and a.id_prod_unif = cp.id_prod_unif and cp.cd_produto = sp.cd_produto and e.cd_estipulante = sp.cd_estipulante     ) a, CRP_PESSOA S, CRP_DOCTO D WHERE     D.NR_DOCTO =  :CPF      and S.ID_PESSOA = D.Id_Pessoa ";
                    SEGURADO.Insert();

                    SEGURADO.InsertCommand = "insert into sma_seguro ss (ss.id_seguro, ss.nr_seguro, ss.id_segurado, ss.id_produto) SELECT seq_sma_seguro.nextval, 1, seq_sma_segurado.currval, a.id_produto     FROM (     SELECT sp.CD_ESTIPULANTE, sp.id_produto, sp.ds_produto, e.ds_estipulante      FROM Tb_Emi_Apoli a, TB_CAD_PRODT cP, sma_produto sp, sma_estipulante e     WHERE NR_APOLI_OFIC = :APO and a.id_prod_unif = cp.id_prod_unif and cp.cd_produto = sp.cd_produto and e.cd_estipulante = sp.cd_estipulante     ) a,     CRP_PESSOA S, CRP_DOCTO D     WHERE     D.NR_DOCTO =  :CPF      and S.ID_PESSOA = D.Id_Pessoa ";
                    SEGURADO.Insert();

                    SMA_SINISTRO.InsertCommand = SMA_SINISTRO.InsertCommand.Replace(":idSeguro", " nvl(:idSeguro, (select max(id_seguro) from sma_seguro)) ");
                    SMA_SINISTRO.SelectCommand = SMA_SINISTRO.SelectCommand.Replace(":idSeguro", " nvl(:idSeguro, (select max(id_seguro) from sma_seguro)) ");

                }
                SMA_SINISTRO.Insert();
                RESERVA.Insert();
                STATUS.Insert();
                STATUS.InsertCommand = "INSERT INTO SMA_SINISTRO_STATUS (ID_SINISTRO, FL_STATUS, DT_ENVIO, DT_ENTRADA, ID_USUARIO) VALUES ((select max(id_sinistro) from sma_sinistro where id_sinistro < 900000), 'A', sysdate, sysdate, 333)";
                STATUS.Insert();

                String sql = SMA_SINISTRO.SelectCommand.Replace(":dtOcorrencia", "'" + TextBoxDtOcorre.Text + "'");

                OracleCommand executeQuery = new OracleCommand(sql.Replace(":idSeguro", "NULL"), conn);

                OracleDataReader dr = executeQuery.ExecuteReader();

                while (dr.Read())
                {
                    lblSinistro.Text = "ID Sinistro: " + (string)dr["ID_SINISTRO_S"] + " Nr Sinistro: " + (string)dr["NR_SINISTRO"];
                }

            }
            catch (Exception ex)
            {

                lblMsgErro.Text = ex.Message;
                lblErro.Visible = true;
                lblMsgErro.Visible = true;
                lblMsg.Visible = false;
                Panel2.Visible = true;
                FormView1.Visible = true;
                Model.Value = "1";
                return;
            }


            //Refresh
            SMA_SINISTRO.Update();
            SMA_SINISTRO.Select(DataSourceSelectArguments.Empty);
            SMA_SINISTRO.DataBind();

            Panel1.Visible = false;
            Panel2.Visible = true;
            FormView1.Visible = true;

            TextBoxDtOcorre.Text = "";
            TextBoxAPO.Text = "";
            TextBoxCPF.Text = "";
            TextBoxCPFReclamante.Text = "";
            TextBoxNrSinistro.Text = "";
            TextBoxNmReclamante.Text = "";
            TextBoxDesc.Text = "";

            lblErro.Visible = false;
            lblMsgErro.Visible = false;
            lblMsg.Visible = true;

            Model.Value = "1";

        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            FormView1.Visible = false;
            Panel2.Visible = true;

            TextBoxDtOcorre.Text = "";
            TextBoxAPO.Text = "";
            TextBoxCPF.Text = "";
            TextBoxCPFReclamante.Text = "";
            TextBoxNrSinistro.Text = "";
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

            String sql = "update sma_sinistro s set s.nr_sinistro = '" + ((TextBox)this.FormView1.FindControl("TextBox2")).Text + "' where s.id_sinistro = " + ((TextBox)this.FormView1.FindControl("TextBox1")).Text;

            OracleCommand executeQuery = new OracleCommand(sql, conn);

            executeQuery.ExecuteNonQuery();

        }
    }
}