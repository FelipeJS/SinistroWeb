using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sinistros.Models
{
    public class Beneficiario
    {
        public int ID_BENEFICIARIO { get; set; }
        public string DS_PESSOA { get; set; }
        public string TP_PARENTESCO { get; set; }
        public float VL_PARTICIPACAO { get; set; }

    }
}