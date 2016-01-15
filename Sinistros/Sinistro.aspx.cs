using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace Sinistros
{
    public partial class Sinistro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
                Response.End();
                return;
            }

            string idSinistro = "";
            idSinistro = Request.QueryString["idSinistro"];

            if (idSinistro == null)
            {
                idSinistro = "0";
                Response.Redirect("Default.aspx");
            }

            try
            {
                txtUsuario.Value = Session["usuario"].ToString();
                txtPerfil.Value = Session["perfil"].ToString();
            }
            catch
            {
                FormsAuthentication.RedirectToLoginPage();
                Response.End();
                return;
            }

            dsSinistro.SelectCommand = dsSinistro.SelectCommand.Replace(":idSinistro", idSinistro);
            dsReservaTotal.SelectCommand = dsReservaTotal.SelectCommand.Replace(":idSinistro", idSinistro);
            dsArrecadacao.SelectCommand = dsArrecadacao.SelectCommand.Replace(":idSinistro", idSinistro);
            dsAutorizacao.SelectCommand = dsAutorizacao.SelectCommand.Replace(":idSinistro", idSinistro);
            dsBeneficiarios.SelectCommand = dsBeneficiarios.SelectCommand.Replace(":idSinistro", idSinistro);
            dsComentarios.SelectCommand = dsComentarios.SelectCommand.Replace(":idSinistro", idSinistro);
            dsDocumentos.SelectCommand = dsDocumentos.SelectCommand.Replace(":idSinistro", idSinistro);
            dsMotivoRejeicao.SelectCommand = dsMotivoRejeicao.SelectCommand.Replace(":idSinistro", idSinistro);
            dsPagamentos.SelectCommand = dsPagamentos.SelectCommand.Replace(":idSinistro", idSinistro);
            dsReserva.SelectCommand = dsReserva.SelectCommand.Replace(":idSinistro", idSinistro);
            dsReservaMovimento.SelectCommand = dsReservaMovimento.SelectCommand.Replace(":idSinistro", idSinistro);
            dsReservaPendente.SelectCommand = dsReservaPendente.SelectCommand.Replace(":idSinistro", idSinistro);
            dsStatus.SelectCommand = dsStatus.SelectCommand.Replace(":idSinistro", idSinistro);
            dsLiquidacoes.SelectCommand = dsLiquidacoes.SelectCommand.Replace(":idSinistro", idSinistro);
            dsCessao.SelectCommand = dsCessao.SelectCommand.Replace(":idSinistro", idSinistro);
            dsJudicialRisco.SelectCommand = dsJudicialRisco.SelectCommand.Replace(":idSinistro", idSinistro);
            dsReservaHonDesp.SelectCommand = dsReservaHonDesp.SelectCommand.Replace(":idSinistro", idSinistro);

        }

        public string ProcessarItemCombo(object myValue, int index)
        {

            if (myValue.ToString() == "")
            {
                return "";
            }

            if (int.Parse(myValue.ToString()) == index)
            {
                return "selected";
            }

            return "";
        }
    }
}