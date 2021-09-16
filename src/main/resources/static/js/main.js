$(function () {
    $(".clickable").click(function () {
        window.location = $(this).data("href");
    });

    $('[data-toggle="tooltip"]').tooltip()
});