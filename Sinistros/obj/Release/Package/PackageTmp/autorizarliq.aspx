<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="autorizarliq.aspx.cs" Inherits="Sinistros.autorizarliq1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />

    <link type="text/css" href="/Content/css/menu.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/grid.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery-ui-1.8.22.custom.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/wizard.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/fileupload.main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery.fileupload-ui.css" rel="stylesheet" />


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
    <script src="js/accounting.min.js" type="text/javascript"></script>

    <script src="/Scripts/FileUpload/tmpl.min.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/canvas-to-blob.min.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/load-image.min.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/jquery.iframe-transport.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/jquery.fileupload.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/jquery.fileupload-ip.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/jquery.fileupload-ui.js" type="text/javascript" charset="ISO88591"></script>
    <script src="/Scripts/FileUpload/main.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/locale.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ajaxStart(function () {
            $.blockUI({ overlayCSS: { opacity: .2 }, message: '<img src="/Content/images/main/loading.gif") />' });
        }).ajaxStop($.unblockUI);

    </script>

    <script type="text/javascript">

        var nId = "0";
        var selecionados = "#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$";
        var selectionadosTodos = ""
        var selecionadosLimpa = "#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$";

        $(document).ready(function () {

            $("#flex1").flexigrid({
                //                url: 'sinistro',
                //                method: 'GET',
                dataType: 'json',
                colModel: [
                        {
                            display: '<input type="checkbox" class="noteCheckBox" id="checkAllNotes" ' +
                                              ' onclick="{ if($(this).attr(\'checked\') == \'checked\') { ' +
                                              '               $(\'input:checkbox\').attr(\'checked\',\'checked\'); ' +
                                              '               $(this).val(\'off\'); ' +
                                              '               selecionados = selectionadosTodos; ' +
                                              '            } else { ' +
                                              '               $(\'input:checkbox\').attr(\'checked\', false); ' +
                                              '               selecionados = selecionadosLimpa; ' +
                                              '               $(this).val(\'on\'); Update ' +
                                              '            }' +
                            //                        $(\'input:checkbox\').attr(\'checked\',\'checked\'); alert(selecionados); }"  
                                      '}" />', name: 'checkBox', width: 40, sortable: false, align: 'left', process: abrirSinistro
                        },
                        { display: 'ID Sinistro', name: 'ID_SINISTRO', width: 80, sortable: true, align: 'left', process: abrirSinistro },
                        { display: 'ID Liquidação', name: 'ID_LIQUIDACAO', width: 80, sortable: true, align: 'left', process: abrirSinistro },
                        { display: 'Beneficiários', name: 'DS_BENEFICIARIO', width: 350, sortable: true, align: 'left', process: abrirSinistro },
                        { display: 'Total a Pagar', name: 'VL_TOTAL', width: 150, align: 'right', process: abrirSinistro },
                        { display: 'Data Emissão', name: 'DS_DT_EMISSAO', width: 116, sortable: true, align: 'center', process: abrirSinistro },
                        { display: 'Tipo', name: 'DS_TPSINISTRO', width: 120, sortable: true, align: 'left', process: abrirSinistro },
                        { display: '', name: 'botao', width: 03, sortable: false, align: 'center', textButton: 'Abrir', ColumnButton: 'Abrir', FunctionButton: 'ExcluirApolice', Icon: 'ui-icon-gear', process: abrirSinistro }
                ],
                onError: function (jqXHR, textStatus, errorThrown) {
                    alert("flexigrid failed " + errorThrown + jqXHR + textStatus);
                },
                usepager: false,
                title: "",
                useRp: false,
                rp: 10,
                showTableToggleBtn: false,
                resizable: false,
                width: 1030,
                height: 481,
                singleSelect: true,
                cursorIcon: '1'
            });

            $('#checkAllNotes').click(function (e) {
                alert("teste");
            });

            $('#btnAprovar').button({
                icons: {
                    primary: "ui-icon-document"
                },
                text: true
            })
            .click(function () {

                var ids;
                $('.noteCheckBox').each(function () {
                    if ($(this).is(':checked')) {
                        ids += $(this).val() + "$";
                    }
                });

                //                                alert(selecionados);
                //                                alert(ids);

                $.ajax({
                    type: "post",
                    contentType: "application/json",
                    url: "sinistro?autorizar=" + document.getElementById('txtUsuario').value + "$A$" + ids,
                    data: "{}",
                    dataType: 'json',
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Liquidações autorizadas com sucesso.');
                        Pesquisar();
                    }
                });
            });

            $('#btnRejeitar').button({
                icons: {
                    primary: "ui-icon-document"
                },
                text: true
            })
            .click(function () {

                var ids;
                $('.noteCheckBox').each(function () {
                    if ($(this).is(':checked')) {
                        ids += $(this).val() + "$";
                    }
                });

                //                alert(selecionados);
                //                alert(ids);

                $.ajax({
                    type: "post",
                    contentType: "application/json",
                    url: "sinistro?autorizar=" + document.getElementById('txtUsuario').value + "$R$" + ids,
                    data: "{}",
                    dataType: 'json',
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Liquidações rejeitas com sucesso.');
                        Pesquisar();
                    }
                });
            });

            $('#btnLimpar').button({
                icons: {
                    primary: "ui-icon-cancel"
                },
                text: true
            }).click(function () {
                ExcluirApolice();
            });

            $('#btnNovaApolice').button({
                icons: {
                    primary: "ui-icon-document"
                },
                text: true
            })
            .click(function () {
                window.location = 'aviso.aspx';
            });

            Pesquisar();
            $("#flex1").flexAddData(formatResults([{ "ID_SINISTRO": 50123, "ID_LIQUIDACAO": 7802, "ID_PESSOA": 0, "ID_DOCTO": 0, "ID_CONTA": 0, "DS_BENEFICIARIO": "CORIS", "DS_TPSINISTRO": "ADMINISTRATIVO", "DS_DT_EMISSAO": "19/01/2015", "FL_PAGTO": null, "VL_TOTAL": 9000.12}]));

        });

        function abrirSinistro() {
        }

        function Pesquisar() {
            opGrid.style.display = 'block';
            $.ajax({
                type: "get",
                contentType: "application/json",
                url: "sinistro?liquidacoes=" + document.getElementById('txtUsuario').value + "$" + document.getElementById('cboPrograma').value,
                data: "{}",
                dataType: 'json',
                success: function (result) {
                    //add data
                    $("#flex1").flexAddData(formatResults(result));

                }
            });
            $("#checkboxes input").attr('checked', 'checked');
        }

        function formatResults(liq) {
            var rows = Array();

            var str = "<div  style='text-align:right;padding-top: 0px;padding-left: 0px;padding-right: 0px;padding-bottom: 0px;'>";

            for (i = 0; i < liq.length; i++) {
                var item = liq[i];

                item.VL_TOTAL = str + accounting.formatMoney(item.VL_TOTAL, "R$ ", 2, ".", ",") + "</div>";
                item.DS_DT_EMISSAO = str.replace(":right", ":center") + item.DS_DT_EMISSAO + "</div>";

                rows.push({
                    cell: ['<input type="checkbox" onclick="{if( $(this).is(\':checked\') ) {selecionados = selecionados.replace(\'#\', ' + item.ID_LIQUIDACAO.toString() + ');} else {selecionados = selecionados.replace(' + item.ID_LIQUIDACAO.toString() + ', \'#\').;} }" class="noteCheckBox" value="' + item.ID_LIQUIDACAO + '" />',
                        '<a href="' + 'Sinistro.aspx?idSinistro=' + item.ID_SINISTRO + '"' + ' target="_blank"> ' + item.ID_SINISTRO + ' ver</a>', item.ID_LIQUIDACAO, item.DS_BENEFICIARIO, item.VL_TOTAL, item.DS_DT_EMISSAO, item.DS_TPSINISTRO, '']
                });
                selectionadosTodos = selectionadosTodos + item.ID_LIQUIDACAO.toString() + "$";
            }
            return { total: liq.length, page: 1, rows: rows }
        }

        function formatValue(int) {
            var str = int + '';
            var res = str.replace(".", ",");
            return res;
        }

    </script>

    <script type="text/javascript">
        $(document).ready(function () {

            $('#btnFiltrar').button({
                icons: {
                    primary: "ui-icon-key"
                },
                text: true
            }).click(function () {
                Pesquisar();
            });
        });
    </script>
    <style type="text/css"> 
        #combo{margin-left:22px; height:2.15em;} 

        .flexigrid {
                font-family: Tahoma, Arial, Helvetica, sans-serif;
                font-size: 14px;
                position: relative;
                border: 0px solid #eee;
                overflow: hidden;
                color: #000;
        }
    </style>

