using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sinistros.Models
{
    public class Pessoa
    {
        public int ID_PESSOA { get; set; }
        public string TP_DOCTO { get; set; }
        public string NR_DOCTO { get; set; }
        public string ID_DOCTO { get; set; }
        public string DS_PESSOA { get; set; }
        public int ID_CONTA { get; set; }
        public string CD_BANCO { get; set; }
        public string DS_BANCO { get; set; }
        public string CD_AGENCIA { get; set; }
        public string DV_AGENCIA { get; set; }
        public string NRO_CONTA { get; set; }
        public string DV_CONTA { get; set; }
        public string TP_CONTA { get; set; }
        public string DS_CONTA { get; set; }
        public string FL_CONTA_PRINCIPAL { get; set; }
        public string TP_PESSOA { get; set; }
        public int ID_ENDERECO { get; set; }
        public string DS_ENDERECO { get; set; }
        public string DS_COMPL { get; set; }
        public string DS_BAIRRO { get; set; }
        public string DS_CIDADE { get; set; }
        public string DS_CEP { get; set; }
        public string CD_UF { get; set; }

    }
}