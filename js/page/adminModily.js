/// <reference path="../lib/jquery.cookie.js" />
/// <reference path="../lib/jquery.js" />
/// <reference path="../lib/mustache.js" />
/// <reference path="../lib/require.js" />
/// <reference path="../lib/underscore-min.js" />


 
var p_tpl = $("#tpl_prize").html();

 
$("#addPrize").click(function (e) {
    var _uuid = window.Common.uuid();
    var html = Mustache.render(p_tpl, { id: _uuid });
    
    $(".prize_content:last").after(html);
    
    $('#winImg_' + _uuid).fileupload({
        url: "handle/GGL_Admin.ashx?uuid=" + window.p_uuid + "&action=addimg&imgtype=prize_" + _uuid,
        done: function (e, data) {
            $(this).parent().parent().parent().find(".prize_img").attr("src", "handle/GGL_ShowImg.ashx?path=" + data.result + "&__s=" + Math.random());
        }
    })
 
});

$("#prizeArea").delegate(".icon-remove", "click", function (e) {
    var _this = this;
    $.get("handle/GGL_Admin.ashx?action=del&p_uuid=" + window.p_uuid + "&uuid=" + $(_this).attr("user-data"), function () {
        $(_this).parent().slideUp(500, function () {
            $(_this).remove();
        });
    })
   
});
 

$("input").blur(function () {
    Common.validate();

});
$("#commit").click(function () {

    Common.submitAll(function () {
        alert("ok");

    });
});
