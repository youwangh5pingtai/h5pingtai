<?php
namespace Media\Controller;
use Think\Controller;
use Common\Api\GameApi;
use Org\WeiXinSDK\WeiXinOauth;
use Common\Api\PayApi;
class GameController extends BaseController {

	public function index($p=1) {
		$this->assign('rs',I('rs'));
		echo I('rs');
		$this->display();
	}
	
	protected function change($gl) {
		$glist = '';
		if ($gl) {
			foreach($gl as $j => $g) {
				foreach($g as $k =>$v) {
					if ('introduction' === $k) {
						$g['introduction'] = strip_tags($v);
					}
					if ('icon' === $k) {
						$v2 = get_cover($v);
						$g['picurl'] = $v2['path'];
					}
					
					if ('recommend_level'=== $k) {
						$g['recommend_level']=floatval($v)*10;
					}
					if ('novice' === $k) {
						$no = explode(',',$v);
						$g['novicenum']=count($no);
					}
					if ('create_time' === $k) {
						$g['create_time']=date('Y-m-d H:i:s',$v);
					}
				}
				$glist[]=$g;
			}
		}
		return $glist;
	}
	
	public function game($p=1) {
		$game['model']='Game';
		$game['field']="g.*,cf.name as game_type_name,gi.introduction";
		$game['join']="__CLASSIFICATION__ as cf on (g.game_type=cf.id)";
		$game['joinnum']="left";
		$game['join1']="__GAME_INFO__ as gi on (gi.id=g.id)";
		$game['joinnum1']="left";
		$game['where']=" g.game_status=1 ";
		$game['order'] = 'g.sort DESC,g.id desc';
		$game['limit']=10;
		$game['page']=$p;
		$gl = parent::getlists($game);
		if($gl['list']&&$gl['total']) {
			$glist = $this->change($gl['list']);
			$data = array(
				'data'		=>	$glist,
				'page' 		=> 	intval($p)+1,
				'total' 	=> 	$gl['total'],
				'status'	=> 1,
			);
		} else
			$data = array(
				'data'		=>	'',
				'page' 		=> 	$p,
				'status'	=> 0,
			);
		$this->ajaxReturn($data,C('DEFAULT_AJAX_RETURN'));	
	}
	
	public function detail($id=0) { 
		$game = D("game"); 
		$game_data = $game->detail($id);
		$game_data['dow_num'] = M("UserPlay","tab_")->where("game_id=".$id)->count();
		$this->game_screenshots($game_data['screenshot']);
		$this->game_gift($id);
		$this->assign("game_data",$game_data);
		$this->display();
	}

	/**
	*游戏截图
	*/
	protected function game_screenshots($screenshots){
		if(!empty($screenshots)){
			$data_img = explode(',', $screenshots);
			$this->assign("gamepic",$data_img);
		}
	}

	/**
	*游戏礼包
	*/
	protected function game_gift($game_id=0){
		$gift = M("Giftbag","tab_")->where("game_id=".$game_id)->select();
		$this->assign("giftlist",$gift);
	}
	
	// public function battle() {
	// 	$game['model']='Game';
	// 	$game['field']="g.*,cf.name as game_type_name";
	// 	$game['join']="__CLASSIFICATION__ as cf on (g.game_type=cf.id)";
	// 	$game['joinnum']="left";
	// 	$game['where']=" g.game_status=1 ";
	// 	$game['order'] = 'g.sort DESC,g.id desc';
	// 	$gl=parent::showlist($game,-1);
	// 	$glist = $this->change($gl);
	// 	$this->assign('game',$glist);
		
	// 	// 广告
	// 	$hr = $this->showlist(array("model"=>"Slidetype","where"=>"typemark='sy_idnex'"),1);
	// 	$hrr = $this->showlist(array("model"=>"Slidemanage","where"=>'classify="'.$hr[0]['id'].'"'),1);
	// 	foreach($hrr as $k => $h) {
	// 		$pic = get_cover($h['cover']);
	// 		$hrr[$k]['picurl']=$pic['path'];
	// 	}
	// 	$this->assign('ad',$hrr);
	// 	$this->display();
	// }
	
