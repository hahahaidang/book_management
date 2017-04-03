//= require jquery
//= require bootstrap
//= require jquery_ujs
//= require awesomplete
//= require moment
function return_index_page(){
    window.location.href='/welcome/index';
}
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
function call_modal(id_modal){
    var id = "#" + id_modal;
    $(id).modal();

}
function call_modal_creation(){
    $('.modal_suggestion').modal();
}


function call_confirm_request(){
    //using render confirm_request
    $.ajax({
            url: '/welcome/review_request',
            method: 'POST',
            datatype: 'html',
            data: $('#create_request_form').serialize()
        })
        .done(function (msg) {
        })
        .success(function (msg){
            $('.modal-content').html(msg);
        })


}

function call_suggest_form(){
    $.ajax({
            url: '/welcome/suggest_form',
            method: 'POST',
            datatype: 'html',
            data: $('#review_form').serialize()
        })
        .done(function (msg) {
            $('.modal-content').html(msg);
        })
}



function create_request(){
    //using: send request to server
    if (raise_confirm('Do you want to create this request?')) {
        $.ajax({
                url: '/welcome/create_request',
                method: 'POST',
                datatype: 'html',
                data: $('#review_form').serialize()
            })
            .success(function (msg) {
                $('#div_success').html(msg);
                $('#div_success').css('display', 'block');
                setTimeout(function(){
                    window.location='/welcome/index';
                },1000)
            })
            .error(function(msg){
                $('#div_fail').css('display','block');
                fade_error_label('div_fail');
            })
    }
    else{
        event.preventDefault();
    }
}

function cancel_request(){
    var bookName = $('#id_tf_book_name').val().length;
    var bookPrice = $('#id_tf_book_price').val().length;
    var bookQuantity = $('#id_tf_book_quantity').val().length;

    //check if bookname, bookprice, bookquantity is blank.
    if ((bookName == 0) && (bookPrice == 0) && (bookQuantity == 0)){
        return return_index_page();
    }
    // if condition is false, raise alert
    if (raise_confirm('Your text are in editing, are you sure exit?')){
        //confirm = true
        return return_index_page();
    }
    return false;
    // return (raise_confirm('Your text are in editing, are you sure tu exit?')) ? return_index_page() : false;
}

function like(id){
    var request_id = "#" + id +"_request_like";
    $.ajax({
            url: '/welcome/like',
            method: 'POST',
            datatype: 'html',
            data: {id : id}
        })
        .success(function(msg){
            $(request_id).html(msg);
            $(request_id).parent().attr('disabled','');

        })

}






// Validate for form suggest


function check_input_form_modal(){
    var flag = true;
    if (!check_tf_name('id_tf_book_name', 'id_label_tf_bookname')){
        flag = false;
    }
    if (!check_tf_book_link('id_tf_book_link', 'id_label_tf_booklink')){
        flag = false;
    }
    if (!check_tf_link_image('id_tf_link_image','id_label_linkimage')){
        flag = false;
    }
    if (!check_tf_price('id_tf_book_price', 'id_label_tf_bookprice')){
        flag = false;
    }
    if (!check_tf_quantity('id_tf_book_quantity', 'id_label_tf_bookquantity')) {
        flag = false;
    }
    fade_error_label('id_label_tf_bookname');
    fade_error_label('id_label_tf_booklink');
    fade_error_label('id_label_linkimage');
    fade_error_label('id_label_tf_bookprice');
    fade_error_label('id_label_tf_bookquantity');
    if (!flag){
        return false
    }
    else{
        call_confirm_request();
    }
}

