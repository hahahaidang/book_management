init();


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