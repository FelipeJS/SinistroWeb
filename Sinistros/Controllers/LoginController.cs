using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Security;
using System.DirectoryServices;

namespace Sinistros.Controllers
{
    public class LoginController : ApiController
    {

        // GET api/<controller>/5
        public String Get(string usuario)
        {

            PetaPoco.Database db = new PetaPoco.Database("DB");

            string[] words = usuario.Split('$');

            string retorno = string.Empty;

            try

            {

                DirectoryEntry objAD = new DirectoryEntry("LDAP://1.0.0.40", words[0].ToUpper(), words[1]);

                retorno = objAD.Name;

            }

            catch (Exception ex)

            {

                try
                {
                    string perfil = db.ExecuteScalar<string>("select id_perfil from sto_usuario s, adm_usuario u where s.id_usuario = u.id_usuario and upper(u.cd_login) = upper('" + words[0].ToUpper() + "') and s.ds_senha = pa_sinistros.fnEncriptar('" + words[1] + "')");

                    if (perfil == null)
                    {
                        FormsAuthentication.SignOut();
                        throw new Exception(ex.Message);
                    };
                    return perfil;

                }
                catch (Exception ex2)
                {
                    FormsAuthentication.SignOut();
                    throw new Exception(ex2.Message);
                }

            }

            return retorno;

        }

        public string Get() 
        {
            FormsAuthentication.SignOut();
            return "";
        }

    }
}