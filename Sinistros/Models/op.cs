using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sinistros.Models
{
    public class Op
    {

        public int ID_OP { get; set; }
        public int ID_SINISTRO { get; set; }
        public string NM_FAVORECIDO { get; set; }
        public float VL_PAGAMENTO { get; set; }
        public string DT_PAGAMENTO { get; set; }
        public string DS_TIPO_PAGTO { get; set; }
        public string DS_FORMA_PAGAMENTO { get; set; }
        public string DS_SERIE_NOTA_FISCAL { get; set; }

    }
}