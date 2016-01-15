<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sinistro.aspx.cs" Inherits="Sinistros.Sinistro" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">


    <link type="text/css" href="/Content/css/menu.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/grid.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery-ui-1.8.22.custom.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/wizard.css" rel="stylesheet" />    
    <link type="text/css" href="/Content/css/wizard.css" rel="stylesheet" />    
    <link type="text/css" href="/Content/css/fileupload.main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery.fileupload-ui.css" rel="stylesheet" />
    <link href="/Content/kendo/2013.3.1119/kendo.common.min.css"
        rel="stylesheet" type="text/css" />
    <link href="/Content/kendo/2013.3.1119/kendo.default.min.css"
        rel="stylesheet" type="text/css" />
    <link href="/Content/Site.css" rel="stylesheet" type="text/css" />

    <!--[if IE 7]> 
        <style type='text/css'>
            #textTop h2 {
                            display: block;
                            margin: 23px auto;
                        }
        </style>    
   <![endif]-->


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

    <script src="Scripts/kendo/2013.3.1119/kendo.web.min.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ajaxStart(function () {
            $.blockUI({ overlayCSS: { opacity: .2 }, message: '<img src="/Content/images/main/loading.gif") />' });
        }).ajaxStop($.unblockUI);

    </script>

    <script type="text/javascript">

        function validarCNPJ(cnpj) {

            cnpj = cnpj.replace(/[^\d]+/g, '');

            if (cnpj == '') return false;

            if (cnpj.length != 14)
                return false;

            // Elimina CNPJs invalidos conhecidos
            if (cnpj == "00000000000000" ||
		cnpj == "11111111111111" ||
		cnpj == "22222222222222" ||
		cnpj == "33333333333333" ||
		cnpj == "44444444444444" ||
		cnpj == "55555555555555" ||
		cnpj == "66666666666666" ||
		cnpj == "77777777777777" ||
		cnpj == "88888888888888" ||
		cnpj == "99999999999999")
                return false;

            // Valida DVs
            tamanho = cnpj.length - 2
            numeros = cnpj.substring(0, tamanho);
            digitos = cnpj.substring(tamanho);
            soma = 0;
            pos = tamanho - 7;
            for (i = tamanho; i >= 1; i--) {
                soma += numeros.charAt(tamanho - i) * pos--;
                if (pos < 2)
                    pos = 9;
            }
            resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
            if (resultado != digitos.charAt(0))
                return false;

            tamanho = tamanho + 1;
            numeros = cnpj.substring(0, tamanho);
            soma = 0;
            pos = tamanho - 7;
            for (i = tamanho; i >= 1; i--) {
                soma += numeros.charAt(tamanho - i) * pos--;
                if (pos < 2)
                    pos = 9;
            }
            resultado = soma % 11 < 2 ? 0 : 11 - soma % 11;
            if (resultado != digitos.charAt(1))
                return false;

            return true;

        }

        function validarCPF(cpf) {
            cpf = cpf.replace(/[^\d]+/g, '');
            if (cpf == '') return false;
            // Elimina CPFs invalidos conhecidos    
            if (cpf.length != 11 || cpf == "00000000000" || cpf == "11111111111" || cpf == "22222222222" || cpf == "33333333333" || cpf == "44444444444" || cpf == "55555555555" || cpf == "66666666666" || cpf == "77777777777" || cpf == "88888888888" || cpf == "99999999999") return false;

            // Valida 1o digito 
            add = 0;
            for (i = 0; i < 9; i++)
                add += parseInt(cpf.charAt(i)) * (10 - i);
            rev = 11 - (add % 11);
            if (rev == 10 || rev == 11) rev = 0;
            if (rev != parseInt(cpf.charAt(9))) return false;
            // Valida 2o digito 
            add = 0;
            for (i = 0; i < 10; i++) add += parseInt(cpf.charAt(i)) * (11 - i);
            rev = 11 - (add % 11);
            if (rev == 10 || rev == 11) rev = 0;
            if (rev != parseInt(cpf.charAt(10))) return false;
            return true;
        }

        var model = { "coberturas": [] };
        $(document).ready(function () {

            if (document.getElementById('txtPerfil').value == '-1') {
                document.getElementById('barraBotoes').style.display = 'none';
                document.getElementById('barraComentario').style.display = 'none';
                document.getElementById('barraJudicial').style.display = 'none';
            }

            document.getElementById('txtValorAjusteHon').disabled = false;
            document.getElementById('txtValorAjusteDes').disabled = false;
            document.getElementById('txtValorAjusteRes').disabled = false;
            document.getElementById('txtValorAjusteSal').disabled = false;

            $('#btnScan').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            $('#btnCarregar').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            $('btFechar').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })

            $("#imagensGrid").flexigrid({
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
                height: 300,
                singleSelect: true,
                cursorIcon: '1',
                newp: 1
            });

            CarregarGridArquivos();

            $('#btnTransformarJudicial').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                overlay.style.display = 'block';
                abrirJudicial.style.display = 'block';
            });

            $('#txtVlPagto').maskMoney({ precision: 2 });
            $('#txtValorAjuste').maskMoney({ precision: 2, allowNegative: true });
            $('#txtValorAjusteHon').maskMoney({ precision: 2, allowNegative: true });
            $('#txtValorAjusteDes').maskMoney({ precision: 2, allowNegative: true });
            $('#txtValorAjusteRes').maskMoney({ precision: 2, allowNegative: true });
            $('#txtValorAjusteSal').maskMoney({ precision: 2, allowNegative: true });

            $('#txtReserva').maskMoney({ precision: 2, allowNegative: true });
            $('#txtReservaHon').maskMoney({ precision: 2, allowNegative: true });
            $('#txtReservaDesp').maskMoney({ precision: 2, allowNegative: true });

            $('#txtReservaDisponivel').maskMoney({ precision: 2, allowNegative: true });
            $('#txtReservaDisponivelHon').maskMoney({ precision: 2, allowNegative: true });
            $('#txtReservaDisponivelDes').maskMoney({ precision: 2, allowNegative: true });
            $('#txtReservaDisponivelRes').maskMoney({ precision: 2, allowNegative: true });
            $('#txtReservaDisponivelSal').maskMoney({ precision: 2, allowNegative: true });
            $('#txtParticipacao').maskMoney({ precision: 2 });
            $('#txtValorLiquidacao').maskMoney({ precision: 2 });
            $('#txtIndenizacaoJudicial').maskMoney({ precision: 2 });
            $('#txtHonorarios').maskMoney({ precision: 2 });
            $('#txtDespesas').maskMoney({ precision: 2 });
            $('#txtRemoto').maskMoney({ precision: 2 });
            $('#txtPossivel').maskMoney({ precision: 2 });
            $('#txtProvavel').maskMoney({ precision: 2 });
            datepickerBR('#txtDtPagto');

            $('.buttonFinish').click(function () {
                //finalizarApolice();
            });

            $('#wizard').smartWizard({
                selected: model.Passo > 0 ? model.Passo - 1 : model.Passo,
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
                onShowStep: showStepCallback,
                onFinish: finalizarApolice
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

            $('#btnComentario').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {

                $.ajax({
                    type: "post",
                    contentType: "application/json",
                    url: "sinistro?comentario=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + '$' +
                                              document.getElementById('cboComentarioEvento').value + '$' +
                                              document.getElementById('txtUsuario').value + '$' +
                                              document.getElementById('txtComentarioEvento').value.replace(/\$/g, '^').replace(/\@/g, '~'),
                    data: "{}",
                    dataType: 'json',
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Comentário gravado com sucesso.');
                        location.reload();
                    }
                });

            });

            $('#btnCancelarOP').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                overlay.style.display = 'none';
                novaOP.style.display = 'none';
            });

            $('#btnLimparPessoa').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                Pessoa.style.display = 'none';
            });

            $('#btnGravarPessoa').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                $.ajax({
                    type: "get",
                    url: "pessoa?nometipo=" + document.getElementById('txtNomePessoa').value + '$' + document.getElementById('cboTipoPessoa').value,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Registro gravado com sucesso.');
                        document.getElementById('txtIdPessoa').value = result;
                    }
                });
            });

            $('#btnFecharPessoas').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                Pessoa.style.display = 'none';
            });

            $('#btnCancelarBeneficiario').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                overlay.style.display = 'none';
                beneficiarios.style.display = 'none';
            });

            $('#btnGravarOP').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                GravarOP();
            });

            $('#btnCadastroPessoa').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                //                beneficiarios.style.display = 'none';
                Pessoa.style.display = 'block';

                $("#flexPessoas").flexigrid({
                    dataType: 'json',
                    colModel: [
                        { display: 'ID', name: 'ID_PESSOA', width: 41, sortable: true, align: 'left', process: abrirPessoa },
                        { display: 'Tipo Pessoa', name: 'TP_PESSOA', width: 60, sortable: true, align: 'left', process: abrirPessoa },
                        { display: 'Nome', name: 'DS_PESSOA', width: 300, sortable: true, align: 'left', process: abrirPessoa }
                ],
                    title: "",
                    useRp: false,
                    showTableToggleBtn: false,
                    resizable: false,
                    width: "100%",
                    height: "100%",
                    singleSelect: true,
                    cursorIcon: '1',
                    newp: 1
                });

                $("#flexDocumentos").flexigrid({
                    dataType: 'json',
                    colModel: [
                        { display: 'Tipo Docto', name: 'TP_DOCTO', width: 100, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Número', name: 'NR_DOCTO', width: 300, sortable: true, align: 'left', process: abrirBeneficiario }
                ],
                    title: "",
                    useRp: false,
                    showTableToggleBtn: false,
                    resizable: false,
                    width: "100%",
                    height: "100%",
                    singleSelect: true,
                    cursorIcon: '1',
                    newp: 1
                });

                $("#flexEnderecos").flexigrid({
                    dataType: 'json',
                    colModel: [
                        { display: 'Endereço', name: 'DS_ENDERECO', width: 250, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Complemento', name: 'DS_COMPL', width: 150, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Bairro', name: 'DS_BAIRRO', width: 150, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Cidade', name: 'DS_CIDADE', width: 150, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'UF', name: 'CD_UF', width: 20, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'CEP', name: 'DS_CEP', width: 50, sortable: true, align: 'left', process: abrirBeneficiario }
                ],
                    title: "",
                    useRp: false,
                    showTableToggleBtn: false,
                    resizable: false,
                    width: "100%",
                    height: "100%",
                    singleSelect: true,
                    cursorIcon: '1',
                    newp: 1
                });

                $("#flexContas").flexigrid({
                    dataType: 'json',
                    colModel: [
                        { display: 'Tipo', name: 'TP_CONTA', width: 100, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Número', name: 'NRO_CONTA', width: 60, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'DV', name: 'DV_CONTA', width: 20, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Banco', name: 'DS_BANCO', width: 100, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Agência', name: 'CD_AGENCIA', width: 60, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'DV', name: 'DV_AGENCIA', width: 20, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Principal', name: 'FL_CONTA_PRINCIPAL', width: 40, sortable: true, align: 'left', process: abrirBeneficiario }
                ],
                    title: "",
                    useRp: false,
                    showTableToggleBtn: false,
                    resizable: false,
                    width: "100%",
                    height: "100%",
                    singleSelect: true,
                    cursorIcon: '1',
                    newp: 1
                });

            });

            $('#btnLimparBeneficiarios').button({
                icons: {
                    primary: "ui-icon-search"
                },
                text: true
            })
            .click(function () {
                if (!confirm("Deseja limpar a lista de beneficiários?")) return;
                $.ajax({
                    type: "post",
                    url: "sinistro?beneficiarios=" + +document.getElementById('FormView1_lblIdSinistro').innerHTML,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Lista de beneficiários excluída com sucesso.');
                    }
                });

                $.ajax({
                    type: "get",
                    contentType: "application/json",
                    url: "sinistro?beneficiario=" + document.getElementById('FormView1_lblIdSinistro').innerHTML,
                    data: "{}",
                    dataType: 'json',
                    success: function (result) {
                        //add data
                        $("#flex1").flexAddData(formatResults(result));

                    }
                });

            });

            $('#btnEstipulante').button({
                icons: {
                    primary: "ui-icon-search"
                },
                text: true
            })
            .click(function () {
                chkEstipulanteClick();
            });

            $('#btnReabrirSinistro').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                ReabrirSinistro();
            });

            $('#btnFecharSinistro').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                FecharSinistro();
            });

            $('#btnAjusteManual').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                AjusteManual();
            });

            $('#btnNovaOP').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                NovaOP();
            });

            $('#btnCancelarAjuste').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                CancelarAjuste();
            });

            $('#btnSalvarAjuste').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                SalvarAjuste();
            });

            $('#btnGravarLiquidacao').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                document.getElementById('btnGravarLiq').disabled = false;
                GravarLiquidacao();
            });

            $('#btnGravarLiq').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                document.getElementById('btnGravarLiq').disabled = true;

                if ($('#chkBoleto').prop('checked')) {
                    var boleto = prompt("Por favor, use o leitor de código de barras para capturar o código do boleto para pagamento");
                    if (boleto != null) {
                        document.getElementById('txtCodigoBoleto').value = boleto;
                    }
                }

                SalvarLiquidacao();
            });

            $('#btnAdicionarBeneficiario').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                AdicionarBeneficiario();
            });

        });

        function AlterarCessao(id) {
            var r = prompt("Qual o novo percentual?");

            if (r == null) { return };
            if (isNaN(r)) {
                alert("Valor inválido!")
                return;
            }

            if (r < 0) {
                alert("Valor inválido!")
                return;
            }
            if (r > 100) {
                alert("Valor inválido!")
                return;
            }

            {
                $.ajax({
                    type: "post",
                    url: "sinistro?alterarCessao=" + id + '$' + r + '$' + document.getElementById('txtUsuario').value,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert("Novo percentual alterado com sucesso.");
                        location.reload();
                    }
                });
            }
        }

        function abrirPessoa(celDiv, id) {
            if (celDiv.outerHTML.toLowerCase().indexOf('width: 41px') > 0) {
                nId = celDiv.innerHTML;
            }
            celDiv.dataFld = nId;
            $(celDiv).dblclick(function () {

                document.getElementById('txtIdPessoa').value = this.dataFld;

                $.ajax({
                    type: "get",
                    url: "pessoa/" + this.dataFld,
                    success: function (result) {
                        $("#flexPessoas").flexAddData([]);
                        document.getElementById('txtNomePessoa').value = result[0].DS_PESSOA;
                    }
                });

                $.ajax({
                    type: "get",
                    url: "pessoa?doctos=" + this.dataFld,
                    success: function (result) {

                        var rows = Array();

                        for (i = 0; i < result.length; i++) {
                            var item = result[i];
                            rows.push({ cell: [item.TP_DOCTO, item.NR_DOCTO, ''] });
                        }
                        pessoas = { total: result.length, page: 1, rows: rows }

                        $("#flexDocumentos").flexAddData(pessoas);

                    }
                });

                $.ajax({
                    type: "get",
                    url: "pessoa?enderecos=" + this.dataFld,
                    success: function (result) {
                        var rows = Array();

                        for (i = 0; i < result.length; i++) {
                            var item = result[i];
                            rows.push({ cell: [item.DS_ENDERECO, item.DS_COMPL, item.DS_BAIRRO, item.DS_CIDADE, item.CD_UF, item.DS_CEP, ''] });
                        }
                        pessoas = { total: result.length, page: 1, rows: rows }

                        $("#flexEnderecos").flexAddData(pessoas);

                    }
                });

                $.ajax({
                    type: "get",
                    url: "pessoa?contas=" + this.dataFld,
                    success: function (result) {
                        var rows = Array();

                        for (i = 0; i < result.length; i++) {
                            var item = result[i];
                            rows.push({ cell: [item.TP_CONTA, item.NRO_CONTA, item.DV_CONTA, item.DS_BANCO, item.CD_AGENCIA, item.DV_AGENCIA, item.FL_CONTA_PRINCIPAL, ''] });
                        }
                        pessoas = { total: result.length, page: 1, rows: rows }

                        $("#flexContas").flexAddData(pessoas);

                    }
                });



            });
        }

        function chkEstipulanteClick() {
            $.ajax({
                type: "get",
                url: "sinistro?idSinistroEstipulante=" + document.getElementById('FormView1_lblIdSinistro').innerHTML,
                success: function (result) {


                    var pessoa = result[0];
                    document.getElementById('txtNome').value = pessoa.DS_PESSOA;
                    document.getElementById('txtCPF').value = pessoa.NR_DOCTO;
                    document.getElementById('txtIdPessoa').value = pessoa.ID_PESSOA;
                    document.getElementById('txtIdDocto').value = pessoa.ID_DOCTO;
                    document.getElementById('txtCPF').value = pessoa.NR_DOCTO;
                    document.getElementById('cboParentesco').value = 99;
                    document.getElementById('txtParticipacao').value = 100;


                    for (i = 0; i < result.length; i++) {
                        var conta = result[i];
                        var dropdown = document.getElementById("cboConta");
                        dropdown[dropdown.length] = new Option(conta.DS_BANCO + " - Agencia: " + conta.CD_AGENCIA + " Conta: " + conta.NRO_CONTA, conta.ID_CONTA);
                    }

                }
            });
        }

        function GravarOP() {
            $.ajax({
                type: "post",
                url: "sinistro?op=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + '$' +
                                      document.getElementById('txtDtPagto2').value + '$' +
                                      document.getElementById('txtUsuario').value,
                error: function (xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert(err.ExceptionMessage);
                },
                success: function (result) {
                    alert('OP gravada com sucesso.');
                    location.reload();
                }
            });
        }

        function NovaOP() {

            switch (document.getElementById('FormView1_lblStatus').innerText) {
                case "APROVAÇAO PAGAMENTO PENDENTE": { alert("Sinistro tem aprovaçao de pagamento pendente. Você não pode cadastrar a OP antes da aprovação."); return; };
            }

            overlay.style.display = 'block';
            novaOP.style.display = 'block';

            $.ajax({
                type: "get",
                url: "sinistro?liquidacao=" + document.getElementById('FormView1_lblIdSinistro').innerHTML,
                success: function (result) {
                    var rows = Array();

                    if (result.length == 0) {
                        alert("Não existe liquidação pendente de pagamento. Use o botão 'Liquidação' para gerar uma liquidação. ");
                        overlay.style.display = 'none';
                        novaOP.style.display = 'none';
                        return;
                    }

                    var item = result[0];
                    document.getElementById('txtIdLiquidacao').value = item.ID_LIQUIDACAO;
                    document.getElementById('txtVlPagto').value = item.VL_TOTAL;
                    if (item.FL_PAGTO == "T")
                    { document.getElementById('txtFlPagto').value = "PAGTO TOTAL"; }
                    else
                    { document.getElementById('txtFlPagto').value = "PAGTO PARCIAL"; }
                    document.getElementById('txtDsBeneficiario').value = item.DS_BENEFICIARIO;
                }
            });

        }

        function FecharSinistro() {
            var x;
            var r = confirm("Deseja fechar o sinistro?");
            if (r == true) {
                $.ajax({
                    type: "post",
                    url: "sinistro?fechar=" + document.getElementById('FormView1_lblIdSinistro').innerHTML,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Sinistro fechado com sucesso.');
                        location.reload();
                    }
                });
            }
        }

        function ReabrirSinistro() {
            var x;
            var r = confirm("Deseja reabrir o sinistro?");
            if (r == true) {
                $.ajax({
                    type: "post",
                    url: "sinistro?reabrir=" + document.getElementById('FormView1_lblIdSinistro').innerHTML,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Sinistro reaberto com sucesso.');
                        location.reload();
                    }
                });
            }
        }

        function CancelarAjuste() {
            overlay.style.display = 'none';
            ajusteManual.style.display = 'none';
        }

        function SalvarAjuste() {
            $.ajax({
                type: "post",
                url: "sinistro?ajuste=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + '$' +
                                              document.getElementById('txtValorAjuste').value.replace(",", ".") + '$' +
                                              document.getElementById('txtValorAjusteHon').value.replace(",", ".") + '$' +
                                              document.getElementById('txtValorAjusteDes').value.replace(",", ".") + '$' +
                                              document.getElementById('txtValorAjusteRes').value.replace(",", ".") + '$' +
                                              document.getElementById('txtValorAjusteSal').value.replace(",", "."),
                error: function (xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert(err.ExceptionMessage);
                },
                success: function (result) {
                    alert('Ajuste gravado com sucesso.');
                    location.reload();
                }
            });
        }

        function AjusteManual() {
            overlay.style.display = 'block';
            ajusteManual.style.display = 'block';

            $.ajax({
                type: "get",
                url: "sinistro?reserva=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + "$1",
                success: function (result) {
                    document.getElementById('txtReservaDisponivel').value = accounting.formatMoney(result.replace(",", "."), "R$ ", 2, ".", ",");
                }
            });

            $.ajax({
                type: "get",
                url: "sinistro?reserva=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + "$2",
                success: function (result) {
                    document.getElementById('txtReservaDisponivelHon').value = accounting.formatMoney(result.replace(",", "."), "R$ ", 2, ".", ",");
                }
            });

            $.ajax({
                type: "get",
                url: "sinistro?reserva=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + "$3",
                success: function (result) {
                    document.getElementById('txtReservaDisponivelDes').value = accounting.formatMoney(result.replace(",", "."), "R$ ", 2, ".", ",");
                }
            });

            $.ajax({
                type: "get",
                url: "sinistro?reserva=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + "$5",
                success: function (result) {
                    document.getElementById('txtReservaDisponivelRes').value = accounting.formatMoney(result.replace(",", "."), "R$ ", 2, ".", ",");
                }
            });

            $.ajax({
                type: "get",
                url: "sinistro?reserva=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + "$6",
                success: function (result) {
                    document.getElementById('txtReservaDisponivelSal').value = accounting.formatMoney(result.replace(",", "."), "R$ ", 2, ".", ",");
                }
            });

        }

        function SalvarLiquidacao() {

            var geraBoleto;
            var retencaoImpostos;
            var bordero;
            var governo;


            if ($('#chkBoleto').prop('checked')) geraBoleto = "1"
            else geraBoleto = "0";

            if ($('#chkRetencaoImpostos').prop('checked')) retencaoImpostos = "1"
            else retencaoImpostos = "0";

            if ($('#chkBordero').prop('checked')) bordero = "1"
            else bordero = "0";

            if ($('#chkGoverno').prop('checked')) governo = "1"
            else governo = "0";

            var vlReserva;
            var tpValor;

            if (document.getElementById('cboTipoLiquidacao').value == 1) {
                vlReserva = document.getElementById('txtReserva').value.replace(",", ".");
                tpValor = 1;
            }
            if (document.getElementById('cboTipoLiquidacao').value == 2) {
                vlReserva = document.getElementById('txtReservaHon').value.replace(",", ".");
                tpValor = 2;
            }
            if (document.getElementById('cboTipoLiquidacao').value == 3) {
                vlReserva = document.getElementById('txtReservaDesp').value.replace(",", ".");
                tpValor = 3;
            }

            $.ajax({
                type: "post",
                contentType: "application/json",
                url: "sinistro?liquidacao=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + '$' +
                                              document.getElementById('txtValorLiquidacao').value.replace(",", ".") + '$' +
                                              vlReserva + '$' +
                                              tpValor + '$' +
                                              document.getElementById('txtDtPagto').value + '$' +
                                              document.getElementById('txtUsuario').value + '$' +
                                              retencaoImpostos + '$' +
                                              geraBoleto + '$' +
                                              document.getElementById('txtCodigoBoleto').value + '$' +
                                              bordero + '$' +
                                              governo + '$' +
                                              document.getElementById('txtComentario').value.replace(/\$/g, '^').replace(/\@/g, '~'),
                data: "{}",
                dataType: 'json',
                error: function (xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert(err.ExceptionMessage);
                },
                success: function (result) {
                    alert('Liquidação gravada com sucesso.');
                    location.reload();
                }
            });
        }

        function GravarLiquidacao() {
            //            sinistrosGrid.style.display = 'block';

            overlay.style.display = 'block';
            beneficiarios.style.display = 'block';

            switch (document.getElementById('FormView1_lblStatus').innerText) {
                case "APROVAÇAO PAGAMENTO PENDENTE": { alert("Sinistro tem aprovaçao pagamento pendente. Você não pode cadastrar uma nova liquidação."); document.getElementById('btnGravarLiq').disabled = true; };
                case "OP PENDENTE": { alert("Sinistro tem liquidação en progresso. Você não pode cadastrar uma nova liquidação ate final da anterior."); document.getElementById('btnGravarLiq').disabled = true; };
                case "OP EM PROGRESSO (PAGNET)": { alert("Sinistro tem liquidação en progresso. Você não pode cadastrar uma nova liquidação ate final da anterior."); document.getElementById('btnGravarLiq').disabled = true; };
            }

            $("#flex1").flexigrid({
                dataType: 'json',
                colModel: [
                        { display: 'ID', name: 'ID_BENEFICIARIO', width: 20, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Nome', name: 'DS_PESSOA', width: 300, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Parentesco', name: 'TP_PARENTESCO', width: 70, sortable: true, align: 'left', process: abrirBeneficiario },
                        { display: 'Participação', name: 'VL_PARTICIPACAO', width: 60, sortable: true, align: 'left', process: abrirBeneficiario }
                ],
                title: "",
                useRp: false,
                showTableToggleBtn: false,
                resizable: false,
                width: "100%",
                height: "100%",
                singleSelect: true,
                cursorIcon: '1',
                newp: 1
            });

            $.ajax({
                type: "get",
                contentType: "application/json",
                url: "sinistro?beneficiario=" + document.getElementById('FormView1_lblIdSinistro').innerHTML,
                data: "{}",
                dataType: 'json',
                success: function (result) {
                    //add data
                    $("#flex1").flexAddData(formatResults(result));

                }
            });

            $.ajax({
                type: "get",
                //contentType: "application/json",
                url: "sinistro?reserva=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + "$1",
                //data: "{}",
                //dataType: 'json',
                success: function (result) {
                    document.getElementById('txtReserva').value = accounting.formatMoney(result.replace(",", "."), "R$ ", 2, ".", ",");
                }
            });

            $.ajax({
                type: "get",
                //contentType: "application/json",
                url: "sinistro?reserva=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + "$2",
                //data: "{}",
                //dataType: 'json',
                success: function (result) {
                    document.getElementById('txtReservaHon').value = accounting.formatMoney(result.replace(",", "."), "R$ ", 2, ".", ",");
                }
            });

            $.ajax({
                type: "get",
                //contentType: "application/json",
                url: "sinistro?reserva=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + "$3",
                //data: "{}",
                //dataType: 'json',
                success: function (result) {
                    document.getElementById('txtReservaDesp').value = accounting.formatMoney(result.replace(",", "."), "R$ ", 2, ".", ",");
                }
            });

        }

        function AdicionarBeneficiario() {
            $.ajax({
                type: "get",
                contentType: "application/json",
                url: "sinistro?beneficiario=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + '$' +
                                                document.getElementById('txtParticipacao').value.replace(",", ".") + '$' +
                                                document.getElementById('cboParentesco').value + '$' +
                                                document.getElementById('txtIdPessoa').value + '$' +
                                                document.getElementById('txtIdDocto').value + '$' +
                                                document.getElementById('cboConta').value,
                data: "{}",
                dataType: 'json',
                success: function (result) {
                    //add data
                    $("#flex1").flexAddData(formatResults(result));

                }
            });

            document.getElementById('txtCPF').value = "";
            document.getElementById('txtNome').value = "";
            document.getElementById('txtIdPessoa').value = "";
            document.getElementById('txtIdDocto').value = "";
            document.getElementById('cboParentesco').value = "";
            document.getElementById('cboConta').options.length = 0;
            document.getElementById('txtParticipacao').value = "";
        }

        function formatResults(Beneficiario) {
            var rows = Array();

            for (i = 0; i < Beneficiario.length; i++) {
                var item = Beneficiario[i];
                rows.push({ cell: [item.ID_BENEFICIARIO, item.DS_PESSOA, item.TP_PARENTESCO, item.VL_PARTICIPACAO, ''] });
            }
            return { total: Beneficiario.length, page: 1, rows: rows }
        }

        function abrirBeneficiario() {
        }

        function pesquisarBeneficiario() {

            if (document.getElementById('txtCPF').value == "") { return; }

            $.ajax({
                type: "get",
                contentType: "application/json",
                url: "pessoa/" + document.getElementById('txtCPF').value,
                data: "{}",
                dataType: 'json',
                success: function (result) {

                    if (result.length == 0) {
                        alert("Pessoa não encontrada.");
                        return;
                    }

                    var pessoa = result[0];
                    document.getElementById('txtNome').value = pessoa.DS_PESSOA;
                    document.getElementById('txtIdPessoa').value = pessoa.ID_PESSOA;
                    document.getElementById('txtIdDocto').value = pessoa.ID_DOCTO;

                    for (i = 0; i < result.length; i++) {
                        pessoa = result[i];
                        var dropdown = document.getElementById("cboConta");
                        dropdown[dropdown.length] = new Option(pessoa.DS_BANCO + " - Agencia: " + pessoa.CD_AGENCIA + " Conta: " + pessoa.NRO_CONTA, pessoa.ID_CONTA);
                    }

                }
            });
        }

        function finalizarApolice() {
        }

        function showStepCallback(obj) {
            var stepNum = obj.attr('rel');
            switch (stepNum) {

                //Finalizar       
                case "8":
                    //consistirApolice();
                    return true;

                default:
                    return true;
            }
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
                $('#step3').show();
                $('#step4').show();
                $('#step5').show();
                $('#step6').show();
                $('#step7').show();
                $('#step8').show();
                $('.buttonPrevious').show();
                $('.buttonNext').show();
                $('.buttonFinish').show();
                IncializarFormularios(model);
            }
            else {
                $('#step2').hide();
                $('#step3').hide();
                $('#step4').hide();
                $('#step5').hide();
                $('#step6').hide();
                $('#step7').hide();
                $('#step8').hide();
                $('.buttonPrevious').hide();
                $('.buttonNext').hide();
                $('.buttonFinish').hide();
            }
        }

        function FecharImg() {
            overlay.style.display = 'none';
            docView.style.display = 'none';
        }

        function Pesquisar() {
            document.getElementById('frmImagem').contentWindow.location.reload();
            overlay.style.display = 'block';
            docUpload.style.display = 'block';
        }

        function abrirImagem(id) {
            document.getElementById("imgDoc").src = "docExp.ashx?IdArquivo=" + id;

            $('btFechar').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })

            overlay.style.display = 'block';
            docView.style.display = 'block';

        }

        function CarregarGridArquivos() {

            $.ajax({
                type: "get",
                contentType: "application/json",
                url: "sinistro?arquivos=" + document.getElementById('FormView1_lblIdSinistro').innerHTML,
                data: "{}",
                dataType: 'json',
                success: function (result) {
                    //add data
                    $("#imagensGrid").flexAddData(formatResultsArq(result));

                }
            });
        }

        function formatResultsArq(arquivos) {
            var rows = Array();

            var str = "<div  style='text-align:right'>";

            for (i = 0; i < arquivos.length; i++) {
                var item = arquivos[i];
                rows.push({ cell: [i + 1, item.DS_DESCRICAO, item.DS_TIPO, '<a href=# onclick="abrirImagem(' + item.ID_ARQUIVO + ');">Abrir</a>', ''] });
            }
            return { total: arquivos.length, page: 1, rows: rows }
        }


    </script>

    <title></title>
