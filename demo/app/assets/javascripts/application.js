//= require jquery
//= require bootstrap
//= require jquery_ujs
//= require awesomplete
//= require moment


function convertDate(){
     // $('.time').forEach(function(element){
     //     digit = parseInt($('.time').html());
     //     result = moment(digit).format('lll');
     //     $('.time').html(result);
     // })
    $('.time').each(function(index, element){
        digit = parseInt($(element).html());
        result = moment(digit).format('lll');
        $(element).html(result);

    })


}

function init() {
    $(document).ready(function () {
        //Check all script then load
        $('.dropdown-toggle').dropdown();
        get_bookname('#tf_search');


    })
}


function raise_confirm(mes) {
    return confirm(mes);
}
function show_warning_lable(id_label, mes) {
    $(id_label).text(mes);
    $(id_label).css('display', 'inline');
}
function hide_label(id_label) {
    $(id_label).css('display', 'none');
}


function get_bookname(id_tf){
    $.ajax({
        url:'/suggest/list_book',
        method: 'POST',
        datatype: 'json',
    })
        .done(function(msg){})
        .success(function(data_response){
            var list_book = data_response.map(function(index){
                return index.book_name;
            });
            new Awesomplete (document.querySelector(id_tf),{list: list_book});
        })
        .fail(function(jqXHR, textStatus){
            alert('Request failed: '+textStatus);
        });

}