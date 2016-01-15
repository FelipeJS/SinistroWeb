using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Sinistros.adm
{
    public partial class CorrecaoMonetaria : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblErro.Visible = false;
            lblMsgErro.Visible = false;
            lblMsg.Visible = false;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            PetaPoco.Database db = new PetaPoco.Database("DB");

            try
            {
                db.BeginTransaction();

                db.Execute("select sum(vl_arrecadado) from sma_cobranca");

                db.Execute("begin" +
                            "    pa_sinistros.prbatchreservascm;" +
                           "end;");
                db.CompleteTransaction();

            }
            catch (Exception ex)
            {
                db.AbortTransaction();
                lblMsgErro.Text = ex.Message;
                lblErro.Text = ex.Message;
                lblErro.Visible = true;
                lblMsgErro.Visible = true;
                lblMsg.Visible = true;
                Model.Value = "1";
            }
            finally
            {
                lblErro.Visible = true;
                lblMsgErro.Visible = true;
                lblMsg.Visible = true;
                Model.Value = "1";
            }
        }

    }
}