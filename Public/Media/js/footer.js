var _footers=new Array();
_footers[0] = ["search.html","game.html","games.html","games_2.html","games_4.html","games_ds.html","ka.html","ka_detail.html","game_ka.html","game_index.html"];
_footers[1] = [];
_footers[2] = ["feed_show.html","feed_add.html","feed_add_2.html"];
_footers[3] = ["feed.html","feed_show.html","feed_add.html","feed_add_2.html"];
_footers[4] = ["hongbao","event.html","event_2.html","event_3.html","feed.html","find.html","online.html","top.html","quan_top.html","rank.html","rank_new.html","top_charm7d.html","top_newuser.html"];
//_footers[3] = ["friends.html","friend.html","games_3.html","zoo.html"];
_footers[5] = ["message.html","my.html","task.html","about.html","bindphone.html","my_credit.html","my_credit_get.html","my_credit_fee.html","my_credit_faq.html","my_credit_pay.html","friends.html","zoo.html","games_3.html","my_games.html"];
var _footer_id=-1;
for(var i=0;i<=5;i++){
	for(var j=0;j<_footers[i].length;j++){
		if(window.location.href.indexOf(_footers[i][j],1)>0){
			_footer_id=i;
		}
	}
}

var _footer="";
var ver="20141205"+Math.random();
_footer+='<div style="height:50px;width:100%;"></div>';
_footer+='<div id="fix_footer" style="border-top:1px solid #ddd;left:0;background-color:#f8f8f8;line-height:80%;color:#ffffff;height:50px;width:100%;position:fixed;bottom:0%;">';
_footer+='<table width=100% height=100% border=0>';
_footer+='<tr>';
if(_footer_id==0){
	_footer+='<td width=33% onclick="window.location=\'/app/games.html?r='+ver+'\';" align=center><img style="filter:invert" src=http://game.9g.com/images/nav_14_on.png height=24><br><span id="menu_1_label" style="font-size:10.5px;color:red">游戏</span></td>';
}
else{
	_footer+='<td width=33% onclick="window.location=\'/app/games.html?r='+ver+'\';" align=center><img style="filter:invert" src=http://game.9g.com/images/nav_14_off.png height=24><br><span id="menu_1_label" style="font-size:10.5px;color:#929292">游戏</span></td>';
}

if(_footer_id==4){
 	_footer+='<td width=33%  onclick="window.location=\'/app/find.html?r='+ver+'\';" align=center><img src=http://game.9g.com/images/nav_16_on.png?v=1 height=24><br><span id="menu_3_label" style="font-size:10.5px;color:red">发现</span></td>';
 }
 else{
 	_footer+='<td  width=33%  onclick="window.location=\'/app/find.html?r='+ver+'\';" align=center><img src=http://game.9g.com/images/nav_16_off.png?v=1 height=24><br><span id="menu_3_label" style="font-size:10.5px;color:#929292">发现</span></td>';
 }

//if(_footer_id==1){
//	_footer+='<td  width=20%  onclick="window.location=\'/app/event.html?r='+ver+'\';" align=center><img src=http://game.9g.com/images/nav_5_on2.png height=24><br><span style="font-size:10.5px;color:red">比赛</span></td>';
//}
//else{
//	_footer+='<td  width=20%  onclick="window.location=\'/app/event.html?r='+ver+'\';" align=center><img src=http://game.9g.com/images/nav_5_off.png height=24><br><span style="font-size:10.5px;color:#929292">比赛</span></td>';
//}


