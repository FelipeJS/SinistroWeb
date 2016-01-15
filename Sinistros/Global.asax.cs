using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Security;
using System.Web.SessionState;

namespace Sinistros
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            GlobalConfiguration.Configuration.Routes.MapHttpRoute(
               name: "default",
               routeTemplate: "{controller}/{id}",
               defaults: new
               {
                   id = RouteParameter.Optional
               });

            GlobalConfiguration.Configuration.Formatters.XmlFormatter.SupportedMediaTypes.Clear();

        }

        protected void Session_Start(object sender, EventArgs e)
        {

//            PetaPoco.Database db = new PetaPoco.Database("DB");

//            Session["usuario"] = db.ExecuteScalar<string>("select id_usuario from adm_usuario where cd_login = nvl('" + Request.QueryString["login"]+"','')");

//            Session["perfil"] = db.ExecuteScalar<string>("select id_perfil from sto_usuario where id_usuario = nvl('" + Session["usuario"] + "',-1)");

//            if (Session["usuario"] == null) Session["usuario"] = 333;

//            if (Session["perfil"] == null) Session["perfil"] = -1;

//            #if DEBUG
//                if (Session["perfil"].ToString() == "-1") Session["perfil"] = 1;
//            #else
//                Console.WriteLine("Mode=Release"); 
//            #endif

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}