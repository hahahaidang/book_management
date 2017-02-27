
//= require jquery
//= require jquery_ujs


function addHover(id){
    var newID = '#' + id;
    $(document).ready(function () {
        $(newID).addClass('active');
        //$(newID).attr('class','nav-home col-md-1 active');
    })
};

function changeColor(id){
    var newID = '#' + id;
    $(document).ready(function () {
        $(newID).css('color','#FA8258');
    })
}