	// public function newest($p=1) {
	// 	// 游戏
	// 	$game['model']='Game';
	// 	$game['where']=" game_status=1 ";
	// 	$game['order'] = 'create_time DESC,id desc';
	// 	$game['limit']=10;
	// 	$game['page']=$p;
	// 	$gl = parent::getlists($game);
	// 	$gll = $this->changetime($gl['list']);
	// 	$this->assign('game',$gll);
	// 	$this->assign('page',2);
	// 	$this->assign('total',$gl['total']);
	// 	dump(time());
	// 	// 广告
	// 	$hr = $this->showlist(array("model"=>"Slidetype","where"=>"typemark='sy_idnex'"),1);
	// 	$hrr = $this->showlist(array("model"=>"Slidemanage","where"=>'classify="'.$hr[0]['id'].'"'),1);
	// 	foreach($hrr as $k => $h) {
	// 		$pic = get_cover($h['cover']);
	// 		$hrr[$k]['picurl']=$pic['path'];
	// 	}
	// 	$this->assign('ad',$hrr);
	// 	$this->display();
	// }
	
	protected function changetime($ga) {
		if ($ga) {
			$now = date('Y-m-d H:i:s',time());
			foreach($ga as $j => $g) {
				foreach($g as $k => $v) {
					if ('icon' === $k) {
						$pic = get_cover($v);
						$ga[$j]['picurl'] = $pic['path'];
					}
					if ('game_type' === $k) {
						$ga[$j]['game_type_name']=get_game_type($v);
					}
					if ('introduction' === $k) {
						$ga[$j]['introduction'] = strip_tags($v);
					}
					if ('recommend_level'=== $k) {
						$ga[$j]['recommend_level']=floatval($v)*10;
					}
					if ('create_time' === $k) {
						$t1 = date('Y-m-d',$v);
						$t2 = explode(" ",$now);
						if ($t1 === $t2[0]) {
							$c = strtotime($now)-$v;
							$c = $c/60>1?$c/3600>1?intval($c/3600).'小时前':intval($c/60).'分前':intval($c).'秒前';
							$ga[$j]['ct']=$c;
						} else {
							$ga[$j]['create_time']=date('Y-m-d H:i:s',$v);
						}
					}
				}
			}
		} else {
			$ga="";
		}
		return $ga;
	}
	
	
	
	public function newsgame($p=1) {
		$game['model']='Game';
		$game['where']=" game_status=1 ";
		$game['order'] =' create_time DESC,id desc ';
		$game['limit']=10;
		$game['page']=$p;
		$gl = parent::getlists($game);
		if($gl['list']&&$gl['total']) {
			$gll = $this->changetime($gl['list']);
			$data = array(
				'data'		=>	$gll,
				'page' 		=> 	intval($p)+1,
				'total' 	=> 	$gl['total'],
				'status'	=> 1,
			);
		} else
			$data = array(
				'data'		=>	'',
				'page' 		=> 	$p,
				'status'	=> 0,
			);
		$this->ajaxReturn($data,C('DEFAULT_AJAX_RETURN'));	
	}
	

	public function open_game_url($appid=""){
		$this->open_game(88);
	}

	/**
	*游戏支付
	*/
	public function game_pay(){
		$data["game_appid"] = $_REQUEST["game_appid"];
		$data["trade_no"]   = $_REQUEST["trade_no"];
		$data["props_name"] = $_REQUEST["props_name"];
		$data["amount"]     = $_REQUEST["amount"];
		$data["user_id"]    = $_REQUEST['user_id'];
		$data["sign"]       = $_REQUEST['sign'];
		$user_id=session('user_auth')['user_id'];
		$ptb=D('User')
		    ->where(array('id'=>$user_id))
		    ->find();
		if(isset($_REQUEST['game_appid'])&&$_REQUEST['game_appid']!=''){
			$map['user_id']=$user_id;
			$map['game_appid']=$_REQUEST['game_appid'];
			$bind_ptb=M('user_play','tab_')
			->where($map)
			->find();
			$this->assign("bind_ptb",$bind_ptb);
		}
		if(IS_POST){
			switch ($_REQUEST['payway']) {
				case 'alipay':
					$this->alipay($_REQUEST);
					break;
				case 'wx':
					$this->wx_jsapi_pay($_REQUEST);
					break;
				case 'ptb':
					$this->platform_coin_pay($_REQUEST);
					break;
				case 'bind_ptb':
					$this->platform_coin_pay($_REQUEST,$bind_ptb);
					break;
			}
		}else{
			$game_data = get_game_entity($data["game_appid"]);
			$data['game_name'] = $game_data['game_name'];
			$data['icon'] = get_cover($game_data['icon'],"path");
		}
		$this->assign("data",$data);
		$this->assign("ptb",$ptb);
		$this->display();
	}

