init();
fade_error_label('result');

function check_input() {
    var flag=true;
    if (!check_input_tf_username('id_tf_username', 'id_label_tf_username')){
        flag = false;
    }
    if (!check_input_tf_password('id_tf_password', 'id_label_tf_password')){
        flag = false;
    }
    return flag;
}

function check_input_tf_username(id_tf, id_lb) {
    var newid_tf = '#' + id_tf;
    var newid_lb = '#' + id_lb;
    var tf_vl = $(newid_tf).val();
    var tf_length = tf_vl.length;
    var expression = /<\/*[sS][cC][rR][iI][pP][tT][\s\S]*?>/;
    var regex = new RegExp(expression);
    if ($.trim(tf_vl).length == 0) {
        show_warning_lable(newid_lb, 'This field can not be blank!');
        fade_error_label('id_label_tf_username');
        return false;
    }
    if (tf_length <= 3) {
        show_warning_lable(newid_lb, 'Username is too short!');
        fade_error_label('id_label_tf_username');
        return false;
    }
    if (tf_length > 16) {
        show_warning_lable(newid_lb, 'Username is too long!');
        fade_error_label('id_label_tf_username');
        return false;
    }
    if (tf_vl.match(regex)){
        show_warning_lable(newid_lb, "String must not contain special characters");
        return false;
    }
    return true;

}
function check_input_tf_password(id_tf, id_lb) {
    var newid_tf = '#' + id_tf;
    var newid_lb = '#' + id_lb;
    var tf_vl = $(newid_tf).val();
    var tf_length = tf_vl.length;
    var expression = /<\/*[sS][cC][rR][iI][pP][tT][\s\S]*?>/;
    var regex = new RegExp(expression);


    if ($.trim(tf_vl).length == 0) {
        show_warning_lable(newid_lb, 'This field can not be blank!');
        fade_error_label('id_label_tf_password');
        return false;
    }
    if (tf_length > 16) {
        show_warning_lable(newid_lb, 'Username is too long!');
        fade_error_label('id_label_tf_password');
        return false;
    }
    if (tf_vl.match(regex)){
        show_warning_lable(newid_lb, 'String must not special characters');
        return false;
    }
    return true;
}

