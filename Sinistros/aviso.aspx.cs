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
    public partial class aviso : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Model.Value = "0";
            pnlJudicial.Visible = false;
//            ddTpSinistro.SelectedIndex = 0;

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

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            Session["FormXYZSubmitted"] = false;

            if (TextBoxCPF.Text.Trim().Length == 0)
                return;

           

            if (TextBoxAPO.Text.Trim().Length == 0)
                ProcessarBilhete();
            else
                ProcessarApolice();

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
                    if (TextBoxAPO.Text.Length < 8)
                    { // Processa Bilhete
                        SEGURADO.InsertCommand = "insert into sma_segurado s (s.id_segurado, s.cd_estipulante, s.cd_cliente_aon, s.cd_cliente_etp, s.cpf, s.ds_cliente, s.id_pessoa) " +
                                                 "SELECT seq_sma_segurado.nextval, a.cd_estipulante, substr(:CPF,1,8), a.nr_idtfc_neg, :CPF, S.DS_PESSOA, s.id_pessoa " +
                                                 "  FROM CRP_PESSOA S, CRP_DOCTO D, Tb_Emi_Apoli a " +
                                                 " WHERE D.NR_DOCTO = :CPF and S.ID_PESSOA = D.Id_Pessoa and a.ID_APOLICE = :APO";

                        SEGURADO.Insert();

                        SEGURADO.InsertCommand = "insert into sma_seguro ss (ss.id_seguro, ss.nr_seguro, ss.id_segurado, ss.id_produto) " +
                                                 "SELECT seq_sma_seguro.nextval, 1, seq_sma_segurado.currval, a.id_produto " +
                                                 "  FROM (     SELECT sp.CD_ESTIPULANTE, sp.id_produto, sp.ds_produto      " +
                                                 "               FROM Tb_Emi_Apoli a, TB_CAD_PRODT cP, sma_produto sp     " +
                                                 "              WHERE  a.ID_APOLICE = :APO and a.id_prod_unif = cp.id_prod_unif and cp.cd_produto = sp.cd_produto and " +
                                                 "                    a.cd_estipulante = sp.cd_estipulante     ) a,     CRP_PESSOA S, CRP_DOCTO D     " +
                                                 " WHERE     D.NR_DOCTO =  :CPF      and S.ID_PESSOA = D.Id_Pessoa ";
                        SEGURADO.Insert();


                        SMA_SINISTRO.InsertCommand = "INSERT INTO sma_sinistro " +
"(id_sinistro, nr_sinistro_aon, nr_sinistro, fl_status, cd_cia, id_segurado, vl_qtde_paga, fl_status_legado, vl_saldo_devedor, fl_documentos_recebidos, fl_catastrofe, " +
"dt_cadastro, dt_modificacao, dt_ult_consulta, tp_sinistro, dt_ocorrencia, dt_aviso, nm_reclamante, cpf_reclamante, id_seguro, tp_reclamante, cd_cober, id_causa, id_endosso, " +
"id_usuario, id_apolice) " +
                        "VALUES " +
"( " +
"(select max(id_sinistro) + 1 from sma_sinistro where id_sinistro < 900000),              " +
"0, " +
"    (select lpad(to_char(pol.cd_sucursal), 2, '0') || " +
"                       lpad(to_char(pol.cd_ramo_emis), 2, '0') || " +
"                       lpad(to_char(nvl(ss.nm_sequencia, 0) + 1), 6, '0') || " +
"                       to_char(sysdate, 'yyyy') SinistroSUSEP " +
"      from tb_emi_apoli pol " +
"     inner join sto_seq_susep ss " +
"        on ss.cd_sucursal = pol.cd_sucursal " +
"       and ss.cd_ramo = pol.cd_ramo_emis " +
"       and to_char(ss.nm_ano) = to_char(sysdate, 'yyyy') " +
"     where pol.id_apolice = :APO) " +
",        " +
"'A',     4, (select id_segurado from sma_seguro where id_seguro = :idSeguro), " +
"0,                        0,                  0,                       0,             0,     sysdate,        sysdate,         sysdate, " +
"nvl(:tpSinistro,1), TO_DATE(:dtOcorrencia, 'DD/MM/YYYY'), TO_DATE(:dtAviso, 'DD/MM/YYYY'), :nmReclamante, :cpfReclamante, :idSeguro, :tpReclamante, :cdCober, :idCausa, :idEndosso, :idUsuario, " +
"(select id_apolice from tb_emi_apoli where id_apolice = :APO) " +
")";

                        SMA_SINISTRO.InsertCommand = SMA_SINISTRO.InsertCommand.Replace(":idSeguro", " nvl(:idSeguro, (select max(id_seguro) from sma_seguro)) ");
                        SMA_SINISTRO.SelectCommand = SMA_SINISTRO.SelectCommand.Replace(":idSeguro", " nvl(:idSeguro, (select max(id_seguro) from sma_seguro)) ");
                    }
                    else
                    {
                        SEGURADO.InsertCommand = "insert into sma_segurado s (s.id_segurado, s.cd_estipulante, s.cd_cliente_aon, s.cd_cliente_etp, s.cpf, s.ds_cliente, s.id_pessoa) " +
                                                 "SELECT seq_sma_segurado.nextval, a.cd_estipulante, substr(:CPF,1,8), :CPF, :CPF, S.DS_PESSOA, s.id_pessoa " +
                                                 "  FROM (     SELECT sp.CD_ESTIPULANTE, sp.id_produto, sp.ds_produto, e.ds_estipulante " +
                                                 "               FROM Tb_Emi_Apoli a, TB_CAD_PRODT cP, sma_produto sp, sma_estipulante e " +
                                                 "              WHERE (NR_APOLI_OFIC = :APO or (ID_APOLICE = :APO AND NR_APOLI_OFIC IS NULL) ) and a.id_prod_unif = cp.id_prod_unif and " +
                                                 "                     cp.cd_produto = sp.cd_produto and e.cd_estipulante = sp.cd_estipulante     ) a, CRP_PESSOA S, CRP_DOCTO D " +
                                                 " WHERE     D.NR_DOCTO =  :CPF      and S.ID_PESSOA = D.Id_Pessoa ";
                        SEGURADO.Insert();

                        SEGURADO.InsertCommand = "insert into sma_seguro ss (ss.id_seguro, ss.nr_seguro, ss.id_segurado, ss.id_produto) " +
                                                 "SELECT seq_sma_seguro.nextval, 1, seq_sma_segurado.currval, a.id_produto " +
                                                 "  FROM (     SELECT sp.CD_ESTIPULANTE, sp.id_produto, sp.ds_produto, e.ds_estipulante      " +
                                                 "               FROM Tb_Emi_Apoli a, TB_CAD_PRODT cP, sma_produto sp, sma_estipulante e     " +
                                                 "              WHERE NR_APOLI_OFIC = :APO and a.id_prod_unif = cp.id_prod_unif and cp.cd_produto = sp.cd_produto and " +
                                                 "                    e.cd_estipulante = sp.cd_estipulante     ) a,     CRP_PESSOA S, CRP_DOCTO D     " +
                                                 " WHERE     D.NR_DOCTO =  :CPF      and S.ID_PESSOA = D.Id_Pessoa ";
                        SEGURADO.Insert();

                        SMA_SINISTRO.InsertCommand = SMA_SINISTRO.InsertCommand.Replace(":idSeguro", " nvl(:idSeguro, (select max(id_seguro) from sma_seguro)) ");
                        SMA_SINISTRO.SelectCommand = SMA_SINISTRO.SelectCommand.Replace(":idSeguro", " nvl(:idSeguro, (select max(id_seguro) from sma_seguro)) ");
                    }

                }
                SMA_SINISTRO.Insert();
