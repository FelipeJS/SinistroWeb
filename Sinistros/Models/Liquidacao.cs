using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sinistros.Models
{
    public class Liquidacao
    {
        public int ID_LIQUIDACAO { get; set; }
        public int ID_SINISTRO { get; set; }
        public int ID_PESSOA { get; set; }
        public int ID_DOCTO { get; set; }
        public int ID_CONTA { get; set; }
        public string DS_BENEFICIARIO { get; set; }
        public string DS_TPSINISTRO { get; set; }
        public string DS_DT_EMISSAO { get; set; }
        public string FL_PAGTO { get; set; }
        public float VL_TOTAL { get; set; }

    }
}