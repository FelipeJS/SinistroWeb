using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;


namespace Sinistros.Controllers
{
    public class SinistroController : ApiController
    {
        public PetaPoco.Database db =
             new PetaPoco.Database("DB");

        public IEnumerable<Models.Sinistro> Get()
        {
            var sinistros =
                db.Query<Models.Sinistro>("SELECT * FROM SMA_SINISTRO S, SMA_SEGURADO SEG WHERE S.ID_SEGURADO = SEG.ID_SEGURADO AND ROWNUM < 101");
            //                db.Page<Models.Sinistro>(1, 20, "SELECT * FROM SMA_SINISTRO S, SMA_SEGURADO SEG WHERE S.ID_SEGURADO = SEG.ID_SEGURADO AND ROWNUM < 101");
            return sinistros;
            //            return CreateFlexiJson(sinistros.ToList(), 1, 1);

        }

        // GET api/<controller>/5
        public IEnumerable<Models.Sinistro> Get(string id)
        {
            //            return "value" + id;

            string[] words = id.Split('$');
            string sql = "SELECT S.*, SEG.DS_CLIENTE, SEG.CD_CLIENTE_ETP, SEG.CPF, A.NR_APOLI_OFIC, " +
"             (SELECT MIN(DS_ESTIPULANTE) FROM SMA_ESTIPULANTE E WHERE SEG.CD_ESTIPULANTE = E.CD_ESTIPULANTE) DS_ESTIPULANTE, " +
"             (SELECT SUM(VL_RESERVA) FROM STO_RESERVA R WHERE R.ID_SINISTRO = S.ID_SINISTRO) VL_RESERVA " +
"            FROM SMA_SINISTRO S " +
"            INNER JOIN SMA_SEGURADO SEG ON S.ID_SEGURADO = SEG.ID_SEGURADO " +
"            LEFT OUTER JOIN TB_EMI_APOLI A ON A.ID_APOLICE = S.ID_APOLICE " +
"            LEFT OUTER JOIN STO_USUARIO U ON U.ID_USUARIO = :idUsuario " +
"            WHERE (S.ID_SINISTRO = :idSinistro OR S.NR_SINISTRO = :idSinistro OR A.Nr_Apoli_Ofic = :nrApo  or SEG.CPF = :cpf :etp :dtAviso :dtRegistro) " +
"            UNION " +
"             " +
"            SELECT S.*, P.DS_PESSOA, NULL, NULL, E.NR_APOLI_OFIC, NULL,                    " +
"              (SELECT SUM(VL_RESERVA) FROM STO_RESERVA R WHERE R.ID_SINISTRO = S.ID_SINISTRO) VL_RESERVA                  " +
"            FROM SMA_SINISTRO S " +
"            INNER JOIN TB_EMI_APOLI A ON A.ID_APOLICE = S.ID_APOLICE  " +
"            INNER JOIN TB_EMI_ENDOS E ON E.ID_ENDOSSO = S.ID_ENDOSSO  " +
"            INNER JOIN CRP_PESSOA P ON E.ID_PESSOA = P.ID_PESSOA " +
"            LEFT OUTER JOIN CRP_DOCTO D ON D.ID_PESSOA = P.ID_PESSOA " +
"            LEFT OUTER JOIN STO_USUARIO U ON U.ID_USUARIO = 888          " +
"            WHERE (S.ID_SINISTRO = :idSinistro OR S.NR_SINISTRO = :idSinistro OR A.Nr_Apoli_Ofic = :nrApo  or D.NR_DOCTO = :2cpf2 :dtAviso :dtRegistro) " +
"                AND S.ID_SEGURADO IS NULL ";


            if (words[0] == "") { sql = sql.Replace(":idSinistro", "null"); }
            else { sql = sql.Replace(":idSinistro", words[0]); }


            if (words[1] == "")
            {
                sql = sql.Replace(":cpf", "null");
                sql = sql.Replace(":2cpf2", "null");
            }
            else
            {
                double Num;
                if (double.TryParse(words[1], out Num))
                {
                    sql = sql.Replace(":cpf", "'" + words[1] + "'");
                    sql = sql.Replace(":2cpf2", "'" + words[1] + "'");
                }
                else
                {
                    sql = sql.Replace(":cpf", "null or SEG.DS_CLIENTE LIKE '%" + words[1].ToUpper() + "%'");
                    sql = sql.Replace(":2cpf2", "null or P.DS_PESSOA LIKE '%" + words[1].ToUpper() + "%'");
                }
            }

            if (words[3] == "")
            {
                sql = sql.Replace(":nrApo", "null");
            }
            else
            {
                sql = sql.Replace(":nrApo", words[3]);
            }

            if (words[6] == "")
            {
                sql = sql.Replace(":idUsuario", "null");
            }
            else
            {
                sql = sql.Replace(":idUsuario", words[6]);
            }

            if (words[2] != "")
            {
                sql = sql.Replace(":etp", " OR SEG.CD_CLIENTE_ETP = '" + words[2].Trim() + "' ");
            }
            else
            {
                sql = sql.Replace(":etp", "");
            }

            if (words[4] != "")
            {
                sql = sql.Replace(":dtAviso", " OR S.DT_AVISO BETWEEN TO_DATE('" + words[4] + "', 'ddmmyyyy') AND TO_DATE('" + words[5] + "', 'ddmmyyyy') ");
            }
            else
            {
                sql = sql.Replace(":dtAviso", "");
            }

            if (words[7] != "")
            {
                sql = sql.Replace(":dtRegistro", " OR S.DT_CADASTRO LIKE TO_DATE('" + words[7] + "', 'ddmmyyyy')");
            }
            else
            {
                sql = sql.Replace(":dtRegistro", "");
            }

            var sinistros =
    db.Query<Models.Sinistro>(sql);
            //                db.Page<Models.Sinistro>(1, 20, "SELECT * FROM SMA_SINISTRO S, SMA_SEGURADO SEG WHERE S.ID_SEGURADO = SEG.ID_SEGURADO AND ROWNUM < 101");
            return sinistros;

        }

