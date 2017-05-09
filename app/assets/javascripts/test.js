//$(document).ready(function () {
//    var request = $.ajax({
//        url: "/test/list_book",
//        method: "GET",
//        dataType: "html"
//    });
//    request.done(function (msg) {
//        alert(msg)
//    });
//
//    request.success(function (response) {
//        var book_list = JSON.parse(response).map(function (i) {
//            return i.book_name;
//        });
//        //new Awesomplete( $('#myinput'), {list: book_list} );
//        new Awesomplete(document.querySelector('#myinput'), {list: book_list});
//
//    });
//
//    request.fail(function (jqXHR, textStatus) {
//        alert("Request failed: " + textStatus);
//    });
//
//
//});
//
function like(id) {
    var request_id = "#" + id + "_request_like";
    $.ajax({
            url: '/welcome/like',
            method: 'POST',
            datatype: 'html',
            data: {id: id}
        })
        .success(function (msg) {
            $(request_id).html(msg);
            $(request_id).parent().attr('disabled', '');

        })
}

function testAjax(){
    var ajax =  new CommonAjax('/welcome/like','POST',null,{id:275},null,function(data){
        {
            console.log('success');
        }
    },null);
    ajax.send();
}
