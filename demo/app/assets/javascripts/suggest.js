init();
awesomplete_insert_book();
fade_error_label('result');
active_label('nav-create');


function check_input(){
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
    return flag;
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


