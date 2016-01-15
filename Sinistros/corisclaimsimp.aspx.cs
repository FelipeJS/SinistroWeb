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
using System.Configuration;
using System.Data.OleDb;
using Oracle.DataAccess.Client;

namespace Sinistros
{
    public partial class corisclaimsimp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.Page.User.Identity.IsAuthenticated)
            {
                FormsAuthentication.RedirectToLoginPage();
                return;
            }

        }

        protected void btProcessar_Click(object sender, EventArgs e)
        {
            PetaPoco.Database db = new PetaPoco.Database("DB");

            db.BeginTransaction();

            try
            {
                // primeiro lançamento
                int idReservaIni = 1 + db.ExecuteScalar<int>("select max(id_reserva) from sto_reserva where id_reserva < 1233426");

                // insere sinistros
 
string sqlString = "DECLARE\n" +
"\n" + 
"   cursor c1 is\n" + 
"\n" + 
"SELECT C.ID_SINISTRO, ROUND(C.VALOR, 2) VALOR FROM\n" + 
"CORIS_CLAIMS_SINISTROS C\n" + 
"WHERE ID_SINISTRO IS NOT NULL;\n" + 
"\n" + 
"vTpStatus NUMBER;\n" + 
"vTotalReserva NUMBER;\n" + 
"vIdLiq NUMBER;\n" + 
"vIdOp NUMBER;\n" + 
"vIniOp NUMBER;\n" + 
"vFimOp NUMBER;\n" + 
"vIdUsuario NUMBER;\n" + 
"\n" + 
"BEGIN\n" + 
"\n" + 
"   select max(o.id_op) + 1 into vIniOp from ctb_op o where o.id_op < 999967891;\n" + 
"\n" + 
"   FOR sinistro_rec in c1\n" + 
"   LOOP\n" + 
"\n" + 
"     dbms_output.put_line(sinistro_rec.id_sinistro);\n" + 
"\n" + 
"     pa_sinistros.prGrabaReserva(vnIdSinistro    => sinistro_rec.id_sinistro, vnValor         => sinistro_rec.valor,\n" + 
"                                 vcEvento        => 'J', vnTpMoneda      => 0, vnTPValor       => 1, vbContabil      => '1');\n" + 
"\n" + 
"     --Grava liquidacao\n" + 
"     --Se for acima da autority do Anielo, informar a autority do Helio 164\n" + 
"     if sinistro_rec.valor > 9999 then -- Helio\n" + 
"        vIdUsuario := 164;\n" + 
"     else\n" + 
"        vIdUsuario := 1000;\n" + 
"     end if;\n" + 
"\n" + 
"     pa_sinistros.prGrabaLiquidacion(vnidsinistro => sinistro_rec.id_sinistro,vnidusuario => vIdUsuario, vntpvalor => 1,vcfl_pagto => 'T',vnvalor =>   sinistro_rec.valor);\n" + 
"                  select max(l.id_liquidacao) into vIdLiq from sto_liquidacao l where l.id_sinistro = sinistro_rec.id_sinistro;\n" +
"                  pa_sinistros.prGrabaOp(vntpop => 1,vdpagamento => sysdate + " + txtDiasPagto.Text + ",vcfavorecido => 'APRIL BRASIL TUR VIAG E ASSIST. INTER S/A',\n" + 
"                                         vnvalorpagamento => sinistro_rec.valor, vntpmoeda => 0,vnidusuario => 370,vntppagamento => 1,vnidpessoa => 54968,\n" + 
"                                         vniddocto => 88379,vnidliquidacao => vIdLiq,vnidconta => 5939,vbIncompleto => 0,vnidsinistro =>  sinistro_rec.id_sinistro);\n" +
"     update sto_liquidacao set fl_status = 'A' where id_sinistro = sinistro_rec.id_sinistro;\n" + 
"   END LOOP;\n" + 
"\n" + 
"   select max(o.id_op) into vFimOp from ctb_op o where o.id_op < 999967891;\n" + 
"\n" + 
"   delete tmp_op_pagnet;\n" + 
"   FOR vIdOp IN  vIniOp .. vFimOp LOOP\n" + 
"      insert into tmp_op_pagnet values (1, vIdOp);\n" + 
"   END LOOP;\n" + 
"   pa_pgn_aquivos.prgeneraopindemnizacion;\n" + 
"\n" + 
"END;";
                    

                db.Execute(sqlString);

                db.Execute("commit");

                // retorna os sinistros gerados
                OracleConnection conn = new OracleConnection();

                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DB"].ToString();

                conn.Open();

                sqlString = "select sum(r.vl_reserva) valor, count(*) quantidade from sto_reserva r where r.id_reserva < 1233426 and r.id_reserva >= " + idReservaIni;

                OracleCommand executeQuery = new OracleCommand(sqlString, conn);

                OracleDataReader dr = executeQuery.ExecuteReader();

                DataTable dt = new DataTable();

                dt.Load(dr);

                gvCSVData.DataSource = dt;
                gvCSVData.DataBind();

                lbStatus.Text = "Status: Arquivo processado com sucesso! - Os valores gerados estão na tabela abaixo.";
                pnProcessar.Visible = false;

            }
            catch
            {
                db.AbortTransaction();
                return;
            }

            db.CompleteTransaction();
        }

        protected void btCSVUpload_Click(object sender, EventArgs e)
        {
            if (FileUploadControl.HasFile)
            {
                //                try
                //                {

                try
                {
                    string currentPath = Server.MapPath("~/") +
                                  Path.GetFileName(FileUploadControl.FileName);
                    FileUploadControl.SaveAs(currentPath);

                    string Extension = Path.GetExtension(FileUploadControl.PostedFile.FileName);

                    gvCSVData.DataSource =
                        GetDataTableFromExcelFile(currentPath, Extension);

                    //                    gvCSVData.DataSource = GetDataTableFromCSVFile(currentPath);
                    gvCSVData.DataBind();
                    lbStatus.Text = "Status: Arquivo importado! - Os registros abaixo não serão processados. Sinistros não cadastrados.";
                    pnProcessar.Visible = true;

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

        protected DataTable GetDataTableFromExcelFile(string currentPath, string Extension)
        {
            string conStr = "";
            switch (Extension)
            {
                case ".xls": //Excel 97-03
                    conStr = ConfigurationManager.ConnectionStrings["Excel03ConString"]
                             .ConnectionString;
                    break;
                case ".xlsx": //Excel 07
                    conStr = ConfigurationManager.ConnectionStrings["Excel07ConString"]
                              .ConnectionString;
                    break;
            }
            conStr = String.Format(conStr, currentPath, "Yes");
            OleDbConnection connExcel = new OleDbConnection(conStr);
            OleDbCommand cmdExcel = new OleDbCommand();
            OleDbDataAdapter oda = new OleDbDataAdapter();
            DataTable dt = new DataTable();
            cmdExcel.Connection = connExcel;

            //Get the name of First Sheet
            connExcel.Open();
            DataTable dtExcelSchema;
            dtExcelSchema = connExcel.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            string SheetName = dtExcelSchema.Rows[0]["TABLE_NAME"].ToString();
            connExcel.Close();

            //Read Data from First Sheet
            try
            {
                connExcel.Open();
                cmdExcel.CommandText = "SELECT * From ['Paid Cases$']";
                oda.SelectCommand = cmdExcel;
                oda.Fill(dt);
                connExcel.Close();
            }
            catch (Exception ex)
            {
                throw new Exception("Não foi possível ler da planilha 'Paid Cases'");
            }

            OracleConnection conn = new OracleConnection();

            conn.ConnectionString = ConfigurationManager.ConnectionStrings["DB"].ToString();

            conn.Open();

            OracleCommand oc = new OracleCommand("", conn);

            try
            {
                oc.CommandText = "DROP TABLE coris_claims";
                oc.ExecuteNonQuery();
                oc.CommandText = "DROP TABLE coris_claims_sinistros";
                oc.ExecuteNonQuery();
            }
            catch { };

            oc.CommandText = "CREATE TABLE coris_claims (CLAIM_CODE  varchar2(100), CLAIM_POLICE_CODE  varchar2(100), NCASO_OUTRA_CENTRAL  varchar2(100), TITULAR varchar2(200), VALOR NUMBER ) ";
            oc.ExecuteNonQuery();

            foreach (DataRow dtRow in dt.Rows)
            {

                if (dtRow["CASE NUMBER"].ToString().Trim() == "") continue;

                oc.CommandText = "insert into coris_claims select '" +
                    dtRow["CASE NUMBER"].ToString() + "' CLAIM_CODE, '" +
                    dtRow["VOUCHER"].ToString() + "' CLAIM_POLICE_CODE, '" + "' NCASO_OUTRA_CENTRAL, '" +
                    dtRow["SEGURADO / BENEFICIARIO"].ToString() + "' TITULAR, " +
                    dtRow["Valor R$"].ToString().Replace(",",".") + " VALOR" +
                    " from dual";
                if (dtRow["CASE NUMBER"].ToString() != "") 
                    try 
                    {
                    oc.ExecuteNonQuery();
                    }
                    catch {
                        oc.CommandText = "insert into coris_claims select '' CLAIM_CODE, '' CLAIM_POLICE_CODE, '" + 
                            "' NCASO_OUTRA_CENTRAL, '" +
                            dtRow["SEGURADO / BENEFICIARIO"].ToString() + "' TITULAR, " +
                            dtRow["Valor R$"].ToString().Replace(",", ".") + " VALOR" +
                            " from dual";
                            oc.ExecuteNonQuery();
                    };
            }

            oc.CommandText = "CREATE TABLE coris_claims_sinistros AS " +
                "SELECT C.Claim_Code, C.TITULAR, C.VALOR,\n" +
            "(SELECT MAX(S.ID_SINISTRO) FROM SMA_SINISTRO S WHERE S.ID_SEGURADO =\n" +
            "COALESCE(\n" +
            "(SELECT MAX(SEG.ID_SEGURADO) FROM SMA_SEGURADO SEG WHERE SEG.CD_ESTIPULANTE = 9902 AND\n" +
            "            SEG.CD_CLIENTE_ETP = REPLACE(REPLACE(REPLACE(C.Claim_Code, '/',''), '-',''), '.','')\n" +
            "            ),\n" +
            "(SELECT MAX(SEG.ID_SEGURADO) FROM SMA_SEGURADO SEG WHERE SEG.CD_ESTIPULANTE = 9902 AND\n" +
            "            '0' || SEG.CD_CLIENTE_ETP = REPLACE(REPLACE(REPLACE(C.Claim_Code, '/',''), '-',''), '.','')\n" +
            "            ),\n" +
            "(SELECT MAX(SEG.ID_SEGURADO) FROM SMA_SEGURADO SEG WHERE SEG.CD_ESTIPULANTE = 9902 AND\n" +
            "            SEG.CD_CLIENTE_ETP = REPLACE(REPLACE(REPLACE(C.CLAIM_POLICE_CODE, '/',''), '-',''), '.','')\n" +
            "            ),\n" +
            "(SELECT MAX(SEG.ID_SEGURADO) FROM SMA_SEGURADO SEG WHERE SEG.CD_ESTIPULANTE = 9902 AND\n" +
            "            SEG.CD_CLIENTE_ETP = REPLACE(REPLACE(REPLACE(REPLACE(C.Claim_Code, '/',''), '0-',''), '.',''), '-','')\n" +
            "            ),\n" +
            "(SELECT MAX(SEG.ID_SEGURADO) FROM SMA_SEGURADO SEG WHERE SEG.CD_ESTIPULANTE = 9902 AND\n" +
            "            SEG.Ds_Chave_Etp = REPLACE(REPLACE(REPLACE(C.Claim_Code, '/',''), '-',''), '.','')\n" +
            "            ),\n" +
            "(SELECT MAX(SEG.ID_SEGURADO) FROM SMA_SEGURADO SEG WHERE SEG.CD_ESTIPULANTE = 9902 AND\n" +
            "            SEG.Ds_Chave_Etp = REPLACE(REPLACE(REPLACE(C.CLAIM_POLICE_CODE, '/',''), '-',''), '.','')\n" +
            "            ),\n" +
            "(SELECT MAX(SEG.ID_SEGURADO) FROM SMA_SEGURADO SEG WHERE SEG.CD_ESTIPULANTE = 9902 AND\n" +
            "            SEG.Ds_Chave_Etp = REPLACE(REPLACE(REPLACE(REPLACE(C.Claim_Code, '/',''), '0-',''), '.',''), '-','')\n" +
            "            ),\n" +
            "(SELECT MAX(SEG.ID_SEGURADO) FROM SMA_SEGURADO SEG WHERE SEG.CD_ESTIPULANTE = 9902 AND\n" +
            "            SEG.CPF = REPLACE(REPLACE(REPLACE(REPLACE(C.CLAIM_POLICE_CODE, '/',''), '0-',''), '.',''), '-','')\n" +
            "            ),\n" +
            "(SELECT MAX(SEG.ID_SEGURADO) FROM SMA_SEGURADO SEG WHERE SEG.CD_ESTIPULANTE = 9902 AND\n" +
            "            '0' || SEG.CPF = REPLACE(REPLACE(REPLACE(REPLACE(C.CLAIM_POLICE_CODE, '/',''), '0-',''), '.',''), '-','')\n" +
            "            ),\n" +
            "(SELECT MAX(SEG.ID_SEGURADO) FROM SMA_SEGURADO SEG WHERE SEG.CD_ESTIPULANTE = 9902 AND SEG.DS_CLIENTE = TRIM(C.TITULAR)\n" +
            "            ))\n" +
            ") id_sinistro \n" +
            "FROM CORIS_CLAIMS C";

            oc.ExecuteNonQuery();

            string sql = "select c.*, " +
                         "       case when id_sinistro is null then 'SINISTRO NAO ENCONTRADO' end STATUS " +
                         "  from coris_claims_sinistros c where id_sinistro is null";

            OracleCommand executeQuery = new OracleCommand(sql, conn);

            OracleDataReader dr = executeQuery.ExecuteReader();

            dt = new DataTable();

            dt.Load(dr);

            return dt;

            //Bind Data to GridView
            //           GridView1.Caption = Path.GetFileName(FilePath);
            //           GridView1.DataSource = dt;
            //           GridView1.DataBind();
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
                    csvData.Columns.Add(datecolumn);
                }

                comando = comando + " pa_sinistros.prcierraop(vnidop => " + colFields[1] + ", " +
                                                             "vdcancelacion => to_date('" + colFields[5].Substring(6, 2) + "/" + colFields[5].Substring(4, 2) + "/" + colFields[5].Substring(0, 4) + "', 'dd/mm/yyyy') ); ";

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
                    csvData.Rows.Add(fieldData);

                    if (fieldData[9] == "003")
                    {
                        comando = comando + " pa_sinistros.prcierraop(vnidop => " + fieldData[1] + ", " +
                                                                     "vdcancelacion => to_date('" + fieldData[5].Substring(6, 2) + "/" + fieldData[5].Substring(4, 2) + "/" + fieldData[5].Substring(0, 4) + "', 'dd/mm/yyyy') ); ";
                    }
                }
            }

            comando = comando + " end; ";
            db.Execute(comando);
            db.Execute("commit");

            return csvData;
        }

    }
}