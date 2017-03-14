//= require jquery
//= require bootstrap
//= require jquery_ujs
//= require awesomplete
//= require moment

function fade_error_label(id_lb) {
    //fade error label after 2000ms
    var newid_lb = '#' + id_lb;
    $(newid_lb).delay(2000).fadeOut('fast');
}
function convertDate() {
    $('.time').each(function (index, element) {
        //parse datetime to integer
        digit = parseInt($(element).html());
        //using momentjs to convert by format
        result = moment(digit).format('lll');
        $(element).html(result);
    })
}

function init() {
    $(document).ready(function () {
        //Check all script then load
        $('.dropdown-toggle').dropdown();
        get_bookname('#tf_search');
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

function set_height_default(){
    //Default height after load
    var totalHeight = $(window).height();
    var heightHeader = $('.navbar-header').height();
    var heightFooter = $('.model-footer').height();
    var newHeight = totalHeight - heightFooter - heightHeader-20; //20 is margin of header and footer
    $('.div-content').css("min-height", function () {
        return newHeight;
    });
}

function resize_screen() {
    //Default height after load
    set_height_default();

    //after resize event then resize
    $(window).resize(function () {
        set_height_default();
    })
}

function active_label(class_label) {
    var newClass = '.' + class_label;
    $(newClass).css('border-bottom', '6px solid #f2f2f2');
}