        public IEnumerable<Models.Beneficiario> GetBeneficiarios(string beneficiario)
        {

            string[] words = beneficiario.Split('$');

            if (words.Length > 1)
            {

                db.Execute("insert into sto_beneficiario b " +
                           "(b.id_sinistro, b.vl_participacao, b.tp_parentesco, b.id_pessoa, b.id_docto, b.id_conta) " +
                           "values " +
                           "(" + words[0] + "," + words[1] + "," + words[2] + "," + words[3] + "," + words[4] + "," + words[5] + ")");
            }

            var beneficiarios =
                db.Query<Models.Beneficiario>("select pes.ds_pessoa, t.ds_parentesco tp_parentesco, sb.vl_participacao, sb.id_beneficiario " +
"  from sto_beneficiario sb inner join crp_pessoa pes on pes.id_pessoa = sb.id_pessoa left outer join sys_tpparentesco t on t.id_tp_parentesco = nvl(sb.tp_parentesco,99) " +
"  left outer join sys_tppessoa tps on tps.cd_tp_pessoa = pes.tp_pessoa " +
"  left outer join crp_conta cb on cb.id_conta = sb.id_conta left outer join crp_docto doc on doc.id_docto = sb.id_docto where sb.id_sinistro = " + words[0]);
            return beneficiarios;
        }

        public IEnumerable<Models.Pessoa> GetBeneficiarioEstipulante(string idSinistroEstipulante)
        {

            var pessoas =
                db.Query<Models.Pessoa>("select p.id_pessoa, " +
"       p.ds_pessoa, " +
"       d.id_docto, " +
"       null, " +
"       k.TPPARENTESCO_OTRO, " +
"       c.id_conta, " +
"       100 vl_participacao, " +
"       b.ds_banco, " +
"       c.cd_agencia, " +
"       c.nro_conta, " +
"       d.id_tpdocto, " +
"       d.nr_docto " +
"from sma_estipulante e " +
"inner join sma_segurado seg " +
"           on seg.cd_estipulante = e.cd_estipulante " +
"inner join sma_sinistro s " +
"           on s.id_segurado = seg.id_segurado " +
"inner join crp_pessoa p " +
"            on p.id_pessoa = e.id_pessoa " +
"inner join crp_docto d  " +
"            on d.id_pessoa = e.id_pessoa " +
"left outer join crp_conta c  " +
"            on c.id_pessoa = e.id_pessoa " +
"           and c.fl_principal = 1 " +
"left outer join fin_banco b " +
"             on c.cd_banco = b.cd_banco " +
"where s.id_sinistro = " + idSinistroEstipulante);
            return pessoas;

        }

