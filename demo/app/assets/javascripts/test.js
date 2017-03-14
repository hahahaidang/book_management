$(document).ready(function () {
    var request = $.ajax({
        url: "/test/list_book",
        method: "GET",
        dataType: "html"
    });
    request.done(function (msg) {
        alert(msg)
    });

    request.success(function (response) {
        var book_list = JSON.parse(response).map(function (i) {
            return i.book_name;
        });
        //new Awesomplete( $('#myinput'), {list: book_list} );
        new Awesomplete(document.querySelector('#myinput'), {list: book_list});

    });

    request.fail(function (jqXHR, textStatus) {
        alert("Request failed: " + textStatus);
    });


});

