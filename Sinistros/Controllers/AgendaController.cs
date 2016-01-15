using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Sinistros.Controllers
{
    public class AgendaController : ApiController
    {

        public PetaPoco.Database db =
             new PetaPoco.Database("DB");
        
        // GET api/<controller>
        public IEnumerable<Models.Agenda> Get()
        {
            var agenda =
                db.Query<Models.Agenda>("select rownum id, 'new Date(\"' || to_char(a.dt_proxrevisao,'dd/mm/yyyy') || ' 08:00 AM\")' as \"start\", "
+ "                                             'new Date(\"' || to_char(a.dt_proxrevisao,'dd/mm/yyyy') || ' 09:00 AM\")' end, "
+            "                                   trim(a.ds_comentarios) || '-' || s.nr_sinistro_aon title," 
+            "                                  u.ds_usuario description, a.id_usuario ownerid "
+            "                           from sto_agenda a inner join sma_sinistro s on a.id_sinistro = s.id_sinistro inner join sma_segurado ase "
+            "                                on ase.id_segurado = s.id_segurado left outer join adm_usuario u on u.id_usuario = a.id_usuario "
+            "                           where a.fl_adiada = 0 and a.fl_feita = 0 order by  a.fl_prioridade, a.dt_proxrevisao");
            return agenda;
        }

        // GET api/<controller>/5
        public string Get(int id)
        {
            return "value";
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
    }
}