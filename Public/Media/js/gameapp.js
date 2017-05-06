var GameApp = {
		lastver:10007
		,
		lastverstring:"1.0.07"
		,
		request:function(name) {
			var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
			var r = window.location.search.substr(1).match(reg);
			if (r != null) return unescape(r[2]); return null;
		}
		,
		verstring:function(){		
			var u=navigator.userAgent;
			if(u.split(" ")[u.split(" ").length-2]=="Game9g"){
				var ver = u.split(" ")[u.split(" ").length-1];
				return ver;
			}
		}
		,
		ver:function(){		
			var u=navigator.userAgent;
			if(u.split(" ")[u.split(" ").length-2]=="Game9g"){
				var ver = u.split(" ")[u.split(" ").length-1];
				return parseInt(ver.split(".")[0])*10000+ parseInt(ver.split(".")[1])*100+parseInt(ver.split(".")[2]);
			};		
		}
		,
		isapp:function(){
			var u=navigator.userAgent;
			if(u.split("Game9g").length>1){
				return true;
			}
			else{
				return false;
			}
		}
		,
		uuid:function(){
			var u=navigator.userAgent;
			if(u.split("uuid ").length>1){
				return u.split("uuid ")[1].split(" ")[0]
			};		
		}
		,
		phonenum:function(){
			var u=navigator.userAgent;
			if(u.split("phoneNum ").length>1){
				var p =  u.split("phoneNum ")[1].split(" ")[0];
				if(p.split("+86").length>1)p=p.split("+86")[1];
				if(p.length>6)return p;
			};		
		}
		,
		isios:function(){		
			var u=navigator.userAgent;
			if(u.split("uuid ios").length>1){
				return true;
			}
			else{
				return false;
			}
		}
		,
		isjiuju:function(){		
			var u=navigator.userAgent;
			if(u.split(" jiuju ").length>1){
				return true;
			}
			else{
				return false;
			}
		}
		,
		weixinlogin:function(){
			if (/micromessenger/ig.test(navigator.userAgent)) {
				//微信浏览器
				window.location="/goto9g.html?r="+Math.random();
				return;
			}
			if (!GameApp.isapp()) {
				//非APP的普通浏览器
				if(confirm("启动并添加微信号\"game9g\"")){
					window.location="weixin:";
				}
				return;
			}
		
			if(GameApp.isios()){
				document.location="appcall::weixinlogin";
				return;
			}
			if(GameApp.ver()<10007){
				//兼容旧版
				document.title="weixinlogin";
				setTimeout("document.title='9G游戏'",500);
			}
			else{
				//兼容旧版
				document.title="weixinlogin";
				setTimeout("document.title='9G游戏'",500);
				document.addEventListener("sendauth", function(e){
					//alert(e.code);
					doLogin(e.code);			
				})	
				window.game9gappjs.jsCall("weixinlogin");
			}
		}		
	}