function check_tf_link_image(id_tf,id_lb){
    var newid_tf = '#' + id_tf;
    var newid_lb = '#' + id_lb;
    var tf_vl = $(newid_tf).val();
    var tf_length = tf_vl.length;

    var expressionScript = /<\/*[sS][cC][rR][iI][pP][tT][\s\S]*?>/;
    var regexScript = new RegExp(expressionScript);


    if (tf_length > 400) {
        show_warning_lable(newid_lb, 'This value is too long!');
        return false;
    }
    if (tf_vl.match(regexScript)){
        show_warning_lable(newid_lb,'This value must not contains special character');
        return false
    }
    return true;
}
function check_tf_book_link(id_tf, id_lb) {
    var newid_tf = '#' + id_tf;
    var newid_lb = '#' + id_lb;
    var tf_vl = $(newid_tf).val();
    var tf_length = tf_vl.length;
    var expression = /^(?:ftp|http|https):\/\/(?:[\w\.\-\+]+:{0,1}[\w\.\-\+]*@)?(?:[a-z0-9\-\.]+)(?::[0-9]+)?(?:\/|\/(?:[\w#!:\.\?\+=&%@!\-\/\(\)]+)|\?(?:[\w#!:\.\?\+=&%@!\-\/\(\)]+))?$/;
    var regex = new RegExp(expression);
    var expressionScript = /<\/*[sS][cC][rR][iI][pP][tT][\s\S]*?>/;
    var regexScript = new RegExp(expressionScript);


    if (tf_length > 400) {
        show_warning_lable(newid_lb, 'This value is too long!');
        return false;
    }
    if (!(tf_vl.match(regex))){
        show_warning_lable(newid_lb, 'This value must be a link! Example:http://website.com');
        return false;
    }
    if (tf_vl.match(regexScript)){
        show_warning_lable(newid_lb,'This value must not contains special character');
        return false
    }
    return true;
}
function check_tf_name(id_tf, id_lb) {
    var newid_tf = '#' + id_tf;
    var newid_lb = '#' + id_lb;
    var tf_vl = $(newid_tf).val();
    var tf_length = tf_vl.length;
    var expression = /<\/*[sS][cC][rR][iI][pP][tT][\s\S]*?>/;
    var regex = new RegExp(expression);

    if ($.trim(tf_vl).length == 0) {
        show_warning_lable(newid_lb, 'This field can not be blank!');
        return false;
    }
    if (tf_length > 255) {
        show_warning_lable(newid_lb, 'Value is too long!');
        return false;
    }
    if (tf_vl.match(regex)){
        show_warning_lable(newid_lb,'This value must not contains special character');
        return false
    }
    return true;
}


function check_tf_price(id_tf, id_lb) {
    var newid_tf = '#' + id_tf;
    var newid_lb = '#' + id_lb;
    var tf_vl = $(newid_tf).val();
    var tf_length = tf_vl.length;
    if (tf_vl.length == 0) {
        show_warning_lable(newid_lb, 'This field can not be blank!');
        return false;
    } else if (tf_length > 255) {
        show_warning_lable(newid_lb, 'Value is too long!');
        return false;
    } else if (tf_vl < 0) {
        show_warning_lable(newid_lb, 'This value must be greater than or equal 0!');
        return false;
    } else if (!$.isNumeric($(newid_tf).val())){
        show_warning_lable(newid_lb, 'This value must be a number!');
        return false;
    }
    else {
        hide_label(newid_lb);
        return true;
    }
}
function check_tf_quantity(id_tf, id_lb) {
    var newid_tf = '#' + id_tf;
    var newid_lb = '#' + id_lb;
    var tf_vl = $(newid_tf).val();
    var tf_length = tf_vl.length;
    var expression = /<\/*[sS][cC][rR][iI][pP][tT][\s\S]*?>/;
    var regex = new RegExp(expression);
    if (tf_vl.length == 0) {
        show_warning_lable(newid_lb, 'This field can not be blank!');
        return false;
    }
    if (tf_length > 255) {
        show_warning_lable(newid_lb, 'Value is too long!');
        return false;
    }
    if (tf_vl < 1) {
        show_warning_lable(newid_lb, 'This value must be a positive number!');
        return false;
    }
    if (!$.isNumeric($(newid_tf).val())){
        show_warning_lable(newid_lb, 'This value must be a number!');
        return false;
    }
    if (!(tf_vl % 1 === 0 )){
        show_warning_lable(newid_lb, 'This value must be Integer!');
        return false
    }
    if (tf_vl.match(regex)){
        show_warning_lable(newid_lb,'This value must not contains special character');
        return false
    }
    return true
}


function awesomplete_insert_book() {
    $.ajax({
            url: '/suggest/list_book',
            method: 'POST',
            datatype: 'json'
        })
        .done(function (msg) {
        })
        .success(function (data_response) {
            var list_book = data_response.map(function (index) {
                return index.book_name;
            });
            new Awesomplete(document.querySelector('#id_tf_book_name'), {list: list_book, minChars: 2});
            awesomplete_parent();

        })
        .fail(function (jqXHR, textStatus) {
            alert("Request failed: " + textStatus);
        });
}

function awesomplete_parent(){
    $('#id_tf_book_name').parent().css('width','100%');
}


function awesomplete_insert_book() {
    $.ajax({
            url: '/suggest/list_book',
            method: 'POST',
            datatype: 'json'
        })
        .done(function (msg) {
        })
        .success(function (data_response) {
            var list_book = data_response.map(function (index) {
                return index.book_name;
            });
            new Awesomplete(document.querySelector('#id_tf_book_name'), {list: list_book, minChars: 2});
            awesomplete_parent();

        })
        .fail(function (jqXHR, textStatus) {
            alert("Request failed: " + textStatus);
        });
}


