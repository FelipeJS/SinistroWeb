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
                                    '}" />', name: 'checkBox', width: 40, sortable: false, align: 'left', process: abrirSinistro },
                        { display: 'ID OP', name: 'ID_OP', width: 40, sortable: true, align: 'left', process: abrirSinistro },
                        { display: 'ID Sinistro', name: 'ID_SINISTRO', width: 50, sortable: true, align: 'left', process: abrirSinistro },
                        { display: 'Favorecido', name: 'NM_FAVORECIDO', width: 350, sortable: true, align: 'left', process: abrirSinistro },
                        { display: 'Valor', name: 'VL_PAGAMENTO', width: 70, sortable: true, align: 'left', process: abrirSinistro },
                        { display: 'Data', name: 'DT_PAGAMENTO', width: 70, sortable: true, align: 'left', process: abrirSinistro },
                        { display: 'Tipo Pagto', name: 'DS_TIPO_PAGTO', width: 70, sortable: true, align: 'left', process: abrirSinistro },
                        { display: 'Forma Pagto', name: 'DS_FORMA_PAGAMENTO', width: 70, sortable: true, align: 'right', process: abrirSinistro },
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
                height: 581,
                singleSelect: true,
                cursorIcon: '1'
            });


            $('#checkAllNotes').click(function (e) {
                alert("teste");
            });


            $('#btnGerarArq').button({
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
                    url: "sinistro?ops=" + ids, //selecionados,
                    data: "{}",
                    dataType: 'json',
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Arquivo de OPs gerado com sucesso.');
                        window.location = 'pagnet.aspx?arquivo=1';
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
                url: "sinistro?op=1",
                data: "{}",
                dataType: 'json',
                success: function (result) {
                    //add data
                    $("#flex1").flexAddData(formatResults(result));

                }
            });
            $("#checkboxes input").attr('checked', 'checked');
        }

        function formatResults(op) {
            var rows = Array();

            var str = "<div  style='text-align:right'>";

            for (i = 0; i < op.length; i++) {
                var item = op[i];
                item.VL_PAGAMENTO = str + accounting.formatMoney(item.VL_PAGAMENTO, "R$ ", 2, ".", ",") + "</div>";
                rows.push({ cell: ['<input type="checkbox" onclick="{if( $(this).is(\':checked\') ) {selecionados = selecionados.replace(\'#\', ' + item.ID_OP.toString() + ');} else {selecionados = selecionados.replace(' + item.ID_OP.toString() + ', \'#\');} }" class="noteCheckBox" value="' + item.ID_OP + '" />', item.ID_OP, item.ID_SINISTRO, item.NM_FAVORECIDO, item.VL_PAGAMENTO, item.DT_PAGAMENTO, item.DS_TIPO_PAGTO, item.DS_FORMA_PAGAMENTO, ''] });
                selectionadosTodos = selectionadosTodos + item.ID_OP.toString() + "$";
            }
            return { total: op.length, page: 1, rows: rows }
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
</head>
<body>
    <div id="container">

        <div id="container_body">


         <div id="title">
            <h3>
                
    Gerar Arquivo para o PagNet

            </h3>
         </div>

<div id="opGrid" class="frameResultado" runat="server" style="display: none"><table id="flex1"> </table>
</div>
            
            <!--Filtro Felipe Campos-->
            <form id="form1" runat="server">
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
                <button type="button" id="btnGerarArq" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false">Gerar Arquivo</button>
            </div>
            </form>
        </div>

    </div>


</body>

</html>
