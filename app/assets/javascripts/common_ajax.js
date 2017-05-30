var CommonAjax = function (url, method, dataType, data, funcBeforeSend, funcSuccess, funcError) {
    this.BeforeSend = funcBeforeSend;
    this.send = function(){
        $.ajax({
            url: url,
            method: method,
            data: data,
            dataType: dataType,
            success: function(response){
                if (funcSuccess!= null && funcSuccess instanceof Function){
                    return funcSuccess(response);
                }
            },
            error: function(response){
                if (funcError!= null && funcError instanceof Function){
                    return funcError(response);
                }
            }
        })
    }

};