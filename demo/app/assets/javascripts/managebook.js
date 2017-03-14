
init();
active_label('btn_dropdown');
function delete_book(){
    var result = raise_confirm('Do you want to delete this?');
    if (!result){
        event.preventDefault();
    }
}
