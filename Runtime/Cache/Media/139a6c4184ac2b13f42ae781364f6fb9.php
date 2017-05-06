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
	



	<link rel="stylesheet" href="/wm/wm/h5/Public/Media/css/index.css">

    <!-- <div  class="logo"><img src="/wm/wm/h5/Public/Media/images/ynlogo.png" /></div> -->

	<table border="0" width="100%" bgcolor="#475B75" height="35">

	  <tbody>

		<tr>

			<td width="1%"></td>

			<td width="24%" align="left" style="font-size:12px;color:#ffffff" onclick="window.location=&#39;<?php echo U('Search/index');?>&#39;">

				<img src="/wm/wm/h5/Public/Media/images/icon_searchgame.png" width="12" height="12" valign="middle"> 搜索

			</td>

			<td width="50%" align="center" style="font-size:14px;color:#ffffff">游戏中心</td>

			<td width="24%" align="right" style="font-size:12px;color:#ffffff">

				<!-- <span id="spanDownload" onclick="">

					<img src="/wm/wm/h5/Public/Media/images/icon_down.png" width="12" height="12" valign="middle"> 下载微端

				</span> -->

			</td>

			<td width="1%"></td>

		</tr>

	  </tbody>

	</table>

	<div id="fix_nav" class="fix_nav"> 

		<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">

			<tr height="3" id="nav_line" class="nav_line" style="display:none;">

				<td class="active"></td>

				<td></td>

				<td></td>

				<td></td>

			</tr>

			<tr class="fn2">

				<td onclick="window.location=&#39;<?php echo U('Index/index');?>&#39;">

					<span id="menu_1_label" class="active">推荐</span></td>

				<td onclick="window.location=&#39;<?php echo U('Game/index');?>&#39;">

					<span id="menu_1_label">新游</span></td>

				<td onclick="window.location=&#39;<?php echo U('Gift/index');?>&#39;">

					<span id="menu_1_label">礼包</span></td>

				<td onclick="window.location=&#39;<?php echo U('Search/index');?>&#39;">

					<span id="menu_1_label">分类</span></td>

			</tr>

		</table>

	</div>

	<div id="nav_end" style="height:50px;display:none"></div>

	<script>

	function onScroll() {

		if ($(window).scrollTop() > 50) {

			$("#fix_nav").css({position:"fixed",top:0});

			$("#nav_line").show();

			$("#nav_end").show();

		} else {

			$("#fix_nav").css({position:""});

			$("#nav_line").hide();

			$("#nav_end").hide();

		}

	}

	$(function(){

		onScroll();

		$(window).scroll(function() {

			onScroll();

		});

	});

	</script>

    <?php $__CATE__ = 'index_top_media';$__LIST__ = D('adv')->adv_lists($__CATE__,"id DESC",1); if(is_array($__LIST__)): $i = 0; $__LIST__ = $__LIST__;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><!--     <div class="newimg"><a href="<?php echo ($vo["url"]); ?>"><img src="<?php echo (get_cover($vo["data"],'path')); ?>"></a></div> -->



	<table border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" width="100%" align="center">

		<tr>

		 <td><a href="<?php echo ($vo["url"]); ?>" target="<?php echo ($vo["target"]); ?>"><img src="<?php echo (get_cover($vo["data"],'path')); ?>" alt="暂无广告图片" width="100%" border="0"></a></td>

		</tr>

	</table><?php endforeach; endif; else: echo "" ;endif; ?>

