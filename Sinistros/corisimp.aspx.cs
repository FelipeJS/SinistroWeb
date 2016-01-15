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
    public partial class corisimp : System.Web.UI.Page
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
                // primeiro sinistro
                int idSinistroIni = 1 + db.ExecuteScalar<int>("select max(id_sinistro) from sma_sinistro where id_sinistro < 900000");

                // insere sinistros
                string sqlString = "INSERT INTO SMA_SINISTRO SI\n" +
"                (SI.ID_SINISTRO, SI.NR_SINISTRO_AON, SI.NR_SINISTRO, SI.FL_STATUS, SI.CD_CIA, SI.ID_SEGURADO, SI.FL_STATUS_LEGADO, SI.FL_DOCUMENTOS_RECEBIDOS, SI.FL_CATASTROFE,\n" +
"                 SI.DT_CADASTRO, SI.DT_MODIFICACAO, SI.DT_ULT_CONSULTA, SI.TP_SINISTRO,\n" +
"                 SI.DT_OCORRENCIA, SI.DT_AVISO, SI.DS_SINISTRO, SI.ID_SEGURO, SI.ID_CAUSA,\n" +
"                 SI.ID_USUARIO, SI.NR_CONTRATO, SI.VL_SALDO_DEVEDOR, SI.ID_APOLICE, SI.ID_ENDOSSO, SI.CD_COBER)\n" +
"\n" +
"                -- Corrigir numeração SUSEP\n" +
"                SELECT\n" +
"                (select max(id_sinistro) from sma_sinistro where id_sinistro < 900000) + ROWNUM,\n" +
"                0,\n" +
"                 '0769' || lpad((select ss.nm_sequencia\n" +
"                              from sto_seq_susep ss where ss.cd_sucursal = '07' and ss.cd_ramo = '69' and to_char(ss.nm_ano) = to_char(sysdate, 'yyyy')) + ROWNUM, 6, 0) ||\n" +
"                            to_char(sysdate, 'yyyy') SinistroSUSEP,\n" +
"                'A', 04, S.ID_SEGURADO, 0, 0, 0, SYSDATE, SYSDATE, SYSDATE, 1, TO_DATE( replace(replace(X.CASE_OPENED_ON, ' 12:00:00 AM', ''), ' 00:00:00', ''), 'DD/MM/YYYY'), SYSDATE - 7, '' NM_ARQUIVO,\n" +
"                (SELECT MIN(SEG.ID_SEGURO) FROM SMA_SEGURO SEG WHERE SEG.ID_SEGURADO = S.ID_SEGURADO AND SEG.NR_SEGURO = 1),\n" +
"                8, 370, X.CASE_NUMBER, X.VALOR_SINISTRO\n" +
", X.ID_APOLICE, X.ID_ENDOSSO,\n" +
"NVL(DECODE(upper(X.TYPE_OF_CLAIM),\n" +
"'ACCIDENT',\t107,\n" +
"'ACCIDENT AND FUNERAL REPATRIATIONS',\t95,\n" +
"'ACCIDENT AND REPATRIATION',\t99,\n" +
"'COMPENSATION FOR LOST BAGGAGE DELAY',\t216,\n" +
"'DENTAL',\t107,\n" +
"'EARLY RETURN',\t100,\n" +
"'INDEMNITY TRIP CANCELLATION',\t78,\n" +
"'INFORMATION',\t213,\n" +
"'LOST / STOLEN DOCUMENTS',\t213,\n" +
"'LOST LUGGAGE',\t216,\n" +
"'PAY COMMISSION AGENT OF TRIP CANCELLATION',\t78,\n" +
"'REIMBURSEMENT OF EXPENSES FOR DELAY OR CANCELLATION OF FLIGHT',\t79,\n" +
"'SICKNESS',\t107,\n" +
"'SICKNESS AND FUNERAL REPATRIATIONS',\t95,\n" +
"'SICKNESS AND REPATRIATION',\t99,\n" +
"'THEFT',\t77,\n" +
"'VIOLATION / THEFT OR DAMAGED LUGGAGE',\t97,\n" +
"'FLIGHT: MISSED CONNECTION',\t79,\n" +
"'ILLNESS/DEATH OF RELATIVE',\t100,\n" +
"'MEDICAL: DEATH',\t91,\n" +
"'WEATHER',\t79,\n" +
"'OUTPATIENT',\t107,\n" +
"'TRIP INTERRUPTION',\t93,\n" +
"'DOCTOR''S VISIT',\t107), 213) \n" +
"\n" +
"                FROM CORIS X\n" +
"                INNER JOIN SMA_SEGURADO S\n" +
"                ON S.ID_SEGURADO = X.ID_SEGURADO\n" +
"                WHERE X.ID_ENDOSSO IS NOT NULL";

                db.Execute(sqlString);

                // ultimo sinistro
                int idSinistroFim = db.ExecuteScalar<int>("select max(id_sinistro) from sma_sinistro where id_sinistro < 900000");

                // insere status
                sqlString = "BEGIN\n" +
                "   FOR i IN " + idSinistroIni + ".." + idSinistroFim + " LOOP\n" +
                "      pa_sinistros.prCambiaEstadoSiniestro(i, k.STATUS_PREAVISO, 370);\n" +
                "      pa_sinistros.prCambiaEstadoSiniestro(i, k.STATUS_AVISO, 370);\n" +
                "   END LOOP;\n" +
                "END;";
                db.Execute(sqlString);

                // insere reserva
                sqlString = "DECLARE\n" +
                "   vSaldo NUMBER := 0;\n" +
                "BEGIN\n" +
                "   FOR i IN " + idSinistroIni + ".." + idSinistroFim + " LOOP\n" +
                "      select s.vl_saldo_devedor into vSaldo from sma_sinistro s where s.id_sinistro = i;\n" +
                "      pa_sinistros.prGrabaReservaAviso(i, vSaldo, 0, 1, 370);\n" +
                "   END LOOP;\n" +
                "END;";
                db.Execute(sqlString);

                // gera OP
                sqlString = "DECLARE\n" +
                "   vSaldo NUMBER := 0;\n" +
                "   vIdLiq NUMBER := 0;\n" +
                "BEGIN\n" +
                "   FOR i IN " + idSinistroIni + ".." + idSinistroFim + " LOOP\n" +
                "      select s.vl_saldo_devedor into vSaldo from sma_sinistro s where s.id_sinistro = i;\n" +
                    "  pa_sinistros.prGrabaLiquidacion(vnidsinistro => i," +
                    "                                  vnidusuario => 370," +
                    "                                  vntpvalor => 1," +
                    "                                  vcfl_pagto => 'T'," +
                    "                                  vnvalor => vSaldo);" +
                "      select l.id_liquidacao into vIdLiq from sto_liquidacao l where l.id_sinistro = i;\n" +
                    "  pa_sinistros.prGrabaOp(vntpop => 1," +
                    "                         vdpagamento => sysdate + 1," +
                    "                         vcfavorecido => 'APRIL BRASIL TUR VIAG E ASSIST. INTER S/A'," +
                    "                         vnvalorpagamento => vSaldo," +
                    "                         vntpmoeda => 0," +
                    "                         vnidusuario => 370," +
                    "                         vntppagamento => 1," +
                    "                         vnidpessoa => 54968," +
                    "                         vniddocto => 88379," +
                    "                         vnidliquidacao => vIdLiq," +
                    "                         vnidconta => 5939," +
                    "                         vbIncompleto => 0," +
                    "                         vnidsinistro =>  i); " +
                "   END LOOP;\n" +
                "END;";
                db.Execute(sqlString);

                // gera arquivo pagnet
                sqlString = "DECLARE\n" +
                "   vIdOp NUMBER := 0;\n" +
                "BEGIN\n" +
                "   delete tmp_op_pagnet;" +
                "   FOR i IN " + idSinistroIni + ".." + idSinistroFim + " LOOP\n" +
                "      select o.id_op into vIdOp from ctb_op o where o.id_sinistro = i;\n" +
                "      insert into tmp_op_pagnet values (1, vIdOp);\n" +
                "   END LOOP;\n" +
                "   pa_pgn_aquivos.prgeneraopindemnizacion; " +
                "END;";
                db.Execute(sqlString);

                // atualiza sequencial nr_susep
                sqlString = "update sto_seq_susep ss\n" +
                "   set ss.nm_sequencia = ss.nm_sequencia + " + (idSinistroFim - idSinistroIni + 1) + "\n" +
                " where ss.cd_sucursal = '07'\n" +
                "   and ss.cd_ramo = '69'\n" +
                "   and to_char(ss.nm_ano) = to_char(sysdate, 'yyyy')";
                db.Execute(sqlString);

                db.Execute("commit");

                // retorna os sinistros gerados
                OracleConnection conn = new OracleConnection();

                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DB"].ToString();

                conn.Open();

                sqlString = "select s.id_sinistro, s.nr_sinistro, seg.ds_cliente from sma_sinistro s, sma_segurado seg " +
                            "where s.id_segurado = seg.id_segurado and s.id_sinistro between " + idSinistroIni + " and " + idSinistroFim;

                OracleCommand executeQuery = new OracleCommand(sqlString, conn);

                OracleDataReader dr = executeQuery.ExecuteReader();

                DataTable dt = new DataTable();

                dt.Load(dr);

                gvCSVData.DataSource = dt;
                gvCSVData.DataBind();

                lbStatus.Text = "Status: Arquivo processado com sucesso! - Os sinistros inseridos estão na tabela abaixo.";
                btProcessar.Visible = false;

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
                string currentPath = Server.MapPath("~/") +
                              Path.GetFileName(FileUploadControl.FileName);
                FileUploadControl.SaveAs(currentPath);

                string Extension = Path.GetExtension(FileUploadControl.PostedFile.FileName);

                gvCSVData.DataSource =
                    GetDataTableFromExcelFile(currentPath, Extension);

                //                    gvCSVData.DataSource = GetDataTableFromCSVFile(currentPath);
                gvCSVData.DataBind();
                lbStatus.Text = "Status: Arquivo importado! - Os registros abaixo não serão processados. Segurados não cadastrados.";
                btProcessar.Visible = true;

                //                    File.Delete(currentPath);
                try
                {
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

        private static DataTable GetDataTableFromExcelFile(string currentPath, string Extension)
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
            connExcel.Open();
            cmdExcel.CommandText = "SELECT * From ['Opened Cases$']";
            oda.SelectCommand = cmdExcel;
            oda.Fill(dt);
            connExcel.Close();

            OracleConnection conn = new OracleConnection();

            conn.ConnectionString = ConfigurationManager.ConnectionStrings["DB"].ToString();

            conn.Open();

            OracleCommand oc = new OracleCommand("CREATE GLOBAL TEMPORARY TABLE coris (voucher  varchar2(50), INSURER  varchar2(200), CASE_NUMBER  varchar2(50), TYPE_OF_CLAIM varchar2(100) ) ON COMMIT DELETE ROWS", conn);

            try
            {
                oc.CommandText = "DROP TABLE coris";
                oc.ExecuteNonQuery();
            }
            catch { };

            //            oc.CommandText = "CREATE TABLE coris (voucher  varchar2(50), INSURER  varchar2(200), CASE_NUMBER  varchar2(50) ) ON COMMIT DELETE ROWS";
            oc.CommandText = "CREATE TABLE coris (voucher  varchar2(50), INSURER  varchar2(200), CASE_NUMBER  varchar2(50), TYPE_OF_CLAIM varchar2(100), CASE_OPENED_ON varchar(30), VALOR_SINISTRO NUMBER, ID_SEGURADO NUMBER, ID_APOLICE NUMBER, ID_ENDOSSO NUMBER ) ";
            oc.ExecuteNonQuery();

            foreach (DataRow dtRow in dt.Rows)
            {

                if (dtRow["Voucher"].ToString().Trim() == "") continue;

                if (dtRow["Voucher"].ToString().Substring(0, 1) == "0")
                    oc.CommandText = "SELECT MAX(S.ID_SEGURADO) FROM SMA_SEGURADO S " +
                                     "WHERE S.CD_CLIENTE_ETP = " +
                                     "upper('" + dtRow["Voucher"].ToString().Remove(0, 1).Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "') ";
                else
                    oc.CommandText = "SELECT MAX(S.ID_SEGURADO) FROM SMA_SEGURADO S " +
                                     "WHERE S.CD_CLIENTE_ETP = " +
                                     "upper('" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "') ";

                string strIdSegurado = oc.ExecuteScalar().ToString();

                if (strIdSegurado == "")
                {
                    oc.CommandText = "SELECT MAX(S.ID_SEGURADO) FROM SMA_SEGURADO S " +
                                     "WHERE S.CD_CLIENTE_ETP = upper(SUBSTR('" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "',1,2) || SUBSTR('" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "',4,50)) " +
                                     "OR S.DS_CHAVE_ETP = upper('" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "') " +
                                     "OR S.DS_CHAVE_ETP = upper('" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "') " +
                                     "OR S.DS_CHAVE_ETP = upper(SUBSTR('" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "',1,2) || SUBSTR('" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "',4,50)) ";
                    strIdSegurado = oc.ExecuteScalar().ToString();
                }

                if (strIdSegurado == "")
                {
                    oc.CommandText = "SELECT MAX(S.ID_SEGURADO) FROM SMA_SEGURADO S " +
                                     "WHERE S.CD_CLIENTE_ETP = lower(SUBSTR('" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "',1,2) || SUBSTR('" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "',4,50)) " +
                                     "OR S.DS_CHAVE_ETP = lower('" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "') " +
                                     "OR S.DS_CHAVE_ETP = lower('" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "') " +
                                     "OR S.DS_CHAVE_ETP = lower(SUBSTR('" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "',1,2) || SUBSTR('" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "',4,50)) ";
                    strIdSegurado = oc.ExecuteScalar().ToString();
                }

                if (strIdSegurado == "")
                {
                    oc.CommandText = "SELECT MAX(S.ID_SEGURADO) FROM SMA_SEGURADO S " +
                                     "WHERE upper(S.CD_CLIENTE_ETP) = upper(SUBSTR('" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "',1,2) || SUBSTR('" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "',4,50)) " +
                                     "OR upper(S.DS_CHAVE_ETP) = upper('" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "') " +
                                     "OR '0' || upper(S.DS_CHAVE_ETP) = upper('" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "') " +
                                     "OR upper(S.DS_CHAVE_ETP) = upper(SUBSTR('" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "',1,2) || SUBSTR('" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "',4,50)) ";
                    strIdSegurado = oc.ExecuteScalar().ToString();
                }

                oc.CommandText = "select case when TO_DATE(replace(replace('" + dtRow["Case opened on"].ToString() + "', ' 12:00:00 AM', ''), ' 00:00:00', ''), 'dd/mm/yyyy') < " +
                                 "                 TO_DATE('31/12/2014', 'dd/mm/yyyy') then a.id_apolice else " +
                                 "            decode(a.id_apolice, 76078, 213081,  " +
                                 "                                 76079, 213081,  " +
                                 "                                213081, 213081, 211181) end " +
                                 "  from tb_emi_apoli a, tb_cad_prodt p, sma_seguro seg " +
                                 " where seg.id_segurado = '" + strIdSegurado + "' and seg.nr_seguro = 1 " +
                                 "   and p.id_produto = (case seg.id_produto when 502 then 454 else seg.id_produto end ) " +
                                 "   and p.id_prod_unif = a.id_prod_unif " +
                                 "   and rownum = 1";

                string strIdApolice = "";

                if (strIdSegurado != "") { strIdApolice = oc.ExecuteScalar().ToString(); }

                oc.CommandText = "select e.id_endosso from tb_emi_endos e, tb_emi_endit t " +
                                 " where e.id_apolice = " + strIdApolice +
                                 "   and TO_DATE(replace(replace('" + dtRow["Case opened on"].ToString() + "', ' 12:00:00 AM', ''), ' 00:00:00', ''), 'dd/mm/yyyy') " +
                                 "       between e.dt_ini_vig and e.dt_fim_vig " +
                                 "   and e.cd_status = 'A' " +
                                 "   and t.id_endosso = e.id_endosso " +
                                 "   and t.cd_tipo_motivo_endos = 220 " +
                                 "   and rownum = 1";

                string strIdEndosso = "";

                if (strIdApolice != "")
                {
                    try
                    {
                        strIdEndosso = oc.ExecuteScalar().ToString();
                    }
                    catch
                    {
                        strIdEndosso = "";
                    }
                }

                oc.CommandText = "insert into coris select '" + dtRow["Voucher"].ToString().Replace("/", "").Replace(".", "").Replace("-", "").Replace(" ", "") + "' VOUCHER, '" +
                                                                dtRow["Insurer"].ToString() + "' INSURER, '" + dtRow["Case Number"].ToString() + "' CASE_NUMBER, '" +
                                                                dtRow["TYPE OF CLAIM"].ToString() + "' TYPE_OF_CLAIM, '" +
                                                                dtRow["Case opened on"].ToString() + "' CASE_OPENED_ON, " +
                                                                dtRow["Valor Sinistro"].ToString().Replace(",", ".") + " VALOR_SINISTRO, '" +
                                                                strIdSegurado + "', '" + strIdApolice + "', '" + strIdEndosso + "' from dual";
                if (dtRow["Insurer"].ToString() != "") oc.ExecuteNonQuery();
            }

            string sql = "select c.*, " +
                         "       case when id_segurado is null then 'SEGURADO NAO ENCONTRADO' " +
                         "            when id_endosso is null then 'ENDOSSO / FATURA NAO ENCONTRADA' end STATUS " +
                         "  from coris c where id_segurado is null or id_endosso is null";

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