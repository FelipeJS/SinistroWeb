/*
Plugin pra transformar os dados de input em json.
    
Criado por: Rodrigo Sampaio
Data criação: 23/08/2012
Email: rodrigo@simetrias.com.br
Projeto: SEA - Sistema de Emissão de Apólices
Pré-requisito: jquery-1.7.1.js(não foi testado com versões anteriores).     
*/

$.fn.formToJson = function (options) {
    var defaults = {
        includeHidden: true, //incluir os campos hidden
        includeDisabled: false //incluir os campos desabilitados
    };
    var options = $.extend(defaults, options);
    var x = '{';
    var $inputs = $(this).find('input');
    var $selects = $(this).find('select');
    $inputs.each(function () {
        var inc = true;
        var o = $(this);
        var i = o.attr('id');
        var t = o.attr('type');
        var d = o.attr('disabled');
        var v = null;
        if ((d || d == "disabled") && !options.includeDisabled) {
            return;
        }
        if (t == 'hidden') {
            if (options.includeHidden) {
                v = replaceAll(o.val(), '"', '');
                inc = true;
            } else {
                inc = false;
            }            
        } else if (t == 'checkbox') {
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

    $selects.each(function () {
        var o = $(this);
        var d = o.attr('disabled');
        if ((d || d == "disabled") && !options.includeDisabled) {
            return;
        }
        var i = o.attr('id');
        var v = o.val();
        x = x + '"' + i + '":"' + v + '",';
    });

    x = x.substring(0, (x.length - 1));
    x = x + '}';

    if (x == '}') {
        alert('Não foi encontrado nenhum elemento de formulário em ' + $(this).attr('id'));
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


/*
Plugin pra transformar os dados de input em json no formato utilizado no FlexGrid.
    
Criado por: Rodrigo Sampaio
Data criação: 11/09/2012
Email: rodrigo@simetrias.com.br
Projeto: SEA - Sistema de Emissão de Apólices
Pré-requisito: jquery-1.7.1.js(não foi testado com versões anteriores).     
*/

$.fn.formToJsonFlexGrid = function (options) {
    var defaults = {
        includeHidden: true, //incluir os campos hidden
        includeDisabled: false //incluir os campos desabilitados
    };
    var options = $.extend(defaults, options);
    var x = '[';
    var $inputs = $(this).find('input');
    var $selects = $(this).find('select');
    $inputs.each(function () {
        var inc = true;
        var o = $(this);
        var i = o.attr('id');
        var t = o.attr('type');
        var d = o.attr('disabled');
        var v = null;
        if ((d || d == "disabled") && !options.includeDisabled) {
            return;
        }
        if (t == 'hidden') {
            if (options.includeHidden) {
                v = replaceAll(o.val(), '"', '');
                inc = true;
            } else {
                inc = false;
            }
        } else if (t == 'checkbox') {
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
        if (inc) x = x + createObject(i,v) + ',';
    });

    $selects.each(function () {
        var o = $(this);
        var d = o.attr('disabled');
        if ((d || d == "disabled") && !options.includeDisabled) {
            return;
        }
        var i = o.attr('id');
        var v = o.val();
        x = x + createObject(i, v) + ',';
    });

    x = x.substring(0, (x.length - 1));
    x = x + ']';

    if (x == ']') {
        alert('Não foi encontrado nenhum elemento de formulário em ' + $(this).attr('id'));
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

function createObject(n, v) {
    return '{"name":"' + n + '", "value":"' + v + '"}';
}