</head>
<body>

    <form id="form1" runat="server">

    <asp:HiddenField runat="server" ID="txtUsuario" />
    <asp:HiddenField runat="server" ID="txtPerfil" />
    <asp:HiddenField runat="server" ID="txtCodigoBoleto" />

    <div id="container">
        <div id="container_body">
         <div id="title">
            <h3>
                
    Sinistro

            </h3>
         </div>


<div id="wizard" class="swMain" >
    <input type="hidden" id="Model" />
    <ul class="anchor">
  	    <li><a href="#step-1" id="step1">
        <label class="stepNumber">1</label>
        <span class="stepDesc">
            Sinistro<br />
            <small>Dados do sinistro</small>
        </span>
	    </a>
        </li>

	    <li><a href="#step-2"  id="step2">
        <label class="stepNumber">2</label>
        <span class="stepDesc">
            Pessoas<br />
            <small>Dados Pessoas</small>
        </span>
	    </a>
	    </li>

	    <li><a href="#step-3"  id="step3">
        <label class="stepNumber">3</label>
        <span class="stepDesc">
            Documentos<br />
            <small>Dados Documentação</small>
        </span>
	    </a>
	    </li>

        <li><a href="#step-4"  id="step4">
        <label class="stepNumber">4</label>
        <span class="stepDesc">
            Reservas<br />
            <small>Reservas cadastradas</small>
        </span>
	    </a>
	    </li>

        <li><a href="#step-5"  id="step5">
        <label class="stepNumber">5</label>
        <span class="stepDesc">
            Judicial<br />
            <small>Dados Judiciais</small>
        </span>
	    </a>
	    </li>

        <li><a href="#step-6"  id="step6">
        <label class="stepNumber">6</label>
        <span class="stepDesc">
            Agenda<br />
            <small>Agenda de ações</small>
        </span>
	    </a>
	    </li>
        
        <li><a href="#step-7"  id="step7">
        <label class="stepNumber">7</label>
        <span class="stepDesc">
            Histórico<br />
            <small>Histórico do sinistro</small>
        </span>
	    </a>
	    </li>        

	    <li><a href="#step-8"  id="step8">
        <label class="stepNumber">8</label>
        <span class="stepDesc">
            Pagamentos<br />
            <small>Ordem de Pagamento</small>
        </span>
	    </a>
	    </li>

	    <li><a href="#step-9"  id="step9">
        <label class="stepNumber">9</label>
        <span class="stepDesc">
            Arrecadações<br />
            <small>Arrecadação de Fundos</small>
        </span>
	    </a>
	    </li>

    </ul>

    <div id="step-1">	    
        <div id="divSinistro">
            
        <style type="text/css">
    
        </style>           

    <asp:FormView ID="FormView1" runat="server" DataSourceID="dsSinistro">

        <ItemTemplate>

            <fieldset class="fieldset-wizard">

