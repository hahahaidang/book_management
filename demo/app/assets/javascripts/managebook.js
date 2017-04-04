init();
active_label('nav-management');
function delete_book(){
    var result = raise_confirm('Do you want to delete this?');
    if (!result){
        event.preventDefault();
    }
}
