init();
event_hover_comment_box();



function event_hover_comment_box(){
    $('.comment_text_area').hover(function(){
        $('.remove_comment_icon').css('display','block');
    },function(){
        $('.remove_comment_icon').css('display','none');
    });

}
function delete_comment(){
    if (!raise_confirm("Are you sure?")){
        event.preventDefault();
    }

}

function call_approve_modal(){
    call_modal('modal_approve')
}
function call_cancel_modal(){
    call_modal('modal_cancel')
}
function approve_request() {
    if (raise_confirm('Do you want to approve this?'))
        return true;
    else
        event.preventDefault();
}
function deny_request(){
    if (raise_confirm('Do you want to deny this?'))
        return true;
    else
        event.preventDefault();
}


function check_tf_comment(id_tf, id_lb){
    var newid_tf = '#' + id_tf;
    var newid_lb = '#' + id_lb;
    var tf_vl = $(newid_tf).val();
    var tf_length = tf_vl.length;
    var expression = /<\/*[sS][cC][rR][iI][pP][tT][\s\S]*?>/;
    var regex = new RegExp(expression);

    if ($.trim(tf_vl).length == 0) {
        show_warning_lable(newid_lb, 'This field can not be blank!');
        event.preventDefault();
    }
    if (tf_length > 255) {
        show_warning_lable(newid_lb, 'Value is too long!');
        event.preventDefault();
    }
    if (tf_vl.match(regex)){
        show_warning_lable(newid_lb,'This value must not contain special character');
        event.preventDefault();
    }
    //if (raise_confirm('Would you like to post this?')){
    //    return true;
    //}
    //else return false;
}

function post_comment(){
    check_tf_comment('comment_text_area','lb_comment');
    $.ajax({
        url: '/welcome/post_comment',
        method: 'POST',
        datatype: 'html',
        data: $('#comment_form').serialize()
    })
        .success(function(msg){
            $('.div_load_comment').html(msg);
            $('#comment_text_area').val('');
            event_hover_comment_box();
        })
        .fail(function(msg){
            show_warning_lable('lb_comment','Error, can not post this comment!');
        })
}

function delete_comment(commentID){
    $.ajax({
        url: '/welcome/delete_comment',
        method: 'POST',
        datatype: 'html',
        data: {comment_id: commentID}
    })
        .success(function(msg){
            $('.div_load_comment').html(msg);
            event_hover_comment_box();
        })
        .fail(function(msg){
        })
}