//= require jquery
//= require jquery_ujs


function changeColor(id) {
    var newID = '#' + id;
    $(document).ready(function () {
        //Check all script then load
        $(newID).css('color', '#FA8258');
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


function document_ready() {
    $(document).ready(function () {

    })
}