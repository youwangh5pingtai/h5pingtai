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
	
<link href="/wm/wm/h5/Public/Media/css/gamedetail.css" rel="stylesheet" />
<div class="fix_nav" id="fix_nav">
  <table border="0" width="100%" bgcolor="#e62b13" height="35">
	  <tr>
		<td width="25%" align="left"><img src="/wm/wm/h5/Public/Media/images/icon_return.png" width="20" onclick="javascript:history.back(-1);" valign="middle"></td>
		<td width="50%" align="center" style="font-size:14px;color:#ffffff" id="gametitle"><?php echo ($data["game_name"]); ?></td>
		<td width="24%" align="right" style="font-size:12px;color:#ffffff" onclick=""></td>
		<td width="1%"></td>
	  </tr>
  </table>
</div>
<div style="height:35px" id="fix_nav_over"></div>
<div class="r-game">
  <div id="toptj">
    <table border="0" cellspacing="2" cellpadding="2" width="100%">
        <tr>
    		<?php $__CATE__ = 2;$__LIST__ = D('Game')->game_recommend_limt($__CATE__, "id desc", 1,true,5); if(is_array($__LIST__)): $i = 0; $__LIST__ = $__LIST__;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><td width="25%">
    				<table align="center" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td align="center" height="55">
        					<img src="<?php echo (get_cover($vo["icon"],'path')); ?>" class="gameicon" onclick="window.location=&#39;<?php echo U('Game/detail?id='.$vo['id']);?>&#39;">
        				</td>
              </tr>
              <tr>
                <td align="center" height="20">
                  <span style="display:block;font-size:12px;color:#000000;width:70px;overflow:hidden;height:14px"><?php echo ($vo["game_name"]); ?></span>
                </td>
              </tr>
    				</table>
    			</td><?php endforeach; endif; else: echo "" ;endif; ?>
        </tr>
    </table>
  </div>
</div>
<div class="r-game" onclick="gotoGame()">
  <table border="0" cellspacing="2" cellpadding="2" width="100%">
    <tbody>
      <tr>
        <td width="20%"><img src="<?php echo (get_cover($game_data["icon"],'path')); ?>" style="border-radius:7px;width:64px;height:64px;" id="gameicon"></td>
        <td width="75%">
          <span style="font-size:16px" id="gamename"><?php echo ($game_data["game_name"]); ?></span><br>
          <span id="gamecount" style="font-size:12px;color:#999999;display:inline-block;"><?php echo ($game_data["dow_num"]); ?>人在玩</span><br>
          <span id="gamecomment" style="font-size:12px;color:#999999;display:inline-block;"><?php echo msubstr($game_data['introduction'],0,35);?></span></td>
        <td width="5%" align="right">
          <a href="<?php echo U('open_game',array('uid'=>get_uid(),'game_id'=>I('id'),'pid'=>I('pid'),'promote_id'=>get_user_pid(get_uid())));?>" class="play-btn">打开</a>
        </td>
      </tr>
    </tbody>
  </table>
</div>
<?php if(!empty($gamepic)): ?><div id="screenShots" style="width: 95%; margin: 0px auto;">
  <div id="iScrollDemo" style="width: 100%; height: 200px; overflow: hidden;">
    <div class="content" style="position: relative; width: 625px; transition-property: -webkit-transform; transform-origin: 0px 0px 0px; transform: translate3d(0px, 0px, 0px);">
      <?php if(is_array($gamepic)): $i = 0; $__LIST__ = array_slice($gamepic,0,4,true);if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><div class="box" style="float: left; width: 120px; margin-right: 5px;">
  			<img src="<?php echo (get_cover($vo,'path')); ?>" width="120">
  		</div><?php endforeach; endif; else: echo "" ;endif; ?>
    </div>
  </div>
</div><?php endif; ?>
<?php if(!empty($giftlist)): ?><div id="gameGift" style="">
  <table border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
      <tr>
        <td><div style="font-size:14px;margin:10px">游戏礼包</div></td>
      </tr>
      <tr>
        <td><div id="packageInfo" style="width:95%;margin:0 auto">
		    <?php if(is_array($giftlist)): foreach($giftlist as $key=>$vo): ?><table border="0" cellspacing="2" cellpadding="2" width="100%" align="center">
              <tbody>
                <tr>
                  <td width="75%" onclick="gotoDetail(<?php echo ($vo["id"]); ?>)"><table border="0" cellspacing="0" cellpadding="0" width="100%" align="center">
                      <tbody>
                        <tr>
                          <td><span class="package_name"><?php echo ($vo["game_name"]); ?>：<?php echo ($vo["giftbag_name"]); ?></span></td>
                        </tr>
                        <tr>
                          <td><div class="desc"><?php echo msubstr($vo['desribe'],0,35);?></div></td>
                        </tr>
                        <tr>
                          <td height="30">
                            <span class="g-rest">剩余<?php echo ($vo["novicenum"]); ?>个</span>
                          </td>
                        </tr>
                      </tbody>
                    </table></td>
                  <td width="15%" align="right"><a class="play-btn" id="bt_action" onclick="pickPackage(155)">领号</a></td>
                </tr>
              </tbody>
            </table>
            <table border="0" cellspacing="0" cellpadding="0" width="95%" align="center">
              <tbody>
                <tr>
                  <td bgcolor="#ffffff" height="5"></td>
                </tr>
              </tbody>
            </table><?php endforeach; endif; ?>
          </div></td>
      </tr>
    </tbody>
  </table>
</div><?php endif; ?>
<?php if(!empty($game_data["introduction"])): ?><div id="gameDesc" style="">
  <table border="0" cellspacing="0" cellpadding="0" width="100%">
    <tbody>
      <tr>
        <td><div style="font-size:14px;margin:10px">游戏介绍</div></td>
      </tr>
      <tr>
        <td><div id="gameDescContent">
            <div style="width:95%;margin:0 auto">
              <div style="font-size:12px;margin:5px;line-height:150%;color:#999999"><?php echo ($game_data["introduction"]); ?></div>
            </div>
          </div></td>
      </tr>
    </tbody>
  </table>
</div><?php endif; ?>
<a class="d-play"  href="<?php echo U('open_game',array('uid'=>get_uid(),'game_id'=>I('id'),'pid'=>I('pid')));?>">打开游戏</a>
<div style="height:10px"></div>
	
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