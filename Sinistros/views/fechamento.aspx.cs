using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;

namespace Sinistros.views
{
    public partial class Fechamento : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void btnGerarXML_Click(object sender, EventArgs e)
        {

            PetaPoco.Database db = new PetaPoco.Database("DB");

            DateTime _dtInicio = DateTime.ParseExact(DtInicio.Value, "dd/MM/yyyy", null);
            DateTime _dtFim = DateTime.ParseExact(DtFim.Value, "dd/MM/yyyy", null);

            _dtFim = _dtFim.AddDays(1);

            if (chkCongelarXML.Checked)
            {
                db.Execute("update sto_parametro p set p.dt_proximo_xml = to_date(to_char(last_day(sysdate) + 1, 'dd/mm/yyyy'), 'dd/mm/yyyy')");

                db.Execute("commit");
                return;

            }

            string strServico = "/xmlcontabil.aspx?dtIni=" + _dtInicio.ToString("ddMMyyyy") + "&dtFim=" + _dtFim.ToString("ddMMyyyy");

            Response.Redirect(strServico);
        }
    }
}