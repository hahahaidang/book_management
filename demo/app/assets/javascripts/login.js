init();
fade_error_label('result');
function check_input() {
    var flag = 0;
    if (check_input_tf_username('id_tf_username', 'id_label_tf_username')) {
        if (check_input_tf_password('id_tf_password', 'id_label_tf_password')) {
            flag = 1;
        }
    }
    if (flag == 1) {
        return true;
    } else return false;
}


function check_input_tf_username(id_tf, id_lb) {
    var newid_tf = '#' + id_tf;
    var newid_lb = '#' + id_lb;
    var tf_vl = $(newid_tf).val();
    var tf_length = tf_vl.length;
    if (tf_vl == "") {
        show_warning_lable(newid_lb, 'This field can not be blank!');
        fade_error_label('id_label_tf_username');
        return false;
    } else if (tf_length <= 3) {
        show_warning_lable(newid_lb, 'Username is too short!');
        fade_error_label('id_label_tf_username');
        return false;
    } else if (tf_length >= 17) {
        show_warning_lable(newid_lb, 'Username is too long!');
        fade_error_label('id_label_tf_username');
        return false;
    } else {
        hide_label(newid_lb);
        return true;
    }
}
function check_input_tf_password(id_tf, id_lb) {
    var newid_tf = '#' + id_tf;
    var newid_lb = '#' + id_lb;
    var tf_vl = $(newid_tf).val();
    var tf_length = tf_vl.length;
    if (tf_vl == "") {
        show_warning_lable(newid_lb, 'This field can not be blank!');
        fade_error_label('id_label_tf_password');
        return false;
    } else if (tf_length >= 128) {
        show_warning_lable(newid_lb, 'Username is too long!');
        fade_error_label('id_label_tf_password');
        return false;
    } else {
        hide_label(newid_lb);
        return true;
    }
}
