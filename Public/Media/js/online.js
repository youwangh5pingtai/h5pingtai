
var game9g = new Game9G();

var isRefreshing = false;
var isLoading = false;

$(document).ready(function(){
	game9g.auth.check({ level: "user" });
});

game9g.addEventListener("roleReady", ready);
game9g.addEventListener("newMessage", onNewMessage);

// Ready
function ready() {
	// 分享
	initShare();
	// 导航菜单
	showLoading();
	// 加载玩家列表
	loadOnlineList(function() {
		hideLoading();
	});
	// 下拉刷新 & 上拉加载更多
	$(window).scroll(onScroll);
}

// 分享
function initShare() {
	game9g.setShareData({
		imgurl: "http://game.9g.com/img/pengpeng_logo.png",
		link: game9g.baseurl + "/app/feed.html?r=" + Math.random(),
		title: "前方高能！发现大波帅男靓女正在匿名群嗨、羞羞真心话和私密游戏，围观的点我……",
		content: "群主说，未满18岁的不让进来， 可是里面明显妹子比汉子多啊，这样真的好吗？"
	});
}

// 下拉刷新 & 上拉加载更多
function onScroll() {
	if (isRefreshing || isLoading) return;
	if ($(window).scrollTop() <= 0) {
		// 下拉刷新
		isRefreshing = true;
		$("#loading").appendTo($("#top"));
		$("#loading").slideDown("fast", function() {
			loadOnlineList(function() {
				$("#loading").slideUp("fast", function(){
					isRefreshing = false;
				});
			});
		});
	}
}

// 消息事件
function onNewMessage(data) {
	if (data > 0) {
		var $badge = $(".nav .badge_message");
		if ($badge.size() == 0) {
			$badge = $("<div></div>").addClass("badge_message");
			$badge.appendTo($(".nav"));
		}
		$badge.text(data);
	} else {
		$(".nav .badge_message").remove();
	}
}

// 加载在线列表
function loadOnlineList(callback) {
	$("#list").empty();
	// var url = "http://wx.9g.com/im/online.jsp";
	var url = "http://pp.9g.com/im/online?token=" + localStorage.token+(game9g.utils.getParameter("sex")?("&sex="+game9g.utils.getParameter("sex")):"");
	$.getJSON(url, function(json) {
		$.time = json.time;
		renderList(json.online);
		callback && callback.call(null);
	});
}

// 显示 loading
function showLoading() {
	$("#loading").show();
}

// 隐藏 loading
function hideLoading() {
	$("#loading").hide();
}

// 渲染在线列表
function renderList(list) {
	$.each(list, function(i, json) {
		// console.log(json);
		renderItem(json).appendTo($("#list"));
	});
}

// 渲染在线用户
function renderItem(user) {
	var $item = $("#templates .item").clone().data("user", user);
	$item.find(".headimg").attr("src", game9g.utils.getHead132(user.headimgurl));
	$item.find(".nickname").text(user.nickname);
	if (user.role_id) {
		$item.find(".tag").text(user.tag).addClass(user.sex == 0 ? "" : (user.sex == 1 ? "male" : "female"));
	}
	var city = user.province + " " + user.city;
	if ($.trim(city) == "") city = "火星";
	$item.find(".city").text(city);
	var content;
	if (user.gameid) {
		if (user.last_scorename) {
			content = "玩 [" + user.gamename + "] " + user.last_scorename;
		} else {
			content = "正在玩 [" + user.gamename + "]";
		}
	} else {
		content = "正在刷新动态";
	}
	$item.find(".content").text(content);
	$item.find(".time").text(formatTime(user.xtime));
	if (user.gameid) {
		$item.find(".game").click(playGame)
		$item.find(".gameicon").attr("src", user.gameicon);
		$item.find(".gamename").text(user.gamename);
	} else {
		$item.find(".game").hide();
	}
	$item.click(goRole);
	return $item;
}

// 时间格式
function formatTime(t) {
	if (isNaN(t)) return "";
	if($.time - t>59){
		return parseInt(($.time - t)/60) + "分钟前";
	}
	else{
		return ($.time - t) + "秒前";
	}
}

// 查看个人主页
function goHome() {
	var user = $(this).data("user");
	$.getJSON("http://wx.9g.com/app/getuser?uid=" + user.uid, function(data) {
		if (data.wx9guid)
			window.location = "homepage.html?id=" + data.wx9guid + "&r=" + Math.random();
	});
}

// 聊天
function goChat() {
	var user = $(this).data("user");
	window.location = "chat.html?talker=" + user.role_id + "&r=" + Math.random();
}

// 角色个人主页
function goRole() {
	var user = $(this).data("user");
	if (user.role_id) {
		window.location = "role.html?id=" + user.role_id + "&r=" + Math.random();
	} else {
		game9g.utils.debug("calluser: uid = " + user.uid);
		var url = "http://pp.9g.com/im/calluser?token=" + localStorage.token + "&uid=" + user.uid;
		$.getJSON(url, function(data) {
			if (data.role_id) {
				window.location = "role.html?id=" + data.role_id + "&r=" + Math.random();
			}
		});
	}
}

// 玩游戏
function playGame(e) {
	var $item = $(this).closest(".item");
	var gameid = $item.data("user").gameid;
	window.location = game9g.baseurl + "/gamecenter.html?gameid=" + gameid + "&r=" + Math.random();
	e.preventDefault();
	e.stopPropagation();
}
