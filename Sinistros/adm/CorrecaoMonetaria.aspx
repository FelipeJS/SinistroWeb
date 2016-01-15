<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CorrecaoMonetaria.aspx.cs" Inherits="Sinistros.adm.CorrecaoMonetaria" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <style type="text/css">
        .style1 {
            width: 142px;
        }

        .style2 {
            width: 430px;
        }

        .style3 {
            width: 115px;
        }

        .style4 {
            width: 143px;
        }

        .style5 {
            width: 70px;
        }

        .style6 {
            width: 144px;
        }

        .style7 {
            width: 138px;
        }

        #Text7 {
            width: 176px;
        }

        #Text9 {
            width: 180px;
        }
    </style>

    <link type="text/css" href="/Content/css/menu.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/grid.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery-ui-1.8.22.custom.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/wizard.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/wizard.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/fileupload.main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery.fileupload-ui.css" rel="stylesheet" />
    <link href="/Content/Site.css" rel="stylesheet" type="text/css" />

    <link href="css/style.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" language="javascript" src="Scripts/kissy-min.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>

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
        var model = { "coberturas": [] };
        $(document).ready(function () {

            $('#wizard').s;

            datepickerBR('#TextBoxData');

            $('#btnIniciar').button({
                icons: {
                    primary: "ui-icon-search"
                },
                text: true
            })
            .click(function () {
                if (!confirm("Confirma a aplicação do índice de correção monetária para todos os sinistros com reserva?")) return;
                $.ajax({
                    type: "post",
                    url: "../sinistro?beneficiarios=" + 1,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Lançamentos realizados com sucesso.');
                    }
                });
            });

            $('#TextBoxPecentual').maskMoney({ precision: 2 });

            $('#wizard').smartWizard({
                //                selected: model.Passo > 0 ? model.Passo - 1 : model.Passo,
                selected: document.getElementById('Model').value,
                transitionEffect: 'none',
                enableAllSteps: true,
                labelNext: 'Próximo',
                labelPrevious: 'Anterior',
                labelFinish: 'Finalizar',
                labelback: 'Voltar',
                showReturnButton: true,
                returnPage: '/',
                enableFinishButton: false,
                onLeaveStep: leaveAStepCallback,
                onShowStep: showStepCallback
            });

            $(window).load(function () {
                $('#wizard').show();
                $('.stepContainer').height($('#step-1').outerHeight());

                if (model.Passo > 0) {
                    $('.stepContainer').height($($('#step' + model.Passo).attr("href")).outerHeight());
                }

                //ENABLE/DISABLE
                //                if (model.Apolice.NrApolice != null) {
                //                    TravarCampos();
                //                }

            });

            $("#flex1").flexigrid({
                //                url: 'sinistro',
                //                method: 'GET',
                dataType: 'json',
                colModel: [
                        { display: 'ID', name: 'ID_DOCUMENTO', width: 41, sortable: true, align: 'left' },
                        { display: 'Nome do Documento', name: 'DS_DOCUMENTO', width: 300, sortable: true, align: 'left' },
                        { display: 'Tipo', name: 'DS_TIPO', width: 50, sortable: true, align: 'left' },
                        { display: 'Visualizar', name: 'DS_LINK', width: 100, sortable: true, align: 'left' },
                        { display: '', name: 'botao', width: 03, sortable: false, align: 'center', textButton: 'Abrir', ColumnButton: 'Abrir', FunctionButton: 'ExcluirApolice', Icon: 'ui-icon-gear' }
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
                width: 820,
                height: 480,
                singleSelect: true,
                cursorIcon: '1',
                newp: 1
            });

        });


        function showStepCallback(obj) {
            var stepNum = obj.attr('rel');
            switch (stepNum) {

                //Finalizar 
                case "2":
                    //consistirApolice();

                    return true;

                default:
                    return true;
            }
        }

        function Pesquisar() {
            document.getElementById('frmImagem').contentWindow.location.reload();
            overlay.style.display = 'block';
            docUpload.style.display = 'block';
        }

        function abrirImagem(id) {
            document.getElementById("imgDoc").src = "docExp.ashx?IdArquivo=" + id;
            overlay.style.display = 'block';
            docView.style.display = 'block';

        }

        function CarregarGridArquivos() {

            $.ajax({
                type: "get",
                contentType: "application/json",
                url: "sinistro?arquivos=" + document.getElementById('FormView1_TextBox1').value,
                data: "{}",
                dataType: 'json',
                success: function (result) {
                    //add data
                    $("#flex1").flexAddData(formatResults(result));

                }
            });
        }

        function formatResults(arquivos) {
            var rows = Array();

            var str = "<div  style='text-align:right'>";

            for (i = 0; i < arquivos.length; i++) {
                var item = arquivos[i];
                rows.push({ cell: [i + 1, item.DS_DESCRICAO, item.DS_TIPO, '<a href=# onclick="abrirImagem(' + item.ID_ARQUIVO + ');">Abrir</a>', ''] });
            }
            return { total: arquivos.length, page: 1, rows: rows }
        }

        function leaveAStepCallback(obj) {
            var stepNum = obj.attr('rel');
            switch (stepNum) {

                //Endosso Zero    
                case "2":
                    //                   if (isCompleteEndossoStep(model)) {
                    //                       persistEndosso(model);
                    return true;
                    //                   } else {
                    //                       return false;
                    //                   }

                default:
                    return true;
            }


        }

        function ExibirCampos(model) {
            if (model.NrProposta != null) {
                $('#step2').show();
                $('.buttonPrevious').show();
                $('.buttonNext').show();
                $('.buttonFinish').show();
                IncializarFormularios(model);
            }
            else {
                $('#step2').hide();
                $('.buttonPrevious').hide();
                $('.buttonNext').hide();
                $('.buttonFinish').hide();
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">

        <asp:HiddenField runat="server" ID="txtUsuario" />
        <asp:HiddenField runat="server" ID="txtPerfil" />
        <asp:HiddenField runat="server" ID="txtIdSinistro" />

        <div id="container">

            <div id="container_body">

                <div id="title">
                    <h3>Correção Monetária</h3>
                </div>

                <div id="wizard" class="swMain">
                    <input type="hidden" id="Model" runat="server" />
                    <ul class="anchor">
                        <li><a href="#step-1" id="step1">
                            <label class="stepNumber">1</label>
                            <span class="stepDesc">Aplicar<br />
                                <small>Correção Monetaria</small>
                            </span>
                        </a>
                        </li>

                        <li><a href="#step-2" id="step2">
                            <label class="stepNumber">2</label>
                            <span class="stepDesc">Confirmação<br />
                                <small></small>
                            </span>
                        </a>
                        </li>
                    </ul>

                    <div id="step-1">

                        <div id="divSinistro">

                            <table style="width: 100%;">
                                <tr>
                                    <td class="style5">Índice de Correção</td>
                                    <td class="style5">Data</td>
                                </tr>
                                <tr>
                                    <td class="style5">
                                        <asp:TextBox ID="TextBoxPecentual" runat="server" ></asp:TextBox>
                                    </td>
                                    <td class="style5">
                                        <asp:TextBox ID="TextBoxData" runat="server" Width="80"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Button ID="btnIniciar" runat="server" OnClick="Button1_Click"
                                            Text="Aplicar" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="style4">&nbsp;</td>
                                    <td class="style5">&nbsp;</td>
                                    <td class="style6">&nbsp;</td>
                                    <td class="style7">&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                            </table>

                        </div>

                    </div>

                    <div id="step-2">

                        <div id="confirmacao">

                            <asp:Panel ID="Panel2" runat="server" Visible="true">

                                <asp:Label ID="lblMsg" runat="server">Índice de Correção Monetária aplicado com sucesso.</asp:Label>
                                <br />
                                <asp:Label ID="lblErro" runat="server" ForeColor="Red">Imprima o RO de Correção Monetária para verificar os lançamentos.</asp:Label>>
        <br />
                                <asp:Label ID="lblMsgErro" runat="server" ForeColor="Red"></asp:Label>>

                                <asp:Label ID="lblSinistro" runat="server"></asp:Label>
                                <br />
                            </asp:Panel>

                        </div>

                    </div>

                </div>

            </div>
        </div>

        <div id="overlay" class="ui-widget-overlay" style="width: 1583px; height: 100%; z-index: 1001; display: none;"></div>

    </form>

</body>
</html>
