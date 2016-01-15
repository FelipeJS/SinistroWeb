<!DOCTYPE html>

<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />

    <!--Aplicação do Estilo Metro-->
    <link rel="stylesheet" href="Content/Metro-UI-CSS-master/css/metro-bootstrap.css">
    <script src="Content/Metro-UI-CSS-master/js/jquery/jquery.min.js"></script>
    <script src="Content/Metro-UI-CSS-master/js/jquery/jquery.widget.min.js"></script>
    <script src="Content/Metro-UI-CSS-master/js/metro/metro.min.js"></script>
    
    <link type="text/css" href="/Content/css/menu.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/grid.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery-ui-1.8.22.custom.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/wizard.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/fileupload.main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery.fileupload-ui.css" rel="stylesheet" />
    <link href="css/monthpicker.css" rel="stylesheet" type="text/css" />

    <script src="/Scripts/jquery/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery.wizard.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery-percent.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery-blockUI.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery.notice.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery.qtip.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery-ui-1.9.1.custom.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery-timerpicker.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery.form.json.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery-manager-error.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery.decimalMask.js" type="text/javascript"></script>
    <script src="/Scripts/grid.js" type="text/javascript"></script>
    <script src="/Scripts/json2.js" type="text/javascript"></script>
    <script src="/Scripts/menu.js" type="text/javascript"></script>
    <script src="/Scripts/commons.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery.maskedinput-1.2.2.js" type="text/javascript"></script>

    <script src="/Scripts/FileUpload/tmpl.min.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/canvas-to-blob.min.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/load-image.min.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/jquery.iframe-transport.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/jquery.fileupload.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/jquery.fileupload-ip.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/jquery.fileupload-ui.js" type="text/javascript" charset="ISO88591"></script>
    <script src="/Scripts/FileUpload/main.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/locale.js" type="text/javascript"></script>

    <script src="Scripts/monthpicker.min.js" type="text/javascript" charset="iso-8859-1"></script>
    <script src="js/accounting.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ajaxStart(function () {
            $.blockUI({ overlayCSS: { opacity: .2 }, message: '<img src="/Content/images/main/loading.gif") />' });
        }).ajaxStop($.unblockUI);

    </script>

    <style type="text/css">
        .flexigrid {
            font-size: 16px;
            font-family: "Open Sans", sans-serif;
            font-weight: 500;
        }
    </style>

    <script type="text/javascript">

        hoje = new Date();
        mes = new String();
        mesAnterior = new String();
        ano = new String();

        if (hoje.getMonth() < 9) {
            mes = '0' + (hoje.getMonth() + 1);
            mesAnterior = '0' + hoje.getMonth();
        }
        else {
            mes = (hoje.getMonth() + 1);
            mesAnterior = '0' + hoje.getMonth();
        }

        ano = hoje.getFullYear().toString();

        $(document).ready(function () {

            $("#flexPorPrograma").flexigrid({
                dataType: 'json',
                colModel: [
                        { display: 'Programa', name: 'Ds_Progr', width: 214, sortable: true, align: 'left' },
                        { display: 'Avisados Liq. R$ ', name: 'vl_reserva', width: 120, sortable: true, align: 'right' },
                        { display: 'Pagos R$ ', name: 'vl_pagtos', width: 120, sortable: true, align: 'right' }
                ],
                title: "Sinistros Avisados No Mês - Principais Programas",
                showTableToggleBtn: false,
                resizable: false,
                width: 490,
                height: 565,
                singleSelect: true,
                cursorIcon: '1',
                newp: 1
            });


            $("#flexMesAtual").flexigrid({
                dataType: 'json',
                colModel: [
                        { display: 'Sinistros Avisados - Mês', name: 'Ds_descricao', width: 210, sortable: true, align: 'left' },
                        { display: 'Valor R$ ', name: 'vl_valor', width: 159, sortable: true, align: 'right' },
                        { display: 'Quantidade  ', name: 'nr_qtd', width: 85, sortable: true, align: 'right' }
                ],
                title: "Mês Corrente",
                showTableToggleBtn: false,
                resizable: false,
                width: 490,
                height: 191,
                singleSelect: true,
                cursorIcon: '1',
                newp: 1
            });

            $("#flexStatus").flexigrid({
                dataType: 'json',
                colModel: [
                        { display: ' ', name: 'Ds_descricao', width: 140, sortable: true, align: 'left' },
                        { display: 'Adm R$  ', name: 'vl_valor', width: 126, sortable: true, align: 'right' },
                        { display: 'Judicial R$  ', name: 'vl_valor_judicial', width: 126, sortable: true, align: 'right' },
                        { display: 'Qtd  ', name: 'nr_qtd', width: 50, sortable: true, align: 'right' }
                ],
                title: "Aging da Provisão Sinistros a Liquidar - PSL",
                showTableToggleBtn: false,
                resizable: false,
                width: 490,
                height: 271,
                singleSelect: true,
                cursorIcon: '1',
                newp: 1
            });

        });

        $.ajax({
            type: "get",
            contentType: "application/json",
            url: "reserva?mes=" + mes + ano,
            data: "{}",
            dataType: 'json',
            success: function (result) {
                //add data
                $("#flexPorPrograma").flexAddData(formatResultsPrograma(result));
            }
        });

        $.ajax({
            type: "get",
            contentType: "application/json",
            url: "reserva/" + mes + ano,
            data: "{}",
            dataType: 'json',
            success: function (result) {
                //add data
                $("#flexMesAtual").flexAddData(formatResults(result));
            }
        });

        $.ajax({
            type: "get",
            contentType: "application/json",
            url: "reserva",
            data: "{}",
            dataType: 'json',
            success: function (result) {
                //add data
                $("#flexStatus").flexAddData(formatResultsAging(result));
            }
        });

        function formatResults(Reserva) {
            var rows = Array();
            var vl_total = 0;

            for (i = 0; i < Reserva.length; i++) {
                var item = Reserva[i];
                if (item.vl_valor < 0)
                { var str = "<div  style='text-align:right;color:red'>"; }
                else
                { var str = "<div  style='text-align:right'>"; }

                rows.push({ cell: [item.ds_descricao, str.concat(accounting.formatMoney(item.vl_valor, { symbol: "", precision: 2, decimal: ",", thousand: ".", format: { pos: "%s %v", neg: "%s (%v)", zero: "  --" } }), "</div>"), str.concat(item.nr_qtd, "</div>"), ''] });
                vl_total = vl_total + item.vl_valor;

                //calcula total somente para Avisos e Ajustes
                if (item.ds_descricao == "(+/-) RECUP. (COS+RES)") {
                    str = "<div  style='text-align:right'>";
                    rows.push({ cell: ["<div style='text-align:left;font-weight: bold;padding-left: 0px;'>SINISTROS LÍQUIDOS</div>", str.concat(accounting.formatMoney(vl_total, { symbol: "", precision: 2, decimal: ",", thousand: ".", format: { pos: "%s %v", neg: "%s (%v)", zero: "  --" } }), "</div>"), ''] });
                }
            }

            if (vl_total < 0)
            { var str = "<div style='text-align:right;font-weight: bold;color:red'>"; }
            else
            { var str = "<div style='text-align:right;font-weight: bold'>"; }

            //            rows.push({ cell: ["", "<div style='text-align:left;font-weight: bold'>TOTAL</div>", str.concat(accounting.formatMoney(vl_total, { symbol: "", precision: 2, decimal: ",", thousand: ".", format: { pos: "%s %v", neg: "%s (%v)", zero: "  --"} }), "</div>"), ''] });

            return { total: Reserva.length, page: 1, rows: rows }
        }

        function formatResultsAging(Reserva) {
            var rows = Array();
            var vl_total = 0;

            for (i = 0; i < Reserva.length; i++) {
                var item = Reserva[i];
                if (item.vl_valor < 0)
                { var str = "<div  style='text-align:right;color:red'>"; }
                else
                { var str = "<div  style='text-align:right'>"; }

                rows.push({ cell: [item.ds_descricao, str.concat(accounting.formatMoney(item.vl_valor, { symbol: "", precision: 2, decimal: ",", thousand: ".", format: { pos: "%s %v", neg: "%s (%v)", zero: "  --" } }), "</div>"), str.concat(accounting.formatMoney(item.vl_valor_judicial, { symbol: "", precision: 2, decimal: ",", thousand: ".", format: { pos: "%s %v", neg: "%s (%v)", zero: "  --" } }), "</div>"), str.concat(item.nr_qtd, "</div>"), ''] });
                vl_total = vl_total + item.vl_valor;

                //calcula total somente para Avisos e Ajustes
                if (item.ds_descricao == "(+/-) RECUP. (COS+RES)") {
                    str = "<div  style='text-align:right'>";
                    rows.push({ cell: ["<div style='text-align:left;font-weight: bold;padding-left: 0px;'>SINISTROS LÍQUIDOS</div>", str.concat(accounting.formatMoney(vl_total, { symbol: "", precision: 2, decimal: ",", thousand: ".", format: { pos: "%s %v", neg: "%s (%v)", zero: "  --" } }), "</div>"), ''] });
                }
            }

            if (vl_total < 0)
            { var str = "<div style='text-align:right;font-weight: bold;color:red'>"; }
            else
            { var str = "<div style='text-align:right;font-weight: bold'>"; }

            //            rows.push({ cell: ["", "<div style='text-align:left;font-weight: bold'>TOTAL</div>", str.concat(accounting.formatMoney(vl_total, { symbol: "", precision: 2, decimal: ",", thousand: ".", format: { pos: "%s %v", neg: "%s (%v)", zero: "  --"} }), "</div>"), ''] });

            return { total: Reserva.length, page: 1, rows: rows }
        }

        function formatResultsPrograma(Reserva) {
            var rows = Array();
            var vl_total = 0;
            var qtd_total = 14;

            if (Reserva.length < 14) { qtd_total = Reserva.length };

            for (i = 0; i < qtd_total; i++) {
                var item = Reserva[i];
                if (item.vl_valor < 0)
                { var str = "<div  style='text-align:right;color:red'>"; }
                else
                { var str = "<div  style='text-align:right'>"; }

                rows.push({ cell: [item.Ds_Progr, str.concat(accounting.formatMoney(item.vl_reserva, { symbol: "", precision: 2, decimal: ",", thousand: ".", format: { pos: "%s %v", neg: "%s (%v)", zero: "  --" } }), "</div>"), str.concat(accounting.formatMoney(item.vl_pagtos, { symbol: "", precision: 2, decimal: ",", thousand: ".", format: { pos: "%s %v", neg: "%s (%v)", zero: "  --" } }), "</div>"), ''] });
                vl_total = vl_total + item.vl_valor;

                //calcula total somente para Avisos e Ajustes
                if (item.ds_descricao == "(+/-) RECUP. (COS+RES)") {
                    str = "<div  style='text-align:right'>";
                    rows.push({ cell: ["<div style='text-align:left;font-weight: bold;padding-left: 0px;'>SINISTROS LÍQUIDOS</div>", str.concat(accounting.formatMoney(vl_total, { symbol: "", precision: 2, decimal: ",", thousand: ".", format: { pos: "%s %v", neg: "%s (%v)", zero: "  --" } }), "</div>"), ''] });
                }
            }

            if (vl_total < 0)
            { var str = "<div style='text-align:right;font-weight: bold;color:red'>"; }
            else
            { var str = "<div style='text-align:right;font-weight: bold'>"; }

            //            rows.push({ cell: ["", "<div style='text-align:left;font-weight: bold'>TOTAL</div>", str.concat(accounting.formatMoney(vl_total, { symbol: "", precision: 2, decimal: ",", thousand: ".", format: { pos: "%s %v", neg: "%s (%v)", zero: "  --"} }), "</div>"), ''] });

            return { total: Reserva.length, page: 1, rows: rows }
        }


    </script>

