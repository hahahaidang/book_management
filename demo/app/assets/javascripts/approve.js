init();


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