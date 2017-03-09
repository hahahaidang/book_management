init();
awesomplete_insert_book();
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
    return false;

}
function check_tf_book_link(id_tf, id_lb) {
    var newid_tf = '#' + id_tf;
    var newid_lb = '#' + id_lb;
    var tf_vl = $(newid_tf).val();
    var tf_length = tf_vl.length;
    if (tf_length > 255) {
        show_warning_lable(newid_lb, 'Value is too long!');
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


function check_tf_price(id_tf, id_lb) {
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
    } else if (tf_vl < 0 || tf_vl > 1000) {
        show_warning_lable(newid_lb, 'This value is out of range!');
        return false;
    } else {
        hide_label(newid_lb);
        return true;
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
    } else if (tf_vl < 1 || tf_vl > 100) {
        show_warning_lable(newid_lb, 'This value is out of range!');
        return false;
    } else {
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
            new Awesomplete(document.querySelector('#id_tf_book_name'), {list: list_book});
            awesomplete_parent();

        })
        .fail(function (jqXHR, textStatus) {
            alert("Request failed: " + textStatus);
        });
}

function awesomplete_parent(){
    $('#id_tf_book_name').parent().css('width','100%');
}

