using System;
using System.IO;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.VisualBasic.FileIO;
using System.Web.Security;


namespace Sinistros
{
    public partial class pagnetimp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
                return;
            }

        }

        protected void btCSVUpload_Click(object sender, EventArgs e)
        {
            if (FileUploadControl.HasFile)
            {
                try
                {
                    string currentPath = Server.MapPath("~/") +
                                  Path.GetFileName(FileUploadControl.FileName);
                    FileUploadControl.SaveAs(currentPath);

                    gvCSVData.DataSource = GetDataTableFromCSVFile(currentPath);
                    gvCSVData.DataBind();
                    lbStatus.Text = "Status: Arquivo processado!";

//                    File.Delete(currentPath);
                }
                catch (Exception ex)
                {
                    lbStatus.Text = @"Status: O arquivo não pode ser processado. 
                    Ocorreu o seguinte erro: " + ex.Message;
                }
            }
            else
            {
                lbStatus.Text = "Status: Arquivo não encontrado.";
            }
        }

        private static DataTable GetDataTableFromCSVFile(string csvfilePath)
        {

            PetaPoco.Database db = new PetaPoco.Database("DB");
            
            string comando = "begin ";
            DataTable csvData = new DataTable();
            using (TextFieldParser csvReader = new TextFieldParser(csvfilePath))
            {

                csvReader.TextFieldType = FieldType.FixedWidth;
                csvReader.SetFieldWidths(573, 25, 479, 14, 181, 8, 1, 18, 161, 3);

                //Read columns from CSV file, remove this line if columns not exits  
                string[] colFields = csvReader.ReadFields();

                foreach (string column in colFields)
                {
                    DataColumn datecolumn = new DataColumn(column);
                    datecolumn.AllowDBNull = true;

                    switch (csvData.Columns.Count)
                    {
                        case 0:
                            datecolumn.ColumnName = "OP";
                            break;
                        case 1:
                            datecolumn.ColumnName = "Sinistro";
                            break;
                        case 2:
                            datecolumn.ColumnName = "Erro";
                            break;
                    }                    
                    if(csvData.Columns.Count<3) csvData.Columns.Add(datecolumn);
                }

                int executar;

                if (colFields[9] == "003")
                {
                    executar = db.ExecuteScalar<int>("select count(*) from ctb_op o where o.id_status not in (k.STATUS_OP_PAGO, k.STATUS_OP_CANCELADO, k.STATUS_OP_REJEITADO) and o.id_op =" + colFields[1]);

                    if (executar == 1)
                        comando = comando + " pa_sinistros.prcierraop(vnidop => " + colFields[1] + ", " +
                                                                    "vdcancelacion => to_date('" + colFields[5].Substring(6, 2) + "/" + colFields[5].Substring(4, 2) + "/" + colFields[5].Substring(0, 4) + "', 'dd/mm/yyyy') ); ";
                    else
                        csvData.Rows.Add(new string[3] { colFields[1], colFields[3], "Status da OP invalido!" });
                }

                //Felipe Campos - Atualização de Status
                if (colFields[9] == "004" || colFields[9] == "005")
                {
                    executar = db.ExecuteScalar<int>("select count(*) from ctb_op o where o.id_status not in (k.STATUS_OP_PAGO) and o.id_op =" + colFields[1]);
                    
                    if (executar == 1)
                        comando = comando + "update ctb_op set id_status = 5 where id_op =" + colFields[1];
                    else
                        csvData.Rows.Add(new string[3] { colFields[1], colFields[3], "Status da OP invalido!" });
                }

                while (!csvReader.EndOfData)
                {

                    string[] fieldData = csvReader.ReadFields();
                    //Making empty value as null
                    for (int i = 0; i < fieldData.Length; i++)
                    {
                        if (fieldData[i] == "")
                        {
                            fieldData[i] = null;
                        }
                    }
//                    csvData.Rows.Add(fieldData);

                    if (fieldData[9] == "003")
                    {

                        executar = db.ExecuteScalar<int>("select count(*) from ctb_op o where o.id_status not in (k.STATUS_OP_PAGO, k.STATUS_OP_CANCELADO, k.STATUS_OP_REJEITADO) and o.id_op =" + fieldData[1]);

                        if (executar == 1)
                            comando = comando + " pa_sinistros.prcierraop(vnidop => " + fieldData[1] + ", " +
                                                                        "vdcancelacion => to_date('" + fieldData[5].Substring(6, 2) + "/" + fieldData[5].Substring(4, 2) + "/" + fieldData[5].Substring(0, 4) + "', 'dd/mm/yyyy') ); ";
                        else
                            csvData.Rows.Add(new string[3] { fieldData[1], fieldData[3], "Status da OP invalido!" });
                    }

                    //Felipe Campos - Atualização de Status
                    if (colFields[9] == "004" || colFields[9] == "005")
                    {
                        executar = db.ExecuteScalar<int>("select count(*) from ctb_op o where o.id_status not in (k.STATUS_OP_PAGO) and o.id_op =" + colFields[1]);

                        if (executar == 1)
                            comando = comando + "update ctb_op set id_status = 5 where id_op =" + colFields[1];
                        else
                            csvData.Rows.Add(new string[3] { colFields[1], colFields[3], "Status da OP invalido!" });
                    }
                }
            }

            if (comando != "begin ")
            {
                comando = comando + " end; ";
                db.Execute(comando);
                db.Execute("commit");
            }
            return csvData;
        }

    }
}