	/**
	*支付宝支付
	*/
	public function alipay($param){
		#判断账号是否存在
		$user = get_user_entity($param['user_id'],false);
		if(empty($user)){$this->error("用户不存在");exit();}
		$game_data = get_game_entity($param['game_appid']);
		#支付配置
		$data['options']  = 'spend';
		$data['order_no'] = 'SP_'.date('Ymd').date ( 'His' ).sp_random_string(4);
		$data['fee']      = $param['amount']/100;
		$data['pay_type'] = 'alipay'; 
		#平台币记录数据
		$data["user_id"]       = $user["id"];
		$data["user_account"]  = $user['account'];
		$data["user_nickname"] = $user['nickname'];
		$data["game_id"]	   = $game_data['id'];
		$data["game_appid"]	   = $param["game_appid"];
		$data["game_name"]     = $game_data["game_name"];
		$data["server_id"]	   = 0;
		$data["server_name"]   = "";
		$data["promote_id"]    = $user['promote_id'];
		$data["promote_account"] = $user['promte_account'];
		$data["pay_order_number"]= $data['order_no'];
		$data["title"] = $param['props_name'];
		$data["pay_amount"]   = $param['amount']/100;
		$data["pay_way"] = 1;
		$data['code']=1;
		$data['extend']  = $param['trade_no'];
		if(is_mobile_request()){
			$data['server']   = 'alipay.wap.create.direct.pay.by.user';
			$data['method']   = 'wap';
		}else{
			$data['server']   = 'create_direct_pay_by_user';
			$data['method']   = 'direct';
		}
		$pay = new PayApi();
		$pay->other_pay($data,C('alipay'));
	}
	
