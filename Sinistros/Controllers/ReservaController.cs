using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Sinistros.Controllers
{
    public class ReservaController : ApiController
    {
        public PetaPoco.Database db =
             new PetaPoco.Database("DB");

        public IEnumerable<Models.Reserva> Get()
        {
            var reservas =
                db.Query<Models.Reserva>("select x.seq, x.ds_evento  ds_descricao,\n" +
"sum(case z.tp_sinistro when 1 then z.vl_reserva else 0 end) vl_valor,\n" + 
"sum(case z.tp_sinistro when 2 then z.vl_reserva else 0 end) vl_valor_judicial,\n" + 
"count(*) nr_qtd from\n" + 
"( select 7 seq, 180 dt_aviso, 'MAIS DE 180 DIAS' ds_evento from dual union\n" + 
"  select 6,     150,          'DE 150 A 180 DIAS'           from dual union\n" + 
"  select 5,     120,          'DE 120 A 150 DIAS'           from dual union\n" + 
"  select 4,      90,          'DE  90 A 120 DIAS'           from dual union\n" + 
"  select 3,      60,          'DE  60 A  90 DIAS'           from dual union\n" + 
"  select 2,      30,          'DE  30 A  60 DIAS'           from dual union\n" + 
"  select 1,       0,          'ATÉ 30 DIAS'          from dual) x\n" + 
"\n" + 
"left outer join\n" + 
"(\n" + 
"select r.id_sinistro,\n" + 
"sum(r.vl_reserva) vl_reserva,\n" + 
"s.tp_sinistro,\n" + 
"case\n" + 
"  when sysdate - s.dt_aviso > 180 then 180\n" + 
"  when sysdate - s.dt_aviso > 150 then 150\n" + 
"  when sysdate - s.dt_aviso > 120 then 120\n" + 
"  when sysdate - s.dt_aviso >  90 then  90\n" + 
"  when sysdate - s.dt_aviso >  60 then  60\n" + 
"  when sysdate - s.dt_aviso >  30 then  30\n" + 
"  else 0\n" + 
"end dt_aviso\n" + 
"from sto_reserva r, sma_sinistro s\n" + 
"where s.tp_sinistro = 1\n" + 
"and s.id_sinistro = r.id_sinistro\n" + 
"group by r.id_sinistro, s.tp_sinistro, s.dt_aviso\n" + 
"having sum(r.vl_reserva) <> 0\n" + 
"union\n" + 
"select r.id_sinistro,\n" + 
"sum(r.vl_reserva) vl_reserva,\n" + 
"s.tp_sinistro,\n" + 
"case\n" + 
"  when sysdate - s.dt_aviso > 180 then 180\n" + 
"  when sysdate - s.dt_aviso > 150 then 150\n" + 
"  when sysdate - s.dt_aviso > 120 then 120\n" + 
"  when sysdate - s.dt_aviso >  90 then  90\n" + 
"  when sysdate - s.dt_aviso >  60 then  60\n" + 
"  when sysdate - s.dt_aviso >  30 then  30\n" + 
"  else 0\n" + 
"end dt_aviso\n" + 
"from sto_reserva r, sma_sinistro s\n" + 
"where s.tp_sinistro = 2\n" + 
"and s.id_sinistro = r.id_sinistro\n" + 
"group by r.id_sinistro, s.tp_sinistro, s.dt_aviso\n" + 
"having sum(r.vl_reserva) <> 0\n" + 
") z\n" + 
"on x.dt_aviso = z.dt_aviso\n" + 
"\n" + 
"group by x.seq, x.ds_evento\n" + 
"order by x.seq");
            //                db.Page<Models.Sinistro>(1, 20, "SELECT * FROM SMA_SINISTRO S, SMA_SEGURADO SEG WHERE S.ID_SEGURADO = SEG.ID_SEGURADO AND ROWNUM < 101");
            return reservas;
            //            return CreateFlexiJson(sinistros.ToList(), 1, 1);

        }

        // GET api/<controller>/5
        public IEnumerable<Models.Reserva> Get(string id)
        {
            //            return "value" + id;

            string[] words = id.Split('$');
            string sql = "select x.seq, X.DS_EVENTO ds_descricao, nvl(sum(r.vl_reserva),0) vl_valor, count(*) nr_qtd " +
"from " +
"( " +
"select 1 seq, 'A' fl_evento, '( + ) AVISOS' ds_evento from dual union " +
"select 2, 'J', '(+/-) AJUSTES' from dual union " +
"select 4, 'P', 'SINISTROS PAGOS' from dual " +
") x " +
"left outer join STO_RESERVA R on R.FL_EVENTO = x.fl_evento and TO_CHAR(R.DT_CADASTRO, 'MMYYYY') = ':mes' " +
"group by x.seq, X.DS_EVENTO " +

"union " +

"select 3, '(+/-) RECUP. (COS+RES)', nvl(sum(r.vl_resseguro + r.vl_cosseguro),0), count(*)  " +
"from  " +
"STO_RESERVA R  " +
"where TO_CHAR(R.DT_CADASTRO, 'MMYYYY') = ':mes' " +
"and (r.vl_resseguro <> 0 or r.vl_cosseguro <> 0) " +
"and r.vl_resseguro is not null " +
"and r.vl_cosseguro is not null ";

            if (words[0] == "") { sql = sql.Replace(":idSinistro", "null"); }
            else { sql = sql.Replace(":mes", words[0]); }

            var reservas =
    db.Query<Models.Reserva>(sql);
            //                db.Page<Models.Sinistro>(1, 20, "SELECT * FROM SMA_SINISTRO S, SMA_SEGURADO SEG WHERE S.ID_SEGURADO = SEG.ID_SEGURADO AND ROWNUM < 101");
            return reservas;

        }

        // GET api/<controller>/5
        public IEnumerable<Models.Reserva> GetPorPrograma(string mes)
        {
            //            return "value" + id;

            string[] words = mes.Split('$');
            string sql = "select\n" +
"p.ds_progr,\n" + 
"sum(case r.fl_evento when 'P' then 0 else r.vl_reserva + r.vl_resseguro + r.vl_cosseguro end) vl_reserva,\n" + 
"sum(case r.fl_evento when 'P' then r.vl_reserva else 0 end) vl_pagtos,\n" + 
"count(*)\n" + 
"from sto_reserva r\n" + 
"inner join sma_sinistro s on s.id_sinistro = r.id_sinistro\n" + 
"left outer join tb_emi_apoli a on a.id_apolice = s.id_apolice\n" + 
"left outer join TB_CAD_PROGR p on p.cd_progr = a.cd_progr\n" + 
"where TO_CHAR(R.DT_CADASTRO, 'MMYYYY') = '092014'\n" + 
"group by p.ds_progr\n" + 
"order by abs(sum(case r.fl_evento when 'P' then 0 else r.vl_reserva + r.vl_resseguro + r.vl_cosseguro end)) +\n" + 
"         abs(sum(case r.fl_evento when 'P' then r.vl_reserva else 0 end)) desc";

//            if (words[0] == "") { sql = sql.Replace(":idSinistro", "null"); }
//            else { sql = sql.Replace(":mes", words[0]); }

            var reservas =
    db.Query<Models.Reserva>(sql);
            return reservas;

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