        public IEnumerable<Models.Liquidacao> GetLiquidacao(string liquidacao)
        {
            string[] words = liquidacao.Split('$');

            var liquidacoes =
                db.Query<Models.Liquidacao>("select 0,id_liquidacao, tp_moeda, vl_total * vl_participacao / 100 vl_total, nvl(vl_valor_ress,0) * vl_participacao / 100 vl_ress, " +
           "       nvl(vl_valor_coss,0) * vl_participacao / 100 vl_coss,  ds_beneficiario, fl_pagto, 0 tp_pagamento, null dt_pagamento, 0 fl_abono," +
           "       id_pessoa, id_docto, id_conta, 0 from vPagoLiquidacionPendiente where id_sinistro = " + words[0]);
            return liquidacoes;
        }

        public IEnumerable<Models.Liquidacao> GetLiquidacoes(string liquidacoes)
        {
            string[] words = liquidacoes.Split('$');

            var str = "select l.id_liquidacao, s.id_sinistro, tps.ds_tpsinistro, to_char(l.dt_emissao, 'dd/mm/yyyy') ds_dt_emissao, pa_sinistros.fnCadenaBeneficiarios(l.id_liquidacao) DS_BENEFICIARIO, " +
                      "       l.vl_valor + nvl(l.vl_valor_ress,0) + nvl(l.vl_valor_coss,0) vl_total, 0, l.rowid " +
                      "from sto_liquidacao l " +
                      "inner join sma_sinistro s on s.id_sinistro = l.id_sinistro " +
                      "inner join sto_tpsinistro tps on tps.id_tpsinistro = s.tp_sinistro " +
                      "inner join tb_emi_apoli a on a.id_apolice = s.id_apolice and (a.cd_progr =  " + words[1] + "  or  " + words[1] + "  = -1)" +
                      "where l.fl_status = 'P' " +
                      "  and l.vl_valor + nvl(l.vl_valor_ress,0) + nvl(l.vl_valor_coss,0) <= " +
                      "      (select nvl(u.vl_tope_indenizacao,0) from sto_usuario u where u.id_usuario = " + words[0] + " ) ";

            var liqs =
                db.Query<Models.Liquidacao>(str);
            return liqs;
        }

        public IEnumerable<Models.Op> GetOPs(string op)
        {
            string[] words = op.Split('$');

            var str = "select 0, t.id_op, t.id_sinistro, t.nm_favorecido, t.vl_pagamento, to_char(t.dt_pagamento,'dd/mm/yyyy') DT_PAGAMENTO, " +
"       case when t.fl_pagto = 'P' then 'PARCIAL' when t.fl_pagto = 'T' then 'TOTAL' end ds_tipo_pagto, t.ds_forma_pagamento, t.ds_serie_nota_fiscal, null " +
"  from VOPSINIESTROS t, ctb_op o, sto_liquidacao l where t.id_status = k.STATUS_OP_PENDENTE_PROCESSA and t.id_tppagamento is not null " +
"   and t.id_op = o.id_op and o.id_liquidacao = l.id_liquidacao and l.fl_status = 'A' " +
"   and t.id_docto is not null and t.tp_moeda is not null and t.id_pessoa is not null " +
"   order by t.nm_favorecido         ";

            var ops =
                db.Query<Models.Op>(str);
            return ops;
        }

        public IEnumerable<Models.Arquivo> GetArquivos(string arquivos)
        {
            var str = "select * from sto_documento where id_sinistro = " + arquivos;

            var arqs =
                db.Query<Models.Arquivo>(str);
            return arqs;
        }

