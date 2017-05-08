var CommonAjax = function (url, method, data, dataType, funcBeforeSend, funcSuccess, funcError) {
    this.BeforeSend = funcBeforeSend;
    this.send = function(){
        $.ajax({
            url: url,
            method: method,
            data: data,
            dataType: dataType,
            success: funcSuccess,
            error: funcError
        })
    }

};