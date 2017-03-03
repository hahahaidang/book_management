
changeColor('vertical_nav_suggest_book');

function check_input(){
    var flag = 0;
    if (check_tf_name('id_tf_book_name','id_label_tf_bookname')){
        if(check_tf_link_description('id_tf_book_link','id_label_tf_booklink')){
            if(check_tf_link_description('id_tf_book_description','id_label_tf_bookdescription')){
                if(check_tf_price('id_tf_book_price','id_label_tf_bookprice')){
                   if(check_tf_quantity('id_tf_book_quantity','id_label_tf_bookquantity')){
                       flag=1;
                   }
                }
            }
        }
    }
    if (flag ==1){
        return true;

    }
    return false;

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

function check_tf_link_description(id_tf, id_lb) {
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
//
