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
    public partial class docImp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Context.Request.QueryString["idsinistro"] != null)
            {
                txtIdSinistro.Value = Context.Request.QueryString["idsinistro"];
            }


            if (Context.Request.QueryString["IdArquivo"] != null)
            {
                blah.Src = "docExp.ashx?IdArquivo=" + Context.Request.QueryString["IdArquivo"];
                FileUploadControl.Enabled = false;
                txtDescricao.Enabled = false;
                btSalvar.Enabled = false;
                lbStatus.Text = "";
            }

        }

        protected void btDocUpload_Click(object sender, EventArgs e)
        {
            if (FileUploadControl.HasFile == false || string.IsNullOrEmpty(txtDescricao.Text))
            {
                lbStatus.Text = "Por favor escolha o arquivo e preencha o campo de descrição.";
            }
            else
            {
                //*** Read Binary Data ***
                byte[] imbByte = new byte[FileUploadControl.PostedFile.InputStream.Length];
                FileUploadControl.PostedFile.InputStream.Read(imbByte, 0, imbByte.Length);

                //*** MimeType ***
                string ExtType = System.IO.Path.GetExtension(FileUploadControl.PostedFile.FileName).ToLower();
                string strMIME = null;
                switch (ExtType)
                {
                    case ".gif":
                        strMIME = "gif";
                        break;
                    case ".jpg":
                    case ".jpeg":
                    case ".jpe":
                        strMIME = "jpeg";
                        break;
                    case ".png":
                        strMIME = "png";
                        break;
                    default:
                        strMIME = ExtType;
                        break;
                }

                //*** Insert to Database ***
                OracleConnection objConn = new OracleConnection();
                string strConstring = null;
                string strORACLE = null;

                strConstring = ConfigurationManager.ConnectionStrings["DB"].ToString();

                strORACLE = "INSERT INTO STO_DOCUMENTO (ID_SINISTRO, ID_ARQUIVO, DS_DESCRICAO, DS_TIPO, BL_ARQUIVO) " +
                            "VALUES (:IdSinistro, NVL((SELECT MAX(ID_ARQUIVO) FROM STO_DOCUMENTO),0) + 1, :DsDescricao, :DsTipo, :BlArquivo)";
                objConn.ConnectionString = strConstring;
                objConn.Open();

                OracleCommand objCmd = new OracleCommand(strORACLE, objConn);
                objCmd.Parameters.Add(":IdSinistro", OracleDbType.Int32).Value = txtIdSinistro.Value;
                objCmd.Parameters.Add(":DsDescricao", OracleDbType.Varchar2).Value = txtDescricao.Text;
                objCmd.Parameters.Add(":DsTipo", OracleDbType.Varchar2).Value = strMIME;
                objCmd.Parameters.Add(":BlArquivo", OracleDbType.Blob).Value = imbByte;
                objCmd.ExecuteNonQuery();

                objConn.Close();
                objConn = null;

                lbStatus.Text = "Arquivo gravado com sucesso.";
                btSalvar.Enabled = true;
                btCancelar.Text = "Fechar";
                FileUploadControl.Enabled = true;
            }

        }
    }
}