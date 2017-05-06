
// Ajax 类
Game9GUtilsAjax = function(method, url, data, type, success) {
	this.xmlhttp = null;
	if (window.XMLHttpRequest) {
		this.xmlhttp = new XMLHttpRequest();
	}
	else {
		this.xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
	}
	this.type = type;
	this.success = success;
	this.xmlhttp.open(method, url, true);
	var _this = this;
	this.xmlhttp.onreadystatechange = function() {
		_this.callback.apply(_this);
	};
	this.xmlhttp.send(data);
}

// Ajax 请求回调
Game9GUtilsAjax.prototype.callback = function() {
	if (this.xmlhttp.readyState == 4 && this.xmlhttp.status == 200) {
		var data = null;
		switch (this.type) {
			case "text":
				data = this.xmlhttp.responseText;
				break;
			case "json":
				try {
					data = JSON.parse(this.xmlhttp.responseText);
				}
				catch (e) {
					data = this.xmlhttp.responseText;
				}
				break;
		}
		this.success && this.success.call(this.xmlhttp, data);
	}
}

// JSONP 类
Game9GUtilsJsonp = function(url, data, jsonparam, success, timeout) {
	var finish = false;
	var theHead = document.getElementsByTagName("head")[0] || document.documentElement;
	var scriptControll = document.createElement("script");
	var jsonpcallback = "jsonpcallback" + (Math.random() + "").substring(2);
	var collect = function() {
		if (theHead != null) {
			theHead.removeChild(scriptControll);
			try {
				delete window[jsonpcallback];
			} catch (ex) { }
			theHead = null;
		}
	};
	var init = function() {
		scriptControll.charset = "utf-8";
		theHead.insertBefore(scriptControll, theHead.firstChild);
		window[jsonpcallback] = function(responseData) {
			finish = true;
			success(responseData);
		};
		jsonparam = jsonparam || "callback";
		if (url.indexOf("?") > 0) {
			url = url + "&" + jsonparam + "=" + jsonpcallback;
		} else {
			url = url + "?" + jsonparam + "=" + jsonpcallback;
		}
		if (typeof data == "object" && data != null) {
			for (var p in data) {
				url = url + "&" + p + "=" + escape(data[p]);
			}
		}
	};
	var timer = function() {
		if (typeof window[jsonpcallback] == "function") {
			collect();
		}
		if (typeof timeout == "function" && finish == false) {
			timeout();
		}
	};
	this.request = function() {
		init();
		scriptControll.src = url;
		window.setTimeout(timer, 10000);
	};
}
