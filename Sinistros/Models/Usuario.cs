using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sinistros.Models
{
    public class Usuario
    {
        public int ID_USUARIO { get; set; }
        public string DS_SENHA { get; set; }
        public string CD_LOGIN { get; set; }
        public string DS_USUARIO { get; set; }
        public string DS_EMAIL { get; set; }
        public string DS_MATRICULA { get; set; }
        public string DS_FONE_RAMAL { get; set; }
        public string CD_STATUS { get; set; }
        public DateTime DT_ULT_ACESSO { get; set; }
        public string CD_IDIOMA { get; set; }
        public string CD_EMPRESA { get; set; }
        public int FL_MOSTRA_MSG { get; set; }
        public DateTime DT_CADASTRO { get; set; }
        public DateTime DT_ULT_SENHA { get; set; }
        public int ID_USUARIO_PAI { get; set; }
        public char TP_USUARIO { get; set; }
        public int VL_NIVEL { get; set; }
        public int FL_TRACE { get; set; }
        public string VL_EXCECAO { get; set; }
        public int ID_PERFIL { get; set; }
        public double VL_TOPE_INDENIZACAO { get; set; }
        public double VL_TOPE_HONORARIOS { get; set; }
        public double VL_TOPE_DESPESAS { get; set; }
        public int FL_VIGENTE { get; set; }
        public int CD_SUCURSAL { get; set; }
        public char FL_REINICIA_SENHA { get; set; }
    }
}