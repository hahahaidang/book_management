//= require jquery
//= require bootstrap
//= require jquery_ujs
//= require awesomplete
//= require moment

function fade_error_label(id_lb){
    var newid_lb = '#' + id_lb;
    $(newid_lb).delay(2000).fadeOut('fast');
}
function convertDate() {
    $('.time').each(function (index, element) {
        digit = parseInt($(element).html());
        result = moment(digit).format('lll');
        $(element).html(result);
    })
}

function init() {
    $(document).ready(function () {
        //Check all script then load
        $('.dropdown-toggle').dropdown();
        get_bookname('#tf_search');
        default_size();
        resize_screen();


    })
}


function raise_confirm(mes) {
    return confirm(mes);
}
function show_warning_lable(id_label, mes) {
    $(id_label).text(mes);
    $(id_label).css('display', 'inline');
}
function hide_label(id_label) {
    $(id_label).css('display', 'none');
}


function get_bookname(id_tf) {
    $.ajax({
        url: '/suggest/list_book',
        method: 'POST',
        datatype: 'json',
    })
        .done(function (msg) {
        })
        .success(function (data_response) {
            var list_book = data_response.map(function (index) {
                return index.book_name;
            });
            new Awesomplete(document.querySelector(id_tf), {list: list_book, minChars: 2});
        })
        .fail(function (jqXHR, textStatus) {
            alert('Request failed: ' + textStatus);
        });

}
function default_size(){
    var totalHeight = $(window).height();
    var newHeight = totalHeight-90;
    $('.div-content').height(newHeight);
}

function resize_screen(){
    $(window).resize(function () {
        var totalHeight = $(window).height();
        var newHeight = totalHeight-90;
        $('.div-content').height(newHeight);
    })


}