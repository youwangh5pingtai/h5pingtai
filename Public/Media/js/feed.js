
var lastFeedId = 0;
var isDetailPage = false;
var comments = [];
var isRefreshing = false;
var isLoading = false;

// 加载动态列表
function loadFeedList(callback) {
	$("#feed_list").empty();
	var url = "http://pp.9g.com/im/getfeeds?id=0&new=1&token=" + localStorage.token + "&r=" + Math.random();
	$.getJSON(url, function(feeds) {
		resetLastFeedId(feeds);
		renderFeeds(feeds);
		callback && callback.call(null);
	});
}

// 加载动态信息
function loadFeed(feedId, callback) {
	isDetailPage = true;
	showLoading();
	var url = "http://pp.9g.com/im/getfeed?&feed_id=" + feedId + "&token=" + localStorage.token + "&r=" + Math.random();
	$.getJSON(url, function(feed) {
		renderFeed(feed).appendTo($("#feed"));
		hideLoading();
		callback && callback.call(null);
	});
}

// 加载更多
function loadMoreFeed(callback) {
	var url = "http://pp.9g.com/im/getfeeds?&id=" + lastFeedId + "&token=" + localStorage.token + "&r=" + Math.random();
	$.getJSON(url, function(feeds) {
		resetLastFeedId(feeds);
		renderFeeds(feeds);
		callback && callback.call(null);
	});
}

// 重围最后一条动态 ID
function resetLastFeedId(feeds) {
	if (feeds.length > 0) {
		lastFeedId = feeds[feeds.length - 1].id;
	}
}

// 渲染动态列表
function renderFeeds(feeds) {
	$.each(feeds, function(i, feed) {
		// console.log(feed);
		renderFeed(feed).appendTo($("#feed_list"));
	});
}

// 渲染动态
function renderFeed(feed) {
	// 创建动态视图
	var $feed = $("<div></div>").addClass("feed").data("feed", feed);
	if (!isDetailPage) $feed.click(gotoFeed);
	// 渲染角色
	renderFeedRole(feed).appendTo($feed);
	// 渲染内容
	var $content = null;
	switch (feed.type) {
		case 1: $content = renderFeedNormal(feed); break;		// 常规动态
		case 2: $content = renderFeedCheckIn(feed); break;		// 签到
		case 3: $content = renderFeedGame(feed); break;			// 游戏
		// case 4: $content = renderFeedVideo(feed); break;		// 视频
		case 5: $content = renderFeedPhoto(feed); break;		// 随手拍
		case 6: $content = renderFeedHongBao(feed); break;		// 红包
		default: $content = renderFeedNormal(feed); break;		// 未知动态
	}
	if ($content != null) {
		$content.height($(document).width() - 20).appendTo($feed);
	}
	// 渲染控制栏
	renderFeedAction(feed).appendTo($feed);
	// 添加到列表
	return $feed;
}

// 渲染角色
function renderFeedRole(feed) {
	var $role = $("#templates .feed_role").clone();
	$role.data("role",feed);
	$role.find(".head").attr("src", game9g.utils.getHead132(feed.headimgurl));
	$role.find(".nickname").text(feed.nickname);
	$role.find(".tag").text(feed.tag).addClass(feed.sex == 0 ? "" : (feed.sex == 1 ? "male" : "female"));
	$role.find(".province").text(feed.province);
	$role.find(".city").text(feed.city);
	$role.find(".time").text(game9g.utils.formatTime(feed.ctime));
	$role.click(gotoRole);
	return $role;
}

// 常规动态
function renderFeedNormal(feed) {
	var $normal = $("#templates .feed_normal").clone();
	$normal.find(".image").attr("src", feed.content.image);
	$normal.find(".text").text(feed.content.text);
	return $normal;
}

// 签到
function renderFeedCheckIn(feed) {
	var $checkin = $("#templates .feed_checkin").clone();
	$checkin.find(".text").text(feed.content.text);
	return $checkin;
}

// 游戏
function renderFeedGame(feed) {
	var $game = $("#templates .feed_game").clone();
	$game.find(".text").text(feed.content.text);
	$game.find(".play").click(playGame);
	return $game;
}

// 随手拍
function renderFeedPhoto(feed) {
	var $photo = $("#templates .feed_photo").clone();
	$photo.find(".image").attr("src", feed.content.image);
	return $photo;
}

// 红包
function renderFeedHongBao(feed) {
	var $hongbao = $("#templates .feed_hongbao").clone();
	$hongbao.find(".type").text(feed.content.type == 1 ? "拼手气红包" : "红包");
	$hongbao.find(".text").text(feed.content.text);
	$hongbao.find(".lucky").click(openHongBao);
	return $hongbao;
}

// 渲染控制栏
function renderFeedAction(feed) {
	var $action = $("#templates .feed_action").clone();
	$action.find(".chat").click(chat);
	$action.find(".comment").text("评论" + (feed.comment > 0 ? "(" + feed.comment + ")" : "")).click(comment);
	$action.find(".good").text("赞" + (feed.good > 0 ? "(" + feed.good + ")" : "")).addClass(feed.feed_good == 1 ? "good_on" : "").click(good);
	return $action;
}

// 显示 loading
function showLoading() {
	$("#loading").show();
}

