using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.DirectoryServices;

namespace Sinistros
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Login_Click(Object sender, EventArgs e)
        {
            PetaPoco.Database db = new PetaPoco.Database("DB");

            try
            {
                DirectoryEntry objAD = new DirectoryEntry("LDAP://1.0.0.40", Descricao.Value, Senha.Value);

                Session["usuarioNome"] = objAD.Name;
                Session["usuarioNome"] = objAD.Username;
                //                Session["usuarioNome"] = objAD.Properties["displayName"].Value.ToString(); ;

                FormsAuthentication.RedirectFromLoginPage(objAD.Username, true);

                Session["usuario"] = db.ExecuteScalar<string>("select u.id_usuario from adm_usuario u where UPPER(u.cd_login) = UPPER('" + objAD.Username + "')");

                Session["perfil"] = db.ExecuteScalar<string>("select id_perfil from sto_usuario where id_usuario = nvl('" + Session["usuario"] + "',-1)");

                if (Session["perfil"] == null) Session["perfil"] = -1;

                #if DEBUG
                    if (Session["perfil"].ToString() == "-1") Session["perfil"] = 1;
                #else
                    Console.WriteLine("Mode=Release"); 
                #endif

            }

            catch (Exception ex)
            {

                try
                {
                    Session["perfil"] = db.ExecuteScalar<string>("select id_perfil from sto_usuario s, adm_usuario u where s.id_usuario = u.id_usuario and upper(u.cd_login) = upper('" + Descricao.Value + "') and s.ds_senha = pa_sinistros.fnEncriptar('" + Senha.Value + "')");

                    if (Session["perfil"] == null)
                    {
                        contaTentativa.Value = "1";
                        throw new Exception(ex.Message);
                    };


                    if (Session["perfil"].ToString() == "63")
                    {
                        Session["perfil"] = "-1";
                    };

                    FormsAuthentication.RedirectFromLoginPage(Descricao.Value, true);

                    Session["usuario"] = db.ExecuteScalar<string>("select u.id_usuario from adm_usuario u where UPPER(u.cd_login) = UPPER('" + Descricao.Value + "')");

                }
                catch (Exception ex2)
                {
                    contaTentativa.Value = "1";
                    throw new Exception(ex2.Message);
                }
            }

            return;

        }

    }
}