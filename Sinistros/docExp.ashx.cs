using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Oracle.DataAccess.Client;
using Oracle.DataAccess.Types;
using System.Configuration;

namespace Sinistros
{
    /// <summary>
    /// Summary description for docExp
    /// </summary>
    public class docExp : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string str;
            str = "select bl_arquivo from sto_documento where id_arquivo=" + context.Request.QueryString["IdArquivo"];

            OracleConnection db = new OracleConnection();
            string strConstring = ConfigurationManager.ConnectionStrings["DB"].ToString();
            db.ConnectionString = strConstring;
            db.Open();

            OracleCommand cmd = new OracleCommand(str, db);
            OracleDataReader reader = cmd.ExecuteReader();

            if(reader.Read()) 
            {
                context.Response.ContentType = "image/jpeg";
                context.Response.BinaryWrite((byte[])reader[0]);
            }

            db.Close();

/*
            db.Connect()
                Dim objConnection As OracleConnection = db.objConnection
                Dim ds As New DataSet
                Dim cmd As OracleCommand = New OracleCommand(Query, objConnection)
                Dim reader As OracleDataReader = cmd.ExecuteReader()
                If reader.Read() Then 
                    context.Response.BinaryWrite(reader(0))
                End If
                db.Disconnect

            context.Response.ContentType = "text/plain";*/
//            context.Response.Write("Hello World");
//            string var = context.Request.QueryString["IdArquivo"];
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}