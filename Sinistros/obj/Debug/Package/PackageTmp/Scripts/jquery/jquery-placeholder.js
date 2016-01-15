$.fn.placeholder = function (options) {
    var defaults = {
        text: 'Preencha o campo'
    };
    var options = $.extend(defaults, options);
    return this.each(function () {
        if ($(this).val() == "") {
            $(this).addClass('placeholder').val(options.text);
        }
        $(this).focus(function () {
            if ($(this).val() == options.text) {
                $(this).removeClass('placeholder').val('');
            }
        });
        $(this).blur(function () {
            if ($(this).val() == "") {
                $(this).addClass('placeholder').val(options.text);
            }
        });
    });
}