        public string GetReservaDisponivel(string reserva)
        {

            string[] words = reserva.Split('$');
            string tipo;

            if (words.Length < 2) { tipo = "1"; } else { tipo = words[1]; };

            return db.ExecuteScalar<string>("select nvl(sum(r.vl_reserva),0) + nvl(sum(r.vl_cosseguro),0) + nvl(sum(r.vl_resseguro),0) " +
                                            "  from sto_reserva r where r.tp_valor = " + tipo + " and r.id_sinistro = " + words[0]);

        }



        // POST api/<controller>
        public void PostExcluirBeneficiarios(string beneficiarios)
        {
            db.Execute("delete sto_beneficiario b where b.id_sinistro = " + beneficiarios);

            db.Execute("commit");
            return;
        }

        // POST api/<controller>
        public void PostAutorizarLiqs(string autorizar)
        {
            string[] words = autorizar.Split('$');

            for (int i = 2; i < words.Length; i++)
            {
                int n;
                bool isNumeric = int.TryParse(words[i], out n);
                if (isNumeric) db.Execute("begin pa_sinistros.prautorizaliquidacion(vnidliquidacion => " + words[i] + ", " +
                                                                                             "    vnidusuario => " + words[0] + ", " +
                                                                                             "      vcstatus => '" + words[1] + "'); " +
                                                    " end;");
            }

            db.Execute("commit");
            return;
        }

        // POST api/<controller>
        public void PostGerarOPs(string ops)
        {
            string[] words = ops.Split('$');

            db.Execute("delete tmp_op_pagnet");

            foreach (string var in words)
            {
                int n;
                bool isNumeric = int.TryParse(var, out n);
                if (isNumeric) db.Execute("insert into tmp_op_pagnet values (1, " + var + ")");
            }

            db.Execute("begin" +
                       "  pa_pgn_aquivos.prgeneraopindemnizacion; " +
                       "end;");

            db.Execute("commit");
            return;
        }

        // POST api/<controller>
        public void PostLiquidacao(string liquidacao)
        {
            liquidacao = liquidacao.Replace("$R$ ", "$"); //Retira a formação de moeda 
            string[] words = liquidacao.Split('$');
            string fl_pagto = "T";

            if (db.ExecuteScalar<float>("select sum(valor) - " + words[1] + " from  " +
"(select sum(r.vl_reserva) valor " +
"  from sto_reserva r " +
" where r.id_sinistro = " + words[0] +
"   and r.tp_valor = " + words[3] +
" union " +
"select nvl(-sum(o.vl_pagamento),0) from ctb_op o where o.id_sinistro = " + words[0] + " and o.tp_op = " + words[3] +
"              and o.id_status not in (k.STATUS_OP_PAGO, k.STATUS_OP_CANCELADO, k.STATUS_OP_REJEITADO) )") < 0)
            {

                var vlDisp = db.ExecuteScalar<float>("select nvl(sum(r.vl_reserva),0) valor from sto_reserva r where r.id_sinistro = " + words[0] + " and r.tp_valor = " + words[3]);

                var vlOps = db.ExecuteScalar<float>("select nvl(sum(o.vl_pagamento),0) from ctb_op o where o.id_sinistro = " + words[0] + " and o.tp_op = " + words[3] +
"              and o.id_status not in (k.STATUS_OP_PAGO, k.STATUS_OP_CANCELADO, k.STATUS_OP_REJEITADO) ");

                throw new ApplicationException("Não pode liquidar um valor maior que o disponível. \n\r" + vlDisp.ToString("c2").PadLeft(20) + " - Reserva  \n\r" + vlOps.ToString("c2").PadLeft(20) + " - OPs Pendentes \n\r" + (vlDisp - vlOps).ToString("c2").PadLeft(20) + " - (Reserva - OPs Pendentes)");
            }

            if (float.Parse(words[1]) < float.Parse(words[2])) { fl_pagto = "P"; }

            // Devolve o cartecter $ retirado do texto do comentário
            words[11] = words[11].Replace("^", "$");

            db.BeginTransaction();

            db.Execute("begin" +
                        "  pa_sinistros.prGrabaLiquidacion(vnidsinistro => " + words[0] + "," +
                        "                                  vnidusuario => " + words[5] + "," +
                        "                                  vntpvalor => " + words[3] + "," +
                        "                                  vcfl_pagto => '" + fl_pagto + "'," +
                        "                                  vnvalor => " + words[1] + ");" +
                       "end;");

            foreach (var a in db.Query<Models.Liquidacao>("select l.*, (l.VL_TOTAL * l.VL_PARTICIPACAO / 100) VL_TOTAL from vPagoLiquidacionPendiente L where id_sinistro = " + words[0]))
            {
                db.Execute("begin" +
                           "  pa_sinistros.prGrabaOp(vntpop => " + words[3] + "," +
                           "                         vdpagamento => to_date('" + words[4] + "','dd/mm/yyyy')," +
                           "                         vcfavorecido => '" + a.DS_BENEFICIARIO + "'," +
                           "                         vnvalorpagamento => " + a.VL_TOTAL.ToString().Replace(",", ".") + "," +
                           "                         vntpmoeda => " + 0 + "," +
                           "                         vnidusuario => " + words[5] + "," +
                           "                         vntppagamento => " + 1 + "," +
                           "                         vnidpessoa => " + a.ID_PESSOA + "," +
                           "                         vniddocto => " + a.ID_DOCTO + "," +
                           "                         vnidliquidacao => " + a.ID_LIQUIDACAO + "," +
                           "                         vnidconta => " + a.ID_CONTA + "," +
                           "                         vbIncompleto => " + 0 + "," +
                           "                         vbRetemImpostos => " + words[6] + "," +
                           "                         vbBoletoBancario => " + words[7] + "," +
                           "                         vbCodigoBoleto => '" + words[8] + "'," +
                           "                         vbBordero => '" + words[9] + "'," +
                           "                         vbGoverno => '" + words[10] + "'," +
                           "                         vnidsinistro =>  " + words[0] + "); " +
                           "end;");
            }

            db.Execute("begin" +
                       "  pa_sinistros.prgrabacomentario(vnidsiniestro => " + words[0] + "," +
                       "                                 vnidusuario => " + words[5] + "," +
                       "                                 vctexto => '" + words[11] + "'," +
                       "                                 vnevento => " + 300 + ");" +
                       "end;");

            db.Execute("commit");
            return;
        }

