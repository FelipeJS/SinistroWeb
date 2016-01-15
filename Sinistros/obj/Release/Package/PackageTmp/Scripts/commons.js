/*
    CONST
*/
var MENSAGEM_REQUERIDO = "Preencha todos os campos em vermelho para realizar esta ação.";
var MENSAGEM_ERRO = "Ocorreu um erro ao tentar realizar esta ação.";
var MENSAGEM_SEL_LINHA = "Selecione uma linha para realizar esta ação.";

/*
    TOOLTIP
*/
function growl(texto, type, tempoExibicao) {
    $.noticeAdd({
        text: texto,
        stayTime: (!isNullOrEmpty(tempoExibicao)) ? tempoExibicao : 5000,
        stay: false,
        type: type
    });
}

function growlError(texto, tempoExibicao) {
    growl(texto, "error", tempoExibicao);
}

function growlSuccess(texto, tempoExibicao) {
    growl(texto, "success", tempoExibicao);
}

function growlInfo(texto, tempoExibicao) {
    growl(texto, "notice", tempoExibicao);
}

function growlWarning(texto, tempoExibicao) {
    growl(texto, "warning", tempoExibicao);
}

/*
    FORMULÁRIO
*/


function resetForm(seletor, resetHidden) {
    $(':input', seletor).each(function () {
        if (this.type == 'select-one')
            this.value = "";
        else if (this.type == 'text')
            this.value = "";
        else if (this.type == 'checkbox')
            this.checked = false;
        else if (this.type == 'hidden') {
            if (resetHidden) {
                this.value = "";
            }
        }
        $(this).removeClass('input-validation-error');
    });
}

/*
    MÁSCARA
*/

var decimalPrecision = 0;
function maskCurrency(seletor, precisao) {
    $(seletor).maskMoney({
        symbol: "R$",
        showSymbol: true,
        decimal: ",",
        precision: isNullOrEmpty(precisao) ? decimalPrecision : precisao, 
        thousands: ".",
        allowZero: true, 
        defaultZero: false 
    });
}

function maskDecimal(seletor, precisao, max) {
    $(seletor).maskMoney({
        showSymbol: false,
        decimal: ",",
        precision: isNullOrEmpty(precisao) ? decimalPrecision : precisao,
        thousands: ".",
        allowZero: true,
        defaultZero: false,
        maxValue: max
    });
}

//INPUT VALIDATION
function NumberOnly(myfield, e, dec) {
    var key;
    var keychar;

    if (window.event)
        key = window.event.keyCode;
    else if (e)
        key = e.which;
    else
        return true;
    keychar = String.fromCharCode(key);

    // control keys
    if ((key == null) || (key == 0) || (key == 8) ||
    (key == 9) || (key == 13) || (key == 27))
        return true;

    // numbers
    else if ((("0123456789").indexOf(keychar) > -1))
        return true;

    // decimal point jump
    else if (dec && (keychar == ".")) {
        myfield.form.elements[dec].focus();
        return true;
    }
    else
        return false;
}

/*
    STRING
*/

function isNullOrEmpty(string) {
    return (string == null || string == "");
}

function replaceAll(string, token, newtoken) {
	while (string.indexOf(token) != -1) {
 		string = string.replace(token, newtoken);
	}
	return string;
}

/*
    DATE
*/
var varRangedDatePickerBR = {

    dateFormat: 'dd/mm/yy',
    changeMonth: true,
    changeYear: true,
    dayNames: ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'],
    dayNamesMin: ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'],
    dayNamesShort: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'],
    monthNames: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
    monthNamesShort: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
    nextText: '>>',
    prevText: '<<',
    defaultDate: +0

};

var varDatePickerBR = {

    dateFormat: 'dd/mm/yy',
    changeMonth: true,
    changeYear: true,
    dayNames: ['Domingo', 'Segunda', 'Terça', 'Quarta', 'Quinta', 'Sexta', 'Sábado'],
    dayNamesMin: ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'],
    dayNamesShort: ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'],
    monthNames: ['Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'],
    monthNamesShort: ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'],
    nextText: '>>',
    prevText: '<<',
    defaultDate: +0

};
//funcao calendário simples
function datepickerBR(seletor) {
    $(seletor).change(function () {
        validateData($(this));
    });
    $(seletor).addClass('w65');
    //máscara para fazer pré-validação dos dados digitados. 
    $.mask = {
        definitions: {
            '3': "[0-3]",
            '9': "[0-9]",
            '1': "[0-1]"
        }
    };
    $(seletor).mask("39/19/9999");
    
    $(seletor).datepicker(varDatePickerBR);
    $(seletor).click(function () {
        $(this).datepicker("show");
    });

}

