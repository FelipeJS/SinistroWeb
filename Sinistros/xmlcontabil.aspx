<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="xmlcontabil.aspx.cs" Inherits="Sinistros.xmlcontabil" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>

    <asp:SqlDataSource id="dsSinistro" runat="server" 
        connectionstring="<%$ ConnectionStrings:DB1 %>" 
        providername="<%$ ConnectionStrings:DB1.ProviderName %>" 
        selectcommand="select  
to_char(d.nm_conta) as AccountCode,
'0' || to_char(e.dt_entrada,'mmyyyy') as AccountingPeriod,
trim(to_char(a.Cd_Sucursal, '0000')) as AnalysisCode1,
trim(to_char(a.cd_grupo_emis, '00')) || trim(to_char(a.Cd_Ramo_Emis, '00'))  as AnalysisCode2,
trim(to_char(a.Cd_Progr, '0000'))  as AnalysisCode3,
trim(to_char(p.cd_produto, '0000'))  as AnalysisCode4,
trim(to_char(nvl((select min(c.cd_canal_distr) from tb_emi_cnldt c where ee.cd_sucursal = c.cd_sucursal and ee.cd_ramo_emis = c.cd_ramo_emis 
        and ee.nr_prop_apoli = c.nr_prop_apoli and ee.nr_prop_endos = c.nr_prop_endos), '2000'), '0000'))
  as AnalysisCode5,
to_char(nvl(ee.cd_dealer, '17658'))  as AnalysisCode6,
to_char(s.dt_ocorrencia,'ddmmyyyy') as AnalysisCode7,
NVL( to_char(a.Nr_Apoli_Ofic), a.nr_lote) as AnalysisCode8,
to_char(nvl(s.nr_sinistro, ' ')) as AnalysisCode9,
to_char(1) as ConversionRate,
case when d.vl_debito > 0 then trim(replace(to_char(trunc(abs(d.vl_debito),2)), ',', '.'))
     when d.vl_credito > 0 then trim(replace(to_char(trunc(abs(d.vl_credito),2)), ',', '.'))
end as TransactionAmount,
'BRL' as CurrencyCode,
case trim(r.fl_evento) when 'J' then 'Ajuste ' else 'Aviso ' end || 'mes ' || to_char(r.dt_cadastro, 'mmyyyy') || ' sntro ' || s.nr_sinistro as Description,
case when nvl(d.vl_debito, 0) > 0 then 'D'
     when nvl(d.vl_credito, 0) > 0 then 'C'
end as DebitCredit,
'AVI' as JournalSource,
'SNTRO' as JournalType,
to_char(e.dt_entrada,'ddmmyyyy') as TransactionDate,
'ID_ASIENTO ' ||d.id_asiento ||' Sec.' ||d.nm_secuencia as TransactionReference
from ctb_mov_enc e
INNER JOIN ctb_mov_det d ON e.id_asiento = d.id_asiento
LEFT OUTER JOIN sto_reserva r ON e.ds_glosa = 'ID_RESERVA ' || r.id_reserva
LEFT OUTER JOIN sma_sinistro s ON r.id_sinistro = s.id_sinistro
LEFT OUTER JOIN tb_emi_apoli a ON s.id_apolice = a.id_apolice
LEFT OUTER JOIN tb_cad_prodt p ON a.id_prod_unif = p.id_prod_unif
LEFT OUTER JOIN tb_emi_endos ee ON s.id_endosso = ee.id_endosso
where e.dt_entrada between to_date(:dt1, 'ddmmyyyy') and to_date(:dt2, 'ddmmyyyy')
and e.vl_total <> 0
and e.ds_glosa like '%RESERVA%'
--and s.id_sinistro = -999999
--and a.id_apolice is not null
--and ee.id_endosso is not null
UNION

select 
to_char(d.nm_conta) as AccountCode,
'0' || to_char(e.dt_entrada,'mmyyyy') as AccountingPeriod,
trim(to_char(a.Cd_Sucursal, '0000')) as AnalysisCode1,
trim(to_char(a.cd_grupo_emis, '00')) || trim(to_char(a.Cd_Ramo_Emis, '00'))  as AnalysisCode2,
trim(to_char(a.Cd_Progr, '0000'))  as AnalysisCode3,
trim(to_char(p.cd_produto, '0000'))  as AnalysisCode4,
trim(to_char(nvl((select min(c.cd_canal_distr) from tb_emi_cnldt c where ee.cd_sucursal = c.cd_sucursal and ee.cd_ramo_emis = c.cd_ramo_emis 
        and ee.nr_prop_apoli = c.nr_prop_apoli and ee.nr_prop_endos = c.nr_prop_endos), '2000'), '0000'))
  as AnalysisCode5,
