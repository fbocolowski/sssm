$(function () {
    function http_request(url, method, data, dataType) {
        $.ajax({
            url: url,
            type: method,
            data: data,
            dataType: dataType,
            success: function (result) {
                if (result.redirect != undefined) {
                    window.location.href = result.redirect;
                } else {
                    alert(result.text);
                }
            },
            error: function (result) {
                alert("Request error.");
            }
        });
    }

    $.ajaxSetup({
        headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
    });

    $('.delete').click(function (e) {
        e.preventDefault();
        var result = confirm('Are you sure?');
        if (result) {
            http_request($(this).attr('href'), 'DELETE', null, 'json');
        }
    });
});
