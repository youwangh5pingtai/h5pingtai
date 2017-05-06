<?php

namespace Media\Controller;
use Think\Controller;
use User\Api\MemberApi;
use Common\Api\GameApi;
use Org\ThinkSDK\ThinkOauth;
use Org\WeiXinSDK\WeiXinOauth;
use Org\UcpaasSDK\Ucpaas;
use Org\XiguSDK\Xigu;
use Common\Api\PayApi;
use Org\UcenterSDK\Ucservice;
class SubscriberController extends BaseController {
	protected function _initialize(){
        /* 读取站点配置 */
        $config = api('Config/lists');
        C($config); //添加配置
    }
	public function __construct() {
		parent::__construct();
		$arr = array(
			"Subscriber",
			"Subscriber/index","Subscriber/pay",
			"Subscriber/trace","Subscriber/feedback",
			"Subscriber/about","TuiRegister/wechat_login_game"
		);
		if (in_array($_SERVER['PATH_INFO'],$arr,true)) {
			if(!is_login_user()){
			 	if(is_weixin()){
			 		$this->wechat_login(1);
			 	}else{
			 		$this->redirect("Subscriber/login");
			 	}
			}
			$this->assign('user',session('user_auth'));
			$user_data = M("user","tab_")->where("id = ".session("user_auth.user_id"))->find();
			if(!is_array(find_uc_account(session('user_auth.account')))){
			$this->assign("user_flatcoin","0.00");
			}else{
				$this->assign("user_flatcoin",$user_data['balance']);
			}
			
		}
	}
	/** 个人中心 */
	public function index() {
			$this->assign("headpic",session("wechat_token.headimgurl"));
		$this->display();
	}
	public function beginPay($param=null){
		$table  = $param['code'] == 1 ? "spend" : "deposit";
        $prefix = $param['code'] == 1 ? "SP_" : "PF_";
        $out_trade_no = $prefix.date('Ymd').date('His').sp_random_string(4);
        $user = get_user_entity($param['user_id']);
        switch ($param['apitype']) {
            case 'swiftpass':
                $pay  = new \Think\Pay($param['apitype'],C($param['config']));
                break;
            default:
                $pay  = new \Think\Pay($param['apitype'],C($param['config']));
                break;
        }
        $vo   = new \Think\Pay\PayVo();
        $vo->setBody("充值记录描述")
            ->setFee($param['price'])//支付金额
            ->setTitle($param['title'])
            ->setBody($param['body'])
            ->setOrderNo($out_trade_no)
            ->setService($param['server'])
            ->setSignType($param['signtype'])
            ->setPayMethod($param['method'])
            ->setTable($table)
            ->setPayWay($param['payway'])
            ->setGameId($param['game_id'])
            ->setGameName($param['game_name'])
            ->setGameAppid($param['game_appid'])
            ->setServerId(0)
            ->setServerName("")
            ->setUserId($param['user_id'])
            ->setAccount($user['account'])
            ->setUserNickName($user['nickname'])
            ->setPromoteId($user['promote_id'])
            ->setPromoteName($user['promote_account'])
            ->setOpenid($param['openid'])
            ->setExtend($param['extend'])
         	->setCallback($param['callbackurl']);
        return $pay->buildRequestForm($vo);
	}

	/** 充值 **/
	public function pay() {	
		if($_REQUEST['paycate']=="alipay") {
				$this->alipay(get_uname(),$_REQUEST['flatcoin']);
		}
		if($_REQUEST['paycate'] == "weixin"){
			$this->wx_jsapi_pay(get_uname(),$_REQUEST['flatcoin']);
		}
		//$user_data = M("user","tab_")->where("id = ".session("user_auth.user_id"))->find();
		//$this->assign("user_flatcoin",$user_data['balance']);
		$this->display();
	}