<!-- FRAME 0 -->
        <!--div class="frame-wizard"-->
            <div class="cell-header" >
                <label>ID Sinistro</label>
                <asp:Label ID="lblIdSinistro" class="labelDescricao" runat="server" Text='<%# Eval("id_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nº Sinistro SUSEP</label>
                <asp:Label ID="Label1" class="labelDescricao" runat="server" Text='<%# Eval("nr_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>CPF do Segurado</label>
                <asp:Label ID="Label2" class="labelDescricao" runat="server" Text='<%# Eval("CPF") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nome</label>
                <asp:Label ID="Label3" class="labelDescricao" runat="server" Text='<%# Eval("ds_cliente") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Certificado</label>
                <asp:Label ID="Label49" class="labelDescricao" runat="server" Text='<%# Eval("CD_CLIENTE_ETP") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Status da Reserva</label>
                <asp:Label id="lblStatus" class="labelDescricao" runat="server" Text='<%# Eval("status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Tipo Sinistro</label>
                <asp:Label ID="lblTpSinistro" class="labelDescricao" runat="server" Text='<%# Eval("tp_sinistro") %>' ></asp:Label>
            </div>
        <!--/div-->

        </fieldset>

        <div class="clear"></div>

        <fieldset class="fieldset-wizard">
            <legend>Principal</legend>

            <div class="cell-wizard-margin" >
                <label>Estipulante</label>
            <asp:TextBox ID="TextBox5" runat="server" Width="380" ReadOnly="true"
                 Text='<%# Eval("ds_estipulante") %>' ></asp:TextBox>
            </div>

            <div class="cell-wizard-margin" >
                <label>Produto</label>
            <asp:TextBox ID="TextBox6" runat="server" class="w250 required" ReadOnly="true"
                 Text='<%# Eval("ds_produto") %>' ></asp:TextBox>
            </div>

            <div class="clear"></div>

            <div class="cell-wizard-margin" >
                <label>Sucursal</label>
            <asp:TextBox ID="TextBox9" runat="server" class="w150 required" ReadOnly="true"
                 Text='<%# Eval("ds_sucursal") %>' ></asp:TextBox>
            </div>

            <div class="cell-wizard-margin" >
                <label>Grupo Ramo Susep</label>
            <asp:TextBox ID="TextBox10" runat="server" class="w200 required" ReadOnly="true"
                 Text='<%# Eval("ds_grupo_susep") %>' ></asp:TextBox>
            </div>

            <div class="cell-wizard-margin" >
                <label>Ramo Susep</label>
            <asp:TextBox ID="TextBox11" runat="server" class="w200 required" ReadOnly="true"
                 Text='<%# Eval("ds_ramo_susep") %>' ></asp:TextBox>
            </div>

    <!--fieldset class="cell-wizard-margin">
        <legend></legend-->

        <div class="cell-wizard-margin" >
            <label>Nº de Sinistro AON</label>
        <asp:TextBox ID="TextBox14" runat="server" class="w100 required"  ReadOnly="true"
                Text='<%# Eval("nr_sinistro_aon") %>' ></asp:TextBox>
        </div>

        <div class="cell-wizard-margin" >
            <label>Data Ocorrência</label>
        <asp:TextBox ID="TextBox15" runat="server" class="w50 required"  ReadOnly="true"
                Text='<%# Eval("dt_ocorrencia") %>' ></asp:TextBox>
        </div>

        <div class="cell-wizard-margin" >
            <label>Data Aviso</label>
        <asp:TextBox ID="TextBox16" runat="server" width="52" ReadOnly="true"
                Text='<%# Eval("dt_aviso") %>' ></asp:TextBox>
        </div>

        <div class="cell-wizard-margin" >
            <label>Cobertura</label>
        <asp:TextBox ID="TextBox17" runat="server" class="w200 required"  ReadOnly="true"
                Text='<%# Eval("cd_cober") %>' ></asp:TextBox>
        </div>

        <div class="cell-wizard-margin" >
            <label>Causa</label>
        <asp:TextBox ID="TextBox18" runat="server" class="w200 required"  ReadOnly="true"
                Text='<%# Eval("id_causa") %>' ></asp:TextBox>
        </div>
    <!--/fieldset-->
            <div class="clear"></div>

        <div class="clear"></div>

    </fieldset>

            <div class="clear"></div>

            <fieldset class="fieldset-wizard">
                <legend>Dados Apólice</legend>


                <div class="cell-wizard-margin" >
                <label>Nº Apolice Ofi.</label>
            <asp:TextBox ID="TextBox13" runat="server" class="w100 required"  ReadOnly="true"
                 Text='<%# Eval("nr_apoli_ofic") %>' ></asp:TextBox>
            </div>

                <div class="cell-wizard-margin" >
                <label>Data Início</label>
            <asp:TextBox ID="TextBox19" runat="server" class="w50 required"  ReadOnly="true"
                 Text='<%# Eval("dt_ini_vig") %>' ></asp:TextBox>
            </div>

                <div class="cell-wizard-margin" >
                <label>Data Término</label>
            <asp:TextBox ID="TextBox20" runat="server" class="w50 required"  ReadOnly="true"
                 Text='<%# Eval("dt_fim_vig") %>' ></asp:TextBox>
            </div>

                <div class="cell-wizard-margin" >
                <label>Nº Endosso Ofi.</label>
            <asp:TextBox ID="TextBox22" runat="server" class="w50 required"  ReadOnly="true"
                 Text='<%# Eval("nr_endos_ofic") %>' ></asp:TextBox>
            </div>

                <div class="cell-wizard-margin" >
                <label>Início Vigência</label>
            <asp:TextBox ID="TextBox23" runat="server" class="w50 required"  ReadOnly="true"
                 Text='<%# Eval("dt_ini_vig_e") %>' ></asp:TextBox>
            </div>

                <div class="cell-wizard-margin" >
                <label>Fim Vigência</label>
            <asp:TextBox ID="TextBox24" runat="server" class="w50 required"  ReadOnly="true"
                 Text='<%# Eval("dt_fim_vig_e") %>' ></asp:TextBox>
            </div>

                <div class="cell-wizard-margin" >
                <label>Importância Segurada</label>
            <asp:TextBox ID="TextBox25" runat="server" class="w50 required"  ReadOnly="true"
                 Text='<%# Eval("vl_impor_segda") %>' ></asp:TextBox>
            </div>

                <div class="cell-wizard-margin" >
                    <label>Prêmio</label>
                    <asp:TextBox ID="TextBox26" runat="server" class="w50 required"  ReadOnly="true" Text='<%# Eval("vl_premio_tarifa") %>' ></asp:TextBox>
                </div>

                <div class="clear"></div>

            </fieldset>

            <div class="clear"></div>
            <!--fieldset class="fieldset-wizard">
                <legend></legend>

                <div class="cell-wizard-margin" >
                    <label>Regulador</label>
                <asp:TextBox ID="TextBox27" runat="server" class="w300 required"  ReadOnly="true"
                        Text='<%# Eval("ds_usuario") %>' ></asp:TextBox>
                </div>

                <div class="cell-wizard-margin" >
                    <label>Data Cadastro</label>
                <asp:TextBox ID="TextBox28" runat="server" class="w100 required"  ReadOnly="true"
                        Text='<%# Eval("dt_aviso") %>' ></asp:TextBox>
                </div>
                <div class="clear"></div>
            </fieldset-->
            
        </ItemTemplate>

    </asp:FormView>


    <fieldset class="fieldset-wizard">
        <legend>Plano Cessão</legend>

        <asp:GridView ID="gvCessao" runat="server" DataSourceID="dsCessao" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
            <Columns>
                <asp:BoundField DataField="ds_tipo_pess" HeaderText="Tipo Participação" />
                <asp:BoundField DataField="ds_descricao" HeaderText="Tipo Operação"  />
                <asp:BoundField DataField="ds_parti" HeaderText="Seguradora" />
                <asp:BoundField DataField="pc_participacao" HeaderText="%"  />
                <asp:TemplateField HeaderText="">
                    <ItemTemplate >
                        <a id="popup" onclick='AlterarCessao(<%# Eval("id_cesion") %>);' > Alterar Percentual </a>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <asp:SqlDataSource ID="dsCessao" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
            SelectCommand="select   tipo.ds_tipo_pess,
                                    oper.ds_descricao,
                                    par.ds_parti,
                                    ces.pc_participacao,
                                    ces.id_cesion
                                from   STO_CESION ces
                        inner join   TB_DOM_TPPES tipo on tipo.cd_tipo_pess = ces.tp_parti
                        inner join   CTB_TPOPERACAO oper on oper.id_operacao = ces.id_operacao
                    left outer join   TB_CAD_PTCCE par on par.cd_parti in (ces.id_cossegurador, ces.id_ressegurador) 
                            where   ces.id_sinistro = :idSinistro">
        </asp:SqlDataSource>
        <div class="clear"></div>
        <div class="clear"></div>
    </fieldset>


    <fieldset class="fieldset-wizard">
    <legend>Status de Autorização</legend>
    <div class="cell-wizard-margin">      
        <label></label>   
        <div class="clear"></div>
    </div>


<asp:GridView ID="GridView2" runat="server" DataSourceID="dsAutorizacao" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="autor" HeaderText="Tipo" />
                        <asp:BoundField DataField="status_autor" HeaderText="Status"  />
                        <asp:BoundField DataField="dt_criacao" HeaderText="Data" />
                        <asp:BoundField DataField="ds_usuario" HeaderText="Usuário"  />
                    </Columns>
            </asp:GridView>

        <asp:SqlDataSource ID="dsAutorizacao" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select case when tpst.fl_status_autorizacion_stro = '1' then 'ADMINISTRATIVA'
            when tpst.fl_status_autorizacion_Liq = '1' then 'LIQUIDAÇAO' end autor,
       case when st.tp_status in (k.STATUS_SINISTRO_ACEITO, k.STATUS_OP_PENDENTE) then 'APROVADO'
            when st.tp_status = k.STATUS_SINISTRO_REJEITADO then 'REJEITO'
            when st.tp_status = k.STATUS_FECHADO_SEM_INDENIZACAO then 'FECHADO_SEM_INDENIZAÇAO'
            when st.tp_status = k.STATUS_SINISTRO_PAGTO then 'PAGTO'
            else 'PENDENTE' end status_autor,
            to_char(st.dt_criacao,'dd/mm/yyyy') dt_criacao,
            u.ds_usuario
  from sto_status st 
 inner join sto_tpstatus tpst
    on tpst.id_tpstatus =  st.tp_status
  left outer join adm_usuario u 
    on u.id_usuario = st.id_usuario
 where st.id_status in (select max(st1.id_status)
                          from sto_status st1
                         inner join sto_tpstatus tpst1
                            on tpst1.id_tpstatus =  st1.tp_status
                         where st1.id_sinistro = :idSinistro
                      group by tpst1.fl_status_autorizacion_stro, 
                               tpst1.fl_status_autorizacion_liq)
 order by st.id_status