<div class="wrap">

	<ul class="list">

		<li class="template">

			<div class="open"></div>

			<div class="num"></div>

			<img class="avatar">

			<div class="score">

				<div class="nickname"></div>

				<div class="intro"></div>

			</div>

		</li>

	</ul>

	<table border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" width="100%">

    <tbody>

      <tr style="display:">

        <td align="center"><table border="0" cellspacing="0" cellpadding="0" width="90%">

            <tbody>

              <tr>

                <td height="10"></td>

              </tr>

              <tr height="30">

                <td style="line-height:150%" align="left"><span style="font-size:16px;color:#000000" id="iNickname">推荐游戏</span></td>

                <td style="font-size:12px;color:#000000" align="right" onclick="window.location=&#39;<?php echo U('Game/index','rs=1');?>&#39;">精选<font color="red" id="tjcount"><?php echo ($recommendcount); ?>款</font>网游&gt;</td>

              </tr>

            </tbody>

          </table></td>

      </tr>

      <tr>

        <td height="1" bgcolor="#f6f6f6"></td>

      </tr>

      <tr>

        <td height="5" bgcolor="#ffffff"></td>

      </tr>

    </tbody>

  </table>

  <table border="0" cellspacing="0" cellpadding="0" width="100%" style="display:" bgcolor="#FFFFFF">

    <tbody>

      <tr>

        <td bgcolor="#ffffff"><div id="toptj">

            <table align="center" border="0" cellspacing="4" cellpadding="4" width="100%">

			<?php $__CATE__ = 1;$__LIST__ = D('Game')->game_recommend_limt($__CATE__, "sort desc", 1,true,16); if(is_array($__LIST__)): $i = 0; $__LIST__ = $__LIST__;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i; if($key%4 == 0): ?><tr><?php endif; ?>

				<td width="20%">

					<table align="center" border="0" cellspacing="0" cellpadding="0">

						<tr>

						  <td align="center" valign="top">

							<img src="<?php echo (get_cover($vo["icon"],'path')); ?>" class="gameicon" onclick="window.location=&#39;<?php echo U('Game/detail?id='.$vo['id']);?>&#39;"></td>

						</tr>

						<tr>

						  <td align="center" height="20">

							<span style="display:block;font-size:12px;color:#000000;width:68px;overflow:hidden;height:14px">

							<?php echo ($vo["game_name"]); ?></span></td>

						</tr>

						<tr>

						  <td height="20" align="center" ><a href="<?php echo U('Game/open_game',array('uid'=>get_uid(),game_id=>$vo['id'],pid=>I('pid'),'promote_id'=>get_user_pid(get_uid())));?>" class="play-btn" target="_back">打开</a></td>

						  <!-- onclick="window.location=&#39;<?php echo U('Game/open_game',array('game_id'=>$vo['id'],'uid'=>get_uid()));?>&#39;" -->

						</tr>

					</table>

				</td>

				<?php if(($key%4 == 3) or ($key == (count($recommend)-1))): ?></tr><?php endif; endforeach; endif; else: echo "" ;endif; ?>

            </table>

          </div></td>

      </tr>

    </tbody>

  </table>

  <table border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" width="100%">

    <tbody>

      <tr style="display:">

        <td align="center"><table border="0" cellspacing="0" cellpadding="0" width="90%">

            <tbody>

              <tr>

                <td height="10"></td>

              </tr>

              <tr height="30">

                <td style="line-height:150%" align="left"><span style="font-size:16px;color:#000000" id="iNickname">最新更新</span></td>

                <td style="font-size:12px;color:#000000" align="right" onclick="window.location=&#39;<?php echo U('Game/index','rs=3');?>&#39;">更新<font color="red" id="weekcount"><?php echo ($newsgamecount); ?>款</font>游戏&gt;</td>

              </tr>

            </tbody>

          </table></td>

      </tr>

      <tr>

        <td height="1" bgcolor="#f6f6f6"></td>

      </tr>

      <tr>

        <td height="5" bgcolor="#ffffff"></td>

      </tr>

    </tbody>

  </table>

  <table border="0" cellspacing="0" cellpadding="0" width="100%" style="display:" bgcolor="#FFFFFF">

    <tbody>

      <tr>

        <td bgcolor="#ffffff"><div id="toptj2">

            <table align="center" border="0" cellspacing="4" cellpadding="4" width="100%">

			<?php $__CATE__ = 3;$__LIST__ = D('Game')->game_recommend_limt($__CATE__, "sort desc", 1,true,16); if(is_array($__LIST__)): $i = 0; $__LIST__ = $__LIST__;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i; if($key%4 == 0): ?><tr><?php endif; ?>

				<td width="20%">

					<table align="center" border="0" cellspacing="0" cellpadding="0">

						<tr>

                          <td align="center" valign="top">

							<img src="<?php echo (get_cover($vo["icon"],'path')); ?>" class="gameicon" onclick="window.location=&#39;<?php echo U('Game/detail?id='.$vo['id']);?>&#39;"></td>

                        </tr>

                        <tr>

                          <td align="center" height="20"><span style="display:block;font-size:12px;color:#000000;width:68px;overflow:hidden;height:14px"><?php echo ($vo["game_name"]); ?></span></td>

                        </tr>

					</table>

				</td>

				<?php if(($key%4 == 3) or ($key == (count($newsgame)-1))): ?></tr><?php endif; endforeach; endif; else: echo "" ;endif; ?>

            </table>

		</td>

      </tr>

    </tbody>

  </table>

  <table border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" width="100%">

    <tbody>

      <tr>

        <td height="10"></td>

      </tr>

      <tr>



      <?php $__CATE__ = 'index_mid_media';$__LIST__ = D('adv')->adv_lists($__CATE__,"id DESC",1); if(is_array($__LIST__)): $i = 0; $__LIST__ = $__LIST__;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><td><a href="<?php echo ($vo["url"]); ?>" target="<?php echo ($vo["target"]); ?>"><img src="<?php echo (get_cover($vo["data"],'path')); ?>" alt="暂无广告图片" width="100%" border="0"></a></td><?php endforeach; endif; else: echo "" ;endif; ?>

      </tr>

    </tbody>

  </table>

  <table border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" width="100%">

    <tbody>

      <tr style="display:">

        <td align="center"><table border="0" cellspacing="0" cellpadding="0" width="90%">

            <tbody>

              <tr>

                <td height="10"></td>

              </tr>

              <tr height="30">

                <td style="line-height:150%" align="left"><span style="font-size:16px;color:#000000" id="iNickname">热门游戏</span></td>

                <td style="font-size:12px;color:#000000" align="right" onclick="window.location=&#39;<?php echo U('Game/index','rs=2');?>&#39;">全部<font color="red" id="allcount"><?php echo ($playgamecount); ?>款</font>游戏&gt;</td>

              </tr>

            </tbody>

          </table></td>

      </tr>

      <tr>

        <td height="1" bgcolor="#e5e5e5"></td>

      </tr>

      <tr>

        <td height="5" bgcolor="#ffffff"></td>

      </tr>

    </tbody>

  </table>

	<ul class="list12">

	<?php $__CATE__ = 2;$__LIST__ = D('Game')->game_recommend_limt($__CATE__, "sort desc", 1,true,16); if(is_array($__LIST__)): $i = 0; $__LIST__ = $__LIST__;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><li class="">

			<div class="open"><a href="<?php echo U('Game/detail?id='.$vo['id']);?>" class="play-btn">打开</a></div>

			<?php if($key < 3): ?><div class="num num<?php echo ($key+1); ?>"></div>

			<?php else: ?>

			<div class="num"><?php echo ($key+1); ?></div><?php endif; ?>

			<img class="avatar" src="<?php echo (get_cover($vo["icon"],'path')); ?>">

			<div class="score">

				<div class="nickname"><?php echo ($vo["game_name"]); ?> 

					<!-- <font color="#aaaaaa" style="font-size:12px"><?php echo ($vo["dow_num"]); ?></font> --></div>

				<div class="intro"><?php echo msubstr($vo['features'],0,35);?></div>

			</div>

		</li><?php endforeach; endif; else: echo "" ;endif; ?>

  </ul>

  <table border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff" width="100%">

    <tbody>

      <tr>

      <?php $__CATE__ = 'index_bottom_media';$__LIST__ = D('adv')->adv_lists($__CATE__,"id DESC",1); if(is_array($__LIST__)): $i = 0; $__LIST__ = $__LIST__;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><td><a href="<?php echo ($vo["url"]); ?>" target="<?php echo ($vo["target"]); ?>"><img src="<?php echo (get_cover($vo["data"],'path')); ?>" alt="暂无广告图片" width="100%" border="0"></a></td><?php endforeach; endif; else: echo "" ;endif; ?>

      </tr>

    </tbody>

  </table>



	
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