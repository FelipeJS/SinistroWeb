(function ($) {
    $.fn.mgrerror = function (options) {
        var defaults = {
            isRequerid: true,
            validFunction: false
        };
        var options = $.extend(defaults, options);
        return this.each(function () {
            var isValid = false;
            $(this).addClass('input-validation-error');
            $(this).blur(function () {                
                if (typeof (options.validFunction) == 'function') {
                    isValid = options.validFunction.call();
                } else if (options.isRequerid) {
                    if ($(this).val() != '')
                        isValid = true;
                }
                if (isValid) {
                    $(this).removeClass('input-validation-error');
                } else {
                    $(this).addClass('input-validation-error');
                }
            });
        });
    };
})(jQuery);