//função calendário para dois campos data(período)
function rangeDatepickerBR(seletorDe, seletorAte) {

    //datepickerBR(seletorDe);
    //datepickerBR(seletorAte);

    $.mask = {
        definitions: {
            '3': "[0-3]",
            '9': "[0-9]",
            '1': "[0-1]"
        }
    };

    $(seletorDe).addClass('w65').mask("39/19/9999");
    $(seletorAte).addClass('w65').mask("39/19/9999");

    $(seletorDe).change(function () {
        if ($(seletorDe).val().length != 10) {
            $(seletorDe).val();
        }
    });
    
    var strSeletor = seletorDe + "," + seletorAte;
    varRangedDatePickerBR.onSelect = function (selectedDate) {
        var option = this.id == seletorDe.substring(1, seletorDe.length) ? "minDate" : "maxDate",
					                    instance = $(this).data("datepicker"),
					                    date = $.datepicker.parseDate(
						                    instance.settings.dateFormat ||
						                    $.datepicker._defaults.dateFormat,
						                    selectedDate, instance.settings);
        dates.not(this).datepicker("option", option, date);
    }

    var dates = $(strSeletor).datepicker(varRangedDatePickerBR);
}

function rangeDateTimePicker(startDateTextBox, endDateTextBox) {

    var startDateTextBox = $(startDateTextBox);
    var endDateTextBox = $(endDateTextBox);

    startDateTextBox.datetimepicker({
        onClose: function (dateText, inst) {
            if (endDateTextBox.val() != '') {
                var testStartDate = startDateTextBox.datetimepicker('getDate');
                var testEndDate = endDateTextBox.datetimepicker('getDate');
                if (testStartDate > testEndDate)
                    endDateTextBox.datetimepicker('setDate', testStartDate);
            }
            else {
                endDateTextBox.val(dateText);
            }
        },
        onSelect: function (selectedDateTime) {
            endDateTextBox.datetimepicker('option', 'minDate', startDateTextBox.datetimepicker('getDate'));
        }
    });
    endDateTextBox.datetimepicker({
        onClose: function (dateText, inst) {
            if (startDateTextBox.val() != '') {
                var testStartDate = startDateTextBox.datetimepicker('getDate');
                var testEndDate = endDateTextBox.datetimepicker('getDate');
                if (testStartDate > testEndDate)
                    startDateTextBox.datetimepicker('setDate', testEndDate);
            }
            else {
                startDateTextBox.val(dateText);
            }
        },
        onSelect: function (selectedDateTime) {
            startDateTextBox.datetimepicker('option', 'maxDate', endDateTextBox.datetimepicker('getDate'));
        }
    });
}

function validateData(seletor) {

    var valor = seletor.val();
    if (valor) {
        $erro = "";
        //var expReg = /^((0[1-9]|[1-2][0-9]|3[0-1])\/(0[1-9]|1[0-2])\/2[0-9]\d{2})$/;
        var expReg = /^((0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[012])\/[1-2][0-9]\d{2})$/;
        if (valor.match(expReg)) {
            var $dia = parseFloat(valor.substring(0, 2));
            var $mes = parseFloat(valor.substring(3, 5));
            var $ano = parseFloat(valor.substring(6, 10));

            if (($mes == 4 && $dia > 30) || ($mes == 6 && $dia > 30) || ($mes == 9 && $dia > 30) || ($mes == 11 && $dia > 30)) {
                $erro = "Data incorreta. O mês especificado tem 30 dias.";
            } else {
                if ($ano % 4 != 0 && $mes == 2 && $dia > 28) {
                    $erro = "Data incorreta. O mês especificado tem 28 dias."
                } else {
                    if ($ano % 4 == 0 && $mes == 2 && $dia > 29) {
                        $erro = "Data incorreta. O mês especificado tem 29 dias.";
                    }
                }
            }
        } else {
            $erro = "Formato de Data para " + valor + " é inválido";
        }
        if ($erro) {
            seletor.val('');
            growlError($erro);
            setTimeout(function () { seletor.focus(); }, 50);
        } else {
            return seletor;
        }
    } else {
        return seletor;
    }

}

