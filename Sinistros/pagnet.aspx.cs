using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Oracle.DataAccess.Client;
using System.Configuration;
using System.Web.Security;

namespace Sinistros
{

    public partial class testeFile : System.Web.UI.Page
    {

        PetaPoco.Database db = new PetaPoco.Database("DB");

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
                return;
            }

            string ds_arquivo; // = "SIN_INDE20140107110139";

            ds_arquivo = Request.QueryString["arquivo"];
            if (ds_arquivo == null)
                ds_arquivo = "";

            if (ds_arquivo == "1")
            {
                string sql1 = "SELECT DS_ARQUIVO FROM (SELECT DS_ARQUIVO FROM STO_PAGNET P ORDER BY P.DT_DATA DESC) WHERE ROWNUM = 1 ";
                ds_arquivo = db.ExecuteScalar<string>(sql1);
            }

            OracleConnection conn = new OracleConnection();

//            conn.ConnectionString = "Data Source=PRODUCAO;Persist Security Info=True;User ID=userqbe001;Password=siemens";
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["DB1"].ToString();

            conn.Open();

            string sql = "SELECT * FROM STO_PAGNET P WHERE P.DS_ARQUIVO = ':ARQ' ORDER BY substr(p.ds_vlinha, 4, 10) ";
            if (ds_arquivo.Trim().Length == 0)
                sql = "SELECT DISTINCT '<A href=pagnet.aspx?arquivo=' || DS_ARQUIVO || '>' || DS_ARQUIVO || '</a><br>' DS_VLINHA, DT_DATA FROM (SELECT P.DS_ARQUIVO, MAX(P.DT_DATA) DT_DATA FROM STO_PAGNET P GROUP BY P.DS_ARQUIVO) ORDER BY DT_DATA DESC";
            else
                sql = sql.Replace(":ARQ", ds_arquivo);

            OracleCommand executeQuery = new OracleCommand(sql, conn);

            OracleDataReader dr = executeQuery.ExecuteReader();

            Boolean ehVazio = true;

            Response.Clear();
            string arquivo = "";

            while (dr.Read())
            {
                ehVazio = false;
                arquivo = arquivo + (string)dr["DS_VLINHA"];
                Console.WriteLine(arquivo);
            }

            if (ehVazio)
            {
                return;
            }

            if (ds_arquivo.Trim().Length > 0)
            {
                Response.ContentType = "text/txt";
                Response.AddHeader("Content-Disposition", "attachment;filename=" + ds_arquivo + ".txt");
                try
                {
                    if (conn.ConnectionString.IndexOf("PRODUCAO") > 0)
                        System.IO.File.WriteAllText(@"\\QBE-BRZ036\ITG_Arquivos\SIT\Interface_Sinistro\APR\" + ds_arquivo + ".txt", arquivo);
                }
                catch
                {
                }

            }
            Response.Write(arquivo);
            Response.End();
        }
    }
}