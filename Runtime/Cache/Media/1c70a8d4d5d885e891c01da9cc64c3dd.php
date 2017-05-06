<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html>
<head>
	<meta property="qc:admins" content="71472552776166367" />
	<meta property="qc:admins" content="0500007726643536375" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-app-status-bar-style" content="black">
	<link rel="apple-touch-icon-precomposed" href="/wm/wm/h5/Public/Media/images/icon_9g.png">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="Cache-Control" content="no-store, must-revalidate">
	<meta http-equiv="expires" content="0">
	<title><?php echo C(PC_SET_TITLE);?></title>
	<meta name="format-detection" content="telephone=no">
	<meta name="viewport" content="user-scalable=no, width=device-width, initial-scale=1, maximum-scale=1,minimal-ui">
	<meta name="keywords" content="<?php echo C(PC_SET_META_KEY);?>">
	<meta name="description" content="<?php echo C(PC_SET_META_DESC);?>">
	<meta name="full-screen" content="yes">
	<link rel="stylesheet" type="text/css" href="/wm/wm/h5/Public/Media/css/base.css">
	<script src="/wm/wm/h5/Public/Media/js/jquery-1.8.3.min.js"></script>
</head>
	<body style="max-width: 640px; margin: 0px auto;">
	<div style="background:#fff;min-height:100vh">
	
	<link href="/wm/wm/h5/Public/Media/css/news.css" rel="stylesheet" />
	<div id="fix_nav" class="fix_nav"> 
		<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
			<tr height="3" id="nav_line" class="nav_line">
				<td class="<?php if(I("category") == media_activity): ?>active<?php endif; ?>"></td>
				<td class="<?php if(I("category") == media_new): ?>active<?php endif; ?>"></td>
				<td class="<?php if(I("category") == media_gg): ?>active<?php endif; ?>"></td>
			</tr>
			<tr class="fn2">
				<td onclick="window.location=&#39;<?php echo U('News/index?category=media_activity');?>&#39;">
					<span id="menu_1_label"  class="<?php if(I("category") == media_activity): ?>active<?php endif; ?>">游戏活动</span>
				</td>
				<td onclick="window.location=&#39;<?php echo U('News/index?category=media_new');?>&#39;">
					<span id="menu_1_label"  class="<?php if(I("category") == media_new): ?>active<?php endif; ?>">游戏新闻</span>
				</td>
				<td onclick="window.location=&#39;<?php echo U('News/index?category=media_gg');?>&#39;">
					<span id="menu_1_label"  class="<?php if(I("category") == media_gg): ?>active<?php endif; ?>">游戏公告</span>
				</td>
			</tr>
		</table>
	</div>
	<div id="nav_end" style="height:50px;"></div>
	<!-- <table border="0" cellspacing="0" cellpadding="0" width="100%">
	  <tbody>
		<tr>
		  <td><img src="<?php echo ($ad[0]["picurl"]); ?>" width="100%" border="0" onclick="window.location='<?php echo ($ad[0]["slideurl"]); ?>'"></td>
		</tr>
	  </tbody>
	</table> -->
	<div class="wrap">
		<ul class="list">
			<li class="template gameinfo">
				<div class="time"></div>
				<div class="num"></div>
				<img class="avatar">
				<div class="score">
					<div class="nickname"></div>
					<div class="scorename"></div>
				</div>
			</li>
			<?php $__CATE__ = D('Category')->getChildrenId($category['id']);$__LIST__ = D('Document')->page(!empty($_GET["p"])?$_GET["p"]:1,10)->lists($__CATE__, '`level` DESC,`id` DESC', 1,true); if(is_array($__LIST__)): $i = 0; $__LIST__ = $__LIST__;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$article): $mod = ($i % 2 );++$i;?><li class="gameinfo">
			  <div class="time"><a href="<?php echo U('News/detail?id='.$article['id']);?>" class="play-btn">阅读</a></div>
			  <div class="num"></div>
			  <img class="avatar" src="<?php echo (get_cover($article["cover_id"],'path')); ?>">
			  <div class="score">
				<div class="nickname"><?php echo ($article["title"]); ?></div>
				<div class="scorename">
					<span class="">发布：<?php echo get_admin_name($article['admin']);?></span>&nbsp;&nbsp;&nbsp;&nbsp;
					<span class="">浏览：<?php echo ($article["view"]); ?></span><br/>
					<span class=""><?php echo ($article["description"]); ?></span>
				</div>
			  </div>
			</li><?php endforeach; endif; else: echo "" ;endif; ?>
		</ul>
		<script>
			loadd();
			function loadd(){
				var loading ='<img src="/wm/wm/h5/Public/Media/images/loading.gif">正在加载中';
				var nodata = '已加载完成全部数据';
				var total='<?php echo ($total); ?>';
				var page = '<?php echo ($page); ?>';
				$(window).bind("scroll", function(){
					var more=$(".loading");
					var $this =$(this),
						viewH =$(document.body).height(),//可见高度
						contentH =$(window).height(),//内容高度
						scrollTop =$(this).scrollTop(),//滚动高度
						newht = viewH - contentH - scrollTop;
					if (page > total){
						more.unbind().html(nodata).css({'background':'#fff'});
						return;
					}
					if(newht <= 0){
						$(".loading").show();
						
						$.ajax({
							type: 'POST',
						  async: true,
					  dataType : 'json',
							url: '/wm/wm/h5/media.php?s=/News/news',
						   data: 'p='+page+'&type=<?php echo ($type); ?>',
					 beforeSend: function(){
									more.html(loading);
								},
						success: function (data) {
								switch (parseInt(data.status)) {
									case 1:
									page = data.page;
									var d = data.data;
									var val = '';
									for(var i=0;i<d.length;i++) {
										val += '<li class="gameinfo">';
										val += '<div class="time"><a href="/wm/wm/h5/media.php?s=/News/detail/id/'+d[i].id+'" class="play-btn">阅读</a></div>';
										val += '<div class="num"></div>';
										val += '<img class="avatar" src="'+d[i].picurl+'">';
										val += '<div class="score">';
										val += '<div class="nickname">'+d[i].title+'</div>';
										val += '<div class="scorename">';
										val += '<span class="">作者：'+d[i].nickname+'</span>&nbsp;&nbsp;&nbsp;&nbsp;';
										val += '<span class="">浏览：'+d[i].view+'</span><br/>';
										val += '<span class="">'+d[i].description+'</span>';
										val += '</div>';
										val += '</div>';
										val += '</li>';															
									}
									$('.list').append(val);
									more.unbind().html('加载更多数据');
									break;
								default:
									more.unbind().html('加载更多数据').hide();
									break;	
								}
								return false;
							},
						error: function () {
								more.unbind().html('加载更多数据').hide();
							},
						cache: false
							
						});
					}
				});
			}
		</script>
	</div>
	
	<div style="height:50px;width:100%;"></div>
	</div>
	<div id="fix_footer">
		<table width="100%" height="100%" border="0">
			<tr>
				<td onclick="window.location=&#39;<?php echo U('Index/index');?>&#39;;" >
					<?php if((CONTROLLER_NAME== Index)or(CONTROLLER_NAME== Game) or (CONTROLLER_NAME== Gift) or (CONTROLLER_NAME== Search)): ?><img style="filter:invert" src="/wm/wm/h5/Public/Media/images/nav_14_on.png"><br>
					<span id="menu_1_label" class="active">游戏</span>
					<?php else: ?>
					<img style="filter:invert" src="/wm/wm/h5/Public/Media/images/nav_14_off.png"><br>
					<span id="menu_1_label" >游戏</span><?php endif; ?>
				</td>
				<td onclick="window.location=&#39;<?php echo U('News/index/category/media_activity');?>&#39;;">
					<?php if(CONTROLLER_NAME== News): ?><img src="/wm/wm/h5/Public/Media/images/nav_16_on.png"><br>
					<span id="menu_3_label" class="active" >活动</span>
					<?php else: ?>
					<img src="/wm/wm/h5/Public/Media/images/nav_16_off.png"><br>
					<span id="menu_3_label" >活动</span><?php endif; ?>
				</td>
				<td onclick="window.location=&#39;<?php echo U('Subscriber/index');?>&#39;;" >
					<?php if(CONTROLLER_NAME== Subscriber): ?><img src="/wm/wm/h5/Public/Media/images/nav_11_on.png"><br>
					<span id="menu_3_label" class="active">我</span>
					<?php else: ?>
					<img src="/wm/wm/h5/Public/Media/images/nav_11_off.png"><br>
					<span id="menu_3_label" >我</span><?php endif; ?>
				</td>
			</tr>
		</table>
		<div id="footer_badge_message"></div>
	</div>
	<div style="display:none"></div>
            <div  class="logo"><img src="<?php echo get_cover(C('PC_SET_LOGO'),'path');?>" /></div>
	<div id="qrcode">		
		<p align="center" style="color:#fff;">
			<img src="<?php echo get_cover(C('PC_SET_QRCODE'),'path');?>" id="qrcodeImg" width="180">
			<br>微信扫码 用手机玩
		</p>
	</div>
	</body>
</html>