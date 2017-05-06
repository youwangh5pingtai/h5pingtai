<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-app-status-bar-style" content="black">
<link rel="apple-touch-icon-precomposed" href="/wm/wm/h5/Public/Media/images/icon_9g.png">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-store, must-revalidate">
<meta http-equiv="expires" content="0">
<title>溪谷软件_专注H5游戏，为您带来全新游戏体验</title>
<meta name="format-detection" content="telephone=no">
<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1,minimal-ui">
<meta name="keywords" content="">
<meta name="description" content="">
<meta name="full-screen" content="yes">
		<link rel="stylesheet" type="text/css" href="/wm/wm/h5/Public/Media/css/base.css">

		<script src="/wm/wm/h5/Public/Media/js/jquery-1.8.3.min.js"></script>
	</head>
	<body style="max-width: 640px; margin: 0px auto;height:100vh">
	
<link rel="stylesheet" type="text/css" href="/wm/wm/h5/Public/Media/css/login.css">
<div id="bodyBg">
	<div id="divWelcome">
		<p class="tip">请选择登录方式</p>
		<p class="dwc">
			<span id="wxlogin"><img onclick="login('weixin')" src="/wm/wm/h5/Public/Media/images/login_wx.png"><font>微信登录</font></span>
			<span id="telogin"><img onclick="login('phone')" src="/wm/wm/h5/Public/Media/images/login_mob.png"><font>手机登录</font></span>
            <span id="qqlogin"><img onclick="login('qq')"    src="/wm/wm/h5/Public/Media/images/login_qq.png"><font>QQ登录</font></span>
             <span id="qqlogin"><img onclick="login('account')"    src="/wm/wm/h5/Public/Media/images/login_user.png"><font>账号登录</font></span>
		</p>
		<p class="tip tipd">&nbsp;</p>
	</div>
</div>
<script>
function login(obj) {
    switch(obj){
        case 'phone':{
            var data = {"account":"输入手机号","gameboxlink":"忘记密码？点击这里重设","gameboxbtn":"登录/一键注册","gameboxtext":"重设密码","type":obj} ;
            box(data)
        };break;
        case 'account':{
            var data = {"account":"输入登陆账号","gameboxlink":"没有账号？点击这里注册","gameboxbtn":"登录","gameboxtext":"注册","type":obj} ;
            box(data)
        };break;
        default:{
            var url = '<?php echo U("thirdlogin");?>';
            url = url.replace(".html","")+"/type/"+obj;
            window.location=url;
        }
    }
}