"></asp:SqlDataSource>

</fieldset>

    <asp:SqlDataSource ID="dsSinistro" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DB1 %>" 
        ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select nvl(str.nr_sinistro,0) nr_sinistro,
       str.id_sinistro,
       nvl(ase.cpf, ( select max(d.nr_docto)
                              from crp_docto d
                             where p.id_pessoa = d.id_pessoa and d.tp_docto in ('CPF','CNPJ') )) cpf,
       nvl(nvl(ase.ds_cliente,( select p.ds_pessoa
                              from crp_pessoa p
                             where p.id_pessoa = ase.id_pessoa )), p.ds_pessoa) ds_cliente,
       nvl(est.ds_estipulante, ( select cp.ds_progr
                              from tb_cad_progr cp
                             where cp.cd_progr = apo.cd_progr )) ds_estipulante,
       (select suc.ds_sucursal from crs_sucursal suc where suc.cd_sucursal = apo.cd_sucursal) ds_sucursal,
       (select gra.ds_grupo_susep from tb_cad_grpsu gra where gra.cd_grupo_susep = apo.cd_grupo_emis) ds_grupo_susep,
       (select ram.ds_ramo_susep from tb_cad_rmosu ram where ram.cd_grupo_susep = apo.cd_grupo_emis and ram.cd_ramo_susep = apo.cd_ramo_emis) ds_ramo_susep,
       --nvl(pa_sinistros.fnEstadoSiniestro(str.id_sinistro),k.STATUS_PREAVISO) status,
       --tps.ds_status status,
       upper((select r.tpmoid from vreserva_status r where r.id_sinistro = str.id_sinistro and rownum = 1)) status,
       str.id_segurado,
       --str.tp_sinistro,
       tp.ds_tpsinistro tp_sinistro,
       ase.cd_cliente_etp,
       str.id_seguro,
       str.id_sinistro_ref,
       seg.vl_capital_segurado,
       (select pdt.ds_produto from tb_cad_prodt pdt where pdt.id_prod_unif = apo.id_prod_unif) ds_produto,
       est.cd_estipulante,
       to_char(str.dt_ocorrencia,'dd/mm/yy') dt_ocorrencia,
       to_char(str.dt_aviso,'dd/mm/yy') dt_aviso,
       str.nr_sinistro_aon,
       (select t.ds_cober from TB_CAD_COBSU t where t.cd_cober = str.cd_cober) cd_cober,
       (select t.ds_causa from STO_TPCAUSA t where t.id_causa = str.id_causa) id_causa,
       apo.nr_apoli_ofic,
       to_char(apo.dt_ini_vig,'dd/mm/yy') dt_ini_vig,
       to_char(apo.dt_fim_vig,'dd/mm/yy') dt_fim_vig,
       en.nr_endos_ofic,
       to_char(en.dt_ini_vig,'dd/mm/yy') dt_ini_vig_e,
       to_char(en.dt_fim_vig,'dd/mm/yy') dt_fim_vig_e,
       en.vl_impor_segda,
       en.vl_premio_tarifa,
       u.id_usuario,
       u.ds_usuario,
       cpl.nr_rg,
       to_char(cpl.dt_nascto,'dd/mm/yy') dt_nascto,
       cpl.ds_endereco,
       cpl.ds_bairro,
       cpl.cd_uf,
       cpl.ds_cidade,
       j.nm_procecesso,
       j.tp_andamento,
       j.tp_motivo_acao,
       to_char(j.dt_citacao,'dd/mm/yy') dt_citacao,
       to_char(j.dt_distrib_acao,'dd/mm/yy') dt_distrib_acao,
       to_char(j.dt_defensa,'dd/mm/yy') dt_defensa,
       j.ds_vara_comarca,
       j.id_escritorio,
       j.vl_capital_segurado,
       j.ds_autor
       
  from sma_sinistro str
 left outer join sma_segurado ase
    on ase.id_segurado = str.id_segurado
 left outer join sto_tpsinistro tp
    on tp.id_tpsinistro = str.tp_sinistro
 left outer join sma_seguro seg
    on seg.id_seguro = str.id_seguro
 left outer join sma_produto prd
    on prd.id_produto = seg.id_produto
 left outer join sma_estipulante est
    on est.cd_estipulante = prd.cd_estipulante
 left outer join tb_emi_apoli apo
    on apo.id_apolice = str.id_apolice
 left outer join tb_emi_endos en
    on str.id_endosso = en.id_endosso
 left outer join crp_pessoa p
    on en.id_pessoa = p.id_pessoa
 left outer join crp_docto d
    on en.id_pessoa = d.id_pessoa
 left outer join adm_usuario u
    on u.id_usuario = str.id_usuario
 left outer join sma_segurado_cpl cpl
    on ase.id_segurado_compl = cpl.id_segurado_compl
 left outer join sto_judicial j
    on j.id_sinistro = str.id_sinistro
 where str.id_sinistro = :idSinistro">
</asp:SqlDataSource>


        </div>
    </div>

    <div id="step-2">	    
        <div id="divPessoas">


    <asp:FormView ID="FormView5" runat="server" DataSourceID="dsSinistro" Width="100%">

        <ItemTemplate>

<!-- FRAME 0 -->
            <fieldset class="fieldset-wizard">

<!-- FRAME 0 -->
        <!--div class="frame-wizard"-->
            <div class="cell-header" >
                <label>ID Sinistro</label>
                <asp:Label ID="Label1" class="labelDescricao" runat="server" Text='<%# Eval("id_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nº Sinistro SUSEP</label>
                <asp:Label ID="Label2" class="labelDescricao" runat="server" Text='<%# Eval("nr_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>CPF do Segurado</label>
                <asp:Label ID="Label3" class="labelDescricao" runat="server" Text='<%# Eval("CPF") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nome</label>
                <asp:Label ID="Label4" class="labelDescricao" runat="server" Text='<%# Eval("ds_cliente") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Certificado</label>
                <asp:Label ID="Label49" class="labelDescricao" runat="server" Text='<%# Eval("CD_CLIENTE_ETP") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Status</label>
                <asp:Label ID="Label5" class="labelDescricao" runat="server" Text='<%# Eval("status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Tipo Sinistro</label>
                <asp:Label ID="Label6" class="labelDescricao" runat="server" Text='<%# Eval("tp_sinistro") %>' ></asp:Label>
            </div>
        <!--/div-->

        </fieldset>

        </ItemTemplate>

    </asp:FormView>

    <asp:FormView ID="FormView2" runat="server" DataSourceID="dsSinistro">
        <ItemTemplate>

            <fieldset class="fieldset-wizard">

                <div class="cell-wizard-margin" >
                    <label>Código Cliente</label>
                <asp:TextBox ID="TextBox2" runat="server" class="w100 required"  ReadOnly="true"
                        Text='<%# Eval("id_segurado") %>' ></asp:TextBox>
                </div>

                <div class="cell-wizard-margin" >
                    <label>Nome</label>
                <asp:TextBox ID="TextBox12" runat="server" class="w300 required"  ReadOnly="true"
                        Text='<%# Eval("ds_cliente") %>' ></asp:TextBox>
                </div>

                <div class="cell-wizard-margin" >
                    <label>CPF</label>
                <asp:TextBox ID="TextBox21" runat="server" class="w100 required"  ReadOnly="true"
                        Text='<%# Eval("cpf") %>' ></asp:TextBox>
                </div>
 
                <div class="cell-wizard-margin" >
                    <label>RG</label>
                <asp:TextBox ID="TextBox29" runat="server" class="w100 required"  ReadOnly="true"
                        Text='<%# Eval("nr_rg") %>' ></asp:TextBox>
                </div>

                <div class="cell-wizard-margin" >
                    <label>Nascimento</label>
                <asp:TextBox ID="TextBox30" runat="server" class="w100 required"  ReadOnly="true"
                        Text='<%# Eval("dt_nascto") %>' ></asp:TextBox>
                </div>

                <div class="cell-wizard-margin" >
                    <label>Endereco</label>
                <asp:TextBox ID="TextBox31" runat="server" class="w300 required"  ReadOnly="true"
                        Text='<%# Eval("ds_endereco") %>' ></asp:TextBox>
                </div>

                <div class="cell-wizard-margin" >
                    <label>Bairro</label>
                <asp:TextBox ID="TextBox32" runat="server" width="230" ReadOnly="true"
                        Text='<%# Eval("ds_bairro") %>' ></asp:TextBox>
                </div>

                <div class="cell-wizard-margin" >
                    <label>Cidade</label>
                <asp:TextBox ID="TextBox34" runat="server" width="430" ReadOnly="true"
                        Text='<%# Eval("ds_cidade") %>' ></asp:TextBox>
                </div>

                <div class="cell-wizard-margin" >
                    <label>UF</label>
                <asp:TextBox ID="TextBox33" runat="server" class="w50 required"  ReadOnly="true"
                        Text='<%# Eval("cd_uf") %>' ></asp:TextBox>
                </div>

            </fieldset>
        </ItemTemplate>
    </asp:FormView>

    <div class="clear"></div>

    <fieldset class="fieldset-wizard">
        <legend>Beneficiários</legend>


            <asp:GridView ID="GridView3" runat="server" DataSourceID="dsBeneficiarios" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="ds_pessoa" HeaderText="Nome" />
                        <asp:BoundField DataField="tp_parentesco" HeaderText="Parentesco"  />
                        <asp:BoundField DataField="vl_participacao" HeaderText="Participacao" />
                    </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="dsBeneficiarios" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select pes.ds_pessoa,
       nvl(sb.tp_parentesco,99) tp_parentesco,
       sb.vl_participacao,
       sb.id_beneficiario
  from sto_beneficiario sb
 inner join crp_pessoa pes
    on pes.id_pessoa = sb.id_pessoa
  left outer join sys_tppessoa tps
    on tps.cd_tp_pessoa = pes.tp_pessoa
  left outer join crp_conta cb
    on cb.id_conta = sb.id_conta
  left outer join crp_docto doc
    on doc.id_docto = sb.id_docto
 where sb.id_sinistro = :idSinistro
"></asp:SqlDataSource>

    </fieldset>

    <div class="clear"></div>

    <fieldset class="fieldset-wizard" style="display:none">
    <legend>Beneficiários</legend>

            <asp:GridView ID="GridView4" runat="server" DataSourceID="dsSinistro" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="id_sinistro" HeaderText="Tipo" />
                        <asp:BoundField DataField="id_sinistro" HeaderText="Status"  />
                        <asp:BoundField DataField="id_sinistro" HeaderText="Data" />
                        <asp:BoundField DataField="id_sinistro" HeaderText="Usuário"  />
                    </Columns>
            </asp:GridView>

    </fieldset>

    <div class="clear"></div>

    <fieldset class="fieldset-wizard" style="display:none">
    <legend>Beneficiários</legend>

            <asp:GridView ID="GridView5" runat="server" DataSourceID="dsSinistro" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="id_sinistro" HeaderText="Tipo" />
                        <asp:BoundField DataField="id_sinistro" HeaderText="Status"  />
                        <asp:BoundField DataField="id_sinistro" HeaderText="Data" />
                        <asp:BoundField DataField="id_sinistro" HeaderText="Usuário"  />
                    </Columns>
            </asp:GridView>

    </fieldset>

        <div class="clear"></div>

        </div>
    </div>

    <div id="step-3">	    
        <div id="divDocumentacao">

    <asp:FormView ID="FormView6" runat="server" DataSourceID="dsSinistro"  Width="100%">

        <ItemTemplate>

<!-- FRAME 0 -->
            <fieldset class="fieldset-wizard">

<!-- FRAME 0 -->
        <!--div class="frame-wizard"-->
            <div class="cell-header" >
                <label>ID Sinistro</label>
                <asp:Label ID="Label7" class="labelDescricao" runat="server" Text='<%# Eval("id_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nº Sinistro SUSEP</label>
                <asp:Label ID="Label8" class="labelDescricao" runat="server" Text='<%# Eval("nr_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>CPF do Segurado</label>
                <asp:Label ID="Label9" class="labelDescricao" runat="server" Text='<%# Eval("CPF") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nome</label>
                <asp:Label ID="Label10" class="labelDescricao" runat="server" Text='<%# Eval("ds_cliente") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Certificado</label>
                <asp:Label ID="Label49" class="labelDescricao" runat="server" Text='<%# Eval("CD_CLIENTE_ETP") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Status</label>
                <asp:Label ID="Label11" class="labelDescricao" runat="server" Text='<%# Eval("status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Tipo Sinistro</label>
                <asp:Label ID="Label12" class="labelDescricao" runat="server" Text='<%# Eval("tp_sinistro") %>' ></asp:Label>
            </div>
        <!--/div-->

        </fieldset>

        </ItemTemplate>

    </asp:FormView>

            <div id="ScanWrapper" style="padding-left:8px">

                <label for="source">Selecionar o Equipamento:</label>
                <select size="1" id="source" style="xposition:relative;width: 220px;" onchange="source_onchange()">
                    <option value = ""></option>    
                </select>
                <input id="btnScan" disabled="disabled" type="button" value="Scan" onclick ="acquireImage();"/>
                <strong> ou </strong> 
                <input id="btnCarregar" type="button" value="Carregar Imagem do Arquivo" onclick="return Pesquisar()" />

                <div id="imagensGrid" ><table id="Table1"> </table>
                </div>

        </div>

    <div class="clear"></div>

    <!--fieldset class="fieldset-wizard">

        <asp:GridView ID="GridView6" runat="server" DataSourceID="dsDocumentos" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                <Columns>
                    <asp:BoundField DataField="ds_resumo" HeaderText="Documento" />
                    <asp:BoundField DataField="recebido" HeaderText="Recebido"  />
                    <asp:BoundField DataField="solicita" HeaderText="Solicitação" />
                    <asp:BoundField DataField="dt_solicitacao" HeaderText="Data Solicitação" />
                    <asp:BoundField DataField="dt_resposta" HeaderText="Data Resposta" />
                    <asp:BoundField DataField="nm_pedidos" HeaderText="Pedidos" />
                </Columns>
        </asp:GridView>

        <asp:SqlDataSource ID="dsDocumentos" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DB1 %>" 
        ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select to_number(doc.cd_documento), 
    doc.ds_resumo,
    nvl(pen.fl_recebido, 0) recebido,
    nvl(pen.fl_solicita, 0) solicita,
    to_char(pen.dt_solicitacao,'dd/mm/yyyy') dt_solicitacao,
    to_char(pen.dt_resposta,'dd/mm/yyyy') dt_resposta,
    nvl(pen.nm_pedidos, 0) nm_pedidos,
    pen.id_pendencia,
    null
