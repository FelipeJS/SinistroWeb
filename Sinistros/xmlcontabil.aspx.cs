using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Web.Security;
using System.Configuration;

namespace Sinistros
{
    public partial class xmlcontabil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

//            if (!this.Page.User.Identity.IsAuthenticated)
//            {
//                FormsAuthentication.RedirectToLoginPage();
//                return;
//            }

            Response.Cookies["UserSettings"]["fileDownload"] = "true";
            Response.Cookies["UserSettings"]["path"] = "/";
            Response.Cookies["UserSettings"].Expires = DateTime.Now.AddDays(1d);

            Int32 tipoOrigem = 0;
            string sql = "";

            OracleConnection conn = new OracleConnection();

            //            conn.ConnectionString = "Data Source=PRODUCAO;Persist Security Info=True;User ID=userqbe001;Password=siemens";
            conn.ConnectionString = ConfigurationManager.ConnectionStrings["DB"].ToString();

            conn.Open();

            sql = dsSinistro.SelectCommand.Replace(":dt1", "'" + Request.QueryString["dtIni"] + "'").Replace(":dt2", "'" + Request.QueryString["dtFim"] + "'");

            OracleCommand executeQuery = new OracleCommand(sql, conn);

            OracleDataReader dr = executeQuery.ExecuteReader();

            Boolean ehVazio = true;

            XmlDocument doc = new XmlDocument();
            XmlNode docNode = doc.CreateXmlDeclaration("1.0", "UTF-8", null);
            doc.AppendChild(docNode);

            XmlNode SSCNode = doc.CreateElement("SSC");
            doc.AppendChild(SSCNode);

            XmlNode PayLoadNode = doc.CreateElement("PayLoad");
            SSCNode.AppendChild(PayLoadNode);

            XmlNode LedgerNode = doc.CreateElement("Ledger");
            PayLoadNode.AppendChild(LedgerNode);


            while (dr.Read())
            {
                ehVazio = false;
                try
                {
                    tipoOrigem = Int32.Parse((string)dr["AnalysisCode1"]);
                }
                catch
                {
                    tipoOrigem = 0;
                }
                Console.WriteLine(tipoOrigem);

                XmlNode LineNode = doc.CreateElement("Line");
                LedgerNode.AppendChild(LineNode);

                XmlNode AccountCode = doc.CreateElement("AccountCode");
                AccountCode.InnerText = (string)dr["AccountCode"];
                LineNode.AppendChild(AccountCode);

                XmlNode AccountingPeriod = doc.CreateElement("AccountingPeriod");
                AccountingPeriod.InnerText = (string)dr["AccountingPeriod"];
                LineNode.AppendChild(AccountingPeriod);


                XmlNode AnalysisCode1 = doc.CreateElement("AnalysisCode1");
                try
                {
                    AnalysisCode1.InnerText = (string)dr["AnalysisCode1"];
                }
                catch
                {
                    AnalysisCode1.InnerText = "0000";
                }
                LineNode.AppendChild(AnalysisCode1);

                XmlNode AnalysisCode2 = doc.CreateElement("AnalysisCode2");
                AnalysisCode2.InnerText = (string)dr["AnalysisCode2"];
                LineNode.AppendChild(AnalysisCode2);

                XmlNode AnalysisCode3 = doc.CreateElement("AnalysisCode3");
                AnalysisCode3.InnerText = (string)dr["AnalysisCode3"];
                LineNode.AppendChild(AnalysisCode3);

                XmlNode AnalysisCode4 = doc.CreateElement("AnalysisCode4");
                AnalysisCode4.InnerText = (string)dr["AnalysisCode4"];
                LineNode.AppendChild(AnalysisCode4);

                XmlNode AnalysisCode5 = doc.CreateElement("AnalysisCode5");
                AnalysisCode5.InnerText = (string)dr["AnalysisCode5"];
                LineNode.AppendChild(AnalysisCode5);

                XmlNode AnalysisCode6 = doc.CreateElement("AnalysisCode6");
                AnalysisCode6.InnerText = (string)dr["AnalysisCode6"];
                LineNode.AppendChild(AnalysisCode6);

                XmlNode AnalysisCode7 = doc.CreateElement("AnalysisCode7");
                AnalysisCode7.InnerText = (string)dr["AnalysisCode7"];
                LineNode.AppendChild(AnalysisCode7);

                XmlNode AnalysisCode8 = doc.CreateElement("AnalysisCode8");
                AnalysisCode8.InnerText = (string)dr["AnalysisCode8"];
                LineNode.AppendChild(AnalysisCode8);

                XmlNode AnalysisCode9 = doc.CreateElement("AnalysisCode9");
                AnalysisCode9.InnerText = (string)dr["AnalysisCode9"];
                LineNode.AppendChild(AnalysisCode9);

                XmlNode BaseRate = doc.CreateElement("BaseRate");
                BaseRate.InnerText = (string)dr["ConversionRate"];
                LineNode.AppendChild(BaseRate);

                XmlNode TransactionAmount = doc.CreateElement("TransactionAmount");
                TransactionAmount.InnerText = (string)dr["TransactionAmount"];
                LineNode.AppendChild(TransactionAmount);

                XmlNode CurrencyCode = doc.CreateElement("CurrencyCode");
                CurrencyCode.InnerText = (string)dr["CurrencyCode"];
                LineNode.AppendChild(CurrencyCode);

                XmlNode Description = doc.CreateElement("Description");
                Description.InnerText = (string)dr["Description"];
                LineNode.AppendChild(Description);

                XmlNode DebitCredit = doc.CreateElement("DebitCredit");
                DebitCredit.InnerText = (string)dr["DebitCredit"];
                LineNode.AppendChild(DebitCredit);

                XmlNode JournalSource = doc.CreateElement("JournalSource");
                JournalSource.InnerText = (string)dr["JournalSource"];
                LineNode.AppendChild(JournalSource);

                XmlNode JournalType = doc.CreateElement("JournalType");
                JournalType.InnerText = (string)dr["JournalType"];
                LineNode.AppendChild(JournalType);

                XmlNode TransactionDate = doc.CreateElement("TransactionDate");
                TransactionDate.InnerText = (string)dr["TransactionDate"];
                LineNode.AppendChild(TransactionDate);

                XmlNode TransactionReference = doc.CreateElement("TransactionReference");
                TransactionReference.InnerText = (string)dr["TransactionReference"];
                LineNode.AppendChild(TransactionReference);

            }

//            Response.Clear(); //optional: if we've sent anything before
//            Response.ContentType = "text/xml"; //must be 'text/xml'
//            Response.ContentEncoding = System.Text.Encoding.UTF8; //we'd like UTF-8
//            doc.Save(Response.Output); //save to the text-writer
            //using the encoding of the text-writer 
            //(which comes from response.contentEncoding)
//            Response.End(); //optional: will end processing


            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            Response.AddHeader("Content-Disposition", "attachment; filename=FechamentoMensal.xml");
//            Response.AddHeader("Content-Length", file.Length.ToString());
            Response.ContentType = "text/plain";
            Response.ContentEncoding = System.Text.Encoding.UTF8; //we'd like UTF-8
            doc.Save(Response.Output); //save to the text-writer
            Response.Flush();
//            Response.TransmitFile("FechamentoMensal.xml");
            Response.End();

        }
    }
}