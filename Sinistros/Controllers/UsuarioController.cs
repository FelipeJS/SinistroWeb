using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Sinistros.Controllers
{
    public class UsuarioController : ApiController
    {
        public PetaPoco.Database db =
             new PetaPoco.Database("DB");

        public IEnumerable<Models.Usuario> GetUsuario(string idUsuario)
        {
            string sql = "select * " +
                "from adm_usuario natural join sto_usuario " +
                "where id_usuario = :idUsuario";

            sql = sql.Replace(":idUsuario", idUsuario);

            var usuario = db.Query<Models.Usuario>(sql);
            return usuario;
        }

        public string PostUsuario(string nomeLogin)
        {
            string[] words = nomeLogin.Split('$');

            db.Execute("INSERT INTO adm_usuario(id_usuario, cd_login, ds_usuario, ds_senha, cd_status, dt_ult_acesso, cd_idioma, cd_empresa, fl_mostra_msg, dt_cadastro, dt_ult_senha) " +
                "VALUES((select max(id_usuario) + 1 from adm_usuario), '" + words[0] + "', '" + words[2] + "', pa_sinistros.fnEncriptar('" + words[0] + "'), 'A', current_timestamp, 'pt-br', 1, 1, current_timestamp,current_timestamp)");

            string id = db.ExecuteScalar<String>("select max(id_usuario) from adm_usuario");

            db.Execute("INSERT INTO sto_usuario(id_usuario, id_perfil, ds_senha, fl_vigente, fl_reinicia_senha) " +
                "VALUES(" + id + ", " + words[1] + ", pa_sinistros.fnEncriptar('" + words[0] + "'), 1, 1)");

            db.Execute("commit");
            return id;
        }

        public string PostEmail(string emailMatricula)
        {
            string[] words = emailMatricula.Split('$');

            db.Execute("UPDATE adm_usuario set " +
                "ds_email = '" + words[1] + "', '" +
                "ds_matricula = '" + words[2] + "'" +
                "where id_usuario = " + words[0]);

            string id = db.ExecuteScalar<String>("select max(id_usuario) from adm_usuario");

            db.Execute("UPDATE sto_usuario set " +
                "ds_senha = pa_sinistros.fnEncriptar('" + words[3] + "'), " +
                "fl_vigente = " + words[4] + "," +
                "fl_reinicia_senha = " + words[5] +
                "where id_usuario = " + words[0]);

            db.Execute("commit");
            return id;
        }

        public string PostFone(string foneRamal)
        {
            string[] words = foneRamal.Split('$');

            db.Execute("UPDATE adm_usuario set " +
                "ds_fone_ramal = '" + words[1] + "', '" +
                "dt_cadastro = '" + words[2] + "'" +
                "tp_usuario = '" + words[3] + "'" +
                "vl_nivel = '" + words[4] + "'" +
                "cd_status = '" + words[5] + "'" +
                "where id_usuario = " + words[0]);

            string id = db.ExecuteScalar<String>("select max(id_usuario) from adm_usuario");

            string retorno = db.ExecuteScalar<String>("select id_usuario, cd_login, ds_usuario from adm_usuario where id_usuario >= (select max(id_usuario) from adm_usuario)");
            retorno += db.ExecuteScalar<String>("select ds_perfil from sto_usuario natural join sto_perfil where id_usuario = " + id);

            db.Execute("commit");
            return retorno;
        }

        public string PostValor(string valores)
        {
            string[] words = valores.Split('$');

            db.Execute("UPDATE adm_usuario set " +
                "id_usuario_pai = '" + words[1] + "', '" +
                "where id_usuario = " + words[0]);

            string id = db.ExecuteScalar<String>("select max(id_usuario) from adm_usuario");

            db.Execute("UPDATE sto_usuario set " +
                "vl_tope_indenizacao = pa_sinistros.fnEncriptar('" + words[1] + "'), " +
                "vl_tope_honorarios = " + words[2] + "," +
                "vl_tope_despesas = " + words[3] +
                "where id_usuario = " + words[0]);

            string retorno = db.ExecuteScalar<String>("select id_usuario, cd_login, ds_usuario from adm_usuario where id_usuario >= (select max(id_usuario) from adm_usuario)");
            retorno += db.ExecuteScalar<String>("select ds_perfil from sto_usuario natural join sto_perfil where id_usuario = " + id);

            db.Execute("commit");
            return retorno;
        }

        public string AlterarUsuarioID(string novoNomeLogin)
        {
            string[] words = novoNomeLogin.Split('$');

            db.Execute("UPDATE adm_usuario set " +
                "cd_login = '" + words[1] + "', '" +
                "ds_usuario = '" + words[2] + "'" +
                "where id_usuario = " + words[0]);

            string id = db.ExecuteScalar<String>("select max(id_usuario) from adm_usuario");

            db.Execute("UPDATE sto_usuario set " +
                "id_perfil = " + words[5] +
                "where id_usuario = " + words[0]);

            string retorno = db.ExecuteScalar<String>("select id_usuario, cd_login, ds_usuario from adm_usuario where id_usuario >= (select max(id_usuario) from adm_usuario)");
            retorno += db.ExecuteScalar<String>("select ds_perfil from sto_usuario natural join sto_perfil where id_usuario = " + id);

            db.Execute("commit");
            return retorno;
        }
    }
}