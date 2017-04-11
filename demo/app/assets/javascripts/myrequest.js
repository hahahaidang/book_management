init();
convertDate();

function delete_item(){
    if (!raise_confirm('Would you like to cancel this request?')){
        return event.preventDefault();
    }
}