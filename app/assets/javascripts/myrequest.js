init();
convertDate();

$(function(){
    $(window).scroll(function(){

        var newLimit = 0;
        var value = 0;


        if ($(window).width() < 768) {
            //for mobile
            newLimit = $('.image_list').size();
            value = $('#status_for_mobile').val();
        }else{
            //for desktop
            // -1 is th, +10 is new limit
            newLimit = $('tr').size() - 1 + 10;
            value = $('#status_for_desktop').val();
        }
        if ($(window).scrollTop() >= ($(document).height() - $(window).height())){
            $('.waiting_div').css( 'display','block');
            $('.waiting_div').css( 'z-index','1000');
            var ajax = new CommonAjax('/manage_book/filter_myrequest', 'GET', 'html',
                {status: value, limit: newLimit},
                function(){
                },
                function(data){
                    $('.waiting_div').css( 'display','none');
                    $('.waiting_div').css( 'z-index','-1');
                    $('.div-content').html(data);
                    ($(window).width() < 768) ? $('#status_for_mobile').val(value) : $('#status_for_desktop').val(value);
                    convertDate();

                },
                function(data){});
            ajax.send();
        }
    });
});


function delete_item(){
    if (!raise_confirm('Would you like to cancel this request?')){
        return event.preventDefault();
    }
}


function func_onchange(){
    //get value from select
    var value = 0;
    if ($(window).width() < 768) {
        //for mobile
        value = $('#status_for_mobile').val();
    }else{
        //for desktop
        value = $('#status_for_desktop').val();
    }


    var ajax = new CommonAjax('/manage_book/filter_myrequest', 'GET', 'html',
        {status: value},
        function(){},
        function(data){
            $('.div-content').html(data);
            ($(window).width() < 768) ? $('#status_for_mobile').val(value) : $('#status_for_desktop').val(value);
            convertDate();

        },function(){});
    ajax.send();
}