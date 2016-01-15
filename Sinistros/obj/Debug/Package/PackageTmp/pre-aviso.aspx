<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="preaviso.aspx" Inherits="Sinistros.login" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />

    <title>..:: SinistroWeb ::..</title>

    <link type="text/css" href="/Content/css/main.css" rel="stylesheet" />
    <link type="text/css" href="/Content/css/jquery-ui-1.8.22.custom.css" rel="stylesheet" />

    <script src="/Scripts/jquery/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery-ui-1.9.1.custom.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery-blockUI.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery.notice.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery-manager-error.js" type="text/javascript"></script>
    <script src="/Scripts/commons.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery-timerpicker.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/tmpl.min.js" type="text/javascript"></script>
    <script src="/Scripts/FileUpload/canvas-to-blob.min.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery.wizard.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery-percent.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery.qtip.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery.form.json.js" type="text/javascript"></script>
    <script src="/Scripts/json2.js" type="text/javascript"></script>
    <script src="/Scripts/menu.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery.decimalMask.js" type="text/javascript"></script>
    <script src="/Scripts/jquery/jquery.maskedinput-1.2.2.js" type="text/javascript"></script>

    <style type="text/css">
        textarea {height:5em;}
    </style>

    <script type="text/javascript">
        $(document).ajaxStart(function () {
            $.blockUI({ overlayCSS: { opacity: .2 }, message: '<img src="/Content/images/main/loading.gif") />' });
        }).ajaxStop($.unblockUI);
    </script>

    <script type="text/javascript">

        $(document).ready(function () {
            datepickerBR('#tDtOcorrencia');

            $('#btnVoltar').button({
                icons: {
                    primary: "ui-icon-key"
                },
                text: true
            }).click(function () {
                $(location).attr('href', 'avisar_sinistro.aspx');
            });

            $('#btnConfirmar').button({
                icons: {
                    primary: "ui-icon-key"
                },
                text: true
            }).click(function () {

                if (!validarCPF(document.getElementById('tCpf').value)) {
                    if (!validarCNPJ(document.getElementById('tCpf').value)) {
                        return;
                    }
                }

                if (ValidarUsuario()) {

                    if (document.getElementById('rTelefone').checked) {
                        var x = 1;
                    } else { x = 2 }

                    //var x = document.getElementById('rTelefone').value == "on" ? "1" : "2";

                    $.ajax({
                        type: "get",
                        contentType: "application/json",
                        url: "sinistro?preaviso=" + document.getElementById('tNome').value + '$' +
                        document.getElementById('tCpf').value + '$' +
                        'to_date(' + document.getElementById('tDtOcorrencia').value + ', dd/mm/yyyy)$' +
                        document.getElementById('tDescricao').value.replace(/\$/g, '^').replace(/\@/g, '~') + '$' +
                        document.getElementById('tComprou').value.replace(/\$/g, '^').replace(/\@/g, '~') + '$' +
                        document.getElementById('tCertificado').value + '$' +
                        document.getElementById('tCobertura').value.replace(/\$/g, '^').replace(/\@/g, '~') + '$' +
                        document.getElementById('tTelefone').value + '$' +
                        document.getElementById('tEmail').value.replace('@', '@@') + '$' +
                        x + '$' +
                        document.getElementById('tReclamante').value,
                        data: "{}",
                        dataType: 'json',

                        error: function (xhr, status, error) {
                            var err = eval("(" + xhr.responseText + ")");
                            alert(err.ExceptionMessage);
                        },

                        success: function (result) {
                            
                            //Verificar porque o numero do preaviso esta aparecendo -1 na tela
                            alert("Pré-Aviso Cadastrado com Sucesso Numero: " + result);
                            location.reload();
                        }
                    });
                }
            });
        });

        function ValidarUsuario() {
            var isValid = true;

            if ($('#tNome').val() == '') {
                isValid = false;
                $('#tNome').mgrerror();
            }

            if ($('#tCpf').val() == '') {
                isValid = false;
                $('#tCpf').mgrerror();
            }

            if ($('#tData').val() == '') {
                isValid = false;
                $('#tData').mgrerror();
            }

            if ($('#tDescricao').val() == '') {
                isValid = false;
                $('#tDescricao').mgrerror();
            }

            if ($('#tComprou').val() == '') {
                isValid = false;
                $('#tComprou').mgrerror();
            }

            if ($('#tCobertura').val() == '') {
                isValid = false;
                $('#tCobertura').mgrerror();
            }

            if ($('#tTelefone').val() == '') {
                isValid = false;
                $('#tTelefone').mgrerror();
            }

            if ($('#tEmail').val() == '') {
                isValid = false;
                $('#tEmail').mgrerror();
            }

            if (isValid) {

                var formJson = {
                    Nome: $('#tNome').val(),
                    Reclamante: $('#tReclamante').val(),
                    Cpf: $('#tCpf').val(),
                    Data: $('#tData').val(),
                    Descricao: $('#tDescricao').val(),
                    Comprou: $('#tComprou').val(),
                    Certificado: $('#tCertificado').val(),
                    Cobertura: $('#tCobertura').val(),
                    Telefone: $('#tTelefone').val(),
                    Email: $('#tEmail').val(),
                    Escolha: $("[name='cEscolha']").val()
                }
            }
            else {
                growlError(MENSAGEM_REQUERIDO);
            }
            return isValid;
        }

        function validarCNPJ(cnpj) {

            cnpj = cnpj.replace(/[^\d]+/g, '');

            if (cnpj == '') {
                alert('CNPJ ou CPF Invalido');
                return false;
            }

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
		cnpj == "99999999999999") {
                alert('CNPJ ou CPF Invalido');
                return false;
            }

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
            if (resultado != digitos.charAt(0)) {
                alert('CNPJ ou CPF Invalido');
                return false;
            }

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
            if (resultado != digitos.charAt(1)) {
                alert('CNPJ ou CPF Invalido');
                return false;
            }

            return true;

        }

        function validarCPF(cpf) {
            cpf = cpf.replace(/[^\d]+/g, '');
            if (cpf == '') return false;
            // Elimina CPFs invalidos conhecidos    
            if (cpf.length != 11 || cpf == "00000000000" || cpf == "11111111111" || cpf == "22222222222" || cpf == "33333333333" || cpf == "44444444444" || cpf == "55555555555" || cpf == "66666666666" || cpf == "77777777777" || cpf == "88888888888" || cpf == "99999999999") {
                alert('CNPJ ou CPF Invalido');
                return false;
            }

            // Valida 1o digito 
            add = 0;
            for (i = 0; i < 9; i++)
                add += parseInt(cpf.charAt(i)) * (10 - i);
            rev = 11 - (add % 11);
            if (rev == 10 || rev == 11) rev = 0;
            if (rev != parseInt(cpf.charAt(9))) {
                alert('CNPJ ou CPF Invalido');
                return false;
            }

            // Valida 2o digito 
            add = 0;
            for (i = 0; i < 10; i++) add += parseInt(cpf.charAt(i)) * (11 - i);
            rev = 11 - (add % 11);
            if (rev == 10 || rev == 11) rev = 0;
            if (rev != parseInt(cpf.charAt(10))) {
                alert('CNPJ ou CPF Invalido');
                return false;
            }
            return true;
        }

    </script>
