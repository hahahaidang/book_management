init();
active_label('nav-management');
function delete_book() {
    if (!raise_confirm('Do you want to delete this?')) {
        event.preventDefault();
    }
}
function call_modal_detail(id) {
    call_modal('modal_detail');
    $.ajax({
            url: '/manage_book/modal_detail',
            method: "POST",
            datatype: "html",
            data: {book_id: id}
        })
        .success(function (msg) {
            $('.modal-content').html(msg);
        })
}

function update_detail() {
    if (check_input_update() && (raise_confirm('Are you sure?'))) {
        $.ajax({
                url: '/manage_book/update',
                method: "POST",
                datatype: "html",
                data: $('#form_update_detail').serialize()
            })
            .success(function (msg) {
                $('#lb_success').css('display', 'block');
                fade_error_label('lb_success');
            })
            .fail(function (msg) {
                $('#lb_fail').css('display', 'block');
                fade_error_label('lb_fail');
            })
    }
}


function check_input_update() {
    var flag = true;
    if (!check_tf_name('tf_book_name', 'id_label_tf_bookname')) {
        flag = false;
    }
    if (!check_tf_quantity('tf_book_quantity', 'id_label_tf_bookquantity')) {
        flag = false;
    }
    fade_error_label('id_label_tf_bookname');
    fade_error_label('id_label_tf_bookquantity');
    return flag;
}
function check_tf_quantity(id_tf, id_lb) {
    var newid_tf = '#' + id_tf;
    var newid_lb = '#' + id_lb;
    var tf_vl = $(newid_tf).val();
    var tf_length = tf_vl.length;
    if (tf_length == 0) {
        show_warning_lable(newid_lb, 'This field can not be blank!');
        return false;
    }
    if (tf_length > 255) {
        show_warning_lable(newid_lb, 'Value is too long!');
        return false;
    }
    if (tf_vl < 0) {
        show_warning_lable(newid_lb, 'This value must be a positive number!');
        return false;
    }
    if (!$.isNumeric($(newid_tf).val())) {
        show_warning_lable(newid_lb, 'This value must be a number!');
        return false;
    }
    return true;
}

function check_tf_name(id_tf, id_lb) {
    var newid_tf = '#' + id_tf;
    var newid_lb = '#' + id_lb;
    var tf_vl = $(newid_tf).val();
    var tf_length = tf_vl.length;
    if (tf_vl.length == 0) {
        show_warning_lable(newid_lb, 'This field can not be blank!');
        return false;
    }
    if (tf_length > 255) {
        show_warning_lable(newid_lb, 'Value is too long!');
        return false;
    }
    return true;
}