from sma_sinistro str
inner join sma_seguro seg
on seg.id_seguro = str.id_seguro
left outer join sma_campanha_docto cad
on seg.id_campanha = cad.id_campanha
left outer join sma_documento doc
on doc.cd_documento = cad.cd_documento
left outer join sma_pendencia pen
on pen.id_sinistro = str.id_sinistro
and pen.cd_documento = doc.cd_documento
where str.id_sinistro = :idSinistro
group by doc.cd_documento, 
        doc.ds_resumo,
        pen.fl_recebido,
        pen.fl_solicita,
        pen.dt_solicitacao,
        pen.dt_resposta,
        pen.nm_pedidos,
        pen.id_pendencia,
        pen.rowid
order by 1
"></asp:SqlDataSource>

        <div class="clear"></div>

        <asp:FormView ID="FormView4" runat="server" DataSourceID="dsMotivoRejeicao">
            <ItemTemplate>

                    <div class="cell-wizard-margin" >
                        <label>Data Recusado</label>
                    <asp:TextBox ID="TextBox2" runat="server" class="w100 required"  ReadOnly="true"
                            Text='<%# Eval("dt_recusado") %>' ></asp:TextBox>
                    </div>

                    <div class="cell-wizard-margin" >
                        <label>Motivo</label>
                    <asp:TextBox ID="TextBox12" runat="server" class="w600 required" Height="80" TextMode="MultiLine" Rows="5" ReadOnly="true"
                            Text='<%# Eval("ds_motivo_rejeicao") %>' ></asp:TextBox>
                    </div>

            </ItemTemplate>
        </asp:FormView>

        <asp:SqlDataSource ID="dsMotivoRejeicao" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DB1 %>" 
        ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select s.fl_status, 
    s.ds_motivo_rejeicao,
    s.fl_documentos_recebidos,
    to_char(st.dt_criacao,'dd/mm/yyyy') dt_recusado
from sma_sinistro s 
inner join sto_status st
on st.id_sinistro = s.id_sinistro
and st.tp_status = k.STATUS_SINISTRO_REJEITADO
where s.id_sinistro = :idSinistro
"></asp:SqlDataSource>

    </fieldset-->

    </div>
    </div>

    <div id="step-4">	    
        <div id="divReserva">

    <asp:FormView ID="FormView7" runat="server" DataSourceID="dsSinistro" Width="100%">

        <ItemTemplate>

<!-- FRAME 0 -->
            <fieldset class="fieldset-wizard">

<!-- FRAME 0 -->
        <!--div class="frame-wizard"-->
            <div class="cell-header" >
                <label>ID Sinistro</label>
                <asp:Label ID="Label13" class="labelDescricao" runat="server" Text='<%# Eval("id_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nº Sinistro SUSEP</label>
                <asp:Label ID="Label14" class="labelDescricao" runat="server" Text='<%# Eval("nr_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>CPF do Segurado</label>
                <asp:Label ID="Label15" class="labelDescricao" runat="server" Text='<%# Eval("CPF") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nome</label>
                <asp:Label ID="Label16" class="labelDescricao" runat="server" Text='<%# Eval("ds_cliente") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Certificado</label>
                <asp:Label ID="Label49" class="labelDescricao" runat="server" Text='<%# Eval("CD_CLIENTE_ETP") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Status</label>
                <asp:Label ID="Label17" class="labelDescricao" runat="server" Text='<%# Eval("status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Tipo Sinistro</label>
                <asp:Label ID="Label18" class="labelDescricao" runat="server" Text='<%# Eval("tp_sinistro") %>' ></asp:Label>
            </div>
        <!--/div-->

        </fieldset>

        </ItemTemplate>

    </asp:FormView>

    <div class="clear"></div>

    <div class="button-bar-inline-right" id="barraBotoes">
        <button type="button" id="btnAjusteManual" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false">Ajuste/Aviso</button>
        <button type="button" id="btnGravarLiquidacao" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false">Liquidação</button>
        <!--button type="button" id="btnNovaOP" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Nova OP</button-->
        <button type="button" id="btnFecharSinistro" class="ui-button ui-widget ui-state-default-red ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false">Encerrar Sinistro</button>
        <!--button type="button" id="btnReabrirSinistro" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false">Reabrir</button-->
    </div>

    <div class="clear"></div>


    <fieldset class="fieldset-wizard">
    <legend>Liquidações</legend>

            <asp:GridView ID="GridView10" runat="server" DataSourceID="dsLiquidacoes" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="id_liquidacao" HeaderText="Liquidação" />
                        <asp:BoundField DataField="id_op" HeaderText="OP" />
                        <asp:BoundField DataField="fl_status" HeaderText="Autorizado" />
                        <asp:BoundField DataField="vl_valor" DataFormatString="R$ {0:###,###,###.00}" HeaderText="Valor" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                    </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="dsLiquidacoes" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select t.id_liquidacao,
       nvl(t.tp_moeda,0) tp_moeda,
       nvl(vl_valor,0) + nvl(vl_valor_coss,0)+ nvl(vl_valor_ress,0) vl_valor,
       nvl(pa_sinistros.fnCadenaOP(t.id_liquidacao),'Pendente') id_op,
       case when t.fl_status = 'A' then 'SIM' else 'NÃO' end fl_status
  from sto_liquidacao t
 where t.id_sinistro = :idSinistro
   and t.fl_valido = '1' 
 order by t.id_liquidacao"></asp:SqlDataSource>

    </fieldset>

    <div class="clear"></div>

    <!--fieldset class="fieldset-wizard">
    <legend>Total Reservas</legend>

            <asp:GridView ID="GridView7" runat="server" DataSourceID="dsReserva" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="ds_valor" HeaderText="" />
                        <asp:BoundField DataField="ds_evento" HeaderText="Tipo Evento"  />
                        <asp:BoundField DataField="vl_indemnizacao" HeaderText="Indenização"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"  />
                        <asp:BoundField DataField="vl_honorarios" HeaderText="Honorários"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"  />
                        <asp:BoundField DataField="vl_despesas" HeaderText="Despesas"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"  />
                        <asp:BoundField DataField="vl_resseguro" HeaderText="Resseguro"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"  />
                        <asp:BoundField DataField="vl_cosseguro" HeaderText="Cosseguro"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"  />
                    </Columns>
            </asp:GridView>

    </fieldset!-->

    <asp:SqlDataSource ID="dsReserva" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DB1 %>" 
        ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
        SelectCommand="select t.ds_valor, t.tp_valor, t.ds_evento, t.vl_indemnizacao, t.vl_honorarios,
                              t.vl_despesas, t.vl_resseguro, t.vl_cosseguro
                          from ctb_vtotalreservas t
                         where t.id_sinistro = :idSinistro
                         and   (t.vl_indemnizacao <> 0
                          or     t.vl_honorarios <> 0
                          or     t.vl_despesas <> 0
                          or     t.vl_resseguro <> 0
                          or     t.vl_cosseguro <> 0)
                          order by t.id_valor">
    </asp:SqlDataSource>

    <div class="clear"></div>

    <fieldset class="fieldset-wizard">
    <legend>Reserva disponível</legend>

            <asp:GridView ID="GridView8" runat="server" DataSourceID="dsReservaPendente" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="ds_descricao" HeaderText="Tipo" />
                        <asp:BoundField DataField="vl_total" DataFormatString="R$ {0:###,###,###.00}" HeaderText="Valor"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"  />
                    </Columns>
            </asp:GridView>
    </fieldset>

    <div class="clear"></div>

    <asp:SqlDataSource ID="dsReservaPendente" runat="server" 
        ConnectionString="<%$ ConnectionStrings:DB1 %>" 
        ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
        SelectCommand="select t.ds_descricao, t.vl_total from ctb_vtotalreservaspendente 
                       t where t.id_sinistro = :idSinistro and t.vl_total <> 0">
    </asp:SqlDataSource>

    <fieldset class="fieldset-wizard">
    <legend>Movimento Reserva Indenização</legend>

            <asp:GridView ID="GridView9" runat="server" DataSourceID="dsReservaMovimento" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="data" DataFormatString="{0:f}" HeaderText="Data" />
                        <asp:BoundField DataField="TPMOID" HeaderText="Tipo Movimento"  />
                        <asp:BoundField DataField="vl_reserva" DataFormatString="R$ {0:###,###,###.00}" HeaderText="Valor"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                    </Columns>
            </asp:GridView>

    </fieldset>

    <asp:SqlDataSource ID="dsReservaMovimento" runat="server" ConnectionString="<%$ ConnectionStrings:DB1 %>" ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
                       SelectCommand="select tpmoid fl_evento, to_char(r.dt_cadastro, 'dd/MM/yyyy') data, r.* 
                                        from VRESERVA_STATUS r
                                       inner join ctb_tpvalor tpv on tpv.id_valor = r.tp_valor
                                       where r.id_sinistro = :idSinistro
                                       order by r.dt_cadastro, r.id_reserva asc">
    </asp:SqlDataSource>

    <div class="clear"></div>

    <fieldset class="fieldset-wizard">
    <legend>Movimento Honorários/Despesas/Outros</legend>

            <asp:GridView ID="GridView60" runat="server" DataSourceID="dsReservaHonDesp" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="dt_cadastro" HeaderText="Data" />
                        <asp:BoundField DataField="ds_descricao" HeaderText="Tipo Reserva"  />
                        <asp:BoundField DataField="fl_evento" HeaderText="Tipo Evento" />
                        <asp:BoundField DataField="vl_reserva_somatorio" DataFormatString="R$ {0:###,###,###.00}" HeaderText="Reserva Total"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                    </Columns>
            </asp:GridView>

    </fieldset>

    <asp:SqlDataSource ID="dsReservaHonDesp" runat="server" ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
            SelectCommand="select to_char(r.dt_cadastro,'dd/mm/yyyy') dt_cadastro,
       tpv.ds_descricao,
       case when r.fl_evento = 'A' then 'AVISO'
            when r.fl_evento = 'J' then 'AJUSTE' || (select ' - ' || t.ds_cm from sto_cm c, sto_tpcm t where c.tp_cm = t.tp_cm and c.id_cm = r.id_cm)
            when r.fl_evento = 'P' then 'PAGTO'
            when r.fl_evento = 'CM' then 'CORREÇAO MONETÁRIA' end fl_evento,
            nvl(r.vl_reserva,0) + nvl(r.vl_cosseguro,0) + nvl(r.vl_resseguro,0) vl_reserva_somatorio,
       r.id_op
  from sto_reserva r 
 inner join ctb_tpvalor tpv
    on tpv.id_valor = r.tp_valor
 where r.id_sinistro = :idSinistro and nvl(r.vl_reserva,0) + nvl(r.vl_cosseguro,0) + nvl(r.vl_resseguro,0) <> 0
   and r.tp_valor <> 1
 order by r.dt_cadastro">
    </asp:SqlDataSource>

    <div class="clear"></div>

        </div>
    </div>

    <div id="step-5">	    
        <div id="divJudicial">

    <asp:FormView ID="FormView8" runat="server" DataSourceID="dsSinistro"  Width="100%">

        <ItemTemplate>

<!-- FRAME 0 -->
            <fieldset class="fieldset-wizard">

<!-- FRAME 0 -->
        <!--div class="frame-wizard"-->
            <div class="cell-header" >
                <label>ID Sinistro</label>
                <asp:Label ID="Label19" class="labelDescricao" runat="server" Text='<%# Eval("id_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nº Sinistro SUSEP</label>
                <asp:Label ID="Label20" class="labelDescricao" runat="server" Text='<%# Eval("nr_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>CPF do Segurado</label>
                <asp:Label ID="Label21" class="labelDescricao" runat="server" Text='<%# Eval("CPF") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nome</label>
                <asp:Label ID="Label22" class="labelDescricao" runat="server" Text='<%# Eval("ds_cliente") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Certificado</label>
                <asp:Label ID="Label49" class="labelDescricao" runat="server" Text='<%# Eval("CD_CLIENTE_ETP") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Status</label>
                <asp:Label ID="Label23" class="labelDescricao" runat="server" Text='<%# Eval("status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Tipo Sinistro</label>
                <asp:Label ID="Label24" class="labelDescricao" runat="server" Text='<%# Eval("tp_sinistro") %>' ></asp:Label>
            </div>
        <!--/div-->

        </fieldset>

        </ItemTemplate>

    </asp:FormView>

    <div class="clear"></div>

    <div class="button-bar-inline-right" id="barraJudicial">
        <button type="button" id="btnTransformarJudicial" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false">Transformar em Sinistro Judicial</button>
    </div>

    <div class="clear"></div>

    <fieldset class="fieldset-wizard">
    <legend>Dados Processo</legend>

    </fieldset>

            <asp:FormView ID="FormView3" runat="server" DataSourceID="dsSinistro">
                <ItemTemplate>
                    <div class="frame-wizard">

                        <div class="cell-wizard-margin" >
                            <label>Nº processo</label>
                        <asp:TextBox ID="TextBox2" runat="server" class="w150 required"  ReadOnly="true"
                             Text='<%# Eval("nm_procecesso") %>' ></asp:TextBox>
                        </div>

                        <div class="cell-wizard-margin" >
                            <label>Andamento Processo</label>
                        <asp:TextBox ID="TextBox35" runat="server" class="w200 required"  ReadOnly="true"
                             Text='<%# Eval("tp_andamento") %>' ></asp:TextBox>
                        </div>

                        <div class="cell-wizard-margin" >
                            <label>Data Citação</label>
                        <asp:TextBox ID="TextBox37" runat="server" class="w100 required"  ReadOnly="true"
                             Text='<%# Eval("dt_citacao") %>' ></asp:TextBox>
                        </div>

                        <div class="cell-wizard-margin" >
                            <label>Data Dist. Ação</label>
                        <asp:TextBox ID="TextBox38" runat="server" class="w100 required"  ReadOnly="true"
                             Text='<%# Eval("dt_distrib_acao") %>' ></asp:TextBox>
                        </div>

                        <div class="cell-wizard-margin" >
                            <label>Data Defesa</label>
                        <asp:TextBox ID="TextBox39" runat="server" class="w100 required"  ReadOnly="true"
                             Text='<%# Eval("dt_defensa") %>' ></asp:TextBox>
                        </div>

                        <div class="cell-wizard-margin" >
                            <label>Capital Segurado</label>
                        <asp:TextBox ID="TextBox43" runat="server" class="w150 required"  ReadOnly="true"
                             Text='<%# Eval("vl_capital_segurado") %>' ></asp:TextBox>
                        </div>

                        <div class="cell-wizard-margin" >
                            <label>Vara/Comarca</label>
                        <asp:TextBox ID="TextBox40" runat="server" class="w200 required"  ReadOnly="true"
                             Text='<%# Eval("ds_vara_comarca") %>' ></asp:TextBox>
                        </div>

                        <div class="cell-wizard-margin" >
                            <label>Escritorio Colaborador</label>
                        <asp:TextBox ID="TextBox41" runat="server" Width="355" ReadOnly="true"
                             Text='<%# Eval("id_escritorio") %>' ></asp:TextBox>
                        </div>

                        <div class="cell-wizard-margin" >
                            <label>Autor</label>
                        <asp:TextBox ID="TextBox42" runat="server" Width="765" ReadOnly="true"
                             Text='<%# Eval("ds_autor") %>' ></asp:TextBox>
                        </div>

                        <div class="cell-wizard-margin" >
                            <label>Motivo da Ação</label>
                        <asp:TextBox ID="TextBox36" runat="server" Width="765" ReadOnly="true"
                             Text='<%# Eval("tp_motivo_acao") %>' ></asp:TextBox>
                        </div>

                    </div>
                </ItemTemplate>
            </asp:FormView> 

    <div class="clear"></div>

    <fieldset class="fieldset-wizard">
    <legend>Probabilidade</legend>

            <asp:GridView ID="gvJudicialRisco" runat="server" Width="768" DataSourceID="dsJudicialRisco" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="vl_remoto" HeaderText="% Remoto" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                        <asp:BoundField DataField="vl_possivel" HeaderText="% Possível" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                        <asp:BoundField DataField="vl_provavel" HeaderText="% Provável" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right" />
                    </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="dsJudicialRisco" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" 
            SelectCommand="select s.vl_remoto, s.vl_possivel, s.vl_provavel from sma_sinistro s where s.id_sinistro = :idSinistro"></asp:SqlDataSource>

    </fieldset>

    <div class="clear"></div>

        </div>
    </div>

    <div id="step-6">	    
        <div id="divAgenda">

    <asp:FormView ID="FormView9" runat="server" DataSourceID="dsSinistro"  Width="100%">

        <ItemTemplate>