</head>
<body class="metro">

    <div id="container">
        <div id="container_body">

            <div id="title">
                <h3>Evolucao da Reserva

                </h3>
            </div>

            <!--div class="frame"-->
            <!--h3>Movimentacao da Reserva</h3-->

            <div class="MonthPicker" id="mes" title="Mês de Referência">Mês de Referência</div>

            <table>
                <tr>
                    <td>
                        <div id="mesAtual" class="frameResultado" runat="server">
                            <table id="flexMesAtual"></table>
                        </div>
                    </td>
                    <td rowspan="2">
                        <div id="mesPorPrograma" class="frameResultado" runat="server">
                            <table id="flexPorPrograma"></table>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="sinistrosGrid" class="frameResultado" runat="server">
                            <table id="flexStatus"></table>
                        </div>
                    </td>
                    <td></td>
                </tr>
            </table>

            <!--/div-->

            <div class="clear"></div>

            <!--div id="sinistrosGrid" class="frameResultado"></div-->

        </div>
    </div>


    <script type="text/javascript">
        $(function () {
            $("#mes").monthpicker("2014-11", callback);
        });

        function callback(data, $e) {
            var str = "";
            str = data.month;
            if (data.month < 10) { str = "0" + data.month } else { str = str.toString() }
            str += data.year;

            $.ajax({
                type: "get",
                contentType: "application/json",
                url: "reserva/" + str,
                data: "{}",
                dataType: 'json',
                success: function (result) {
                    //add data
                    $("#flexMesAtual").flexAddData(formatResults(result));
                }
            });

        }

    </script>

</body>
</html>