// 隐藏 loading
function hideLoading() {
	$("#loading").hide();
}

// 下载 App
function download() {
	window.location = "http://a.app.qq.com/o/simple.jsp?pkgname=com.game9g.pp&r=" + Math.random();
}

// 查看动态
function gotoFeed() {
	var feed = $(this).closest(".feed").data("feed");
	window.location = "feed_show.html?id=" + feed.id + "&r=" + Math.random();
}

// 玩游戏
function playGame() {
	var feed = $(this).closest(".feed").data("feed");
	// alert("play game:\n" + feed.content.gameid + "\n" + feed.id + "\n" + feed.role_id);
	var data = { feed_id: feed.id };
	window.location = game9g.baseurl + "/gamecenter.html?gameid=" + feed.content.gameid + "&source=feed_pk&data=" + encodeURIComponent(JSON.stringify(data)) + "&r=" + Math.random();
	return false;
}

// 打开红包
function openHongBao() {
	var feed = $(this).closest(".feed").data("feed");
	// alert("open hongbao:\n" + feed.content.id + "\n" + feed.id + "\n" + feed.role_id + "\n" + feed.content.type + "\n" + feed.content.text);
	if (confirm("《怦怦——不止于心动》\n下载怦怦 App 即可领取红包，现在就去下载？")) {
		download();
	}
	return false;
}

//个人主页
function gotoRole(){
	var role = $(this).data("role");
	window.location="role.html?id="+role.role_id;
	return false;
}

// 聊天
function chat() {
	var feed = $(this).closest(".feed").data("feed");
	// if (confirm("《怦怦——不止于心动》\n下载怦怦 App 即可与对方聊天，现在就去下载？")) {
	// 	download();
	// }
	window.location = "chat.html?talker=" + feed.role_id + "&r=" + Math.random();
	return false;
}

// 评论
function comment() {
	var feed = $(this).closest(".feed").data("feed");
	if (isDetailPage) {
		window.scrollTo(0, 999999);
		$("#comment_form .content").removeData("replyTo").focus();
	} else {
		window.location = "feed_show.html?id=" + feed.id + "&action=comment&r=" + Math.random();
	}
	return false;
}

// 点赞
function good() {
	var feed = $(this).closest(".feed").data("feed");
	var $good = $(this);
	var url = "http://pp.9g.com/im/feedgood?token=" + localStorage.token + "&feed_id=" + feed.id + "&r=" + Math.random();
	$.getJSON(url, function(data) {
		$good.text("赞" + (data.good > 0 ? "(" + data.good + ")" : "")).toggleClass("good_on", data.feed_good == 1);
	});
	return false;
}

// 加载动态评论
function loadFeedCommentList(feedId, scrollToEnd) {
	var url = "http://pp.9g.com/im/getfeedcommentlist?feed_id=" + feedId + "&r=" + Math.random();
	$.getJSON(url, function(data) {
		comments = data;
		if (comments.length > 0) $("#comment_list .empty").hide();
		$.each(comments, function(i, comment) {
			renderComment(comment).appendTo($("#comment_list"));
		});
		if (scrollToEnd) {
			window.scrollTo(0, 999999);
			$("#comment_form .content").focus();
		}
	});
}

// 渲染评论
function renderComment(comment) {
	var $comment = $("#templates .feed_comment").clone().data("comment", comment);
	renderFeedRole(comment).prependTo($comment);
	$comment.find(".content").text(comment.content);
	if (comment.parent_id != 0) {
		getCommentById(comment.parent_id, function(parent) {
			var quote = $comment.find("blockquote");
			renderFeedRole(parent).prependTo(quote);
			quote.find(".reply_content").text(parent.content);
			quote.show();
		});
	}
	$comment.find(".reply").click(reply);
	return $comment;
}

// 查找评论
function getCommentById(id, callback) {
	$.each(comments, function(i, comment) {
		if (comment.id == id) {
			callback && callback.call(null, comment);
			return false;
		}
	});
}

// 回复评论
function reply() {
	var comment = $(this).closest(".feed_comment").data("comment");
	$("#comment_form .content").data("replyTo", comment).attr("placeholder", "回复：" + comment.nickname).focus();
}

// 发表评论
function sendComment() {
	var feed = $(".feed").data("feed");
	var $content = $("#comment_form .content");
	var content = $content.val();
	if ($.trim(content) == "") {
		$content.focus();
		return;
	}
	var url;
	if ($content.data("replyTo")) {
		var parentId = $content.data("replyTo").id;
		url = "http://pp.9g.com/im/addfeedcommentreply?token=" + localStorage.token + "&feed_id=" + feed.id + "&parent_id=" + parentId + "&content=" + encodeURIComponent(content);
	} else {
		url = "http://pp.9g.com/im/addfeedcomment?token=" + localStorage.token + "&feed_id=" + feed.id + "&content=" + encodeURIComponent(content);
	}
	$.getJSON(url, function(data) {
		if (typeof data == "object") {
			if (data.comment) {
				alert("发表评论成功！");
				window.location = "feed_show.html?id=" + feed.id + "&action=comment_add&r=" + Math.random();
			} else {
				alert("发表评论失败：" + JSON.stringify(data));
			}
		} else {
			alert("发表评论失败");
		}
	});
}