to_char(nvl(ee.cd_dealer, '17658'))  as AnalysisCode6,
to_char(s.dt_ocorrencia,'ddmmyyyy') as AnalysisCode7,
NVL( to_char(a.Nr_Apoli_Ofic), a.nr_lote) as AnalysisCode8,
to_char(nvl(s.nr_sinistro, ' ')) as AnalysisCode9,
to_char(1) as ConversionRate,
case when d.vl_debito <> 0 then trim(replace(to_char(trunc(abs(d.vl_debito),2)), ',', '.'))
     when d.vl_credito <> 0 then trim(replace(to_char(trunc(abs(d.vl_credito),2)), ',', '.'))
end as TransactionAmount,
'BRL' as CurrencyCode,
'Pagto mes ' || to_char(e.dt_entrada, 'mmyyyy') || ' sntro ' || s.nr_sinistro as Description,
case when nvl(d.vl_debito, 0) <> 0 then 'D'
     when nvl(d.vl_credito, 0) <> 0 then 'C'
end as DebitCredit,
'AVI' as JournalSource,
'SNTRO' as JournalType,
to_char(e.dt_entrada,'ddmmyyyy') as TransactionDate,
'ID_ASIENTO ' ||d.id_asiento ||' Sec.' ||d.nm_secuencia as TransactionReference
from ctb_mov_enc e
INNER JOIN ctb_mov_det d ON e.id_asiento = d.id_asiento
LEFT OUTER JOIN sma_sinistro s ON trim(e.ds_glosa) = 'SINISTRO.' || s.id_sinistro
LEFT OUTER JOIN tb_emi_apoli a ON s.id_apolice = a.id_apolice
LEFT OUTER JOIN tb_cad_prodt p ON a.id_prod_unif = p.id_prod_unif
LEFT OUTER JOIN tb_emi_endos ee ON s.id_endosso = ee.id_endosso
where e.dt_entrada between to_date(:dt1, 'ddmmyyyy') and to_date(:dt2, 'ddmmyyyy')
and e.vl_total <> 0
and e.ds_glosa like 'SINISTRO%'


UNION

select 
to_char(d.nm_conta) as AccountCode,
'0' || to_char(e.dt_entrada,'mmyyyy') as AccountingPeriod,
trim(to_char(a.Cd_Sucursal, '0000')) as AnalysisCode1,
trim(to_char(a.cd_grupo_emis, '00')) || trim(to_char(a.Cd_Ramo_Emis, '00'))  as AnalysisCode2,
trim(to_char(a.Cd_Progr, '0000'))  as AnalysisCode3,
trim(to_char(p.cd_produto, '0000'))  as AnalysisCode4,
trim(to_char(nvl((select min(c.cd_canal_distr) from tb_emi_cnldt c where ee.cd_sucursal = c.cd_sucursal and ee.cd_ramo_emis = c.cd_ramo_emis 
        and ee.nr_prop_apoli = c.nr_prop_apoli and ee.nr_prop_endos = c.nr_prop_endos), '2000'), '0000'))
  as AnalysisCode5,
to_char(nvl(ee.cd_dealer, '17658'))  as AnalysisCode6,
to_char(s.dt_ocorrencia,'ddmmyyyy') as AnalysisCode7,
NVL( to_char(a.Nr_Apoli_Ofic), a.nr_lote) as AnalysisCode8,
to_char(nvl(s.nr_sinistro, ' ')) as AnalysisCode9,
to_char(1) as ConversionRate,
case when d.vl_debito > 0 then trim(replace(to_char(d.vl_debito), ',', '.'))
     when d.vl_credito > 0 then trim(replace(to_char(d.vl_credito), ',', '.'))
end as TransactionAmount,
'BRL' as CurrencyCode,
'Pagto mes ' || to_char(e.dt_entrada, 'mmyyyy') || ' sntro ' || s.nr_sinistro as Description,
case when nvl(d.vl_debito, 0) > 0 then 'D'
     when nvl(d.vl_credito, 0) > 0 then 'C'
end as DebitCredit,
'AVI' as JournalSource,
'SNTRO' as JournalType,
to_char(e.dt_entrada,'ddmmyyyy') as TransactionDate,
'ID_ASIENTO ' ||d.id_asiento ||' Sec.' ||d.nm_secuencia as TransactionReference
from ctb_mov_enc e
INNER JOIN ctb_mov_det d ON e.id_asiento = d.id_asiento
LEFT OUTER JOIN ctb_op o ON e.ds_glosa = 'OP.' || o.id_op
LEFT OUTER JOIN sma_sinistro s ON o.id_sinistro = s.id_sinistro
LEFT OUTER JOIN tb_emi_apoli a ON s.id_apolice = a.id_apolice
LEFT OUTER JOIN tb_cad_prodt p ON a.id_prod_unif = p.id_prod_unif
LEFT OUTER JOIN tb_emi_endos ee ON s.id_endosso = ee.id_endosso
where e.dt_entrada between to_date(:dt1, 'ddmmyyyy') and to_date(:dt2, 'ddmmyyyy')
and e.vl_total <> 0
and e.ds_glosa like 'OP%'

">
    </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