//                RESERVA.Insert();
                STATUS.Insert();
                STATUS.InsertCommand = "INSERT INTO SMA_SINISTRO_STATUS (ID_SINISTRO, FL_STATUS, DT_ENVIO, DT_ENTRADA, ID_USUARIO) VALUES ((select max(id_sinistro) from sma_sinistro where id_sinistro < 900000), 'A', sysdate, sysdate, :idUsuario)";
                //                STATUS.InsertCommand = STATUS.InsertCommand.Replace(":idUsuario", txtUsuario.Value.ToString());
                STATUS.Insert();

                String sql = SMA_SINISTRO.SelectCommand.Replace(":dtOcorrencia", "'" + TextBoxDtOcorre.Text + "'");

                String idSeguro = ddSeguro.SelectedValue;

                if (ddSeguro.SelectedValue == "") idSeguro = "NULL";
                
                OracleCommand executeQuery = new OracleCommand(sql.Replace(":idSeguro", idSeguro), conn); 

                OracleDataReader dr = executeQuery.ExecuteReader();

                String idSinistro = "";

                while (dr.Read())
                {
                    try
                    {
                        lblSinistro.Text = "ID Sinistro: " + (string)dr["ID_SINISTRO_S"] + " Nr Sinistro: " + (string)dr["NR_SINISTRO"];
                        idSinistro = (string)dr["ID_SINISTRO_S"];
                    }
                    catch
                    {
                        lblSinistro.Text = "ID Sinistro: " + (string)dr["ID_SINISTRO_S"] + " Nr Sinistro: ";
                    }
                }

                String sql1 = "begin " +
                    "  pa_sinistros.prgrabareservaaviso(vnidsiniestro => :vnidsiniestro, " +
                    "                                   vnimportereserva => :vnimportereserva, " +
                    "                                   vntpmoneda => 0, " +
                    "                                   vntpvalor => 1, " +
                    "                                   vnidusuario => 370); " +
                    "end; ";

                sql1 = sql1.Replace(":vnidsiniestro", idSinistro).Replace(":vnimportereserva", TextBoxValor.Text.Replace(",", "."));

                OracleCommand executeQuery1 = new OracleCommand(sql1, conn);

                executeQuery1.ExecuteNonQuery();

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

        protected void btnCancelar_Click(object sender, EventArgs e)
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

        private void ProcessarApolice()
        {
            Int32 tipoOrigem = 0;
            string sql = "";

            ddSeguro.Visible = true;
            lblSeguro.Visible = false;
            lblCosseguroAceito.Visible = false;

            OracleConnection conn = new OracleConnection();

            conn.ConnectionString = ConfigurationManager.ConnectionStrings["DB1"].ToString();

            conn.Open();

            sql = "SELECT ID_APOLICE, to_char(CD_TIPO_ORIGEM) CD_TIPO_ORIGEM, CD_TIPO_EMIS FROM TB_EMI_APOLI A WHERE A.NR_APOLI_OFIC = :APO";
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

                // Apólice de cosseguro aceito
                if ((string)dr["CD_TIPO_ORIGEM"] == "2") { lblCosseguroAceito.Visible = true; }

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

            if (ehVazio && tipoOrigem != 3 && ddTpSinistro.SelectedIndex == 0)
            {
                Panel2.Visible = true;
                lblMsg.Visible = false;
                lblMsgErro.Visible = false;
                FormView1.Visible = false;
                lblErro.Visible = true;
                lblErro.Text = "Esta 'e uma Apólice de massificados. Não foi encontrado um endosso para a data informada.";

                pnlJudicial.Visible = true;

                Model.Value = "1";

                return;
            }

            if (ehVazio && tipoOrigem == 3 && ddTpSinistro.SelectedIndex == 0)
            {
                Panel2.Visible = true;
                lblMsg.Visible = false;
                lblMsgErro.Visible = false;
                FormView1.Visible = false;
                lblErro.Visible = true;
                lblErro.Text = "Data de ocorrencia fora do período de vigência.";

                pnlJudicial.Visible = true;

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

            Int32 idApolice = 0;
            string sql = "";

            ddSeguro.Visible = true;
            lblSeguro.Visible = true;

            sql = "select to_char(a.id_apolice) ID_APOLICE, p.ds_pessoa DS_CLIENTE, a.nr_idtfc_neg SEGURO, est.ds_estipulante ESTIPULANTE, NULL ID_SEGURO " +
            "from tb_emi_apoli a, tb_emi_endos e, crp_pessoa p, crp_docto d, sma_estipulante est\n" +
            "where a.id_apolice = e.id_apolice\n" +
            "and e.id_pessoa = p.id_pessoa\n" +
            "and d.id_pessoa = p.id_pessoa\n" +
            "and est.cd_estipulante = a.cd_estipulante\n" +
            "and (a.nr_idtfc_neg = " + TextBoxCPF.Text +
            " or d.nr_docto = '" + TextBoxCPF.Text + "')";

            OracleConnection conn = new OracleConnection();

            conn.ConnectionString = ConfigurationManager.ConnectionStrings["DB1"].ToString();

            conn.Open();

            OracleCommand executeQuery = new OracleCommand(sql, conn);

            OracleDataReader dr = executeQuery.ExecuteReader();

            Boolean ehVazio = true;

            while (dr.Read())
            {
                ehVazio = false;
                idApolice = Int32.Parse((string)dr["ID_APOLICE"]);
            }

            if (ehVazio)
            {
                Panel2.Visible = true;
                lblMsg.Visible = false;
                lblMsgErro.Visible = false;
                FormView1.Visible = false;
                lblErro.Visible = true;
                lblErro.Text = "Não foi encontrado bilhete para o CPF ou Número informado.";

                return;
            }

            SEGURADO.SelectCommand = sql;

            SEGURADO.Select(DataSourceSelectArguments.Empty);

            sql = "SELECT E.ID_ENDOSSO, 'Num: ' || to_char(E.NR_ENDOS_OFIC, '000000') || ' Vig: ' || TO_CHAR(E.DT_INI_VIG, 'DD/MM/YYYY') || ' A ' || TO_CHAR(E.DT_FIM_VIG, 'DD/MM/YYYY') ENDOSSO " +
"FROM TB_EMI_ENDOS E, TB_EMI_APOLI A WHERE E.ID_APOLICE = A.ID_APOLICE " +
"AND A.ID_APOLICE = :APO AND TO_DATE(:OCO, 'DD/MM/YYYY') BETWEEN E.DT_INI_VIG AND E.DT_FIM_VIG";

            TextBoxAPO.Text = idApolice.ToString();

            ENDOSSO.SelectCommand = sql;
            ENDOSSO.Select(DataSourceSelectArguments.Empty);

            Panel1.Visible = true;
            Panel2.Visible = false;

        }

        protected void btnJudicialSim_Click(object sender, EventArgs e)
        {

            Model.Value = "0";
            ddTpSinistro.SelectedIndex = 1;

        }


    }
}