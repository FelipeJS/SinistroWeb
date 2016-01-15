using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sinistros.Models
{
    public class Arquivo
    {
        public int ID_ARQUIVO { get; set; }
        public int ID_SINISTRO { get; set; }
        public string DS_DESCRICAO { get; set; }
        public string DS_TIPO { get; set; }
    }
}