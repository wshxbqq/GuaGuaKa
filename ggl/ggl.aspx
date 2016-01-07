<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ggl.aspx.cs" Inherits="guaguale_ggl_ggl" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <script>
        document.domain="jd.com";
    </script>
    <script src="../js/lib/jquery.js"></script>
    <script src="../js/lib/jquery.cookie.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style>
        body {
            margin:0px;
            padding:0px;
        }
        .container {
            width:640px;
            height:640px;
            overflow:hidden;
            margin:0 auto;
         <% if (bigimg != "")
            { %>
                background:url(handle/GGL_ShowImg.ashx?path=<%=bigimg %>);
        <%}
            else
            { %>
         background:url(img/bigbg.jpg);
        <%} %>
             
           
            position:relative;
        }
 
        .mask_panel{
         width: 400px;
            height: 160px;
            position:absolute;
            z-index:10;
            top: 240px;
            left: 107px;
        }

        .get_prize_btn{
                width: 300px;
    height: 98px;
    background: red;
    position: absolute;
    top: 450px;
    left: 150px;
        display:none;
        }

    </style>
    <style>
     
        .login_btn {
         width: 400px;
            height: 160px;
            position:absolute;
            z-index:100;
            top: 240px;
            left: 107px;
            background:#ccc;
        }
        .disable_panel {
            background-color:rgba(0, 0, 0, 0.53);
            position:absolute;
            width:100%;
            height:100%;
                z-index: 14;
                display:none;
        }
            .disable_panel p {
                margin-top: 300px;
    color:#fff;
    text-align: center;
    font-size: 29px;
    font-family: 微软雅黑;
            }

        .play_count {
        position: absolute;
    left: 200px;
    top: 194px;
    color: #fff;
    width: 210px;
    text-align: center;
    font-size: 22px;
    background-color: #828282;
    border-radius: 10px;
    height: 33px;
    line-height: 33px;
        
        }

    </style>
