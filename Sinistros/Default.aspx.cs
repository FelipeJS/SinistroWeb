using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace Sinistros
{
    public partial class Default1 : System.Web.UI.Page
    {

        public PetaPoco.Database db =
             new PetaPoco.Database("DB");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
                return;
            }

            try
            {
                if (Session["perfil"].ToString() == "-1")
                {
                    grupoMenu.Visible = false;
                    modulosMenu.Visible = false;
                }
            }
            catch
            {
                FormsAuthentication.RedirectToLoginPage();
                return;
            }

            txtPerfil.Value = Session["perfil"].ToString();
            txtUsuario.Value = Session["usuario"].ToString();

            if (Session["perfil"].ToString() == "23" || Session["perfil"].ToString() == "0") mnuOpcoes.Visible = true;
            else mnuOpcoes.Visible = false;

            if (Session["perfil"].ToString() == "1" || Session["perfil"].ToString() == "23" || Session["perfil"].ToString() == "0") mnuServicos.Visible = true;
            else mnuServicos.Visible = false;

        }

        protected void btnProcessar_Click(object sender, EventArgs e)
        {

            string[] lines = txtNumerosSusep.Text.Split(new string[] { Environment.NewLine }, StringSplitOptions.None);

            for (int i = 0; i < lines.Length; i++)
            {
                if (lines[i].Trim() == "") lines[i] = "null";

            }

            //Retorna somatório de sinistros encerrados.
            var valorTotal = db.ExecuteScalar<string>("select sum(vl_reserva)" +
            " from sto_reserva r inner join sma_sinistro s on s.id_sinistro = r.id_sinistro inner join ( select " + string.Join(" nr_sinistro from dual union select ", lines) + " nr_sinistro from dual)" +
            " d on s.nr_sinistro = d.nr_sinistro");

            string sqlString = "DECLARE\n" +
            "\n" +
            "cursor c1 is\n" +
            "select *\n" +
            "from sma_sinistro s natural join \n" +
            "(\n " +
            "select " + string.Join(" nr_sinistro from dual union select ", lines) +
            " nr_sinistro from dual)\n" +
            "where (select sum(o.vl_pagamento) from ctb_op o where o.id_sinistro = s.id_sinistro and o.id_status in (k.STATUS_OP_PENDENTE_PROCESSA, k.STATUS_OP_PENDENTE_RESPOSTA)) IS NULL;\n" +
            "\n" +
            "BEGIN\n" +
            "\n" +
            "   FOR sinistro_rec in c1\n" +
            "   LOOP\n" +
            "\n" +
            "       pa_sinistros.prCierraSinIndemnizacion(vnidsiniestro =>    sinistro_rec.id_sinistro  ,\n" +
            "                                             vnTpMotivo => 21,\n" +
            "                                             vcMotivo => ' ',\n" +
            "                                             vnidusuario => '" + txtUsuario.Value + "' );\n" +
            "\n" +
            "   END LOOP;\n" +
            "\n" +
            "END;";

            string message = "";

            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script type = 'text/javascript'>");
            sb.Append("window.onload=function(){");

            try
            {
                db.Execute(sqlString);
                message = "Os sinistros informados, sem OPs pendentes, foram encerrados com sucesso! R$" + valorTotal;
                txtNumerosSusep.Text = "";
            }
            catch (Exception ex)
            {
                message = "Ocorreu um erro. Verifique! \n" + ex.Message;
            }

            sb.Append("alert('");
            sb.Append(message.Replace("\n", "").Replace("\"", "").Replace("'", ""));
            sb.Append("')};");
            sb.Append("</script>");
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());

        }

    }
}