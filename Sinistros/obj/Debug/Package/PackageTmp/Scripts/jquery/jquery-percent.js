/*
    Plugin para validar %.
    
    Criado por: Rodrigo Sampaio
    Data criação: 22/08/2012
    Email: rodrigo@simetrias.com.br
    Projeto: SEA - Sistema de Emissão de Apólices
    Pré-requisitos: jquery-1.7.1.js(não foi testado com versões anteriores).     
                    
*/

$.fn.percent = function (options) {
    var defaults = {
        decimalSeparator: ',',
        precision: 2,
        minValue: '0',
        maxValue: '100'
    };

    var input;
    var inputStyle;
    var lastValue = '';
    var options = $.extend(defaults, options);
    var minValue = parseFloat(options.minValue);
    var maxValue = parseFloat(options.maxValue);
    var decimalSeparator = options.decimalSeparator == '.' ? '.' : ',';
    var precision = options.precision;

    return this.each(function () {
        input = $(this);
        input.bind('keydown', keydown);
        input.bind('keypress', keypress);
        input.bind('keyup', keyup);
        input.bind('blur', blur);
        input.bind("contextmenu", function (e) {
            e.preventDefault();
        });
    });

    function keydown(e) {
        lastValue = input.val();
        var k = e.keyCode;

        //desabilita shift
        if (e.shiftKey == 1)
            return false;

        //bloqueia mais de um separador decimal
        var isSeparator = false;
        if (k == 190 || k == 194 || k == 110 || k == 188) {
            if (input.val().indexOf('.') > -1 || input.val().indexOf(',') > -1)
                return false;
        }


        //bloqueia tudo o que for diferente dos caracteres 
        //listados nos comentarios abaixo.
        if ((k >= 48 && k <= 57) ||     //0-9
            (k >= 96 && k <= 105) ||    //0-9 Numpad
            k == 8 ||                   //Backspace
            k == 46 ||
            k == 9) {
            return true;
        } else {
            if (((k == 190 || k == 194) && decimalSeparator == '.') ||
                    ((k == 110 || k == 188) && decimalSeparator == ',')) {
                return true;
            }
            return false;
        }
    }

    function keypress(e) {
        //keyup(e);
    }

    function keyup(e) {
        if ((msg = validateValue()) != null) {
            handleError(msg);
            return;
        }

        if (!isValidPrecision(input.val(), precision)) {
            input.val(input.val().substring(0, input.val().indexOf(decimalSeparator) + 1 + precision));
            return;
        }

        input.removeClass('input-validation-error');
    }

    function blur() {
        if (isValidPrecision(input.val(), precision) && validateValue() == null) {
            input.attr('style', 'border-color: #999;');
        }
    }

    function validateValue() {
        var strValue = input.val() != null ? input.val().replace(',','.') : '0';
        var value = parseFloat(strValue);
        if (value < minValue) {
            input.val(minValue);
            return "O percentual não pode ser menor que " + minValue + ".";
        } else if (value > maxValue) {
            input.val(maxValue);
            return "O percentual não pode ser maior que " + maxValue + ".";
        }
        return null;
    }

    function isValidPrecision(value, precision) {
        var pos = value.indexOf(decimalSeparator);
        if (pos > -1) {
            var decimalPart = value.substring(pos + 1, value.length);
            if (decimalPart.length > precision)
                return false;
        }
        return true;
    }

    function handleError(message) {
        growlError(message, 5000);
        input.attr('style', 'border-color: #ff0000;');
    }

}

