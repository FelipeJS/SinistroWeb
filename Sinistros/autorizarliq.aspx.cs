using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace Sinistros
{
    public partial class autorizarliq1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
                Response.End();
                return;
            }
            
            txtUsuario.Value = Session["usuario"].ToString();
            txtPerfil.Value = Session["perfil"].ToString();
        }
    }
}