</head>
<body>


    <div class="container">
        <div class="play_count">今天还有<span>0</span>次机会</div>
        <div class="login_btn"></div>
        <div class="disable_panel"><p>今日游戏次数已用完</p></div>
        <canvas class="mask_panel" id="mask"></canvas>
    </div>












    <script>
        var count_remian = 0;
        
 
        var shop_uuid="<%= shopUUID%>";
        window.complete = 0;
        var maskimg = "img/mask.jpg";
        if ("<%= maskimg%>" !== "") {
             maskimg = "handle/GGL_ShowImg.ashx?path=<%= maskimg %>";
        }

        


        var lose_img = "<%= lose_img %>";
        if (lose_img) {
            lose_img = "handle/GGL_ShowImg.ashx?path=<%= lose_img %>";
        } else {
            lose_img = "img/lose.jpg";
        }
        var isLogin = function (cb) {
            var sid = window.top.getArgs().sid || $.cookie("sid");
            if (sid) {
                $.cookie("sid", sid)
            }

            window.top.$.post("http://act.jshop.jd.com/m/islogin.html", { "sid": sid }, function (data) {
                cb(data);

            })
            return;
        };



        raffleStart();
        
      

 
       
  
       
        function hideGua() {
            $(".disable_panel").show();


        }

        function raffleStart() {
            isLogin(function (d) {
                if (d.isLogined) {
                    $(".login_btn").hide();
                    raffle(d);
                } else {
                    $(".login_btn").bind("touchstart", function () { window.top.location.href = "http://m.jd.com/user/login.action?returnurl=" + encodeURIComponent(window.top.location.href); });
                    $(".login_btn").bind("click", function () { window.top.location.href = "http://m.jd.com/user/login.action?returnurl=" + encodeURIComponent(window.top.location.href); });
                    $(".play_count").html("您还未登录,请登录");

                }
            })

        }
     
             function raffle(d) {
            window.top.$.ajax({
                url: "http://ls.activity.jd.com/lotteryApi/getLotteryInfo.action",
                data: {
                    lotteryCode: shop_uuid,
                    authType: 2,
                    cookieValue: d.enpin
                },
                dataType: "jsonp",
                jsonpCallback: "callbackInfo",
                success: function (infoData) {

                    window.top.$.ajax({
                        url: "http://l.activity.jd.com/mobile/lottery_start.action",
                        data: {
                            lotteryCode: shop_uuid,
                            authType: 2,
                            cookieValue: d.enpin
                        },
                        dataType: "jsonp",
                        jsonpCallback: "callback",
                        success: function (data) {

                            window.complete = 0;
                            count_remian = parseInt(data.data.chances);
                            $(".play_count span").html(count_remian+1);
                            var pass = data.data.pass;
                            if (!pass && count_remian == 0) {
                                $(".play_count span").html(count_remian);
                                hideGua();
                            }

                            if (data.data.winner) {
                                var prizeId = data.data.prizeId;
                                for (var __i in infoData.data.lotteryPrize) {
                                    if (infoData.data.lotteryPrize[__i]["prizeId"] == prizeId) {

                                        initCanvas(infoData.data.lotteryPrize[__i]["prizeImg"], maskimg);

                                    }
                                }
                            } else {

                                initCanvas(lose_img, maskimg);



                            }


                        }
                    });
                }
            });        }          function initCanvas(src,maskSrc) {
           
            window.canvasP = $("#mask").offset();
            window.mousePath = [];
            var maskimgDom = window.maskimgDom = document.createElement("img");
            maskimgDom.addEventListener('load', function (e) {
                (function (bodyStyle) {
                    bodyStyle.mozUserSelect = 'none';
                    bodyStyle.webkitUserSelect = 'none';
                    var img = new Image();
                    var canvas = document.querySelector('canvas');
                    canvas.style.backgroundColor = 'transparent';
                    canvas.style.position = 'absolute';
                    img.addEventListener('load', function (e) {
                        var ctx;
                        var w = img.width, h = img.height;
                        var offsetX = canvas.offsetLeft, offsetY = canvas.offsetTop;
                        var mousedown = false;
                        function layer(ctx) {
                            ctx.drawImage(maskimgDom, 0, 0);
                        }
                        function eventDown(e) {
                            e.preventDefault();
                            mousedown = true;
                            if (window.complete) {


                            }
                        }
                        function eventUp(e) {
                            e.preventDefault();
                            mousedown = false;
                        }
                        function eventMove(e) {
                            e.preventDefault();
                            if (window.complete) {
                                return;
                            }
                            if (mousedown) {
                                if (e.changedTouches) {
                                    e = e.changedTouches[e.changedTouches.length - 1];
                                }

                                var x = e.pageX - canvasP.left;
                                var y = e.pageY - canvasP.top;
                                window.mousePath.push({ x: x, y: y });
                                if (window.mousePath.length > 100) {

                                    window.complete = 1;
                                    ctx.save()
                                    ctx.beginPath()
                                    ctx.arc(x, y, 2000, 0, 2 * Math.PI);
                                    ctx.clip()
                                    ctx.clearRect(0, 0, 400, 160);
                                    ctx.restore();
                                    setTimeout(function () {
                                        raffleStart();
                                    }, 1000);
                                    

                                }
                                ctx.save()
                                ctx.beginPath()
                                ctx.arc(x, y, 20, 0, 2 * Math.PI);
                                ctx.clip()
                                ctx.clearRect(0, 0, 400, 160);
                                ctx.restore();
                            }
                        }
                        canvas.width = w;
                        canvas.height = h;
                        canvas.style.backgroundImage = 'url(' + img.src + ')';
                        ctx = canvas.getContext('2d');
                        ctx.fillStyle = 'transparent';
                        ctx.fillRect(0, 0, w, h);
                        layer(ctx);
                        ctx.globalCompositeOperation = 'destination-out';
                        canvas.addEventListener('touchstart', eventDown);
                        canvas.addEventListener('touchend', eventUp);
                        canvas.addEventListener('touchmove', eventMove);
                        canvas.addEventListener('mousedown', eventDown);
                        canvas.addEventListener('mouseup', eventUp);
                        canvas.addEventListener('mousemove', eventMove);
                    });

                    var __spliter = "?";
                    if (src.indexOf("?")>-1) {
                        __spliter = "&";
                    }
                    img.src = src + __spliter+"__=" + Math.random();


                })(document.body.style);

            });
            maskimgDom.src = maskimg;

                   }
       

    </script>
</body>
</html>
