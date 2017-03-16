init();
awesomplete_insert_book();
fade_error_label('result');
active_label('lb_suggest');
script_check('script');
script_check('id_tf_book_name', 'id_label_tf_bookname');

function check_input() {
    var flag = 0;
    if (check_tf_name('id_tf_book_name', 'id_label_tf_bookname')) {
        if (check_tf_book_link('id_tf_book_link', 'id_label_tf_booklink')) {
            if (check_tf_price('id_tf_book_price', 'id_label_tf_bookprice')) {
                if (check_tf_quantity('id_tf_book_quantity', 'id_label_tf_bookquantity')) {
                    flag = 1;
                }
            }

        }
    }

    if (flag == 1) {
        if (raise_confirm('Do you want to insert this?')) {
            return true;

        }
        else return false;

    }
    // $('#id_label_tf_bookname').delay(1500).fadeOut('slow');
    fade_error_label('id_label_tf_bookname');
    fade_error_label('id_label_tf_booklink');
    fade_error_label('id_label_tf_bookprice');
    fade_error_label('id_label_tf_bookquantity');

    return false;

}
function check_tf_book_link(id_tf, id_lb) {
    var newid_tf = '#' + id_tf;
    var newid_lb = '#' + id_lb;
    var tf_vl = $(newid_tf).val();
    var tf_length = tf_vl.length;
    var expression = /^(?:ftp|http|https):\/\/(?:[\w\.\-\+]+:{0,1}[\w\.\-\+]*@)?(?:[a-z0-9\-\.]+)(?::[0-9]+)?(?:\/|\/(?:[\w#!:\.\?\+=&%@!\-\/\(\)]+)|\?(?:[\w#!:\.\?\+=&%@!\-\/\(\)]+))?$/;
    var regex = new RegExp(expression);


    if (tf_length > 255) {
        show_warning_lable(newid_lb, 'This value is too long!');
        return false;
    }else if (!(tf_vl.match(regex))){
        show_warning_lable(newid_lb, 'This value must be a link! Example:http://website.com');
        return false;
    }
    else {
        hide_label(newid_lb);
        return true;
    }
}
function check_tf_name(id_tf, id_lb) {
    var newid_tf = '#' + id_tf;
    var newid_lb = '#' + id_lb;
    var tf_vl = $(newid_tf).val();
    var tf_length = tf_vl.length;
    // var expression = /<[sS][cC][rR][iI][pP][tT][\s\S]*?>[\s\S]*?<\/[sS][cC][rR][iI][pP][tT]>/;
    var expression = /<\/*[sS][cC][rR][iI][pP][tT][\s\S]*?>/;
    var regex = new RegExp(expression);

    if ($.trim(tf_vl).length == 0) {
        show_warning_lable(newid_lb, 'This field can not be blank!');
        return false;
    }else if (tf_length > 255) {
        show_warning_lable(newid_lb, 'Value is too long!');
        return false;
    }else if (tf_vl.match(regex)){
        show_warning_lable(newid_lb,'This value must not contains special character');
    }
    else {
        hide_label(newid_lb);
        return true;
    }
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
    if (tf_vl.length == 0) {
        show_warning_lable(newid_lb, 'This field can not be blank!');
        return false;
    } else if (tf_length > 255) {
        show_warning_lable(newid_lb, 'Value is too long!');
        return false;
    } else if (tf_vl < 1) {
        show_warning_lable(newid_lb, 'This value must be a positive number!');
        return false;
    }else if (!$.isNumeric($(newid_tf).val())){
        show_warning_lable(newid_lb, 'This value must be a number!');
        return false;
    }else if (!(tf_vl % 1 === 0 )){
        show_warning_lable(newid_lb, 'This value must be Integer!');
        return false
    }
    else {
        hide_label(newid_lb);
        return true;
    }
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

function script_check(id_tf, id_lb){
    var newid_tf = '#' + id_tf;
    var newid_lb = '#' + id_lb;

    var tf_vl = $(newid_tf).val();

    var expression = /<script[\s\S]*?>[\s\S]*?<\/script>/;
    var regex = new RegExp(expression);
    if (tf_vl.match(regex)){
        show_warning_lable(newid_lb, 'String must not contains <script>')
    }
}