        // POST api/<controller>
        public void PostComentario(string comentario)
        {
            string[] words = comentario.Split('$');

            // Devolve o cartecter $ retirado do texto do comentário
            words[3] = words[3].Replace("^", "$");

            db.Execute("begin" +
                       "  pa_sinistros.prgrabacomentario(vnidsiniestro => " + words[0] + "," +
                       "                                 vnidusuario => " + words[2] + "," +
                       "                                 vctexto => '" + words[3] + "'," +
                       "                                 vnevento => " + words[1] + ");" +
                       "end;");

            db.Execute("commit");
            return;
        }

        // POST api/<controller>
        public void PostJudicial(string judicial)
        {
            string[] words = judicial.Split('$');

            if (words[2] == "") { words[2] = "0"; }
            if (words[3] == "") { words[3] = "0"; }
            if (words[4] == "") { words[4] = "0"; }
            if (words[5] == "") { words[5] = "0"; }
            if (words[6] == "") { words[6] = "0"; }
            if (words[7] == "") { words[7] = "0"; }

            DateTime thisDay = DateTime.Today;

            db.Execute("begin " +
                        "pa_sinistros.prgrabanuevojuicio(vnidsiniestro => " + words[0] + "," +
                        "                                  vdaccion => to_date('" + thisDay.ToString("dd/MM/yyyy") + "','dd/mm/yyyy')," +
                        "                                  vcAutor => ''," +
                        "                                  vnidusuario => " + words[1] + " );" +
                        "pa_sinistros.prGrabaReservaAjuste(vnidsiniestro => " + words[0] + "," +
                        "                                  vnimportereserva => " + words[2] + " ," +
                        "                                  vntpvalor => 1," +
                        "                                  vbcontabil => '1'); " +
                        "pa_sinistros.prGrabaReservaAjuste(vnidsiniestro => " + words[0] + "," +
                        "                                  vnimportereserva => " + words[3] + " ," +
                        "                                  vntpvalor => 2," +
                        "                                  vbcontabil => '1'); " +
                        "pa_sinistros.prGrabaReservaAjuste(vnidsiniestro => " + words[0] + "," +
                        "                                  vnimportereserva => " + words[4] + " ," +
                        "                                  vntpvalor => 3," +
                        "                                  vbcontabil => '1'); " +
                        "update sma_sinistro s set s.vl_remoto = " + words[5] + ", s.vl_possivel = " + words[6] + ", s.vl_provavel = " + words[7] + " ;" +
                       "end;");

            db.Execute("commit");
            return;
        }