</head>
<body>
    <div id="container">
        <div class="topo" id="topo">
            <p>&nbsp;&nbsp;&nbsp;<img src="css/images/logo_qbe.jpg" alt="logo" /></p>
        </div>

        <div id="infoTop" class="left" align="right" style="float: right">
            <p style="color: Black">Versão: 2.5.1</p>
        </div>

        <div id="container_body">

            <div id="title">
                <h3>Pré-Aviso</h3>
            </div>

            <div class="frame">
                <form id="frmPreAviso" action="#">

                    <div class="cell">
                        <label for="tNome">Nome do Segurado</label>
                        <input class="w280" id="tNome" name="cNome" type="text" />
                    </div>
                    <div class="clear"></div>

                    <div class="cell">
                        <label for="tNome">Nome do Reclamante</label>
                        <input class="w280" id="tReclamante" name="cReclamante" type="text" />
                    </div>
                    <div class="clear"></div>

                    <div class="cell">
                        <label for="tCpf">CPF/CNPJ</label>
                        <input class="w130" id="tCpf" name="cCpf" type="text" onchange="validarCPF(this.value),validarCNPJ(this.value)" />
                    </div>
                    <div class="clear"></div>

                    <div class="cell">
                        <label for="tDtOcorrencia">Data da Ocorrência do Sinistro</label>
                        <input class="w75" id="tDtOcorrencia" name="cDtOcorrencia" type="text" />
                    </div>
                    <div class="clear"></div>

                    <div class="cell">
                        <label for="tDescricao">O que Aconteceu</label>
                        <textarea class="w280" id="tDescricao" name="cDescricao" cols="40" rows="20"></textarea>
                    </div>
                    <div class="clear"></div>

                    <div class="cell">
                        <label for="tComprou">Onde ele Comprou</label>
                        <input class="w280" id="tComprou" name="cComprou" type="text" maxlength="50"/>
                    </div>
                    <div class="clear"></div>

                    <div class="cell">
                        <label for="tCertificado">Numero do Certificado</label>
                        <input class="w280" id="tCertificado" name="cCertificado" type="text" maxlength="50" />
                    </div>
                    <div class="clear"></div>

                    <div class="cell">
                        <label for="tCobertura">Descrição da Cobertura</label>
                        <input class="w280" id="tCobertura" name="cCobertura" type="text" maxlength="50" />
                    </div>
                    <div class="clear"></div>
                    
                    <div class="cell">
                        <label for="tTelefone">Telefone de Contato</label>
                        <input class="w150" id="tTelefone" name="cTelefone" type="text" maxlength="15"/>
                    </div>
                    <div class="clear"></div>

                    <div class="cell">
                        <label for="tEmail">E-mail de Contato</label>
                        <input class="w280" id="tEmail" name="cEmail" type="text"/>
                    </div>
                    <div class="clear"></div>

                    <fieldset id="Escolha" class="cell">
                        <legend>
                            <label style="color: black;">Por Onde Deseja ser Contactado</label>
                        </legend>
                        <label>
                            <input type="radio" id="rTelefone" name="cEscolha" checked="checked" />Telefone
                            <input type="radio" id="rEmail" name="cEscolha" />E-mail
                        </label>
                    </fieldset>
                    <div class="clear"></div>

                    
                    <div class="cell">
                        <button type="button" id="btnConfirmar">Confirmar</button>
                    </div>
                    
                    <div class="cell" style="float:right">
                        <button type="button" id="btnVoltar">Voltar</button>
                    </div>
                    <div class="clear"></div>
                    
                </form>
            </div>
        </div>
    </div>
</body>
</html>


