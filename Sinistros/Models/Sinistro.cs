using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sinistros.Models
{
    public class Sinistro
    {
        public int ID_SINISTRO { get; set; }
        public string NR_SINISTRO { get; set; }
        public string DS_CLIENTE { get; set; }
        public string CD_CLIENTE_ETP { get; set; }
        public string NR_APOLI_OFIC { get; set; }
        public string DS_ESTIPULANTE { get; set; }
        public string CPF { get; set; }
        public float VL_RESERVA { get; set; }
    }
}