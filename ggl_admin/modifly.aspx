<%@ Page Language="C#" AutoEventWireup="true" CodeFile="modifly.aspx.cs" Inherits="guaguale_ggl_admin_modifly" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../css/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

    <link href="../css/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet" />

    <script src="../js/lib/mustache.js"></script>

    <script src="../js/lib/underscore-min.js"></script>
    <link href="../css/admin_all.css" rel="stylesheet" />
    <link href="../js/lib/jQuery-File-Upload-master/css/jquery.fileupload.css" rel="stylesheet" />
    <script src="../js/page/common.js"></script>
</head>
<body>
    <div class="container">
        <div class="masthead">
            <h3 class="muted">刮刮乐-抽奖生成</h3>
 
            <!-- /.navbar -->
        </div>


        <div class="hero-unit ht ht1">
            <legend>基本信息：</legend>
            <form class="form-horizontal">
                <div class="control-group">
                    <label class="control-label" for="projectName">系统UUID：</label>
                    <div class="controls">
                        <p class="alert alert-success" id="page_uuid">xxxxxxxx</p>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="projectName">活动名称</label>
                    <div class="controls">
                        <input type="text" id="projectName" name="projectName" placeholder="活动名称" value="<%=p_name %>" />
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label" for="jshopUrl">jshop页面地址</label>
                    <div class="controls">
                        <input type="text" id="jshopUrl" name="jshopUrl" placeholder="jshop页面地址" value="<%=jshop_url %>" />
                    </div>
                </div>
                <!-- <div class="row-fluid show-grid bottom_control">
                    <div class="span6 offset9">
                        <button id="ht1_btn" type="button" class="btn btn-large btn-success">下一步</button>
                    </div>
                </div>-->
            </form>
        </div>

 





        <div class="hero-unit ht ht2" id="prizeArea">




            <legend>奖品设置：</legend>


            <form class="form-horizontal">

                <div class="control-group">
                    <label class="control-label">大背景图片:</label>

                    <div class="controls">
                        <input type="file" id="bgImg" />
                        
                        <img class="img_big_bg" src="<%= bgimg %>" />
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label">遮盖图片:</label>

                    <div class="controls">
                        <input type="file" id="maskImg" />
                        <img class="img_mask" src="<%= maskimg %>" />
                    </div>
                </div>




                <div class="control-group">
                    <label class="control-label">未中奖图片:</label>

                    <div class="controls">
                        <input type="file" id="loseImg" />
                        <img class="img_lose" src="<%= loseimg %>" />
                    </div>
                </div>

                <legend id="legend_p">风控系统对接:</legend>

                <div class="prize_content">


                    <div class="control-group">
                        <label class="control-label">风控系统UUID:</label>
                        <div class="controls">
                            <input type="text" id="shop_uuid" placeholder="对应风控系统生成的UUID" value="<%=shop_uuid %>" />
                        </div>
                    </div>


                </div>

                <legend id="legend1">jshop嵌入代码:</legend>

                <div class="prize_content">


                    <div class="control-group">
                        <label class="control-label">风控系统UUID:</label>
                        <div class="controls">
                            <textarea class="jshop_code">
                                

                            </textarea>
                        </div>
                    </div>


                </div>





                <div class="row show-grid bottom_control">

                    <div class="span3 offset8">
                        <button id="commit" type="button" class="btn btn-large btn-success">确定</button>

                    </div>
                </div>
            </form>
        </div>


    </div>

    <textarea   style="display:none"  id="code_tpl">
        <script>
            document.domain = "jd.com";
            function getArgs() {
                var args = new Object();
                var query = location.search.substring(1);
                var pairs = query.split("&");
                for (var i = 0; i < pairs.length; i++) {
                    var pos = pairs[i].indexOf('=');
                    if (pos == -1) continue;
                    var argname = pairs[i].substring(0, pos);
                    var value = pairs[i].substring(pos + 1);
                    value = decodeURIComponent(value);
                    args[argname] = value;
                }
                return args;
            }
        </script>
        <div style="margin:0 auto; height:640px;">            
            <iframe frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" src="http://gamecfg.jd.com/guaguale/ggl/ggl.aspx?p_uuid={{p_uuid}}" width="640" height="640"></iframe>        
        </div>

    </textarea>


    <script src="../js/lib/jquery.js"></script>
    <!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
    <script src="../js/lib/jQuery-File-Upload-master/js/jquery.iframe-transport.js"></script>
    <script src="../js/lib/jQuery-File-Upload-master/js/vendor/jquery.ui.widget.js"></script>
    <!-- The basic File Upload plugin -->
    <script src="../js/lib/jQuery-File-Upload-master/js/jquery.fileupload.js"></script>
    <!-- Bootstrap JS is not required, but included for the responsive demo navigation -->

    <script>
        window.p_uuid = "<%= p_uuid %>";
        var code_html = Mustache.render($("#code_tpl").html(), { p_uuid: window.p_uuid });
        $(".jshop_code").html(code_html);
        $("#page_uuid").html(window.p_uuid);
        (function () {

            $('#bgImg').fileupload({
                url: "handle/GGL_Admin.ashx?uuid=" + window.p_uuid + "&action=addimg&imgtype=bgimg",
                done: function (e, data) {
                    $(".img_big_bg").attr("src", "handle/GGL_ShowImg.ashx?path=" + data.result + "&__s=" + Math.random());
                }
            })
            $('#maskImg').fileupload({
                url: "handle/GGL_Admin.ashx?uuid=" + window.p_uuid + "&action=addimg&imgtype=mask",
                done: function (e, data) {
                    $(".img_mask").attr("src", "handle/GGL_ShowImg.ashx?path=" + data.result + "&__s=" + Math.random());
                }
            })

            $('#loseImg').fileupload({
                url: "handle/GGL_Admin.ashx?uuid=" + window.p_uuid + "&action=addimg&imgtype=lose",
                done: function (e, data) {
                    $(".img_lose").attr("src", "handle/GGL_ShowImg.ashx?path=" + data.result + "&__s=" + Math.random());
                }
            })

        })()


        $("input").blur(function () {
            Common.validate();

        });

        $("#commit").click(function () {

            Common.submitAll(function () {
                alert("ok");

            });
        });


    </script>

</body>
</html>