<!-- FRAME 0 -->
            <fieldset class="fieldset-wizard">

<!-- FRAME 0 -->
        <!--div class="frame-wizard"-->
            <div class="cell-header" >
                <label>ID Sinistro</label>
                <asp:Label ID="Label25" class="labelDescricao" runat="server" Text='<%# Eval("id_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nº Sinistro SUSEP</label>
                <asp:Label ID="Label26" class="labelDescricao" runat="server" Text='<%# Eval("nr_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>CPF do Segurado</label>
                <asp:Label ID="Label27" class="labelDescricao" runat="server" Text='<%# Eval("CPF") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nome</label>
                <asp:Label ID="Label28" class="labelDescricao" runat="server" Text='<%# Eval("ds_cliente") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Certificado</label>
                <asp:Label ID="Label49" class="labelDescricao" runat="server" Text='<%# Eval("CD_CLIENTE_ETP") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Status</label>
                <asp:Label ID="Label29" class="labelDescricao" runat="server" Text='<%# Eval("status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Tipo Sinistro</label>
                <asp:Label ID="Label30" class="labelDescricao" runat="server" Text='<%# Eval("tp_sinistro") %>' ></asp:Label>
            </div>
        <!--/div-->

        </fieldset>

        </ItemTemplate>

    </asp:FormView>

            <asp:GridView ID="GridView11" runat="server" DataSourceID="dsAgenda" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="dt_criacao" HeaderText="Dt Criação" />
                        <asp:BoundField DataField="ds_comentarios" HeaderText="Comentários"  />
                        <asp:BoundField DataField="dt_proxrevisao" HeaderText="Dt Revisão" />
                        <asp:BoundField DataField="fl_feita" HeaderText="OK" />
                        <asp:BoundField DataField="fl_adiada" HeaderText="Adiada" />
                        <asp:BoundField DataField="id_agendaautomata" HeaderText="Autom" />
                        <asp:BoundField DataField="ds_usuario" HeaderText="Usuário" />
                        <asp:BoundField DataField="dt_alteracao" HeaderText="Dt Modificação" />
                    </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="dsAgenda" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select to_char(a.dt_criacao,'dd/mm/yyyy') dt_criacao,
       trim(a.ds_comentarios) ds_comentarios,
       null,
       to_char(a.dt_proxrevisao,'dd/mm/yyyy') dt_proxrevisao,
       a.fl_feita,
       a.fl_adiada,
       decode(nvl(a.id_agendaautomata,-1),-1,0,1) id_agendaautomata,
       u.ds_usuario,
       to_char(a.dt_alteracao,'dd/mm/yyyy') dt_alteracao,
       a.id_agenda,
       a.fl_prioridade,
       a.id_usuario
  from sto_agenda a
  left outer join adm_usuario u 
    on u.id_usuario = a.id_usuario
 where a.id_sinistro = :idSinistro
"></asp:SqlDataSource>

            <div class="clear"></div>

        </div>
    </div>

    <div id="step-7">	    
        <div id="divHistorico">

    <asp:FormView ID="FormView10" runat="server" DataSourceID="dsSinistro"  Width="100%">

        <ItemTemplate>

<!-- FRAME 0 -->
            <fieldset class="fieldset-wizard">

<!-- FRAME 0 -->
        <!--div class="frame-wizard"-->
            <div class="cell-header" >
                <label>ID Sinistro</label>
                <asp:Label ID="Label31" class="labelDescricao" runat="server" Text='<%# Eval("id_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nº Sinistro SUSEP</label>
                <asp:Label ID="Label32" class="labelDescricao" runat="server" Text='<%# Eval("nr_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>CPF do Segurado</label>
                <asp:Label ID="Label33" class="labelDescricao" runat="server" Text='<%# Eval("CPF") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nome</label>
                <asp:Label ID="Label34" class="labelDescricao" runat="server" Text='<%# Eval("ds_cliente") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Certificado</label>
                <asp:Label ID="Label49" class="labelDescricao" runat="server" Text='<%# Eval("CD_CLIENTE_ETP") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Status</label>
                <asp:Label ID="Label35" class="labelDescricao" runat="server" Text='<%# Eval("status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Tipo Sinistro</label>
                <asp:Label ID="Label36" class="labelDescricao" runat="server" Text='<%# Eval("tp_sinistro") %>' ></asp:Label>
            </div>
        <!--/div-->

        </fieldset>

        </ItemTemplate>

    </asp:FormView>


    <!--fieldset class="fieldset-wizard">
    <legend>Histórico de Status</legend>

            <asp:GridView ID="GridView12" runat="server" DataSourceID="dsStatus" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="dt_criacao" HeaderText="Data" />
                        <asp:BoundField DataField="ds_status" HeaderText="Status"  />
                        <asp:BoundField DataField="ds_usuario" HeaderText="Usuário" />
                    </Columns>
            </asp:GridView>

    </fieldset-->

            <asp:SqlDataSource ID="dsStatus" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select to_char(st.dt_criacao,'dd/mm/yyyy') dt_criacao,
       tpst.ds_status,
       u.ds_usuario
  from sto_status st
 inner join sto_tpstatus tpst
    on st.tp_status = tpst.id_tpstatus
  left outer join adm_usuario u 
    on u.id_usuario = st.id_usuario
 where st.id_sinistro = :idSinistro
 order by st.id_status desc
"></asp:SqlDataSource>

    <fieldset class="fieldset-wizard">
        <legend>Histórico de Status/Comentários</legend>

        <asp:GridView ID="GridView14" runat="server" DataSourceID="dsComentarios" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                <Columns>
                    <asp:BoundField DataField="ds_usuario" HeaderText="Usuário" />
                    <asp:BoundField DataField="dt_registro" HeaderText="Data"  />
                    <asp:BoundField DataField="ds_evento" HeaderText="Evento" />
                    <asp:BoundField DataField="ds_comentario" HeaderText="Comentário" />
                </Columns>
        </asp:GridView>

        <asp:SqlDataSource ID="dsComentarios" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select u.ds_usuario, txt.bn_texto ds_comentario,
                            to_char(t.dt_registro,'dd/mm/yyyy') dt_registro,e.ds_evento, t.id_tarefa, t.id_texto 
                    from sma_tarefa t, adm_usuario u, exc_evento e, adm_texto txt
                    where t.id_usuario = u.id_usuario
                    and t.cd_evento = e.cd_evento
                    and txt.id_texto = t.id_texto
                    and t.id_sinistro = :idSinistro
                    order by t.dt_registro desc">
        </asp:SqlDataSource>

        <div class="clear"></div>

    </fieldset>

        <div class="cell-wizard">

            <label for="Itens_DsObjSeguradoEdit"> Novo Status / Comentário </label>

            <asp:SqlDataSource ID="dsEvento" runat="server"
                ConnectionString="<%$ ConnectionStrings:DB1 %>" 
                ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>"     
                SelectCommand = "select -1 cd_evento, ' ' ds_evento from dual
                                 union
                                 select t.cd_evento, upper(t.ds_evento) ds_evento from exc_evento t  where t.fl_sinistro = 1 order by ds_evento">
            </asp:SqlDataSource>

            <asp:DropDownList ID="cboComentarioEvento" runat="server" 
                    DataSourceid="dsEvento"
                    DataTextField="ds_evento" 
                    DataValueField="cd_evento"
                    >
            </asp:DropDownList>

            <textarea id="txtComentarioEvento" cols="80" rows="5" style="height: 100px;" ></textarea>

            <div class="button-bar-inline-right" id="barraComentario">
                <button type="button" id="btnComentario" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Gravar Comentário</button>
            </div>

        </div>

        <div class="clear"></div>

        </div>
    </div>

    <div id="step-8">	    
        <div id="divPagamentos">

    <asp:FormView ID="FormView11" runat="server" DataSourceID="dsSinistro"  Width="100%">

        <ItemTemplate>

<!-- FRAME 0 -->
            <fieldset class="fieldset-wizard">

<!-- FRAME 0 -->
        <!--div class="frame-wizard"-->
            <div class="cell-header" >
                <label>ID Sinistro</label>
                <asp:Label ID="Label37" class="labelDescricao" runat="server" Text='<%# Eval("id_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nº Sinistro SUSEP</label>
                <asp:Label ID="Label38" class="labelDescricao" runat="server" Text='<%# Eval("nr_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>CPF do Segurado</label>
                <asp:Label ID="Label39" class="labelDescricao" runat="server" Text='<%# Eval("CPF") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nome</label>
                <asp:Label ID="Label40" class="labelDescricao" runat="server" Text='<%# Eval("ds_cliente") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Certificado</label>
                <asp:Label ID="Label49" class="labelDescricao" runat="server" Text='<%# Eval("CD_CLIENTE_ETP") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Status</label>
                <asp:Label ID="Label41" class="labelDescricao" runat="server" Text='<%# Eval("status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Tipo Sinistro</label>
                <asp:Label ID="Label42" class="labelDescricao" runat="server" Text='<%# Eval("tp_sinistro") %>' ></asp:Label>
            </div>
        <!--/div-->

        </fieldset>

        </ItemTemplate>

    </asp:FormView>

    <div class="clear"></div>

    <div class="clear"></div>

            <asp:GridView ID="GridView13" runat="server" DataSourceID="dsPagamentos" AutoGenerateColumns="false"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="id_op" HeaderText="OP" />
                        <asp:BoundField DataField="tp_op" HeaderText="Tipo OP"  />
                        <asp:BoundField DataField="ds_status" HeaderText="Status" />
                        <asp:BoundField DataField="nm_favorecido" HeaderText="Beneficiário" />
                        <asp:BoundField DataField="ds_conta" HeaderText="Conta" />
                        <asp:BoundField DataField="vl_pagamento" HeaderText="Valor Pagto"  DataFormatString="R$ {0:###,###,###.00}" ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"  />
                        <asp:BoundField DataField="dt_pagamento" HeaderText="Dt Pagto" />
                        <asp:BoundField DataField="ds_forma_pagamento" HeaderText="Forma Pagto" />
                    </Columns>
            </asp:GridView>

            <asp:SqlDataSource ID="dsPagamentos" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DB1 %>" 
            ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select v.id_op,
       v.tp_op,
       t.ds_status,
       v.nm_favorecido,
       v.vl_pagamento,
       to_char(v.dt_pagamento,'dd/mm/yyyy') dt_pagamento,
       v.ds_forma_pagamento,
       v.dt_cancelamento,
       v.ds_conta,
       (case when v.dt_cancelamento is not null then 1 else 0 end)
  from vOPSiniestros v, ctb_tpstatusop t
 where v.id_sinistro = :idSinistro and t.id_tpstatusop = v.id_status
"></asp:SqlDataSource>

        <div class="clear"></div>

        </div>
    </div>

    <div id="step-9">	    
        <div id="divArrec">

    <asp:FormView ID="FormView12" runat="server" DataSourceID="dsSinistro"  Width="100%">

        <ItemTemplate>

<!-- FRAME 0 -->
            <fieldset class="fieldset-wizard">

<!-- FRAME 0 -->
        <!--div class="frame-wizard"-->
            <div class="cell-header" >
                <label>ID Sinistro</label>
                <asp:Label ID="Label43" class="labelDescricao" runat="server" Text='<%# Eval("id_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nº Sinistro SUSEP</label>
                <asp:Label ID="Label44" class="labelDescricao" runat="server" Text='<%# Eval("nr_sinistro") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>CPF do Segurado</label>
                <asp:Label ID="Label45" class="labelDescricao" runat="server" Text='<%# Eval("CPF") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Nome</label>
                <asp:Label ID="Label46" class="labelDescricao" runat="server" Text='<%# Eval("ds_cliente") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Certificado</label>
                <asp:Label ID="Label49" class="labelDescricao" runat="server" Text='<%# Eval("CD_CLIENTE_ETP") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Status</label>
                <asp:Label ID="Label47" class="labelDescricao" runat="server" Text='<%# Eval("status") %>' ></asp:Label>
            </div>

            <div class="cell-header" >
                <label>Tipo Sinistro</label>
                <asp:Label ID="Label48" class="labelDescricao" runat="server" Text='<%# Eval("tp_sinistro") %>' ></asp:Label>
            </div>
        <!--/div-->

        </fieldset>

        </ItemTemplate>

    </asp:FormView>

                    <label>Arrecadação de Fundos</label>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"  
                    DataSourceID="dsArrecadacao"  CssClass="DDGridView" RowStyle-CssClass="td" HeaderStyle-CssClass="th" CellPadding="6">
                    <Columns>
                        <asp:BoundField DataField="TO_CHAR(C.DT_ARRECADACAO,'DD/MM/YYYY')" 
                            HeaderText="Data Arrecadação" 
                            SortExpression="TO_CHAR(C.DT_ARRECADACAO,'DD/MM/YYYY')" />
                        <asp:BoundField DataField="NRO_CONTA" HeaderText="Nº da Conta" 
                            SortExpression="NRO_CONTA" />
                        <asp:BoundField DataField="NVL(C.VL_ARRECADADO,0)" 
                            HeaderText="Valor Arrecadado" SortExpression="NVL(C.VL_ARRECADADO,0)"  ItemStyle-HorizontalAlign="Right" HeaderStyle-HorizontalAlign="Right"  />
                        <asp:BoundField DataField="TO_CHAR(C.DT_VECTO,'DD/MM/YYYY')" 
                            HeaderText="Data Vcto da Conta" 
                            SortExpression="TO_CHAR(C.DT_VECTO,'DD/MM/YYYY')" />
                        <asp:BoundField DataField="NVL(C.NRO_RODADA,0)" HeaderText="Rodada" 
                            SortExpression="NVL(C.NRO_RODADA,0)" />
                        <asp:BoundField DataField="TO_CHAR(C.DT_PROC,'DD/MM/YYYY')" 
                            HeaderText="Data Processo" SortExpression="TO_CHAR(C.DT_PROC,'DD/MM/YYYY')" />
                        <asp:BoundField DataField="TO_CHAR(C.DT_REFERENCIA,'DD/MM/YYYY')" 
                            HeaderText="Data Referencia" 
                            SortExpression="TO_CHAR(C.DT_REFERENCIA,'DD/MM/YYYY')" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="dsArrecadacao" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:DB1 %>" 
                    ProviderName="<%$ ConnectionStrings:DB1.ProviderName %>" SelectCommand="select to_char(c.dt_arrecadacao,'dd/mm/yyyy'),
       c.nro_conta,
       nvl(c.vl_arrecadado,0),
       to_char(c.dt_vecto,'dd/mm/yyyy'),
       nvl(c.nro_rodada,0),
       to_char(c.dt_proc,'dd/mm/yyyy'),
       to_char(c.dt_referencia,'dd/mm/yyyy')
  from sma_cobranca c, sma_sinistro s
 where s.id_sinistro = :idSinistro
 and c.id_seguro = s.id_seguro
 order by c.id_cobranca desc
