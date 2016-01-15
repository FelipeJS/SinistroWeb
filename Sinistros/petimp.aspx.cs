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
    public partial class petimp : System.Web.UI.Page
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
                "                 SI.ID_USUARIO, SI.VL_SALDO_DEVEDOR, SI.ID_APOLICE, SI.ID_ENDOSSO, SI.CD_COBER, SI.CPF_RECLAMANTE, SI.NM_RECLAMANTE, SI.NR_CONTRATO)\n" +
                "\n" +
                "                -- Corrigir numeração SUSEP\n" +
                "                SELECT\n" +
                "                (select max(id_sinistro) from sma_sinistro where id_sinistro < 900000) + ROWNUM,\n" +
                "                0,\n" +
                "                 '0964' || lpad((select ss.nm_sequencia\n" +
                "                              from sto_seq_susep ss where ss.cd_sucursal = '09' and ss.cd_ramo = '64' and to_char(ss.nm_ano) = to_char(sysdate, 'yyyy')) + ROWNUM, 6, 0) ||\n" +
                "                            to_char(sysdate, 'yyyy') SinistroSUSEP,\n" +
                "                'A', 04, null, 0, 0, 0, SYSDATE, SYSDATE, SYSDATE, 1, TO_DATE( substr(X.DATA_OCORR,1,10), 'DD/MM/YYYY'), SYSDATE, '' NM_ARQUIVO,\n" +
                "                NULL,\n" +
                "                8, 370, X.VALOR_SINISTRO\n" +
                ", a.id_apolice,\n" +
                "\n" +
                "                (select max(e.id_endosso)\n" +
                "                   from tb_emi_endos e, tb_emi_endit t\n" +
                "                  where e.id_apolice = a.id_apolice\n" +
                "                    and TO_DATE( substr(X.DATA_OCORR,1,10), 'DD/MM/YYYY') between e.dt_ini_vig and e.dt_fim_vig\n" +
                "                    and e.cd_status = 'A'\n" +
                "                    and t.id_endosso = e.id_endosso\n" +
                "                    --and t.cd_tipo_motivo_endos = 220\n" +
                "                    ), 95, trim(replace(replace(replace(X.CNPJ,'/',''),'.',''),'-','')), substr(X.CLINICA,1,50), X.AGENCIA \n" +
                "\n" +
                "                FROM PET X\n" +
                "                INNER JOIN TB_EMI_APOLI A ON A.NR_APOLI_OFIC = X.APOLICE\n" +
                "                WHERE\n" +
                "                                (select max(e.id_endosso)\n" +
                "                   from tb_emi_endos e, tb_emi_endit t\n" +
                "                  where e.id_apolice = a.id_apolice\n" +
                "                    and TO_DATE( substr(X.DATA_OCORR,1,10), 'DD/MM/YYYY') between e.dt_ini_vig and e.dt_fim_vig\n" +
                "                    and e.cd_status = 'A'\n" +
                "                    and t.id_endosso = e.id_endosso\n" +
                "                    --and t.cd_tipo_motivo_endos = 220\n" +
                "                    ) IS NOT NULL AND X.STATUS IS NULL ";

                db.Execute(sqlString);

                // ultimo sinistro
                int idSinistroFim = db.ExecuteScalar<int>("select max(id_sinistro) from sma_sinistro where id_sinistro < 900000");

                if (idSinistroFim < idSinistroIni)
                {
                    lbStatus.Text = "Status: Arquivo não processado! - Não há registros válidos.";
                    btProcessar.Visible = false;
                    lbPagto.Visible = false;
                    txtDiasPagto.Visible = false;
                }

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
                "   vIdPessoa NUMBER := 0;\n" +
                "   vIdDocto NUMBER := 0;\n" +
                "   vIdConta NUMBER := 0;\n" +
                "   vFavorecido VARCHAR2(200);\n" +
                "BEGIN\n" +
                "   FOR i IN " + idSinistroIni + ".." + idSinistroFim + " LOOP\n" +
                "      select s.vl_saldo_devedor into vSaldo from sma_sinistro s where s.id_sinistro = i;\n" +
                    "  pa_sinistros.prGrabaLiquidacion(vnidsinistro => i," +
                    "                                  vnidusuario => 370," +
                    "                                  vntpvalor => 1," +
                    "                                  vcfl_pagto => 'T'," +
                    "                                  vnvalor => vSaldo);" +
                    "  select l.id_liquidacao into vIdLiq from sto_liquidacao l where l.id_sinistro = i;\n" +

                    "  select d.id_pessoa, d.id_docto, c.id_conta, s.nm_reclamante\n" +
                    "    into vIdPessoa, vIdDocto, vIdConta, vFavorecido\n" +
                    "    from crp_docto d, crp_conta c, sma_sinistro s \n" +
                    "    where s.id_sinistro = i\n" +
                    "     and d.nr_docto = s.cpf_reclamante\n" +
                    "     and c.id_pessoa = d.id_pessoa\n" +
                    "     and c.cd_agencia = s.nr_contrato\n" +
                    "     and rownum = 1;\n" +

                    "      select l.id_liquidacao into vIdLiq from sto_liquidacao l where l.id_sinistro = i;\n" +

                    "  pa_sinistros.prGrabaOp(vntpop => 1," +
                    "                         vdpagamento => sysdate + " + txtDiasPagto.Text + "," +
                    "                         vcfavorecido => vFavorecido," +
                    "                         vnvalorpagamento => vSaldo," +
                    "                         vntpmoeda => 0," +
                    "                         vnidusuario => 370," +
                    "                         vntppagamento => 1," +
                    "                         vnidpessoa => vIdPessoa," +
                    "                         vniddocto => vIdDocto," +
                    "                         vnidliquidacao => vIdLiq," +
                    "                         vnidconta => vIdConta," +
                    "                         vbIncompleto => 0," +
                    "                         vnidsinistro =>  i," +
                    "                         vcSerieNota => '2012'); " +
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
                " where ss.cd_sucursal = '09'\n" +
                "   and ss.cd_ramo = '64'\n" +
                "   and to_char(ss.nm_ano) = to_char(sysdate, 'yyyy')";
                db.Execute(sqlString);

                db.Execute("commit");

                // retorna os sinistros gerados
                OracleConnection conn = new OracleConnection();

                conn.ConnectionString = ConfigurationManager.ConnectionStrings["DB"].ToString();

                conn.Open();

                sqlString = "select s.id_sinistro, s.nr_sinistro from sma_sinistro s where s.id_sinistro between " + idSinistroIni + " and " + idSinistroFim;

                OracleCommand executeQuery = new OracleCommand(sqlString, conn);

                OracleDataReader dr = executeQuery.ExecuteReader();

                DataTable dt = new DataTable();

                dt.Load(dr);

                gvCSVData.DataSource = dt;
                gvCSVData.DataBind();

                lbStatus.Text = "Status: Arquivo processado com sucesso! - Os sinistros inseridos estão na tabela abaixo.";
                btProcessar.Visible = false;
                lbPagto.Visible = false;
                txtDiasPagto.Visible = false;


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
                    lbStatus.Text = "Status: Arquivo importado! - Os registros abaixo não serão processados.";
                    btProcessar.Visible = true;
                    lbPagto.Visible = true;
                    txtDiasPagto.Visible = true;

                    //                    File.Delete(currentPath);
                }
                catch (Exception ex)
                {
                    lbStatus.Text = @"Status: O arquivo não pode ser processado. 
                    Ocorreu o seguinte erro: " + ex.Message;
                    btProcessar.Visible = true;
                    lbPagto.Visible = true;
                    txtDiasPagto.Visible = true;
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
            cmdExcel.CommandText = "SELECT * From ['Folha de rosto$']";
            oda.SelectCommand = cmdExcel;
            oda.Fill(dt);
            connExcel.Close();

            OracleConnection conn = new OracleConnection();

            conn.ConnectionString = ConfigurationManager.ConnectionStrings["DB"].ToString();

            conn.Open();

            OracleCommand oc = new OracleCommand("CREATE GLOBAL TEMPORARY TABLE pet", conn);

            try
            {
                oc.CommandText = "DROP TABLE pet";
                oc.ExecuteNonQuery();
            }
            catch { };

            //            oc.CommandText = "CREATE TABLE coris (voucher  varchar2(50), INSURER  varchar2(200), CASE_NUMBER  varchar2(50) ) ON COMMIT DELETE ROWS";
            oc.CommandText = "CREATE TABLE pet (PLANO varchar2(50), APOLICE varchar2(200), NOME_TITULAR varchar2(50), CPF varchar2(100), " +
                             "DATA_OCORR varchar(30), DATA_PAGTO varchar(30), CLINICA varchar(200), BANCO varchar(30), AGENCIA varchar(30), " +
                             "CONTA varchar(30), CNPJ varchar(30), VALOR_SINISTRO NUMBER, STATUS varchar(200)) ";
            oc.ExecuteNonQuery();

            foreach (DataRow dtRow in dt.Rows)
            {
                if (dtRow["PLANO"].ToString() != "")
                {

                    var dtOcorre = DateTime.Now;
                    var dtPagto = DateTime.Now;
                    var status = "";

                    try
                    {
                        dtOcorre = DateTime.Parse(dtRow["DATA OCORRÊNCIA"].ToString());
                        dtPagto = DateTime.Parse(dtRow["DATA PAGAMENTO"].ToString());

                    }
                    catch (Exception)
                    {
                        status = "Datas inválidas!";
                    }

                    oc.CommandText = "  select count(*)\n" +
                    "    from crp_docto d, crp_conta c" +
                    "    where d.nr_docto = trim(replace(replace(replace('" + dtRow["DADOS BANCÁRIOS"].ToString() + "','/',''),'.',''),'-',''))" +
                    "     and c.id_pessoa = d.id_pessoa\n" +
                    "     and c.cd_agencia = " + dtRow["Agência"].ToString();

                    if (oc.ExecuteScalar().ToString() == "0") { status = "DADOS BANCÁRIOS inválidos!"; }

                    if (!ValidaCNPJ(dtRow["DADOS BANCÁRIOS"].ToString()) && !ValidaCPF(dtRow["DADOS BANCÁRIOS"].ToString())) { status = "CPF ou CNPJ em DADOS BANCÁRIOS é inválido"; }

                    oc.CommandText = "insert into pet select '" + dtRow["PLANO"].ToString() + "' PLANO, '" +
                                                                    dtRow["APOLICE "].ToString() + "' APOLICE, '" +
                                                                    dtRow["NOME TITULAR"].ToString() + "' NOME_TITULAR, '" +
                                                                    dtRow["CPF"].ToString() + "' CPF, '" +
                                                                    dtOcorre.ToString("dd/MM/yyyy") + "' DATA_OCORR, '" +
                                                                    dtPagto.ToString("dd/MM/yyyy") + "' DATA_PAGTO, '" +
                                                                    dtRow["CLINICA"].ToString() + "' CLINICA, '" +
                                                                    dtRow["Banco"].ToString() + "' BANCO, '" +
                                                                    dtRow["Agência"].ToString() + "' AGENCIA, '" +
                                                                    dtRow["Conta"].ToString() + "' CONTA, '" +
                                                                    dtRow["DADOS BANCÁRIOS"].ToString() + "' CNPJ, " +
                                                                    dtRow["INDENIZAÇÃO"].ToString().Replace(",", ".") + " VALOR_SINISTRO, '" +
                                                                    status + "' STATUS from dual";
                    oc.ExecuteNonQuery();
                }
            }



            string sql = "    select X.APOLICE,	X.NOME_TITULAR,	X.AGENCIA,	X.CNPJ,	X.VALOR_SINISTRO, NVL(X.STATUS, 'Segurado Não Cadastrado!') STATUS\n" +
            "FROM PET X\n" +
            "LEFT OUTER JOIN TB_EMI_APOLI A ON A.NR_APOLI_OFIC = X.APOLICE\n" +
            "WHERE\n" +
            "A.ID_APOLICE IS NULL OR X.STATUS IS NOT NULL OR\n" +
            "                (select max(e.id_endosso)\n" +
            "   from tb_emi_endos e, tb_emi_endit t\n" +
            "  where e.id_apolice = a.id_apolice\n" +
            "    and TO_DATE( substr(X.DATA_OCORR,1,10), 'DD/MM/YYYY') between e.dt_ini_vig and e.dt_fim_vig\n" +
            "    and e.cd_status = 'A'\n" +
            "    and t.id_endosso = e.id_endosso\n" +
            "    --and t.cd_tipo_motivo_endos = 220\n" +
            "    ) IS NULL";

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

        private static bool ValidaCPF(string vrCPF) { string valor = vrCPF.Replace(".", ""); valor = valor.Replace("-", ""); if (valor.Length != 11) return false; bool igual = true; for (int i = 1; i < 11 && igual; i++) if (valor[i] != valor[0]) igual = false; if (igual || valor == "12345678909") return false; int[] numeros = new int[11]; for (int i = 0; i < 11; i++) numeros[i] = int.Parse(valor[i].ToString()); int soma = 0; for (int i = 0; i < 9; i++) soma += (10 - i) * numeros[i]; int resultado = soma % 11; if (resultado == 1 || resultado == 0) { if (numeros[9] != 0) return false; } else if (numeros[9] != 11 - resultado) return false; soma = 0; for (int i = 0; i < 10; i++) soma += (11 - i) * numeros[i]; resultado = soma % 11; if (resultado == 1 || resultado == 0) { if (numeros[10] != 0) return false; } else if (numeros[10] != 11 - resultado) return false; return true; }

        private static bool ValidaCNPJ(string vrCNPJ) { string CNPJ = vrCNPJ.Replace(".", ""); CNPJ = CNPJ.Replace("/", ""); CNPJ = CNPJ.Replace("-", ""); int[] digitos, soma, resultado; int nrDig; string ftmt; bool[] CNPJOk; ftmt = "6543298765432"; digitos = new int[14]; soma = new int[2]; soma[0] = 0; soma[1] = 0; resultado = new int[2]; resultado[0] = 0; resultado[1] = 0; CNPJOk = new bool[2]; CNPJOk[0] = false; CNPJOk[1] = false; try { for (nrDig = 0; nrDig < 14; nrDig++) { digitos[nrDig] = int.Parse(CNPJ.Substring(nrDig, 1)); if (nrDig <= 11) soma[0] += (digitos[nrDig] * int.Parse(ftmt.Substring(nrDig + 1, 1))); if (nrDig <= 12) soma[1] += (digitos[nrDig] * int.Parse(ftmt.Substring(nrDig, 1))); } for (nrDig = 0; nrDig < 2; nrDig++) { resultado[nrDig] = (soma[nrDig] % 11); if ((resultado[nrDig] == 0) || (resultado[nrDig] == 1)) CNPJOk[nrDig] = (digitos[12 + nrDig] == 0); else CNPJOk[nrDig] = (digitos[12 + nrDig] == (11 - resultado[nrDig])); } return (CNPJOk[0] && CNPJOk[1]); } catch { return false; } }

    }
}