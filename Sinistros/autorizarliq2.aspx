<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="autorizarliq2.aspx.cs" Inherits="Sinistros.autorizarliq" %>

<!DOCTYPE html>

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
                        { display: '<input type="checkbox" class="noteCheckBox" id="checkAllNotes" ' +
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
                                    '}" />', name: 'checkBox', width: 20, sortable: false, align: 'center', process: abrirSinistro },
                        { display: 'ID Liquidação', name: 'ID_LIQUIDACAO', width: 60, sortable: true, align: 'left', process: abrirSinistro },
                        { display: 'ID Sinistro', name: 'ID_SINISTRO', width: 50, sortable: true, align: 'left', process: abrirSinistro },
                        { display: 'Beneficiários', name: 'DS_BENEFICIARIO', width: 450, sortable: true, align: 'left', process: abrirSinistro },
                        { display: 'Total a Pagar', name: 'VL_TOTAL', width: 70, sortable: true, align: 'right', process: abrirSinistro },
                        { display: 'Data Emissão', name: 'DS_DT_EMISSAO', width: 70, sortable: true, align: 'left', process: abrirSinistro },
                        { display: 'Tipo', name: 'DS_TPSINISTRO', width: 100, sortable: true, align: 'left', process: abrirSinistro },
                        { display: '', name: 'botao', width: 03, sortable: false, align: 'center', textButton: 'Abrir', ColumnButton: 'Abrir', FunctionButton: 'ExcluirApolice', Icon: 'ui-icon-gear', process: abrirSinistro }
                ],
                onError: function (jqXHR, textStatus, errorThrown) {
                    alert("flexigrid failed " + errorThrown + jqXHR + textStatus);
                },
                usepager: true,
                title: "",
                useRp: true,
                rp: 10,
                showTableToggleBtn: false,
                resizable: false,
                width: 1030,
                height: 331,
                singleSelect: true,
                cursorIcon: '1',
                newp: 1
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
                $.ajax({
                    type: "post",
                    contentType: "application/json",
                    url: "sinistro?autorizar=" + document.getElementById('txtUsuario').value + "$A$" + selecionados,
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
                $.ajax({
                    type: "post",
                    contentType: "application/json",
                    url: "sinistro?autorizar=" + document.getElementById('txtUsuario').value + "$R$" + selecionados,
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

        });

        function abrirSinistro() {
        }

        function Pesquisar() {
            opGrid.style.display = 'block';
            $.ajax({
                type: "get",
                contentType: "application/json",
                url: "sinistro?liquidacoes=" + document.getElementById('txtUsuario').value,
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

            for (i = 0; i < liq.length; i++) {
                var item = liq[i];
                rows.push({ cell: ['<input type="checkbox" onclick="{if( $(this).is(\':checked\') ) {selecionados = selecionados.replace(\'#\', ' + item.ID_LIQUIDACAO.toString() + ');} else {selecionados = selecionados.replace(' + item.ID_LIQUIDACAO.toString() + ', \'#\');} }" class="noteCheckBox" value="' + item.ID_LIQUIDACAO + '" />', item.ID_LIQUIDACAO, item.ID_SINISTRO, item.DS_BENEFICIARIO, item.VL_TOTAL, item.DS_DT_EMISSAO, item.DS_TPSINISTRO, ''] });
                selectionadosTodos = selectionadosTodos + item.ID_LIQUIDACAO.toString() + "$";
            }
            return { total: liq.length, page: 1, rows: rows }
        }
        
    </script>

</head>
<body>
    <div id="container">

    <form id="form1" runat="server">
       <asp:HiddenField runat="server" ID="txtPerfil" />
       <asp:HiddenField runat="server" ID="txtUsuario" />
    </form>

        <div id="container_body">


         <div id="title">
            <h3>
                
    Liquidações Pendentes de Autorização

            </h3>
         </div>

<div id="opGrid" class="frameResultado" runat="server" style="display: none"><table id="flex1"> </table>
</div>

            <div class="button-bar-inline-right">
                <button type="button" id="btnAprovar" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false">Aprovar Selecionados</button>
                <button type="button" id="btnRejeitar" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false">Rejeitar Selecionados</button>
            </div>

        </div>

    </div>


</body>

</html>