function box(data) {
    $('.box').remove();
    $('#bodyBg').after('<div class="box"></div>');
	html = 	'<div id="gamemask" class="gamemask"></div>'
	html += '<div id="gamebox" class="gamebox">'
	html += '<div class="gameboxmain">'
	html += '<input style="display:none;"/><input type="text" class="gameboxtext" placeholder="'+data.account+'" value="" autocomplete="off">'
	html += '<input style="display:none;"/><input type="password" class="gameboxtext" placeholder="输入密码" autocomplete="off">'
    html += '<a class="gameboxlink" href="javascript:void(0)">'+data.gameboxlink+'</a>'
	html += '<div class="gameboxbtn">'+data.gameboxbtn+'</div>';
	html += '</div>'
	html += '<img class="gameboxclose" src="/wm/wm/h5/Public/Media/images/panel_close.png">'
	html += '</div>';
	$('.box').html(html);
	$('.gameboxclose').click(function() {
		$('.box').remove();
	});
    $('.gameboxlink').on('click',function() {
        var gbt = $.trim($('.gameboxtext').val()),
            ht ='<input style="display:none;"/><input type="text" class="gameboxtext" placeholder="'+data.account+'" value="" autocomplete="off">';
            ht += '<input style="display:none;"/><input type="password" class="gameboxtext" placeholder="设置密码">'
            ht += '<div class="gameboxbtn">'+data.gameboxtext+'</div>';               
            $('.gameboxmain').empty().html(ht);
            var way = data.type=="phone"?2:1;
            gameboxbtn(way);       
    });
    //### 0代表注册 1:代表重发(用户账号注册) 2:密码设置
    //#初始化
    gameboxbtn(0);
    function gameboxbtn(way) {
        $('.gameboxbtn').on('click',function() {
            var that = this;
            phone    = $('.gamebox :input[type=text]').val(),
            password = $('.gamebox :input[type=password]').val();
            pid="<?php echo I('pid');?>";
            gid="<?php echo I('gid');?>";
            if (!phone) {
                var msg = data.type == "phone"?"请输入手机号":"请输入账号";
                alert(msg);return false;
            }
            if (!password || password.length<6) {
                alert('请输入至少6位的密码');return false;
            }

            switch(way){
                case 0:{
                    $.ajax({
                        type:'post',
                        dataType:'json',
                        data:{"username":phone,"password":password,"type":data.type},
                        url:'<?php echo U("login");?>',
                        success:function(d) {
                            switch(d.status){
                                case 1:{
                                    window.location.href=d.url;
                                };break;
                                case 2:{
                                    t(phone,password,0,pid,gid,d);
                                };break;
                                default:{
                                    alert(d.msg);
                                }
                            }
                        },
                        error:function() {
                            alert('服务器故障，请稍后再试');
                        }
                    });
                };break;
                case 1:{
                    $.ajax({
                        type:'post',
                        dataType:'json',
                        data:{"username":phone,"password":password,"type":data.type,"game_id":0,"promote_id":0,"promote_account":"自然注册"},
                        url:'<?php echo U("register");?>',
                        success:function(data) {
                            switch(parseInt(data.status)) {
                                case -3: {
                                    alert(data.msg);
                                };break;
                                case 0:{
                                    alert(data.msg)
                                };break;
                                default:{
                                    window.location.href = data.url;
                                }
                                
                            }
                        },
                        error:function() {
                            alert('服务器故障，请稍后再试');
                        }
                    });
                };break;
                case 2:{
                    //t(phone,password,2,pid,gid,"123");
                    $.ajax({
                        type:'post',
                        dataType:'json',
                        data: {"phone":phone,"delay":1,"way":2,"type":data.type},
                        url: '<?php echo U("telsvcode");?>',
                        success:function(data) {
                            t(phone,password,2,pid,gid,data);
                        },
                        error:function() {
                            alert('服务器故障，请稍后再试');
                        }
                    });
                };break;
            }
        });
    }
    
    var t = function(phone,password,way,pid,gid,data) {
        var gbc=(way==2)?'完成':'激活', h = '<p>'+data.msg+'</p>';
        h += '<div class="gamebindp">'
        h += '<input class="gamebindpcode" placeholder="输入安全码" /><div class="gamebindpsend disabled">重新发送</div>'
        h += '</div><div class="gamebindpbot">'
        h += '<div class="gamebindpactive">'+gbc+'</div><div class="gamebindpcancel">取消</div></div>';
        $('.gameboxmain').empty().html(h);
        var b = r && r('.gamebindpsend',60);
        //重新发送 验证码                    
        $('.gamebindpsend').on('click',function() {
            if (!$(this).hasClass('disabled')) {
                var e = this;
                $.ajax({
                    type:'post',
                    url: '<?php echo U("telsvcode");?>',
                    data: 'phone='+phone,
                    dataType: 'json',
                    success: function(d) {
                        if (parseInt(d.status) == 2) {
                           $('.gameboxmain p').text(d.msg);
                           b = r && r('.gamebindpsend',60);                                           
                        } else {
                            $('.gameboxmain p').text(d.msg);
                        }
                    }
                });                                
            }
            return false;
        });
        //验证安全码                         
        $('.gamebindpactive').on('click',function() {
            pid="<?php echo I('pid');?>";
            gid="<?php echo I('gid');?>";
            var pcode = $.trim($('.gamebindpcode').val());
            if (pcode == '' ) {alert('请输入安全码');return false;}
            $.ajax({
                type:'post',
                dataType:'json',
                url:'<?php echo U("check_tel_code");?>',
                data:{"username":phone,"password":password,"type":data.type,"code":pcode,"g_id":gid,"g_name":"","p_id":pid,"p_account":"自然注册","way":way},
                success:function (d) {
                    switch (parseInt(d.status)) {
                        case 1:{
                            window.location.href=d.url;
                        };
                        break;
                        case 2:{
                            $('.gameboxmain p').text(d.msg);
                            clearInterval(b);
                            setTimeout(function() { 
                                var data = {
                                    "account":"输入手机号",
                                    "gameboxlink":"忘记密码？点击这里重设",
                                    "gameboxbtn" :"登录/一键注册",
                                    "gameboxtext":"重设密码",
                                    "type":"phone"
                                } ;
                                box(data);
                            },2000);
                        };break;
                        default: 
                            alert(d.msg);
                    }
                }
            });
        });
        
        $('.gamebindpcancel').on('click',function(e) {                           
            clearInterval(b);
            var data = {
                "account":"输入手机号",
                "gameboxlink":"忘记密码？点击这里重设",
                "gameboxbtn":"登录/一键注册",
                "gameboxtext":"重设密码",
                "type":"phone"
            };
            box(data);
        });
    }
    function r(e,r) {
        var r = r;
        $(e).addClass('disabled');
        if (r == 0) {
            $(e).text('重新发送');clearInterval(a);
            return;
        }
        var a = setInterval(function() {
            r--;
            $(e).text(r + '秒后重发'),
            0 == r && ($(e).removeClass('disabled'), $(e).text('重新发送'), clearInterval(a));
        },1e3);
        return a;
    };
    return false;
}

</script>

    <div id="qrcode">
		<p align="center">
			<img src="<?php echo get_cover(C('PC_SET_QRCODE'),'path');?>" id="qrcodeImg" width="180">
			<br>微信扫码 用手机玩
		</p>
	</div>
	</body>
</html>