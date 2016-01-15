using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Sinistros.Controllers
{
    public class PessoaController : ApiController
    {
        public PetaPoco.Database db =
             new PetaPoco.Database("DB");

        public IEnumerable<Models.Pessoa> Get()
        {
            var pessoa =
                db.Query<Models.Pessoa>("SELECT P.*, D.NR_DOCTO, D.ID_DOCTO FROM CRP_PESSOA P, CRP_DOCTO D WHERE D.ID_PESSOA = P.ID_PESSOA AND (D.TP_DOCTO = 'CPF' OR D.TP_DOCTO = 'CNPJ') AND ROWNUM < 101");
            //                db.Page<Models.Sinistro>(1, 20, "SELECT * FROM SMA_SINISTRO S, SMA_SEGURADO SEG WHERE S.ID_SEGURADO = SEG.ID_SEGURADO AND ROWNUM < 101");
            return pessoa;
            //            return CreateFlexiJson(sinistros.ToList(), 1, 1);

        }

        // GET api/<controller>/5
        public IEnumerable<Models.Pessoa> Get(string id)
        {
            string sql = "SELECT P.*, D.NR_DOCTO, D.ID_DOCTO, C.ID_CONTA, C.TP_CONTA, T.DS_CONTA, C.NRO_CONTA, C.DV_CONTA, C.CD_BANCO, B.DS_BANCO, C.CD_AGENCIA, C.DV_AGENCIA " +
"FROM CRP_PESSOA P " +
"INNER JOIN CRP_DOCTO D ON D.ID_PESSOA = P.ID_PESSOA " +
"LEFT OUTER JOIN CRP_CONTA C ON C.ID_PESSOA = P.ID_PESSOA " +
"LEFT OUTER JOIN FIN_BANCO B ON B.CD_BANCO = C.CD_BANCO " +
"LEFT OUTER JOIN SYS_TPCONTA T ON T.TP_CONTA = C.ID_TPCONTA " +
"WHERE D.NR_DOCTO = ':nrDocto'";

            sql = sql.Replace(":nrDocto", id);

            if (id.Length < 10) { sql = sql.Replace("D.NR_DOCTO", "P.ID_PESSOA"); }

            var pessoa =
                db.Query<Models.Pessoa>(sql);
            return pessoa;

        }

        // GET api/<controller>/5
        public IEnumerable<Models.Pessoa> GetNome(string nome)
        {
            string sql = "SELECT P.* " +
"FROM CRP_PESSOA P " +
"WHERE P.DS_PESSOA LIKE UPPER(':nome%')";

            sql = sql.Replace(":nome", nome);

            //            var pessoa = db.Query<Models.Pessoa>(sql);
            //            return pessoa;


            var pessoa =
                db.Query<Models.Pessoa>(sql);
            return pessoa;

        }

        //Felipe Campos
        public IEnumerable<Models.Pessoa> GetCPF(string numeroCPF)
        {
            string sql = "SELECT TP_DOCTO, NR_DOCTO, DS_PESSOA " +
                         "FROM CRP_DOCTO NATURAL JOIN CRP_PESSOA " +
                         "WHERE NR_DOCTO = ':numeroCPF' ";

            sql = sql.Replace(":numeroCPF", numeroCPF);

            var cpf = db.Query<Models.Pessoa>(sql);
            return cpf;
        }

        //Felipe Campos
        public IEnumerable<Models.Pessoa> GetConta(string numeroConta)
        {
            string[] words = numeroConta.Split('$');

            string sql = "SELECT P.*, C.ID_CONTA, C.ID_TPCONTA TP_CONTA, T.DS_CONTA, C.NRO_CONTA, C.DV_CONTA, C.CD_BANCO, B.DS_BANCO, C.CD_AGENCIA, C.DV_AGENCIA,  C.FL_PRINCIPAL FL_CONTA_PRINCIPAL " +
                         "FROM CRP_PESSOA P " +
                         "INNER JOIN CRP_CONTA C ON C.ID_PESSOA = P.ID_PESSOA " +
                         "LEFT OUTER JOIN FIN_BANCO B ON B.CD_BANCO = C.CD_BANCO " +
                         "LEFT OUTER JOIN SYS_TPCONTA T ON T.TP_CONTA = C.ID_TPCONTA " +
                         "WHERE C.NRO_CONTA = " + words[0] + " AND C.CD_AGENCIA = " + words[1] + " AND C.CD_BANCO = " + words[2];

            var pessoa =
                db.Query<Models.Pessoa>(sql);
            return pessoa;

        }

        // GET api/<controller>/5
        public IEnumerable<Models.Pessoa> GetDoctos(string doctos)
        {
            string sql = "SELECT P.*, D.TP_DOCTO, D.NR_DOCTO, D.ID_DOCTO " +
"FROM CRP_PESSOA P " +
"INNER JOIN CRP_DOCTO D ON D.ID_PESSOA = P.ID_PESSOA " +
"WHERE D.ID_PESSOA = :doctos " +
"AND D.TP_DOCTO IN ('CPF','CNPJ')";

            sql = sql.Replace(":doctos", doctos);

            //            var pessoa = db.Query<Models.Pessoa>(sql);
            //            return pessoa;


            var pessoa =
                db.Query<Models.Pessoa>(sql);
            return pessoa;

        }

        // GET api/<controller>/5
        public IEnumerable<Models.Pessoa> GetEnderecos(string enderecos)
        {
            string sql = "SELECT P.*, E.* " +
"FROM CRP_PESSOA P " +
"INNER JOIN CRP_ENDERECO E ON E.ID_PESSOA = P.ID_PESSOA " +
"WHERE P.ID_PESSOA = ':enderecos'";

            sql = sql.Replace(":enderecos", enderecos);

            //            var pessoa = db.Query<Models.Pessoa>(sql);
            //            return pessoa;


            var pessoa =
                db.Query<Models.Pessoa>(sql);
            return pessoa;

        }

        // GET api/<controller>/5
        public IEnumerable<Models.Pessoa> GetContas(string contas)
        {
            string sql = "SELECT P.*, C.ID_CONTA, C.ID_TPCONTA TP_CONTA, T.DS_CONTA, C.NRO_CONTA, C.DV_CONTA, C.CD_BANCO, B.DS_BANCO, C.CD_AGENCIA, C.DV_AGENCIA,  C.FL_PRINCIPAL FL_CONTA_PRINCIPAL " +
"FROM CRP_PESSOA P " +
"INNER JOIN CRP_CONTA C ON C.ID_PESSOA = P.ID_PESSOA " +
"LEFT OUTER JOIN FIN_BANCO B ON B.CD_BANCO = C.CD_BANCO " +
"LEFT OUTER JOIN SYS_TPCONTA T ON T.TP_CONTA = C.ID_TPCONTA " +
"WHERE P.ID_PESSOA = :contas";

            sql = sql.Replace(":contas", contas);

            //            var pessoa = db.Query<Models.Pessoa>(sql);
            //            return pessoa;


            var pessoa =
                db.Query<Models.Pessoa>(sql);
            return pessoa;

        }

        // GET api/<controller>/5
        public string GetPessoaID(string nometipo)
        {
            string[] words = nometipo.Split('$');

            db.Execute("insert into CRP_PESSOA (DS_PESSOA, TP_PESSOA) " +
                        "values ('" + words[0] + "', '" + words[1] + "')");

            string id = db.ExecuteScalar<String>("select seq_crp_pessoa.currval from dual");

            db.Execute("commit");
            return id;
        }

        // POST api/<controller>
        public void PostDocto(string docto)
        {
            docto = docto + "$CPF$1";

            string[] words = docto.Split('$');

            if (words[1].Length > 11)
            {
                words[2] = "CNPJ";
                words[3] = "2";
            }

            db.Execute("insert into CRP_DOCTO (ID_PESSOA, NR_DOCTO, TP_DOCTO, ID_TPDOCTO) " +
                        "values ('" + words[0] + "', '" + words[1] + "', '" + words[2] + "', " + words[3] + ")");

            db.Execute("commit");
            return;
        }

        //Felipe Campos
        public void PostAlteracaoDocto(string doctoNovo)
        {
            doctoNovo = doctoNovo + "$CPF$1";

            string[] words = doctoNovo.Split('$');

            db.Execute(" UPDATE CRP_DOCTO " + 
                       " SET NR_DOCTO = '" + words[0] +
                       "' WHERE NR_DOCTO = '" + words[1] + "'");

            db.Execute("commit");
            return;
        }

        // POST api/<controller>
        public void PostEndereco(string endereco)
        {
            endereco = endereco.Replace("$", "','");

            db.Execute("insert into CRP_ENDERECO (id_pessoa, ds_endereco, ds_compl, ds_bairro, ds_cidade, cd_uf, ds_cep) " +
                        "values ('" + endereco + "')");

            db.Execute("commit");
            return;
        }

        // POST api/<controller>
        public void PostConta(string conta)
        {
            conta = conta.Replace("$", "','");

            conta = conta.Replace("'on'", "'1'");

            db.Execute("insert into CRP_CONTA (ID_PESSOA, NRO_CONTA, DV_CONTA, CD_BANCO, CD_AGENCIA, DV_AGENCIA, FL_PRINCIPAL, ID_TPCONTA) " +
                        "values ('" + conta + "')");

            db.Execute("commit");
            return;
        }

        //Felipe Campos
        public void PostContaNova(string contaNova)
        {
            string[] words = contaNova.Split('$');

            if (words[5] == "on")
                words[5] = "1";
            else
                words[5] = "0";

            db.Execute(" UPDATE CRP_CONTA C " +
                       " SET C.NRO_CONTA = " + words[0] +
                       ", C.DV_CONTA = " + words[1] +
                       ", C.CD_BANCO = " + words[2] +
                       ", C.CD_AGENCIA = " + words[3] +
                       ", C.DV_AGENCIA = " + words[4] +
                       ", C.FL_PRINCIPAL = " + words[5] +
                       ", C.ID_TPCONTA = " + words[6] +
                       " WHERE C.NRO_CONTA = " + words[7] + 
                       " AND C.CD_AGENCIA = " + words[8] +
                       " AND C.CD_BANCO = " + words[9]);

            db.Execute("commit");
            return;
        }
    }
}