	/**
	*微信支付
	*/
	public function wx_pay(){
		#判断账号是否存在
		$user = get_user_entity(get_uname(),true);
		if(empty($user)){$this->error("用户不存在");exit();}
		$game_data = get_game_entity($_POST['game_appid']);
		#支付配置
		$data['options']  = 'spend';
		$data['order_no'] = 'SP_'.date('Ymd').date ( 'His' ).sp_random_string(4);
		$data['fee']      = $_POST['amount']/100;//0.01;
		$data['pay_type'] = 'swiftpass'; 
		$data['server'] = "pay.weixin.native";
		#平台币记录数据
		$data["user_id"]       = $user["id"];
		$data["user_account"]  = $user['account'];
		$data["user_nickname"] = $user['nickname'];
		$data["game_id"]	   = $game_data['id'];
		$data["game_appid"]	   = $_POST["game_appid"];
		$data["game_name"]     = $game_data["game_name"];
		$data["server_id"]	   = 0;
		$data["server_name"]   = "";
		$data["promote_id"]    = $user['promote_id'];
		$data["promote_account"] = $user['promte_account'];
		$data["pay_order_number"]= $data['order_no'];
		$data["title"] = $_POST['props_name'];
		$data["pay_amount"]   = $_POST['amount']/100;
		$data["pay_way"] = 2;
		$data['extend']  = $_POST['trade_no'];
		$data['code']  = 1;
		$pay = new PayApi();
		$arr = $pay->other_pay($data,C('weixin'));
		if($arr['status1'] === 500){
			\Think\Log::record($arr['msg']);
			$html ='<div class="d_body" style="height:px;">
					<div class="d_content">
						<div class="text_center">'.$arr["msg"].'</div>
					</div>
					</div>';
			$json_data = array("status"=>1,"html"=>$html);
		}else{
			$html ='<div class="d_body" style="height:px;">
					<div class="d_content">
						<div class="text_center">
							<table class="list" width="100%">
								<tbody>
								<tr>
									<td class="text_right">订单号</td>
									<td class="text_left">'.$arr["out_trade_no"].'</td>
								</tr>
								<tr>
									<td class="text_right">充值金额</td>
									<td class="text_left">本次充值'.$data["pay_amount"].'元，实际付款'.$data["pay_amount"].'元</td>
								</tr>
								</tbody>
							</table>
							<img src="'.$arr["code_img_url"].'" height="301" width="301">
							<br/>&nbsp;&nbsp;&nbsp;&nbsp;
							<img src="/Public/Media/images/wx_pay_tips.png">
						</div>
					</div>
				</div>';
			$json_data = array("status"=>1,"out_trade_no"=>$arr["out_trade_no"],"html"=>$html);
		}
		
		$this->ajaxReturn($json_data);
	}
	/**
	*微信wap支付
	*/
	public function wx_wap_pay(){
		$user = get_user_entity(get_uname(),true);
		if(empty($user)){$this->error("用户不存在");exit();}
		$game_data = get_game_entity($_POST['game_appid']);
		#支付配置
		$data['code']     = 1;
		$data['fee']    = 0.01;
		$data['body']     = '游戏充值';
		$data['pay_type']  = 'swiftpass';
		$data['config']   = 'weixin';
		$data['method']   = 'direct';
		$data['server']   = 'pay.weixin.wappay';
		$data['signtype'] = 'MD5';
		#平台币记录数据
		$data['user_id']          = $user['id'];
		$data['pay_status']       = 0;
		$data['payway']           = 2;
		$data['pay_source']       = 1;
		$data['options']  = 'spend';
		$data['order_no'] = 'SP_'.date('Ymd').date ( 'His' ).sp_random_string(4);
		#平台币记录数据
		$data["user_id"]       = $user["id"];
		$data["user_account"]  = $user['account'];
		$data["user_nickname"] = $user['nickname'];
		$data["game_id"]	   = $game_data['id'];
		$data["game_appid"]	   = $_POST["game_appid"];
		$data["game_name"]     = $game_data["game_name"];
		$data["server_id"]	   = 0;
		$data["server_name"]   = "";
		$data["promote_id"]    = $user['promote_id'];
		$data["promote_account"] = $user['promte_account'];
		$data["pay_order_number"]= $data['order_no'];
		$data["title"] = $_POST['props_name'];
		$data["pay_amount"]   = $_POST['amount']/100;
		$data["pay_way"] = 2;
		$data['extend']  = $_POST['trade_no'];
		$pay = new PayApi();
		$arr = $pay->other_pay($data,C('weixin'));
		if($arr['status1'] === 500){
			\Think\Log::record($arr['msg']);
			$html ='<div class="d_body" style="height:px;">
					<div class="d_content">
						<div class="text_center">'.$arr["msg"].'</div>
					</div>
					</div>';
			$json_data = array("status"=>0,"html"=>$html);
		}else{
			$json_data = array("status"=>1,"pay_info"=>$arr['pay_info']);
		}
		$this->ajaxReturn($json_data);
	}
	public function checkstatus(){
		sleep(3);
		substr($_REQUEST['out_trade_no'],0,2)=="PF"?$model='deposit':$model='spend';
		$data=M($model,'tab_')->where(array('pay_order_number'=>$_REQUEST['out_trade_no']))->find();
		if($data['pay_status']==1){
			$url=U('Game/open_game',array('game_id'=>$data['game_id']));
			$this->ajaxReturn(array("status"=>1,'url'=>$url));
		}else{
			$this->ajaxReturn(array("status"=>0));
		}
	}
	/**
	*微信 JSAPI 支付
	*/
	public function wx_jsapi_pay($param = array()){
		$user = get_user_entity(get_uname(),true);
		if(empty($user)){$this->error("用户不存在");exit();}
		$game_data = get_game_entity($param['game_appid']);
		$data['code']     = 1;
		$data['fee']    = 0.01;
		$data['body']     = '游戏充值';
		$data['pay_type']  = 'swiftpass';
		$data['config']   = 'weixin';
		$data['method']   = 'direct';
		$data['server']   = 'pay.weixin.jspay';
		$data['openid'] = session("wechat_token.openid");
		$data['signtype'] = 'MD5';
		#平台币记录数据
		$data['user_id']          = $user['id'];
		$data['pay_status']       = 0;
		$data['payway']           = 2;
		$data['pay_source']       = 1;
		$data['options']  = 'spend';
		$data['order_no'] = 'SP_'.date('Ymd').date ( 'His' ).sp_random_string(4);
		#平台币记录数据
		$data["user_id"]       = $user["id"];
		$data["user_account"]  = $user['account'];
		$data["user_nickname"] = $user['nickname'];
		$data["game_id"]	   = $game_data['id'];
		$data["game_appid"]	   = $_POST["game_appid"];
		$data["game_name"]     = $game_data["game_name"];
		$data["server_id"]	   = 0;
		$data["server_name"]   = "";
		$data["promote_id"]    = $user['promote_id'];
		$data["promote_account"] = $user['promte_account'];
		$data["pay_order_number"]= $data['order_no'];
		$data["title"] = $_POST['props_name'];
		$data["pay_amount"]   = $_POST['amount']/100;
		$data["pay_way"] = 2;
		$data['extend']  = $_POST['trade_no'];
		$data['callbackurl'] = "http://".$_SERVER['HTTP_HOST'].U('Game/open_game',array('game_id'=>$game_data['id']));
		$pay = new PayApi();
		$arr = $pay->other_pay($data,C('weixin'));
		if($arr['status'] != 500){
			redirect("https://pay.swiftpass.cn/pay/jspay?token_id={$arr['token_id']}&showwxtitle=1"); 
		}
	}

