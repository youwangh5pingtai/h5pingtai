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
	
<link href="/wm/wm/h5/Public/Media/css/newsdetail.css" rel="stylesheet" />
<div class="fix_nav" id="fix_nav">
  <table border="0" width="100%" bgcolor="#e62b13" height="35">
	  <tr>
		<td width="25%" align="left"><img src="/wm/wm/h5/Public/Media/images/icon_return.png" width="20" onclick="window.location=&#39;<?php echo U('News/index/category/media_activity');?>&#39;" valign="middle"></td>
		<td width="50%" align="center" style="font-size:14px;color:#ffffff" id="gametitle"><?php echo ($info["title"]); ?></td>
		<td width="24%" align="right" style="font-size:12px;color:#ffffff" onclick=""></td>
		<td width="1%"></td>
	  </tr>
  </table>
</div>
<div style="height:35px" id="fix_nav_over"></div>
<div class="newscontent">
<div class="newstitle"></div>
<div class="newsinfo" >
	<span>时间：<?php echo (date('Y-m-d',$info["update_time"])); ?></span>&nbsp;&nbsp;&nbsp;&nbsp;
	<span>作者：<?php echo get_admin_name($info['admin']);?></span>&nbsp;&nbsp;&nbsp;&nbsp;
	<span>浏览：<?php echo ($info["view"]); ?></span></div>
<div class="nc">
	<?php echo ($info["content"]); ?>
</div>
<!-- <div class="newspage">
	<div class="npprev">上一篇：
	<?php if(empty($prev)): ?>没有了
	<?php else: ?>
		<a href="<?php echo U('News/detail?id='.$prev['id']);?>" title="<?php echo ($prev['title']); ?>">
	 <?php echo ($prev['title']); ?></a><?php endif; ?>
	</div>
	<div class="npnext">下一篇：
	<?php if(empty($next)): ?>没有了<?php else: ?>
		<a href="<?php echo U('News/detail?id='.$next['id']);?>" title="<?php echo ($next['title']); ?>">
	<?php echo ($next['title']); ?></a><?php endif; ?></div>
</div> -->
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