        public void PostJudicialDados(string judicialDados)
        {
            string[] words = judicialDados.Split('$');

            if (words[10] == "") { words[10] = "0"; }
            if (words[11] == "") { words[11] = "0"; }

            string sqlString = "update sto_judicial set " +
            "\tNM_PROCESSO = '" + words[1] + "',\n" +
            "\tDS_MOTIVO_ACAO = '" + words[2] + "',\n" +
            "\tDS_REU = '" + words[3] + "',\n" +
            "\tDS_OBJETO = '" + words[4] + "',\n" +
            "\tID_ADVOGADO_RESPONSAVEL = " + words[5] + ",\n" +
            "\tDS_ADVOGADO_PARTE_CONTRARIA = '" + words[6] + "',\n" +
            "\tDT_CITACAO =  to_date('" + words[7] + "', 'dd/mm/yyyy'),\n" +
            "\tDT_CADASTRO = to_date('" + words[8] + "', 'dd/mm/yyyy'),\n" +
            "\tDT_DEFESA = to_date('" + words[9] + "', 'dd/mm/yyyy'),\n" +
            "\tVL_CAUSA = " + words[10] + ",\n" +
            "\tVL_RISCO = " + words[11] + ",\n" +
            "\tTP_RISCO = " + words[12] + ",\n" +
            "\tTP_ANDAMENTO = " + words[13] + ",\n" +
            "\tTP_ENCERRAMENTO = " + words[14] + ",\n" +
            "\tDS_AUTOR = '" + words[15] + "',\n" +
            "\tDS_COMARCA_UF = '" + words[16] + "',\n" +
            "\tDS_COMARCA_CIDADE = '" + words[17] + "',\n" +
            "\tDS_VARA = '" + words[18] + "',\n" +
            "\tTP_RITO = " + words[19] + ",\n" +
            "\tTP_MOTIVO_ACAO = " + words[20] + ",\n" +
            "\tTP_CAUSA_RAIZ = '" + words[21] + "'\n" +
            "\tWHERE ID_SINISTRO =  " + words[0];

            db.Execute(sqlString);


            if (words[22].Length == 0) { words[1] = "0"; }
            if (words[23].Length == 0) { words[2] = "0"; }

            if (float.Parse(words[22]) != 0)
            {
                float indenizacaoF = float.Parse(words[22]) - float.Parse(words[24]);
                string indenizacao = indenizacaoF.ToString();

                db.Execute("begin" +
                           "  pa_sinistros.prGrabaReservaAjuste(vnidsiniestro => " + words[0] + "," +
                           "                             vnimportereserva => " + indenizacao + "," +
                           "                             vntpvalor => " + 1 + "," +
                           "                             vbcontabil => '1'); " +
                           "end;");
            }

            if (float.Parse(words[23]) != 0)
            {
                var honorarioF = float.Parse(words[23]) - float.Parse(words[25]);
                string honorario = honorarioF.ToString();

                db.Execute("begin" +
                           "  pa_sinistros.prGrabaReservaAjuste(vnidsiniestro => " + words[0] + "," +
                           "                             vnimportereserva => " + honorario + "," +
                           "                             vntpvalor => " + 2 + "," +
                           "                             vbcontabil => '1'); " +
                           "end;");
            }

            return;
        }