function toolTipText(seletor, texto) {
    $(seletor).qtip({
        content: texto,
        show: 'mouseover',
        hide: 'mouseout',
        position: {
            corner: {
                target: 'topMiddle',
                tooltip: 'bottomLeft'
            }
        },
        style: {
            border: {
                color: '#009AE4',
                width: 2
            },
            tip: 'bottomLeft',
            name: 'light',
            content: { 'font-size': '8px' }
        }

    })
}

function formToJson(seletorForm) {
    if (seletorForm == null) {
        alert("Informe o seletor pai dos campos que serão \"parseados\"");
        return;
    }        
    var $inputs = $(seletorForm + ' :input');
    var x = '{';
    $inputs.each(function () {
        var inc = true;
        var o = $(this);
        var i = o.attr('id');
        var t = o.attr('type');
        var v = null;
        if (t == 'checkbox') {
            v = o.attr('checked') == 'checked' ? true : false;
            inc = true;
        } else if (t == 'radio') {
            if (o.attr('checked') == 'checked') {
                i = o.attr('name');
                v = o.val();
                inc = true;
            } else {
                inc = false;
            }
        } else if (t == 'text') {
            v = replaceAll(o.val(), '"', '');
            inc = true;
        } else if (t == 'button' || t == 'submit') {
            inc = false;
        } else {
            v = o.val();
            inc = true;
        }
        if (inc) x = x + '"' + i + '":"' + v + '",';
    });            
    x = x.substring(0, (x.length - 1));
    x = x + '}';

    if (x == '}') {
        alert('Não foi encontrado nenhum elemento de formulário em ' + seletorForm);
        return;
    }

    try {
        var j = $.parseJSON(x);
        return j;
    } catch (e) {
        alert('Não foi possível gerar o Objeto Json.');
        return null;
    }                           
                      
}

function addErrorStyle(seletor) {
    $(seletor).attr('style', 'border: 1px solid #FF0000');
}

function removeErrorStyle(seletor) {
    if ($(seletor).val() != '') {
        $(seletor).attr('style', 'border: 1px solid #999');
    }
}

function trataMensagemRetorno(obj) {
    var completeSuccess = false;
    if (obj != null) {        
        switch (obj.Tipo) {
            case 0:
                growlError(obj.Mensagem, calculaTempoMensagemRetorno(obj));
                completeSuccess = false;
                break;
            case 1:
                growlInfo(obj.Mensagem, calculaTempoMensagemRetorno(obj));
                completeSuccess = true;
                break;

            case 2:
                growlWarning(obj.Mensagem, calculaTempoMensagemRetorno(obj));
                completeSuccess = true;
                break;
        }
    }
    return completeSuccess;
}

function calculaTempoMensagemRetorno(obj) {

    var tempoRetorno = 0;

    if (obj.Mensagem.length >= 200)
        tempoRetorno = 10000;
    else if (obj.Mensagem.length >= 100)
        tempoRetorno = 7500;
    else if (obj.Mensagem.length >= 50)
        tempoRetorno = 2500;
    else
        tempoRetorno = 1500;

    return tempoRetorno;
}

function alterFieldState(form, disabled) {

    var $input = $(form).find('input,select');
    $input.each(function () {
        if (!$(this).hasClass('preserveState')) {
            if (disabled) 
            {
                $(this).attr('disabled', 'disabled');
            }
            else 
            {
                $(this).removeAttr('disabled');
            }
        }
    });

    var $buttons = $(form).find('button');
    $buttons.each(function () {
        if (!$(this).hasClass('preserveState')) {
            if (disabled) {
                $(this).button('disable').attr('disabled', 'disabled');
            }
            else {
                $(this).button('enable').removeAttr('disabled');
            }
        }
    });

    var $uploads = $(form).find('.fileUpload');

    $uploads.each(function () {
        if (!$(this).hasClass('preserveState')) {
            if (disabled) 
            {
                $(this).fileupload('disable');
            }
            else 
            {
                $(this).fileupload('enable');
            }
        }
    });

    var $fileinput =  $(form).find('.fileinput-button');

    $fileinput.each(function () {
        if (!$(this).hasClass('preserveState')) {
            if (disabled) {
                $(this).button('disable');
            }
            else {
                $(this).button('disable');
            }
        }
    });
}

