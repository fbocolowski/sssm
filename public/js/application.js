$(function () {
    $.ajaxSetup({
        headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
    });

    $('.delete').click(function (e) {
        e.preventDefault();
        $.ajax({
            url: $(this).attr('href'),
            type: 'DELETE',
            data: null,
            dataType: 'json',
            success: function (result) {
                if (result.redirect != undefined) {
                    window.location.href = result.redirect;
                } else {
                    snackbar(result.text);
                }
            },
            error: function (result) {
                console.log("Request error");
            }
        });
    });
});