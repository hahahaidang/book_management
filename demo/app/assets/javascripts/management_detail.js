init();
fade_error_label('result');
active_label('btn_dropdown');


function return_management_page(){
    window.location.href='/manage_book/managebook_page';
}

function check_input_update() {
    flag = 0;
    if (check_tf_name('tf_book_name', 'id_label_tf_bookname')) {
        if (check_tf_quantity('tf_book_quantity', 'id_label_tf_bookquantity')) {
            flag = 1
        }
        if (flag == 1) {
            if (raise_confirm('Do you want to update?'))
                return true;
            else return false;
        } else {
            $('#result').css('display', 'none');
            return false;
        }
    }
}
function check_tf_quantity(id_tf, id_lb) {
    var newid_tf = '#' + id_tf;
    var newid_lb = '#' + id_lb;
    var tf_vl = $(newid_tf).val();
    var tf_length = tf_vl.length;
    if (tf_vl == "") {
        show_warning_lable(newid_lb, 'This field can not be blank!');
        return false;
    } else if (tf_length > 255) {
        show_warning_lable(newid_lb, 'Value is too long!');
        return false;
    } else if (tf_vl < 0) {
        show_warning_lable(newid_lb, 'This value must be a positive number!');
        return false;
    }else if (!$.isNumeric($(newid_tf).val())){
        show_warning_lable(newid_lb, 'This value must be a number!');
        return false;
    } else {
        hide_label(newid_lb);
        return true;
    }
}

function check_tf_name(id_tf, id_lb) {
    var newid_tf = '#' + id_tf;
    var newid_lb = '#' + id_lb;
    var tf_vl = $(newid_tf).val();
    var tf_length = tf_vl.length;
    if (tf_vl == "") {
        show_warning_lable(newid_lb, 'This field can not be blank!');
        return false;
    } else if (tf_length > 255) {
        show_warning_lable(newid_lb, 'Value is too long!');
        return false;
    } else {
        hide_label(newid_lb);
        return true;
    }
}
