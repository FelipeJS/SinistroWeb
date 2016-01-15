using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Sinistros
{
    public partial class autorizarliq : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            txtUsuario.Value = Session["usuario"].ToString();

        }
    }
}