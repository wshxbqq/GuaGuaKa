window.Common = {};
Common.getQueryString=function(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}


Common.uuid=function() {
    var s = [];
    var hexDigits = "0123456789abcdef";
    for (var i = 0; i < 36; i++) {
        s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
    }
    s[14] = "4";  // bits 12-15 of the time_hi_and_version field to 0010
    s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);  // bits 6-7 of the clock_seq_hi_and_reserved to 01
    s[8] = s[13] = s[18] = s[23] = "-";

    var uuid = s.join("");
    return uuid;
}


Common.validate=function() {
 
    var result = {};
    result.code = 1;
    result.errMsg = [];
    var projectName = $("#projectName");
    var jshopUrl = $("#jshopUrl");
    var shop_uuid = $("#shop_uuid");
 

 
    if (!shop_uuid.val()) {
        result.code = 0;
        result.errMsg.push("每日游戏次数必填");
        shop_uuid.parent().parent().addClass("error");
    } else {
        shop_uuid.parent().parent().removeClass("error");
    }


     
    if (!projectName.val()) {
        result.code = 0;
        result.errMsg.push("活动名称必填");
        projectName.parent().parent().addClass("error");
    } else {
        projectName.parent().parent().removeClass("error");
    }
 
 

 

    return result;

}


Common.submitAll = function (cb) {
    if (Common.validate()["code"] > 0) {
        var data = {
            projectName: $("#projectName").val(),
            jshopUrl: $("#jshopUrl").val(),
            shopUUID: $("#shop_uuid").val(),

          

        };
        var prize_content = $(".prize_content");
 
        console.log(data);

        $.post("handle/GGL_Admin.ashx?action=addnew&p_uuid=" + window.p_uuid, data, function (data) {

            if (cb) { cb(data) }

        });


    } else {
           

    }

}