function alterFieldTypeState(form,tipo, disabled) 
{
    
    switch(tipo)
    {
        case 1:

            var $input = $(form).find('input,select');
            $input.each(function () {
                if (!$(this).hasClass('preserveState')) {
                    if (disabled) {
                        $(this).attr('disabled', 'disabled');
                    }
                    else {
                        $(this).removeAttr('disabled');
                    }
                }
            });
            break;

        case 2:

            var $buttons = $(form).find('button');
            $buttons.each(function () {
                if (!$(this).hasClass('preserveState')) {
                    if (disabled) {
                        $(this).attr('disabled', 'disabled');
                    }
                    else {
                        $(this).removeAttr('disabled');
                    }
                }
            });

            var $buttons = $(form).find('.ui-button');
            $buttons.each(function () {
                if (!$(this).hasClass('preserveState')) {
                    if (disabled) {
                        $(this).button('disable');
                    }
                    else {
                        $(this).button('enable');
                    }
                }
            });

            break;
        case 3:

            var $uploads = $(form).find('.fileUpload');

            $uploads.each(function () {
                if (!$(this).hasClass('preserveState')) {
                    if (disabled) {
                        $(this).fileupload('disable');
                    }
                    else {
                        $(this).fileupload('enable');
                    }
                }
            });

            break;
        case 4:

            var $fileinput = $(form).find('.fileinput-button');

            $fileinput.each(function () {
                if (!$(this).hasClass('preserveState')) {
                    if (disabled) {
                        $(this).button('disable');
                    }
                    else {
                        $(this).button('disable');
                    }
                }
            });

            break;
    }
}

function  getTextFromSelect(seletor,defaultText) {
    var $input = $(seletor);
    var t = (defaultText != null && defaultText != '') ? defaultText : '----------';
    if ($input.is('select')) {
        return $input.val() != '' ? $(seletor + ' > option:selected').text() : t;
    } else {
        return defaultText;
    }
}

function getDataJson(data) {
    var regex = /-?\d+/;
    var m = regex.exec(data);
    var data = new Date(parseInt(m[0]))
    var day = "" + data.getDate();
    var month = data.getMonth() + 1;
    if ($.browser.msie && parseInt($.browser.version) < 9) //IE
    {
        var year = parseInt(data.getYear());
    }
    else {
        var year = 1900 + parseInt(data.getYear());
    }

    return (day.length == 1 ? ("0" + day) : day) + '/' + (month.length == 1 ? ("0" + month) : month) + '/' + year;
}

function mascaraDinheiro(campo) {

    var valor = $(campo).val();

    var strCheck = '0123456789';
    var len = valor.length;
    var a = '', t = '', neg = '';

    if (len != 0 && valor.charAt(0) == '-') {
        neg = '-';
    }

    if (len == 0) {
        t = '0.00';
    }

    for (var i = 0; i < len; i++) {
        if ((valor.charAt(i) != '0') && (valor.charAt(i) != ',')) break;
    }

    for (; i < len; i++) {
        if (strCheck.indexOf(valor.charAt(i)) != -1)
            a += valor.charAt(i);
    }

    var n = parseFloat(a);
    n = isNaN(n) ? 0 : n / Math.pow(10, 2);
    t = n.toFixed(2);

    i = 1;
    var p, d = (t = t.split('.'))[i].substr(0, 2);
    for (p = (t = t[0]).length; (p -= 3) >= 1; ) {
        t = t.substr(0, p) + '.' + t.substr(p);
    }

    valor = (2 > 0) ? (neg + t + ',' + d + Array((2 + 1) - d.length).join(0))
			: (neg + t);


    $(campo).val(valor);
}

function MascaraDinheiro(campo) {

    var valor = $(campo).val();
    var neg = '';

    if (valor.length != 0 && valor.charAt(0) == '-') {
        neg = '-';
        valor = valor.replace('-', '');
        
    }

    if (valor.indexOf(',') < 0) {
        valor = valor + ',00';
    }

    for (var x = valor.indexOf(','); (x -= 3) >= 1; ) {
        valor = valor.substr(0, x) + '.' + valor.substr(x);
    }

    $(campo).val(neg + valor);

}

function RemoverMascara(campo) {
    var valor = $(campo).val();
    valor = valor.replace('.', '');
    $(campo).val(valor);
}