/**
if(_footer_id==2){
	_footer+='<td width=25%  onclick="window.location=\'/app/message.html?r='+ver+'\';" align=center><img id=imgIm src=http://game.9g.com/images/nav_13_on.png height=24><br><span id="menu_3_label" style="font-size:10.5px;color:red">消息</span></td>';
}
else{
	_footer+='<td  width=25%  onclick="window.location=\'/app/message.html?r='+ver+'\';" align=center><img id=imgIm src=http://game.9g.com/images/nav_13_off.png height=24><br><span id="menu_3_label" style="font-size:10.5px;color:#929292">消息</span></td>';
}

if(_footer_id==3){
 	_footer+='<td width=16%  onclick="window.location=\'/app/feed.html?r='+ver+'\';" align=center><img src=http://game.9g.com/images/nav_12_on.png?v=1 height=24><br><span id="menu_3_label" style="font-size:10.5px;color:red">动态</span></td>';
}
else{
 	_footer+='<td  width=16%  onclick="window.location=\'/app/feed.html?r='+ver+'\';" align=center><img src=http://game.9g.com/images/nav_12_off.png?v=1 height=24><br><span id="menu_3_label" style="font-size:10.5px;color:#929292">动态</span></td>';
}
**/
 

 
if(_footer_id==5){
	_footer+='<td width=33%  onclick="window.location=\'/app/my.html?r='+ver+'\';" align=center><img src=http://game.9g.com/images/nav_11_on.png height=24><br><span id="menu_3_label" style="font-size:10.5px;color:red">我</span></td>';	
}
else{
	_footer+='<td  width=33%  onclick="window.location=\'/app/my.html?r='+ver+'\';" align=center><img src=http://game.9g.com/images/nav_11_off.png height=24><br><span id="menu_3_label" style="font-size:10.5px;color:#929292">我</span></td>';
}
_footer+='</tr>';
_footer+='</table>';

/****************************** badge ***********************************/

_footer += '<div id="footer_badge_message" style="position: absolute; left: 83%; top:3px; background: #F00; border-radius: 8px; color: #FFF; padding: 2px 5px; font-family: SimHei; font-size: 12px; display: none;"></div>';

/****************************** badge ***********************************/

_footer+='</div>';


_footer+='<div style="display:none">';

// 2015-3-16 Game9G app 不显示底部菜单
// 2015-8-17 去掉此限制
// if (navigator.userAgent.toLowerCase().indexOf("game9g") != -1) _footer = '<div style="display:none">';

document.write(_footer);

//var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
//document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F0ae524064813b8dc07ece5ce724a7b04' type='text/javascript'%3E%3C/script%3E"));

var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");
// document.write(unescape("%3Cspan id='cnzz_stat_icon_2947366'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s5.cnzz.com/stat.php%3Fid%3D2947366' type='text/javascript'%3E%3C/script%3E"));
// 2015-12-11 改为异步加载
var cnzz_s_tag = document.createElement("script");
cnzz_s_tag.type = "text/javascript";
cnzz_s_tag.async = true;
cnzz_s_tag.charset = "utf-8";
cnzz_s_tag.src = cnzz_protocol + "s5.cnzz.com/stat.php?id=2947366&async=1";
var root_s = document.getElementsByTagName("script")[0];
root_s.parentNode.insertBefore(cnzz_s_tag, root_s);

document.write('</div>');



function resizeWindow () {
    var DEFAULT_WIDTH = 320, // 页面的默认宽度
        ua = navigator.userAgent.toLowerCase(), // 根据 user agent 的信息获取浏览器信息
        deviceWidth = window.screen.width, // 设备的宽度
        devicePixelRatio = window.devicePixelRatio || 1, // 物理像素和设备独立像素的比例，默认为1
        targetDensitydpi;

    // Android4.0以下手机不支持viewport的width，需要设置target-densitydpi
    if (ua.match(/MicroMessenger/i)=="micromessenger"&& ua.indexOf("android") != -1) {
        targetDensitydpi = DEFAULT_WIDTH / deviceWidth * devicePixelRatio * 160;
        $('meta[name="viewport"]').attr('content', 'target-densitydpi=' + targetDensitydpi +
                ', width=device-width, user-scalable=no');
    }

    // TODO: 其他手机需要特殊处理的在下面

}
//resizeWindow();


/**************************************************** 未读消息数 ****************************************************************/