	public function platform_coin_pay($param,$bind_ptb){
		$user = get_user_entity(get_uname(),true);
		if($bind_ptb!=null|$bind_ptb!=''){
			$money=$bind_ptb['bind_balance'];
		}else{
			$money=$user['balance'];
		}
		if($money < $param['amount']/100){
			$this->error("余额不足!");exit;
		}
		$game_data = get_game_entity($param['game_appid']);
        $data_spned['user_id']          = $param["user_id"];
        $data_spned['user_account']     = $user["account"];
        $data_spned['user_nickname']    = $user["nickname"];
        $data_spned['game_id']          = $game_data["id"];
        $data_spned['game_appid']       = $game_data["game_appid"];
        $data_spned['game_name']        = $game_data["game_name"];
        $data_spned['server_id']        = 0;
        $data_spned['server_name']      = "";
        $data_spned['promote_id']       = $user["promote_id"];
        $data_spned['promote_account']  = $user["promote_account"];
        $data_spned['order_number']     = $param["order_number"];
        $data_spned['pay_order_number'] = 'SP_'.date('Ymd').date ( 'His' ).sp_random_string(4);
        $data_spned['props_name']       = $param["props_name"];
        $data_spned['pay_amount']       = $param["amount"]/100;
        $data_spned['pay_time']         = NOW_TIME;
        $data_spned['pay_status']       = 1;
        $data_spned['pay_game_status']  = 0;
        $data_spned['extend']           = $param['trade_no'];
        $data_spned['pay_way']          = 0;
        $data_spned['spend_ip']         = get_client_ip();
        if($param['payway']=='ptb'){
        	$model1=M("user","tab_");
        	$model2=M("spend","tab_");
        	$model1->where("id=".$param['user_id'])->setDec("balance",$param['amount']/100);
        	$spend_id = $model2->add($data_spned);
        	$this->set_ratio($data_spned['pay_order_number']);
        }else if($param['payway']=='bind_ptb'){
        	$model1=M("user_play","tab_");
        	$model2=M("bind_spend","tab_");
        	$map['user_id']=$param['user_id'];
        	$map['game_appid']=$param['game_appid'];
        	$model1->where($map)->setDec("bind_balance",$param['amount']/100);
        	$spend_id = $model2->add($data_spned);
        }
        $res =json_decode($this->pay_game_notify($data_spned),true);
		if($res['status'] == "success"){
			$model2->where("id=".$spend_id)->setField("pay_game_status",1);
		}
        redirect("http://".$_SERVER['HTTP_HOST']."/media.php?s=/Game/open_game/game_id/".$game_data['id']);
	}

