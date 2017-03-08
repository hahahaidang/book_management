//= require jquery
//= require bootstrap
//= require jquery_ujs
//= require awesomplete


function changeColor(id) {
    var newID = '#' + id;
    $(document).ready(function () {
        //Check all script then load
        $(newID).css('color', '#FA8258');
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