if (window.game9g) {
	game9g.addEventListener("newMessage", function(data) {
		var badgeMessage = document.getElementById("footer_badge_message");
		if (data > 0) {
			badgeMessage.innerHTML = data;
			badgeMessage.style.display = "";
		} else {
			badgeMessage.innerHTML = "";
			badgeMessage.style.display = "none";
		}
	});
	
	//修改标题
	if(game9g.spid&&game9g.spid!="9g"){
		game9g.on("spReady",function(){
			if(game9g.sp.spname)document.title=game9g.sp.spname;
		});	
	}
}


/**************************************************** 适应了PC大小以及在PC可以使用微信登录 ****************************************************************/
//2016-1-22适应了PC大小以及在PC可以使用微信登录
window.__getJSON = function(url, callback) {
	var xmlhttp = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
	xmlhttp.open("GET", url, true);
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			var data = null;
			try {
				data = JSON.parse(xmlhttp.responseText);
			} catch (e) {
				data = this.xmlhttp.responseText;
			}
			callback && callback.call(xmlhttp, data);
		}
	};
	xmlhttp.send(null);
};
function resizePcMobile(){
	var mobileAgent = new Array("iphone", "ipod", "ipad", "android", "mobile", "blackberry", "webos", "incognito", "webmate", "bada", "nokia", "lg", "ucweb", "skyfire");
	var browser = navigator.userAgent.toLowerCase(); 
	var isMobile = false; 
	for (var i=0; i<mobileAgent.length; i++){ 
		if (browser.indexOf(mobileAgent[i])!=-1){
			isMobile = true; 
		}
	} 
	if(!isMobile){
		//document.title="9G游戏-9G.com"
		document.getElementsByTagName("body")[0].style.maxWidth="640px";
		document.getElementsByTagName("body")[0].style.margin="0 auto";
		document.getElementById("fix_footer").style.maxWidth="640px";
		document.getElementById("fix_footer").style.left=0;
		document.getElementById("fix_footer").style.right=0;
		document.getElementById("fix_footer").style.margin="auto";
		var span = document.getElementById("fix_nav");
		if(span){
			span.style.maxWidth="640px";
			span.style.left=0;
			span.style.right=0;
			span.style.margin="auto";
		}
		
		var w=window.innerWidth;
		var r = ((w-640)/2-220)/2;
		if(r>0){
			var div = "<div id='qrcode' style='position:fixed;top:5px;right:"+r+"px;width:220px'>";
			div+="<p align=center><img src=http://www.9g.com/wx_9g.jpg id=qrcodeImg width=180><br>微信扫码登录</p>";
			div+="</div>";
			document.write(div);
			
			if(window.game9g){
				game9g.auth.getUser(function(user){
					if(user){
						$("#qrcode").html("  <span style='font-size:14px' onclick='window.location=\"/app/my.html\"'><img style='vertical-align: middle;-webkit-border-radius: 5px; -moz-border-radius: 5px; border-radius: 5px;' src='"+user.headimgurl+"' width=20 height=20> " + user.nickname+"</span> | <span style='font-size:14px' onclick='window.location=\"/app/logout.html\"'>退出登录</span>");
					}
				});
			}
			
			if(!localStorage.token){
				__getJSON("http://wx.9g.com/qrcode/create?type=login", function (data) {
					//scene = data.scene;
					document.getElementById("qrcodeImg").src =data.url;		
					checkRqCode(data.scene);
				});	
			}
		}
	}
}
// 检查扫描结果
function checkRqCode(scene) {
	__getJSON("http://wx.9g.com/qrcode/check?scene=" + scene, function (data) {
		switch (data.status) {
			case -1:
				//alert("二维码已失效");
				break;
			case 0:
				setTimeout(function(){checkRqCode(scene);}, 1000);
				break;
			case 1:
				top.location = "/app/login.html?token="+data.token;
				break;
		}
	});
}
resizePcMobile();
///////////////////////