	protected function pay_game_notify($data){
        $game = new GameApi();
        $result = $game->game_pay_notify($data);
        return $result;
    }

	protected function bind_spend_param($data_pt){
		$user_entity = get_user_entity($param['user_id']);
        $data_bind_spned['user_id']          = $param["user_id"];
        $data_bind_spned['user_account']     = $user_entity["account"];
        $data_bind_spned['user_nickname']    = $user_entity["nickname"];
        $data_bind_spned['game_id']          = $param["game_id"];
        $data_bind_spned['game_appid']       = $param["game_appid"];
        $data_bind_spned['game_name']        = $param["game_name"];
        $data_bind_spned['server_id']        = 0;
        $data_bind_spned['server_name']      = "";
        $data_bind_spned['promote_id']       = $user_entity["promote_id"];
        $data_bind_spned['promote_account']  = $user_entity["promote_account"];
        $data_bind_spned['order_number']     = $param["order_number"];
        $data_bind_spned['pay_order_number'] = $param["pay_order_number"];
        $data_bind_spned['props_name']       = $param["title"];
        $data_bind_spned['pay_amount']       = $param["price"];
        $data_bind_spned['pay_time']         = NOW_TIME;
        $data_bind_spned['pay_status']       = $param["pay_status"];
        $data_bind_spned['pay_game_status']  = 0;
        $data_bind_spned['pay_way']          = 1;
        $data_bind_spned['spend_ip']         = $param["spend_ip"];
        return $data_bind_spned;
	}
	/**
    *游戏返利
    */
    protected function set_ratio($data){
        $map['pay_order_number']=$data;
        $spend=M("Spend","tab_")->where($map)->find();
        $reb_map['game_id']=$spend['game_id'];
        $rebate=M("Rebate","tab_")->where($reb_map)->find();
        if($rebate['ratio']==0||null==$rebate){
            return false;
        }else{
            if($rebate['money']>0&&$rebate['status']==1){
                if($spend['pay_amount']>=$rebate['money']){
                    $this->compute($spend,$rebate);
                }else{
                    return false;
                }
            }else{
                $this->compute($spend,$rebate);
            }
        }
    }
    //计算返利
    protected function compute($spend,$rebate){
        $user_map['user_id']=$spend['user_id'];
        $user_map['game_id']=$spend['game_id'];            
        $bind_balance=$spend['pay_amount']*($rebate['ratio']/100);
        $spend['ratio']=$rebate['ratio'];
        $spend['ratio_amount']=$bind_balance;
        M("rebate_list","tab_")->add($this->add_rebate_list($spend));
        $re=M("UserPlay","tab_")->where($user_map)->setInc("bind_balance",$bind_balance);
        return $re;
    }
    /**
    *返利记录
    */
    protected function add_rebate_list($data){
        $add['pay_order_number']=$data['pay_order_number'];
        $add['game_id']=$data['game_id'];
        $add['game_name']=$data['game_name'];
        $add['user_id']=$data['user_id'];
        $add['pay_amount']=$data['pay_amount'];
        $add['ratio']=$data['ratio'];
        $add['ratio_amount']=$data['ratio_amount'];
        $add['promote_id']=$data['promote_id'];
        $add['promote_name']=$data['promote_account'];
        $add['create_time']=time();
        return $add;
    }
	//打开游戏
    public function open_game()
    {
        $this->is_login() || redirect(U('Subscriber/login'));
        $GameApi = new GameApi();
        $uid = session("user_auth.user_id");
        $game_id = $_REQUEST['game_id'];
        if($promote_id>0){
            $pid=$promote_id;
        }else{
            $pid =$_REQUEST['pid']==""?0:$_REQUEST['pid'];
        }
        $login_url = $GameApi->game_login($uid,$game_id,$pid);
        $this->assign("login_url",$login_url);
        $this->display();
    }
}
