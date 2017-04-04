init();
convertDate();
active_label('nav-home');





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


function awesomplete_parent(){
    $('#id_tf_book_name').parent().css('width','100%');
}