        public void PostReserva(string ajuste)
        {

            string[] words = ajuste.Split('$');

            if (words[1].Length == 0) { words[1] = "0"; }
            if (words[2].Length == 0) { words[2] = "0"; }
            if (words[3].Length == 0) { words[3] = "0"; }
            if (words[4].Length == 0) { words[4] = "0"; }
            if (words[5].Length == 0) { words[5] = "0"; }

            if (db.ExecuteScalar<float>("select sum(valor) + " + words[1] + " from  " +
                                         "(select sum(r.vl_reserva) valor " +
                                         "  from sto_reserva r " +
                                         " where r.id_sinistro = " + words[0] +
                                         "   and r.tp_valor = 1" +
                                         " union " +
                                         "select nvl(-sum(o.vl_pagamento),0) from ctb_op o where o.id_sinistro = " + words[0] + " and o.tp_op = 1" +
                                         "              and o.id_status not in (k.STATUS_OP_PAGO, k.STATUS_OP_CANCELADO, k.STATUS_OP_REJEITADO) )") < 0)
                throw new ApplicationException("Não pode ajustar a reserva para um valor menor que zero. Verifique reserva disponível e OPs agendadas.");

            if (db.ExecuteScalar<float>("select sum(valor) + " + words[2] + " from  " +
                                         "(select sum(r.vl_reserva) valor " +
                                         "  from sto_reserva r " +
                                         " where r.id_sinistro = " + words[0] +
                                         "   and r.tp_valor = 2" +
                                         " union " +
                                         "select nvl(-sum(o.vl_pagamento),0) from ctb_op o where o.id_sinistro = " + words[0] + " and o.tp_op = 2" +
                                         "              and o.id_status not in (k.STATUS_OP_PAGO, k.STATUS_OP_CANCELADO, k.STATUS_OP_REJEITADO) )") < 0)
                throw new ApplicationException("Não pode ajustar a reserva para um valor menor que zero. Verifique reserva disponível e OPs agendadas.");

            if (db.ExecuteScalar<float>("select sum(valor) + " + words[3] + " from  " +
                                         "(select sum(r.vl_reserva) valor " +
                                         "  from sto_reserva r " +
                                         " where r.id_sinistro = " + words[0] +
                                         "   and r.tp_valor = 3" +
                                         " union " +
                                         "select nvl(-sum(o.vl_pagamento),0) from ctb_op o where o.id_sinistro = " + words[0] + " and o.tp_op = 3" +
                                         "              and o.id_status not in (k.STATUS_OP_PAGO, k.STATUS_OP_CANCELADO, k.STATUS_OP_REJEITADO) )") < 0)
                throw new ApplicationException("Não pode ajustar a reserva para um valor menor que zero. Verifique reserva disponível e OPs agendadas.");


            if (float.Parse(words[1]) != 0)
            {
                db.Execute("begin" +
                           "  pa_sinistros.prGrabaReservaAjuste(vnidsiniestro => " + words[0] + "," +
                           "                             vnimportereserva => " + words[1] + "," +
                           "                             vntpvalor => " + 1 + "," +
                           "                             vbcontabil => '1'); " +
                           "end;");
            }

            if (float.Parse(words[2]) != 0)
            {
                db.Execute("begin" +
                           "  pa_sinistros.prGrabaReservaAjuste(vnidsiniestro => " + words[0] + "," +
                           "                             vnimportereserva => " + words[2] + "," +
                           "                             vntpvalor => " + 2 + "," +
                           "                             vbcontabil => '1'); " +
                           "end;");
            }

            if (float.Parse(words[3]) != 0)
            {
                db.Execute("begin" +
                       "  pa_sinistros.prGrabaReservaAjuste(vnidsiniestro => " + words[0] + "," +
                       "                             vnimportereserva => " + words[3] + "," +
                       "                             vntpvalor => " + 3 + "," +
                       "                             vbcontabil => '1'); " +
                       "end;");
            }

            if (float.Parse(words[4]) != 0)
            {
                db.Execute("begin" +
                       "  pa_sinistros.prGrabaReservaAjuste(vnidsiniestro => " + words[0] + "," +
                       "                             vnimportereserva => " + words[4] + "," +
                       "                             vntpvalor => " + 5 + "," +
                       "                             vbcontabil => '1'); " +
                       "end;");
            }

            if (float.Parse(words[5]) != 0)
            {
                db.Execute("begin" +
                       "  pa_sinistros.prGrabaReservaAjuste(vnidsiniestro => " + words[0] + "," +
                       "                             vnimportereserva => " + words[5] + "," +
                       "                             vntpvalor => " + 6 + "," +
                       "                             vbcontabil => '1'); " +
                       "end;");
            }

            db.Execute("commit");
            return;
        }

