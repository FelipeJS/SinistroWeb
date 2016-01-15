$(document).ready(function () {
    $("img").hover(function () {
        $(this).css("border", "4px solid white");
        $('#logo').css("border", "none");
    }, function () {
        $(this).css("border", "none");
    }).click(function () {
        $(location).attr('href', "default.aspx");
    });
});