"></asp:SqlDataSource>

        <div class="clear"></div>

        </div>
    </div>

</div>

<div class="both"></div>
        </div>
    </div>

    <div id="novaOP" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable" style="outline: 0px none; z-index: 1002; height: auto; width: 700px; top: 173px; left: 438.5px; display: none;" tabindex="-1" role="dialog" aria-labelledby="ui-id-7">
        <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> Ordem de Pagamento </div>
        <div id="editNovaOP" class="ui-dialog-content ui-widget-content" style="display: block; width: auto; min-height: 0px; height: 100px;" scrolltop="0" scrollleft="0">

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Liquidação </label>
                <input id="txtIdLiquidacao" style="width: 60px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Valor Pagto </label>
                <input id="txtVlPagto" style="width: 60px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Tipo de Pagto </label>
                <input id="txtFlPagto" style="width: 80px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Beneficiário </label>
                <input id="txtDsBeneficiario" style="width: 350px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Data de Pagto </label>
                <input id="txtDtPagto2" style="width: 60px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>
            <div class="button-bar-inline">
                <button type="button" id="btnCancelarOP" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Cancelar</button>
                <button type="button" id="btnGravarOP" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Gravar OP</button>
            </div>

        </div>
    </div>

    <div id="ajusteManual" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable" style="outline: 0px none; z-index: 1002; height: auto; width: 700px; top: 173px; left: 450px; display: none;" tabindex="-1" role="dialog" aria-labelledby="ui-id-7">
        <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> Ajuste Manual </div>
        <div id="editAjusteManual" class="ui-dialog-content ui-widget-content" style="display: block; width: auto; min-height: 0px; height: 150px;" scrolltop="0" scrollleft="0">

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Indenização </label>
                <input id="txtReservaDisponivel" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Honorários </label>
                <input id="txtReservaDisponivelHon" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Despesas </label>
                <input id="txtReservaDisponivelDes" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Ressarcimentos </label>
                <input id="txtReservaDisponivelRes" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Salvados </label>
                <input id="txtReservaDisponivelSal" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>

            <div class="clear"></div>

            <div class="cell-wizard">
                <!--label for="Itens_DsObjSeguradoEdit"> Valor Ajuste </label-->
                <input id="txtValorAjuste" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>

            <div class="cell-wizard">
                <!--label for="Itens_DsObjSeguradoEdit"> Honorários </label-->
                <input id="txtValorAjusteHon" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <!--label for="Itens_DsObjSeguradoEdit"> Despesas </label-->
                <input id="txtValorAjusteDes" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>

            <div class="cell-wizard">
                <!--label for="Itens_DsObjSeguradoEdit"> Honorários </label-->
                <input id="txtValorAjusteRes" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <!--label for="Itens_DsObjSeguradoEdit"> Despesas </label-->
                <input id="txtValorAjusteSal" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>

            <div class="clear"></div>

            <div class="button-bar-inline-right">
                <button type="button" id="btnCancelarAjuste" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Cancelar</button>
                <button type="button" id="btnSalvarAjuste" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Gravar Ajuste</button>
            </div>

        </div>
    </div>

    <script type="text/javascript">

        $(document).ready(function () {

            $('#btnCancelarJudicial').button({
                icons: {
                    primary: "ui-icon"
                },
                text: true
            })
            .click(function () {
                overlay.style.display = 'none';
                abrirJudicial.style.display = 'none';
            });

            $('#btnGravarJudicial').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {

                $.ajax({
                    type: "post",
                    url: "sinistro?judicial=" + document.getElementById('FormView1_lblIdSinistro').innerHTML + '$' +
                                                document.getElementById('txtUsuario').value + '$' +
                                                document.getElementById('txtIndenizacaoJudicial').value.replace(",", ".") + '$' +
                                                document.getElementById('txtHonorarios').value.replace(",", ".") + '$' +
                                                document.getElementById('txtDespesas').value.replace(",", ".") + '$' +
                                                document.getElementById('txtRemoto').value.replace(",", ".") + '$' +
                                                document.getElementById('txtPossivel').value.replace(",", ".") + '$' +
                                                document.getElementById('txtProvavel').value.replace(",", "."),
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Sinistro Judicial gravado com sucesso.');
                        location.reload();
                    }
                });
            });

        });
    
    </script>

    <div id="abrirJudicial" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable" style="outline: 0px none; z-index: 1002; height: auto; width: 700px; top: 173px; left: 438.5px; display: none;" tabindex="-1" role="dialog" aria-labelledby="ui-id-7">
        <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> Reabrir Como Sinistro Judicial </div>
        <div id="Div3" class="ui-dialog-content ui-widget-content" style="display: block; width: auto; min-height: 0px; height: 50px;" scrolltop="0" scrollleft="0">

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Indenização </label>
                <input id="txtIndenizacaoJudicial" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Honorários </label>
                <input id="txtHonorarios" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Despesas </label>
                <input id="txtDespesas" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>

        </div>
        <div id="Div5" class="ui-dialog-content ui-widget-content" style="display: block; width: auto; min-height: 0px; height: 50px;" scrolltop="0" scrollleft="0">

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> % Remoto </label>
                <input id="txtRemoto" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> % Possível </label>
                <input id="txtPossivel" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> % Provável </label>
                <input id="txtProvavel" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>

            <div class="button-bar-inline">
                <button type="button" id="btnGravarJudicial" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Gravar Judicial</button>
                <button type="button" id="btnCancelarJudicial" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Cancelar</button>
            </div>

        </div>
    </div>

    <script type="text/javascript">
        var model = { "coberturas": [] };
        $(document).ready(function () {

            $('#btnPesquisarPessoa').button({
                icons: {
                    primary: "ui-icon-search"
                },
                text: true
            })
            .click(function () {
                $.ajax({
                    type: "get",
                    contentType: "application/json",
                    url: "pessoa?nome=" + document.getElementById('txtNomePessoa').value,
                    data: "{}",
                    dataType: 'json',
                    success: function (result) {
                        //add data

                        var rows = Array();

                        for (i = 0; i < result.length; i++) {
                            var item = result[i];
                            rows.push({ cell: [item.ID_PESSOA, item.TP_PESSOA, item.DS_PESSOA, ''] });
                        }
                        pessoas = { total: result.length, page: 1, rows: rows }

                        $("#flexPessoas").flexAddData(pessoas);

                    }
                });
            });

            $('#btnAdicionarCPF').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {

                if (!validarCPF(document.getElementById('txtCPFPessoa').value)) {
                    if (!validarCNPJ(document.getElementById('txtCPFPessoa').value)) {
                        alert('CPF ou CNPJ Inválido!');
                        return;
                    }
                }

                $.ajax({
                    type: "post",
                    url: "pessoa?docto=" + document.getElementById('txtIdPessoa').value + '$' + document.getElementById('txtCPFPessoa').value,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('CPF / CNPJ gravado com sucesso.');
                        $.ajax({
                            type: "get",
                            url: "pessoa?doctos=" + document.getElementById('txtIdPessoa').value,
                            success: function (result) {

                                var rows = Array();

                                for (i = 0; i < result.length; i++) {
                                    var item = result[i];
                                    rows.push({ cell: [item.TP_DOCTO, item.NR_DOCTO, ''] });
                                }
                                pessoas = { total: result.length, page: 1, rows: rows }

                                $("#flexDocumentos").flexAddData(pessoas);

                            }
                        });
                    }
                });
            });

            $('#btnAdicionarEnd').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                $.ajax({
                    type: "post",
                    url: "pessoa?endereco=" + document.getElementById('txtIdPessoa').value + '$' + document.getElementById('txtEndereco').value + '$' +
                                          document.getElementById('txtComplemento').value + '$' + document.getElementById('txtBairro').value + '$' +
                                          document.getElementById('txtCidade').value + '$' + document.getElementById('txtUF').value + '$' +
                                          document.getElementById('txtCEP').value,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Registro gravado com sucesso.' + result);


                        $.ajax({
                            type: "get",
                            url: "pessoa?enderecos=" + document.getElementById('txtIdPessoa').value,
                            success: function (result) {
                                var rows = Array();

                                for (i = 0; i < result.length; i++) {
                                    var item = result[i];
                                    rows.push({ cell: [item.DS_ENDERECO, item.DS_COMPL, item.DS_BAIRRO, item.DS_CIDADE, item.CD_UF, item.DS_CEP, ''] });
                                }
                                pessoas = { total: result.length, page: 1, rows: rows }

                                $("#flexEnderecos").flexAddData(pessoas);

                            }
                        });


                    }
                });
            });

            $('#btnAdicionarConta').button({
                icons: {
                    primary: "ui-icon-disk"
                },
                text: true
            })
            .click(function () {
                $.ajax({
                    type: "post",
                    url: "pessoa?conta=" + document.getElementById('txtIdPessoa').value + '$' + document.getElementById('txtConta').value + '$' +
                                          document.getElementById('txtContaDV').value + '$' + document.getElementById('cboBanco').value + '$' +
                                          document.getElementById('txtAgencia').value + '$' + document.getElementById('txtAgenciaDV').value + '$' +
                                          document.getElementById('chkPrincipal').value + '$' + document.getElementById('cboTipoConta').value,
                    error: function (xhr, status, error) {
                        var err = eval("(" + xhr.responseText + ")");
                        alert(err.ExceptionMessage);
                    },
                    success: function (result) {
                        alert('Registro gravado com sucesso.');

                        $.ajax({
                            type: "get",
                            url: "pessoa?contas=" + document.getElementById('txtIdPessoa').value,
                            success: function (result) {
                                var rows = Array();

                                for (i = 0; i < result.length; i++) {
                                    var item = result[i];
                                    rows.push({ cell: [item.TP_CONTA, item.NRO_CONTA, item.DV_CONTA, item.DS_BANCO, item.CD_AGENCIA, item.DV_AGENCIA, item.FL_CONTA_PRINCIPAL, ''] });
                                }
                                pessoas = { total: result.length, page: 1, rows: rows }

                                $("#flexContas").flexAddData(pessoas);

                            }
                        });

                    }
                });
            });

        });

    </script>

    <div id="Pessoa" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable" style="outline: 0px none; z-index: 1003; height: 600px; width: 960px; top: 100px; left: 260px; display: none;" tabindex="-1" role="dialog" aria-labelledby="ui-id-7">
        <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> Cadastro Pessoas </div>
        <div id="Div2" class="ui-dialog-content ui-widget-content" style="display: block; width: auto; min-height: 0px; height: 600px;" scrolltop="0" scrollleft="0">

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit">Tipo de Pessoa</label>
                <select id="cboTipoPessoa" style="width: 80px;" >
                  <option value="F">Física</option>
                  <option value="J">Jurídica</option>
                </select>
            </div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Nome </label>
                <input id="txtNomePessoa" style="width: 350px;" type="text" />
            </div>

            <div class="button-bar-inline">
                <button type="button" id="btnPesquisarPessoa" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Pesquisar</button>
                <button type="button" id="btnLimparPessoa" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Limpar</button>
                <button type="button" id="btnGravarPessoa" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Gravar</button>
                <button type="button" id="btnFecharPessoas" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Fechar</button>
            </div>

            <div class="clear"></div>

            <div id="pessoasGrid" class="frameResultado"  style="margin:10px 0px 10px 9px" ><table id="flexPessoas"> </table></div>

            <div class="clear"></div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> CPF/CNPJ </label>
                <input id="txtCPFPessoa" style="width: 100px;" type="text" />
            </div>

            <div class="button-bar-inline">
                <button type="button" id="btnAdicionarCPF" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Adicionar</button>
            </div>


            <div class="clear"></div>
            <div id="documentosGrid" class="frameResultado"  style="margin:10px 0px 10px 9px" ><table id="flexDocumentos"> </table></div>

            <div class="clear"></div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Endereço </label>
                <input id="txtEndereco" style="width: 200px;" type="text" />
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Complemento </label>
                <input id="txtComplemento" style="width: 150px;" type="text" />
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Bairro </label>
                <input id="txtBairro" style="width: 100px;" type="text" />
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Cidade </label>
                <input id="txtCidade" style="width: 100px;" type="text" />
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> UF </label>
                <input id="txtUF" style="width: 20px;" type="text" />
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> CEP </label>
                <input id="txtCEP" style="width: 70px;" type="text" />
            </div>

            <div class="button-bar-inline">
                <button type="button" id="btnAdicionarEnd" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Adicionar</button>
            </div>

            <div class="clear"></div>
            <div id="enderecosGrid" class="frameResultado"  style="margin:10px 0px 10px 9px" ><table id="flexEnderecos"> </table></div>

            <div class="clear"></div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Tipo da Conta </label>
                <select id="cboTipoConta" style="width: 100px;" >
                  <option value="1">Corrente</option>
                  <option value="2">Poupança</option>
                </select>
            </div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Banco </label>
                <select id="cboBanco" style="width: 200px;" >
                    <option value="0">000 - Banco Bankpar S.A.	</option>
                    <option value="1">001 - Banco do Brasil S.A.	</option>
                    <option value="3">003 - Banco da Amazônia S.A.	</option>
                    <option value="4">004 - Banco do Nordeste do Brasil S.A.	</option>
                    <option value="12">012 - Banco Standard de Investimentos S.A.	</option>
                    <option value="14">014 - Natixis Brasil S.A. Banco Múltiplo	</option>
                    <option value="17">017 - BNY MELLON	</option>
                    <option value="19">019 - Banco Azteca do Brasil S.A.	</option>
                    <option value="21">021 - BANESTES S.A. Banco do Estado do Espírito Santo	</option>
                    <option value="24">024 - Banco de Pernambuco S.A. - BANDEPE	</option>
                    <option value="25">025 - Banco Alfa S.A.	</option>
                    <option value="29">029 - Banco Banerj S.A.	</option>
                    <option value="33">033 - BANCO SANTANDER	</option>
                    <option value="36">036 - Banco Bradesco BBI S.A.	</option>
                    <option value="37">037 - Banco do Estado do Pará S.A.	</option>
                    <option value="39">039 - Banco do Estado do Piauí S.A. - BEP	</option>
                    <option value="40">040 - Banco Cargill S.A.	</option>
                    <option value="41">041 - Banco do Estado do Rio Grande do Sul S.A.	</option>
                    <option value="44">044 - Banco BVA S.A.	</option>
                    <option value="45">045 - Banco Opportunity S.A.	</option>
                    <option value="47">047 - Banco do Estado de Sergipe S.A.	</option>
                    <option value="62">062 - Hipercard Banco Múltiplo S.A.	</option>
                    <option value="63">063 - Banco Ibi S.A. Banco Múltiplo	</option>
                    <option value="64">064 - Goldman Sachs do Brasil Banco Múltiplo S.A.	</option>
                    <option value="65">065 - Banco Bracce S.A.	</option>
                    <option value="66">066 - Banco Morgan Stanley S.A.	</option>
                    <option value="69">069 - BPN Brasil Banco Múltiplo S.A.	</option>
                    <option value="70">070 - BRB - Banco de Brasília S.A.	</option>
                    <option value="72">072 - Banco Rural Mais S.A.	</option>
                    <option value="73">073 - BB Banco Popular do Brasil S.A.	</option>
                    <option value="74">074 - Banco J. Safra S.A.	</option>
                    <option value="75">075 - Banco CR2 S.A.	</option>
                    <option value="76">076 - Banco KDB S.A.	</option>
                    <option value="78">078 - BES Investimento do Brasil S.A.	</option>
                    <option value="79">079 - JBS Banco S.A.	</option>
                    <option value="84">084 - Unicred Norte do Paraná	</option>
                    <option value="96">096 - Banco BM de Serviços de Liquidação e Custódia S.A	</option>
                    <option value="100">100 - TRANSITÓRIA	</option>
                    <option value="101">101 - Adiantamento de Despesas	</option>
                    <option value="102">102 - FORNECEDORES	</option>
                    <option value="104">104 - Caixa Econômica Federal	</option>
                    <option value="107">107 - Banco BBM S.A.	</option>
                    <option value="168">168 - HSBC Finance (Brasil) S.A. - Banco Múltiplo	</option>
                    <option value="184">184 - Banco Itaú BBA S.A.	</option>
                    <option value="204">204 - Banco Bradesco Cartões S.A.	</option>
                    <option value="208">208 - Banco BTG Pactual S.A.	</option>
                    <option value="212">212 - Banco Matone S.A.	</option>
                    <option value="213">213 - Banco Arbi S.A.	</option>
                    <option value="214">214 - Banco Dibens S.A.	</option>
                    <option value="215">215 - Banco Comercial e de Investimento Sudameris S.A.	</option>
                    <option value="217">217 - Banco John Deere S.A.	</option>
                    <option value="218">218 - Banco Bonsucesso S.A.	</option>
                    <option value="222">222 - Banco Credit Agricole Brasil S.A.	</option>
                    <option value="224">224 - Banco Fibra S.A.	</option>
                    <option value="225">225 - Banco Brascan S.A.	</option>
                    <option value="229">229 - Banco Cruzeiro do Sul S.A.	</option>
                    <option value="230">230 - Unicard Banco Múltiplo S.A.	</option>
                    <option value="233">233 - Banco GE Capital S.A.	</option>
                    <option value="237">237 - BANCO BRADESCO	</option>
                    <option value="241">241 - Banco Clássico S.A.	</option>
                    <option value="243">243 - Banco Máxima S.A.	</option>
                    <option value="246">246 - Banco ABC Brasil S.A.	</option>
                    <option value="248">248 - Banco Boavista Interatlântico S.A.	</option>
                    <option value="249">249 - Banco Investcred Unibanco S.A.	</option>
                    <option value="250">250 - Banco Schahin S.A.	</option>
                    <option value="254">254 - Paraná Banco S.A.	</option>
                    <option value="263">263 - Banco Cacique S.A.	</option>
                    <option value="265">265 - Banco Fator S.A.	</option>
                    <option value="266">266 - Banco Cédula S.A.	</option>
                    <option value="300">300 - Banco de La Nacion Argentina	</option>
                    <option value="318">318 - Banco BMG S.A.	</option>
                    <option value="320">320 - Banco Industrial e Comercial S.A.	</option>
                    <option value="341">341 - BANCO ITAU S/A.	</option>
                    <option value="356">356 - Banco Real S.A.	</option>
                    <option value="366">366 - Banco Société Générale Brasil S.A.	</option>
                    <option value="370">370 - Banco WestLB do Brasil S.A.	</option>
                    <option value="376">376 - Banco J. P. Morgan S.A.	</option>
                    <option value="389">389 - Banco Mercantil do Brasil S.A.	</option>
                    <option value="394">394 - Banco Bradesco Financiamentos S.A.	</option>
                    <option value="399">399 - HSBC Bank Brasil S.A. - Banco Múltiplo	</option>
                    <option value="409">409 - UNIBANCO - União de Bancos Brasileiros S.A.	</option>
                    <option value="412">412 - Banco Capital S.A.	</option>
                    <option value="422">422 - Banco Safra S.A.	</option>
                    <option value="453">453 - Banco Rural S.A.	</option>
                    <option value="456">456 - Banco de Tokyo-Mitsubishi UFJ Brasil S.A.	</option>
                    <option value="464">464 - Banco Sumitomo Mitsui Brasileiro S.A.	</option>
                    <option value="473">473 - Banco Caixa Geral - Brasil S.A.	</option>
                    <option value="477">477 - Citibank N.A.	</option>
                    <option value="479">479 - Banco ItaúBank S.A	</option>
                    <option value="487">487 - Deutsche Bank S.A. - Banco Alemão	</option>
                    <option value="488">488 - JPMorgan Chase Bank	</option>
                    <option value="492">492 - ING Bank N.V.	</option>
                    <option value="494">494 - Banco de La Republica Oriental del Uruguay	</option>
                    <option value="495">495 - Banco de La Provincia de Buenos Aires	</option>
                    <option value="505">505 - Banco Credit Suisse (Brasil) S.A.	</option>
                    <option value="600">600 - Banco Luso Brasileiro S.A.	</option>
                    <option value="604">604 - Banco Industrial do Brasil S.A.	</option>
                    <option value="610">610 - Banco VR S.A.	</option>
                    <option value="611">611 - Banco Paulista S.A.	</option>
                    <option value="612">612 - Banco Guanabara S.A.	</option>
                    <option value="613">613 - Banco Pecúnia S.A.	</option>
                    <option value="623">623 - Banco Panamericano S.A.	</option>
                    <option value="626">626 - Banco Ficsa S.A.	</option>
                    <option value="630">630 - Banco Intercap S.A.	</option>
                    <option value="633">633 - Banco Rendimento S.A.	</option>
                    <option value="634">634 - Banco Triângulo S.A.	</option>
                    <option value="637">637 - Banco Sofisa S.A.	</option>
                    <option value="638">638 - Banco Prosper S.A.	</option>
                    <option value="641">641 - Banco Alvorada S.A.	</option>
                    <option value="643">643 - Banco Pine S.A.	</option>
                    <option value="652">652 - Itaú Unibanco Holding S.A.	</option>
                    <option value="653">653 - Banco Indusval S.A.	</option>
                    <option value="654">654 - Banco A.J.Renner S.A.	</option>
                    <option value="655">655 - Banco Votorantim S.A.	</option>
                    <option value="707">707 - Banco Daycoval S.A.	</option>
                    <option value="719">719 - Banif-Banco Internacional do Funchal (Brasil)S.A.	</option>
                    <option value="721">721 - Banco Credibel S.A.	</option>
                    <option value="724">724 - Banco Porto Seguro S.A.	</option>
                    <option value="734">734 - Banco Gerdau S.A.	</option>
                    <option value="735">735 - Banco Pottencial S.A.	</option>
                    <option value="738">738 - Banco Morada S.A.	</option>
                    <option value="739">739 - Banco BGN S.A.	</option>
                    <option value="740">740 - Banco Barclays S.A.	</option>
                    <option value="741">741 - Banco Ribeirão Preto S.A.	</option>
                    <option value="743">743 - Banco Semear S.A.	</option>
                    <option value="744">744 - BankBoston N.A.	</option>
                    <option value="745">745 - Banco Citibank S.A.	</option>
                    <option value="746">746 - Banco Modal S.A.	</option>
                    <option value="747">747 - Banco Rabobank International Brasil S.A.	</option>
                    <option value="748">748 - Banco Cooperativo Sicredi S.A.	</option>
                    <option value="749">749 - Banco Simples S.A.	</option>
                    <option value="751">751 - Dresdner Bank Brasil S.A. - Banco Múltiplo	</option>
                    <option value="752">752 - Banco BNP Paribas Brasil S.A.	</option>
                    <option value="753">753 - NBC Bank Brasil S.A. - Banco Múltiplo	</option>
                    <option value="755">755 - Bank of America Merrill Lynch Banco Múltiplo S.A.	</option>
                    <option value="756">756 - Banco Cooperativo do Brasil S.A. - BANCOOB	</option>
                    <option value="757">757 - Banco KEB do Brasil S.A.	</option>
                </select>
            </div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Agencia </label>
                <input id="txtAgencia" style="width: 50px;" type="text" />
            </div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> DV </label>
                <input id="txtAgenciaDV" style="width: 20px;" type="text" />
            </div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Número </label>
                <input id="txtConta" style="width: 50px;" type="text" />
            </div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> DV </label>
                <input id="txtContaDV" style="width: 20px;" type="text" />
            </div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Principal </label>
                <input id="chkPrincipal" type="checkbox" />
            </div>

            <div class="button-bar-inline">
                <button type="button" id="btnAdicionarConta" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Adicionar</button>
            </div>


            <div class="clear"></div>
            <div id="contasGrid" class="frameResultado"  style="margin:10px 0px 10px 9px" ><table id="flexContas"> </table></div>


        </div>
    </div>

    <div id="beneficiarios" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable" style="outline: 0px none; z-index: 1002; height: 600px; width: 695px; top: 173px; left: 438.5px; display: none;" tabindex="-1" role="dialog" aria-labelledby="ui-id-7">
        <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> Beneficiários </div>
        <div id="editDialogItem" class="ui-dialog-content ui-widget-content" style="display: block; width: auto; min-height: 0px; height: 550px;" scrolltop="0" scrollleft="0">
            <input id="txtIdPessoa" type="hidden" />
            <input id="txtIdDocto" type="hidden" />
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> CPF / CNPJ </label>
                <input id="txtCPF" class="w200" type="text" value="" onblur="pesquisarBeneficiario();"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Nome </label>
                <input id="txtNome" style="width: 410px;" type="text" value="" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Parentesco </label>
                <select id="cboParentesco" style="width: 205px;" >
                  <option value="NULL">...</option>
                  <option value="1">TITULAR</option>
                  <option value="2">CONJUGE</option>
                  <option value="3">FILHO</option>
                  <option value="4">MAE</option>
                  <option value="5">PAI</option>
                  <option value="6">AVO</option>
                  <option value="99">OUTROS</option>
                </select>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Conta Bancária </label>
                <select id="cboConta" style="width: 230px;"  >
                </select>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Participação </label>
                <input id="txtParticipacao" style="width: 50px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>
            <div class="button-bar-inline-right">
                <button type="button" id="btnAdicionarBeneficiario" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false" >Adicionar</button>
            </div>
            <div class="clear"></div>

            <div class="button-bar-inline-right">
                <button type="button" id="btnEstipulante" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Dados Estipulante</button>
                <button type="button" id="btnCadastroPessoa" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Cadastro de Pessoas</button>
                <button type="button" id="btnLimparBeneficiarios" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Limpar Lista de Beneficiários</button>
            </div>

            <div class="clear"></div>

            <div id="beneficiariosGrid" class="frameResultado" ><table id="flex1"> </table></div>

            <div class="clear"></div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Reserva Disponível </label>
                <!--input id="txtReserva" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/-->
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Indenização </label>
                <input id="txtReserva" style="width: 160px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Honorários </label>
                <input id="txtReservaHon" style="width: 160px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>
            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Despesas </label>
                <input id="txtReservaDesp" style="width: 160px;" type="text" value="" name="Itens_DsObjSeguradoEdit" disabled="disabled"/>
            </div>

            <div class="clear"></div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Comentário Pagamento </label>
                <textarea id="txtComentario" cols="89" rows="5" style="height: 100px;" ></textarea>
            </div>

            <div class="clear"></div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Valor a Ser Liquidado </label>
                <input id="txtValorLiquidacao" style="width: 100px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>

           <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Data de Pagto </label>
                <input id="txtDtPagto" style="width: 60px;" type="text" value="" name="Itens_DsObjSeguradoEdit"/>
            </div>

            <div class="cell-wizard">
                <label for="Itens_DsObjSeguradoEdit"> Tipo </label>
                <select id="cboTipoLiquidacao" style="width: 150px;" >
                  <option value="1">Indenização</option>
                  <option value="2">Honorário</option>
                  <option value="3">Despesa</option>
                </select>
                <input id="chkBoleto" type="checkbox"/>Boleto Bancário
                <input id="chkBordero" type="checkbox"/>Borderô
                <input id="chkGoverno" type="checkbox"/>Governo
                <input id="chkRetencaoImpostos" type="checkbox"/>Com Retenção de Impostos
             </div>

            <div class="button-bar-inline-right">
                <button type="button" id="btnGravarLiq" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button" aria-disabled="false">Gravar Liquidação</button>
                <button type="button" id="btnCancelarBeneficiario" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" >Cancelar</button>
            </div>

        </div>
    </div>

    <div id="docUpload" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable" style="outline: 0px none; z-index: 1002; height: auto; width: 1106px; top: 0px; left: 300px; display: none;" tabindex="-1" role="dialog" aria-labelledby="ui-id-7">
        <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> Importar Documento </div>
        <div id="Div1" class="ui-dialog-content ui-widget-content" style="display: block; width: auto; min-height: 0px; height: 100%;" scrolltop="0" scrollleft="0">
<iframe id="frmImagem" src="docImp.aspx" height="100%" width="100%" frameborder="0"></iframe>        
    </div>
    </div>

    <div id="docView" class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable" style="outline: 0px none; z-index: 1002; height: auto; width: 1106px; top: 0px; left: 300px; display: none;" tabindex="-1" role="dialog" aria-labelledby="ui-id-7">
        <div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix"> Visualizar Documento </div>
        <div id="Div4" class="ui-dialog-content ui-widget-content" style="display: block; width: auto; min-height: 0px; height: 100%;" scrolltop="0" scrollleft="0">
            <table style="border-style:none; width=100%;" >
                <tr><td style="width:99%"></td><td align="right"><input type="button" id="btFechar" value="Fechar" onclick="FecharImg();" /></td></tr>
                <tr><td colspan="2" align="center">
                    <img id="imgDoc" src="" alt="" /></td>   
                </tr>
            </table>  
        </div>
    </div>

    <div id="overlay" class="ui-widget-overlay" style="width: 1583px; height: 950px; z-index: 1001; display: none;"></div>

    </form>


</body>
</html>