</head>
<body>
    <div id="container">


        <div id="container_body">

        <form id="form1" runat="server">
            <asp:HiddenField runat="server" ID="txtPerfil" />
            <asp:HiddenField runat="server" ID="txtUsuario" />
    
            <div id="title">
                <h3>Liquidações Pendentes de Autorização</h3>
            </div>

            <div id="opGrid" class="frameResultado" runat="server" style="display: none">
                <table id="flex1"></table>
            </div>

            <div class="button-bar-inline-right">

                <label for="Itens_DsObjSeguradoEdit"> Filtrar por programa </label>

                <asp:SqlDataSource ID="dsPrograma" runat="server"
                    ConnectionString="<%$ ConnectionStrings:DB1 %>" 
                    ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>"     
                    SelectCommand = "select -1 cd_progr, ' ' ds_progr from dual
                                     union
                                     select t.cd_progr, to_char(t.cd_progr, '0000') || ' - ' || upper(t.ds_progr) ds_progr from TB_CAD_PROGR t order by ds_progr">
                </asp:SqlDataSource>

                <asp:DropDownList ID="cboPrograma" runat="server" 
                        DataSourceid="dsPrograma"
                        DataTextField="ds_progr" 
                        DataValueField="cd_progr">
                </asp:DropDownList>

                <button type="button" id="btnFiltrar">Filtrar</button>
                <button type="button" id="btnAprovar" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false">Aprovar Selecionados</button>
                <button type="button" id="btnRejeitar" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false">Rejeitar Selecionados</button>
            </div>

        </form>

        </div>

    </div>


</body>

</html>
