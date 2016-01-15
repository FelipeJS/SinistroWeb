using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Sinistros.Models
{
    public class Reserva
    {
        public int seq { get; set; }
        public string ds_descricao { get; set; }
        public float vl_valor  { get; set; }
        public float vl_valor_judicial { get; set; }
        public string Ds_Progr { get; set; }
        public float vl_reserva { get; set; }
        public float vl_pagtos { get; set; }
        public int nr_qtd { get; set; }
    }
}