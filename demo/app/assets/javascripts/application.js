
//= require jquery
//= require jquery_ujs



function changeColor(id){
    var newID = '#' + id;
    $(document).ready(function () {
    //Check all script then load
        $(newID).css('color','#FA8258');
    })
}


function raise_confirm(mes){
    return confirm(mes);
}