	/**
	*支付宝支付
	*/
	public function alipay($account="",$amount=0.01){
		#判断账号是否存在
		$user = get_user_entity($account,true);
		if(empty($user)){$this->error("用户不存在");exit();}
		#支付配置
		$data['code']  = 2;
		$data['price']    = 0.01;
		$data['body']     = '平台币购买';
		$data['title']    = '平台币购买';
		$data['apitype']  = 'alipay';
		$data['config']   = 'alipay';
		$data['signtype'] = 'MD5';
		if(is_mobile_request()){
			$data['server']   = 'alipay.wap.create.direct.pay.by.user';
			$data['method']   = 'wap';
		}else{
			$data['server']   = 'create_direct_pay_by_user';
			$data['method']   = 'direct';
		}
		#平台币记录数据
		$data['user_id']          = $user['id'];
		$data['pay_amount']       = $_POST['alipay_amount'];
		$data['pay_status']       = 0;
		$data['payway']           = 1;
		$data['pay_source']       = 1;
		echo $this->beginPay($data);
	}
	/**
	*微信pc支付
	*/
	public function wx_pay(){

		#判断账号是否存在
		$user = get_user_entity(get_uname(),true);
		if(empty($user)){$this->error("用户不存在");exit();}
		#支付配置
		$data['code']     = 2;
		$data['price']    = 0.01;
		$data['body']     = '平台币购买';
		$data['title']    = '平台币购买';
		$data['apitype']  = 'swiftpass';
		$data['config']   = 'weixin';
		$data['method']   = 'direct';
		$data['server']   = 'pay.weixin.native';
		$data['signtype'] = 'MD5';
		#平台币记录数据
		$data['user_id']          = $user['id'];
		$data['pay_amount']       = $_POST['amount'];
		$data['pay_status']       = 0;
		$data['payway']           = 2;
		$data['pay_source']       = 1;
		$arr = $this->beginPay($data);
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
		#支付配置
		$data['code']     = 2;
		$data['price']    = $_POST['amount'];
		$data['body']     = '平台币购买';
		$data['title']    = '平台币购买';
		$data['apitype']  = 'swiftpass';
		$data['config']   = 'weixin';
		$data['method']   = 'direct';
		$data['server']   = 'pay.weixin.wappay';
		$data['signtype'] = 'MD5';
		#平台币记录数据
		$data['user_id']          = $user['id'];
		$data['pay_amount']       = $_POST['alipay_amount'];
		$data['pay_status']       = 0;
		$data['payway']           = 2;
		$data['pay_source']       = 1;
		$arr = $this->beginPay($data);
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
	/**
	*微信 JSAPI 支付
	*/
	public function wx_jsapi_pay($account,$amount){
		$user = get_user_entity($account,true);
		if(empty($user)){$this->error("用户不存在");exit();}
		#支付配置
		$data['code']     = 2;
		$data['price']    = 0.01;//$_POST['amount']
		$data['body']     = '平台币购买';
		$data['title']    = '平台币购买';
		$data['apitype']  = 'swiftpass';
		$data['config']   = 'weixin';
		$data['method']   = 'direct';
		$data['server']   = 'pay.weixin.jspay';
		$data['signtype'] = 'MD5';
		$data['openid'] = session("wechat_token.openid");
		#平台币记录数据
		$data['user_id']          = $user['id'];
		$data['pay_amount']       = $_POST['flatcoin'];
		$data['pay_status']       = 0;
		$data['payway']           = 2;
		$data['pay_source']       = 1;
		$data['callbackurl']      = "http://".$_SERVER['HTTP_HOST'].U('Subscriber/index');
		$arr = $this->beginPay($data);
		if($arr['status'] != 500){
			redirect("https://pay.swiftpass.cn/pay/jspay?token_id={$arr['token_id']}&showwxtitle=1"); 
		}
	}
	/** 玩过的游戏 */
	public function trace() {
		$user_id = session("user_auth.user_id");
		$map['user_id'] = $user_id;
		$play = M('play','tab_user_')->field("tab_user_play.*,g.icon,g.cover,g.game_type_name")
        ->join("tab_game as g on(g.id=tab_user_play.game_id) ",'left')->where($map)->group("tab_user_play.game_id")->select();
		$this->assign('playgame',$play);
		$this->display();
	}	
	/** b绑定平台币 */
	public function bdptb() {
		$user_id = session("user_auth.user_id");
		$map['user_id'] = $user_id;
		$play=M('user_play as a','tab_')
			->field('a.game_name,icon,game_id,bind_balance')
			->where($map)
			->join('tab_game on a.game_id = tab_game.id')
			->select();
		$this->assign('playgame',$play);
		$this->display();
	}
	/** 意见反馈 */
	public function feedback() {
		if($_POST) {
			$content=$_POST['content'];
			$contact=$_POST['contact'];
			if (!empty($content) && !empty($contact)) {
				$feedback = M('Feedback','tab_');
				$data['username']=session('user_auth.account');
				$data['username']=session('user_auth.nickname');
				$data['content']=$content;
				$data['contact']=$contact;
                $data['create_time']=time();
				$feedback->add($data);
				$this->ajaxReturn(array('status'=>1,'msg'=>'成功'));
			}
		}		
		$this->display();
	}
	/** 关于我们 */
	public function about() {		
		$this->display();
	}
	protected function getE($num="") {
		switch($num) {
			case -1:  $error = '用户名长度必须在6-30个字符以内！'; break;
			case -2:  $error = '用户名被禁止注册！'; break;
			case -3:  $error = '用户名被占用！'; break;
			case -4:  $error = '密码长度不合法'; break;
			case -5:  $error = '邮箱格式不正确！'; break;
			case -6:  $error = '邮箱长度必须在1-32个字符之间！'; break;
			case -7:  $error = '邮箱被禁止注册！'; break;
			case -8:  $error = '邮箱被占用！'; break;
			case -9:  $error = '手机格式不正确！'; break;
			case -10: $error = '手机被禁止注册！'; break;
			case -11: $error = '手机号被占用！'; break;
			case -20: $error = '请填写正确的姓名';break;
			default:  $error = '未知错误';
		}
		return $error;
	}
	/**
	* 登陆
	*/
	public function login($username='',$password='',$type="") {
		if(IS_POST){
			if($type == "phone" && !preg_match("/^1[34578][0-9]{9}$/",$username)){
				$this->ajaxReturn(array("status"=>0,"msg"=>"请输入正确的手机号码"));exit;
			}
			$user = new MemberApi();
			$uc   =new  Ucservice();
			if(C('UC_SET')==1){
				$uidarray = $uc->uc_login($username, $password,1);
				if($uidarray>0){ 
					$is_c=find_uc_account($username);
				if(is_array($is_c)){
		            $map['id']=$is_c['id'];
		            $data['login_time'] =time();
		            $data["login_ip"]   = get_client_ip();
		            M('user','tab_')->where($map)->save($data);
		            $uidd=$is_c['id'];
		            $nickname=$is_c['nickname'];
		        }else{
		            $uidd=$uidarray['uid'];
		            $nickname="Uc用户";
		        }
			        /* 记录登录SESSION和COOKIES */
			        $auth = array(
		            'user_id'         => $uidd,
		            'account'         => $username,
		            'nickname'        => $nickname,
			        );
			        session('user_auth', $auth);
			        session('user_auth_sign', data_auth_sign($auth));					
					$this->ajaxReturn(array("status"=>1,"msg"=>"登陆成功","url"=>U('Subscriber/index')));
				}else{
					if($uidarray==-1){
					if($type=="phone"){
						$this->telsvcode($username,1,0,$type);
					}else{
					   echo json_encode(array('status'=>0,'msg'=>'用户不存在')) ;
					}
					}else{
					   echo json_encode(array('status'=>0,'msg'=>'密码错误')) ;
					}

				}

			}else{
				$result = $user->login($username,$password);
				switch ($result) {
					case -1:#账号不存在
						if($type=="phone"){
						$this->telsvcode($username,1,0,$type);
						}
						else{
							$this->ajaxReturn(array("status"=>0,"msg"=>"账号不存在"));
						}
						break;
					case -2:
						$this->ajaxReturn(array("status"=>0,"msg"=>"密码错误"));
						break;
					case -4:
						$this->ajaxReturn(array("status"=>0,"msg"=>"用户被锁定"));
						break;
					default:
						$this->ajaxReturn(array("status"=>1,"msg"=>"登陆成功","url"=>U('Subscriber/index')));
						break;
				}
			}

		}else{
			$this->display();
		}
	}
    //注册
    public function register($username='',$password='',$type='',$game_id=0,$promote_id=0,$promote_account="自然注册") {
    	$user = new MemberApi();
    	$data['account']  = $username;
    	$data['password'] = $password;
        $data['nickname'] = $username;
        $data['phone']    = $type=='phone'?$username:"";
        $data['headimgurl'] = $userInfo['headimgurl'];
        $data['openid']     = $userInfo['unionid'];
        $data['promote_id']        = $_REQUEST['p_id'];
        $data['promote_account']   = get_promote_name($_REQUEST['p_id']);
        $data['parent_id']        = get_fu_id($_REQUEST['p_id']);
        $data['parent_id']        = get_fu_id($_REQUEST['p_id']);
        $data['parent_name']        = get_parent_name($_REQUEST['p_id']);
        $data['fgame_name']        = get_game_name($game_id);
        $data['fgame_id']        = $_REQUEST['g_id'];
        $data['register_time']        = time();
        $data['third_login_type']  = $type == "phone"?1:0;
        if($type=='phone'){
        	$data['register_way'] = 2;
        }elseif ($type=='account'){
        	$data['register_way'] = 1;
        }else{
        	$data['register_way'] = 3;
        }
		if(C('UC_SET')==1){
			$uc = new Ucservice();
	    	$uc_id=$uc->uc_register($username,$password,"",$promote_id,$promote_account,$game_id, get_game_name($game_id),3,1);
			}
			if($uc_id==-3){
				$this->ajaxReturn(array("status"=>-3,"msg"=>"账号已存在"));exit();
			}
		$result = $user->register($data);
		if($type=="account"){
			switch ($result) {
				case -3:
					$this->ajaxReturn(array("status"=>-3,"msg"=>"账号已存在"));
					break;
				case 0:
					$this->ajaxReturn(array("status"=>0,"msg"=>"注册失败"));
				default:

					$this->ajaxReturn(array("status"=>1,"msg"=>"注册成功","url"=>U("Subscriber/index")));
					break;
			}
			exit();
		}
		return $result;
	}
	/**
	*修改密码
	*/
	public function update_paw($username,$password){
		$map['account'] = $username;
		$user_data = M("user","tab_")->where($map)->find();
		if(empty($user_data)){
			return -1;
		}
		$user = new MemberApi();
		$result = $user->updatePassword($user_data['id'],$password);
		return $result;
	}
    // 发送手机安全码
    public function telsvcode($phone=null,$delay=10,$way=1,$type="phone") {  
 		/// 产生手机安全码并发送到手机且存到session
        $rand = rand(100000,999999);
        $xigu = new Xigu(C('sms_set.smtp'));
        $param = $rand.",".$delay;
        $result = json_decode($xigu->sendSM(C('sms_set.smtp_account'),$phone,C('sms_set.smtp_port'),$param),true); 
        // 存储短信发送记录信息
        $result['create_time'] = time();
        $result['pid']=0;
        $r = M('Short_message')->add($result);
        if($result['send_status'] != '000000') {
            echo json_encode(array('status'=>0,'msg'=>'发送失败，请重新获取'));exit;
        } 
        $telsvcode['code']  = $rand;
        $telsvcode['phone'] = $phone;
        $telsvcode['time']  = $result['create_time'];
        $telsvcode['delay'] = $delay;
        session('telsvcode',$telsvcode);
        if ($way == 0) {
            echo json_encode(array(
            	'status'=> 2,
            	'msg'   => "注册成功！请在".$delay."分钟内完成<br/>验证码已经发送到 $phone",
            	"type"  => $type,
            	'data'  => $telsvcode)
            );           
        } else if ($way == 1) {
            echo json_encode(array('status'=>2,'msg'=>'验证码已重新发送，请查看您的手机',"type"=>$type));
        } else if ($way == 2){
            echo json_encode(array('status'=>2,'msg'=>"请输入验证码，验证码已经发送到 $phone","type"=>$type));
        }            
	}
	/**
	*短信验证
	*/
	public function check_tel_code($username,$password,$type,$code,$g_id,$g_name,$p_id,$p_account,$way){
		$telcode = session('telsvcode');
        $time = (time() - $telcode['time'])/60;
        if ($time>$telcode['delay']) {
            session('telsvcode',null);unset($telcode);
            echo json_encode(array('status'=>0,'msg'=>'时间超时,请重新获取验证码'));exit;
        }
        if ($telcode['code'] == $code) {
        	switch ($way) {
        		case 0:#注册成功
        			$result = $this->register($username,$password,$type,$g_id,$g_name,$p_id,$p_account,$way);
        			if($result){
        				$url = U("Subscriber/index");
        				$this->ajaxReturn(array("status"=>1,"msg"=>"成功","url"=>$url));
        			}else{

        				$this->ajaxReturn(array("status"=>0,"msg"=>"失败","url"=>$url));
        			}
        			break;
        		default:
        			$result = $this->update_paw($username,$password);
        			if($result > 0){
        				if(C('UC_SET')==1){
						  $uc = new Ucservice();
		                  $uc_id=$uc->uc_edit($username,"11",$password,"",1);
					}
        				$url = U("Subscriber/index");
        				$this->ajaxReturn(array("status"=>2,"msg"=>"成功","url"=>$url));
        			}
        			else{
        				$msg = $result == -1 ? "账号不存在":"修改失败";
        				$this->ajaxReturn(array("status"=>0,"msg"=>$msg,));
        			}
        			break;
        	}
        }else{
        	echo json_encode(array('status'=>0,'msg'=>'安全码不正确，请重新输入'));
        }
	}
	/** * 第三方登陆 * */
	public function thirdlogin($type = null){
		empty($type) && $this->error('参数错误');
		session('[destroy]');
		//加载ThinkOauth类并实例化一个对象
		$sns  = ThinkOauth::getInstance($type);
		if(!empty($sns)){
			if($type=="weixin"){
				if(is_weixin()){
					$this->wechat_login(1);
				}else{
					$this->wechat_qrcode_login(1);
				}
			}
			else{
				//跳转到授权页面
				redirect($sns->getRequestCodeURL());
			}
		}
	}

	/** * 回调函数 */
	public function callback($type="", $code =""){
		if(empty($type)||empty($code)){
			$this->error('参数错误',U("index"));
		}
		//加载ThinkOauth类并实例化一个对象
		$sns  = ThinkOauth::getInstance($type);
		$token = $sns->getAccessToken($code , $extend);
		//获取当前登录用户信息
		if(is_array($token)){
			//$user = A('User', 'Event');
            if ($type=='qq') {
                $user_info = A('Type','Event')->qq($token);
                $data['headpic']=$user_info['headpic'];
            } else {
                $user_info = $sns->getUserInfo($token['access_token'],$token['openid']);                          
                $user_info = json_decode($user_info,true);
                $data['headpic']=$user_info['headimgurl'];
            }
            $prefix = $type=="qq"?"QQ_":"WX_";
			$data['account']  = $prefix.time().random_string(6);
			$data['nickname'] = $user_info['nickname'];
			$data['openid']   = $user_info['openid'];
			$data['promote_id'] = $_REQUEST['pid'];
			$data['promote_account'] = get_promote_name($_REQUEST['pid']);
			// $data['third_login_type'] = 4;
			if(get_game_name($_REQUEST['gid'])!=''){
	            $data['fgame_id'] = $_REQUEST['gid'];
	            $data['fgame_name'] = get_game_name($$_REQUEST['gid']);
	        }
			$data['register_way'] = 4;
			$user = new MemberApi();
        	$res = $user->third_login($data);
			if($res){
				session("wechat_token",null);
				session(array('expire' => $token['expires_in']));
            	$token['headimgurl'] = $data['headpic'];
            	session("wechat_token", $token);
				$this->redirect("Subscriber/index");
			}
			else{
				$data['info']=$up->getError();
				$data['status']=0;
			}
		}
	}

	function wite_text($txt,$name){
    	$myfile = fopen($name, "w") or die("Unable to open file!");
    	fwrite($myfile, $txt);
    	fclose($myfile);
	}


	public function isLogin(){
		$data = $this->is_login();
		if($data){
			$this->ajaxReturn(array("status"=>1));
		}else{
			$this->ajaxReturn(array("status"=>0));
		}
	}
	public function checkstatus(){
		sleep(3);
		substr($_REQUEST['out_trade_no'],0,2)=="PF"?$model='deposit':$model='spend';
		$data=M($model,'tab_')->where(array('pay_order_number'=>$_REQUEST['out_trade_no']))->find();
		if($data['pay_status']==1){
			$this->ajaxReturn(array("status"=>1));
		}else{
			$this->ajaxReturn(array("status"=>0));
		}
	}
	/**
	* 退出
	*/
	public function logout() {
		if(is_login_user()){
            D('User')->logout();
            session('[destroy]');
            $data['url'] = U("login");
            echo json_encode($data);
        } else {
            $this->redirect('login');
        }
	}
}