        public void PostFecharSinistro(string fechar)
        {
            string[] words = fechar.Split('$');
            db.Execute("begin" +
                       "  pa_sinistros.prCierraSinIndemnizacion(vnidsiniestro => " + words[0] + "," +
                       "                             vnTpMotivo => 21," +
                       "                             vcMotivo => ' '," +
                       "                             vnidusuario => '333'); " +
                       "end;");
            db.Execute("commit");
            return;
        }

        public void PostReabrirSinistro(string reabrir)
        {
            string[] words = reabrir.Split('$');
            db.Execute("begin" +
                       "  pa_sinistros.prReabrirSiniestro(vnidsiniestro => " + words[0] + "," +
                       "                             vnidusuario => '333'); " +
                       "end;");
            db.Execute("commit");
            return;
        }

        public void PostGravarOP(string op)
        {

            string[] words = op.Split('$');

            foreach (var a in db.Query<Models.Liquidacao>("select l.*, (l.VL_TOTAL * l.VL_PARTICIPACAO / 100) VL_TOTAL from vPagoLiquidacionPendiente L where id_sinistro = " + words[0]))
            {
                db.Execute("begin" +
                           "  pa_sinistros.prGrabaOp(vntpop => " + 1 + "," +
                           "                         vdpagamento => to_date('" + words[1] + "','dd/mm/yyyy')," +
                           "                         vcfavorecido => '" + a.DS_BENEFICIARIO + "'," +
                           "                         vnvalorpagamento => " + a.VL_TOTAL.ToString().Replace(",", ".") + "," +
                           "                         vntpmoeda => " + 0 + "," +
                           "                         vnidusuario => " + words[2] + "," +
                           "                         vntppagamento => " + 1 + "," +
                           "                         vnidpessoa => " + a.ID_PESSOA + "," +
                           "                         vniddocto => " + a.ID_DOCTO + "," +
                           "                         vnidliquidacao => " + a.ID_LIQUIDACAO + "," +
                           "                         vnidconta => " + a.ID_CONTA + "," +
                           "                         vbIncompleto => " + 0 + "," +
                           "                         vnidsinistro =>  " + words[0] + "); " +
                           "end;");
                db.Execute("commit");

            }

            return;
        }

        public void PostAlterarCessao(string alterarCessao)
        {

            string[] words = alterarCessao.Split('$');

            db.Execute("update sto_cesion c set c.pc_participacao = " + words[1].Replace(",", ".") + " where c.id_cesion = " + words[0]);
            db.Execute("commit");

            return;
        }

        public string GetPreAviso(string preaviso)
        {
            PetaPoco.Database db = new PetaPoco.Database("DB");

            preaviso = preaviso.Replace("$", "','").Replace(", dd/mm/yyyy)'", "', 'dd/mm/yyyy')").Replace("'to_date(", "to_date('");

            db.Execute("insert into sto_preaviso (id_preaviso, ds_cliente, cpf, dt_compra," +
                        "ds_descricao, ds_comprou, nr_certificado, ds_cobertura, nr_telefone, ds_email, fl_escolha, ds_reclamante) " +
                        "values ((select nvl(max(id_preaviso),0)+1 from sto_preaviso), '" + preaviso +
                        "' )");

            db.Execute("commit");

            return db.ExecuteScalar<string>("select max(id_preaviso) from sto_preaviso");
        }

        // POST api/<controller>
        public void Post([FromBody]string value)
        {
        }

        // PUT api/<controller>/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/<controller>/5
        public void Delete(int id)
        {
        }

        /*        private JsonResult CreateFlexiJson(IEnumerable<Models.Sinistro> items, int page, int total)
                {
                    return Json(
                            new
                            {
                                page,
                                total,
                                rows =
                                    items
                                    .Select(x =>
                                        new
                                        {
                                            id = x.ID_SINISTRO,
                                            // either use GetPropertyList(x) method to get all columns 
                                            cell = new object[] { x.NR_SINISTRO, x.DS_CLIENTE }
                                        })
                            }, JsonRequestBehavior.AllowGet);
                }
        */
    }
}