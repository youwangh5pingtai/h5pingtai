<?php
namespace Media\Controller;
use Think\Controller;
use User\Api\MemberApi;
use Common\Api\GameApi;
use Org\XiguSDK\Xigu;
use Org\ThinkSDK\ThinkOauth;
use Common\Api\PayApi;
use Com\Wechat;
use Com\WechatAuth;
use Org\UcenterSDK\Ucservice;

class TuiRegisterController extends BaseController {
	
	protected function _initialize(){
      
    }
	public function __construct() {
		parent::__construct();
	}


	public function index(){
		$this->display();
	}

	/**
	* 登陆
	*/
	public function login($username='',$password='',$type="") {
		if(IS_POST){
            if(session('wechat_token')!=''){
               session('wechat_token',null); 
            }
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
                    if(isset($_REQUEST['game_id'])&&get_game_name($_REQUEST['game_id'])!=''){
                        $url=U('Media/Game/open_game',array('game_id'=>$_REQUEST['game_id']));
                    }else{
                        $url=U('Subscriber/index');
                    }            
                    // var_dump($_REQUEST);exit();
                    $this->ajaxReturn(array("status"=>1,"msg"=>"登陆成功","url"=>$url));
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
                    if(isset($_REQUEST['game_id'])&&get_game_name($_REQUEST['game_id'])!=''){
                        $url=U('Media/Game/open_game',array('game_id'=>$_REQUEST['game_id']));
                    }else{
                        $url=U('Subscriber/index');
                    }
					$this->ajaxReturn(array("status"=>1,"msg"=>"登陆成功","url"=>$url));
					break;
			}
        }
		}else{
			$this->display();
		}
	}

	/** * 第三方登陆 * */
	public function thirdlogin($type = null,$gid=0,$pid=0){
		empty($type) && $this->error('参数错误');
        session('[destroy]');
        $sns  = ThinkOauth::getInstance($type);
        if(!empty($sns)){
    		if($type=="weixin"){
    			if(is_weixin()){
    				$this->wechat_login(1,$gid,$pid);
    			}else{
    				$this->wechat_qrcode_login(1,$gid,$pid);
    			}
    		}else{
                //跳转到授权页面
                if(get_game_name($gid)!=''){
                    $qqurl=$sns->getRequestCodeURL($gid,$pid);
                }else{
                    $qqurl=$sns->getRequestCodeURL();
                }
                redirect($qqurl);
            }
        }
	}
    
    //注册
    public function register($username='',$password='',$type='',$game_id=0,$promote_id=0) {
    	$user = new MemberApi();
    	$data['account']  = $username;
    	$data['password'] = $password;
        $data['nickname'] = $username;
        $data['phone']    = $type=='phone'?$username:"";
        $data['headimgurl'] = $userInfo['headimgurl'];
        $data['openid']     = $userInfo['unionid'];
        $data['promote_id']        = $promote_id;
        $data['promote_account']   = get_promote_name($promote_id);
        $data['third_login_type']  = $type == "phone"?1:0;
        $data['register_way'] = 1;
        if(get_game_name($game_id)!=''){
            $data['fgame_id'] = $game_id;
            $data['fgame_name'] = get_game_name($game_id);
        }
        if(C('UC_SET')==1){
        $uc = new Ucservice();
        $uc_id=$uc->uc_register($username,$password,"",$promote_id,get_promote_name($promote_id),$game_id, get_game_name($game_id),3,1);
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
                    if(isset($_REQUEST['game_id'])&&get_game_name($_REQUEST['game_id'])!=''){
                        $url=U('Media/Game/open_game',array('game_id'=>$_REQUEST['game_id']));
                    }else{
                        $url=U('Subscriber/index');
                    }
					$this->ajaxReturn(array("status"=>1,"msg"=>"注册成功","url"=>$url));
					break;
			}
			exit();
		}
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
            echo json_encode(array('status'=>2,'msg'=>'验证码已重新发送，请查看您的手机',"type"=>$type,'data'=>$telsvcode));
        } else if ($way == 2){
            echo json_encode(array('status'=>2,'msg'=>"请输入验证码，验证码已经发送到 $phone","type"=>$type,'data'=>$telsvcode));
        }            
	}

	/**
	*短信验证
	*/
	public function check_tel_code($username,$password,$type,$code,$g_id,$p_id,$way){
		$telcode = session('telsvcode');
        $time = (time() - $telcode['time'])/60;
        if ($time>$telcode['delay']) {
            session('telsvcode',null);unset($telcode);
            echo json_encode(array('status'=>0,'msg'=>'时间超时,请重新获取验证码'));exit;
        }
        if ($telcode['code'] == $code) {
        	switch ($way) {
        		case 0:#注册成功
        			$result = $this->register($username,$password,$type,$g_id,$p_id,$way);
        			if($result){
                        if(get_game_name($g_id)!=''){
                            $url=U('Media/Game/open_game',array('game_id'=>$g_id));
                        }else{
                            $url = U("Subscriber/index");
                        }
        				$this->ajaxReturn(array("status"=>1,"msg"=>"成功","url"=>$url));
        			}else{
        				$this->ajaxReturn(array("status"=>0,"msg"=>"失败","url"=>$url));
        			}
        			break;
        		default:
        			$result = $this->update_paw($username,$password);
        			if($result > 0){
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

	/** * 第三方微信公众号登陆 * */
	public function wechat_login($state=0,$gid=0,$pid=0){
		
		if(is_weixin()){
			$appid     = C('wechat.appid');
            $appsecret = C('wechat.appsecret');
            $token = session("token");
	        if($token){
	            $auth = new WechatAuth($appid, $appsecret, $token);
	        } else {
	            $auth  = new WechatAuth($appid, $appsecret);
	            $token = $auth->getAccessToken();
	            session(array('expire' => $token['expires_in']));
	            session("token", $token['access_token']);
	        }
            $redirect_uri = "http://".$_SERVER['HTTP_HOST']."/media.php/TuiRegister/wechat_login_game/gid/".$gid.'/pid/'.$pid;
            //var_dump($redirect_uri);exit();
            redirect($auth->getRequestCodeURL($redirect_uri,$state));
		}
	}

	/** * 第三方微信扫码登陆 * */
	public function wechat_qrcode_login($state=1,$gid=0,$pid=0){
		if(!is_weixin()){
			$appid     = C('wx_login.appid');
            $appsecret = C('wx_login.appsecret');
            $token = session("qrcode_token");
	        if($token){
	            $auth = new WechatAuth($appid, $appsecret, $token);
	        } else {
	            $auth  = new WechatAuth($appid, $appsecret);
	            $token = $auth->getAccessToken();
	            session(array('expire' => $token['expires_in']));
	            session("qrcode_token", $token['access_token']);
	        }
            $redirect_uri = "http://".$_SERVER['HTTP_HOST']."/media.php/TuiRegister/wechat_login_game/gid/".$gid.'/pid/'.$pid;
            redirect($auth->getQrconnectURL($redirect_uri,$state));
		}
	}

	public function wechat_login_game(){
        if(is_weixin()){
            $appid     = C('wechat.appid');
            $appsecret = C('wechat.appsecret');
        }else{
            $appid     = C('wx_login.appid');
            $appsecret = C('wx_login.appsecret');
        }
        
        $auth  = new WechatAuth($appid, $appsecret);
        $token = $auth->getAccessToken("code",$_GET['code']);
        
        $userInfo = $auth->getUserInfo($token['openid']);
        $login_data['account']  = "WX_".date('Ymd').date ( 'His' ).sp_random_string(6);
        $login_data['nickname'] = $userInfo['nickname'];
        $login_data['headimgurl'] = $userInfo['headimgurl'];
        $login_data['openid']     = $userInfo['unionid'];
        $login_data['promote_id'] = $_REQUEST['pid'];
        $login_data['promote_account'] = get_promote_name($_REQUEST['pid']);
        $login_data['register_way']=3;
        if(get_game_name($_REQUEST['gid'])){
            $login_data['fgame_id']  = $_REQUEST['gid'];
            $login_data['fgame_name']  = get_game_name($_REQUEST['gid']);
        }
        session("wechat_token",null);
        //if(empty(session("wechat_token"))){
            session(array('expire' => $token['expires_in']));
            $token['headimgurl'] = $userInfo['headimgurl'];
            session("wechat_token", $token);
        //}
        $user = new MemberApi();
        $result = $user->third_login($login_data);
        if($_GET['state'] == 0){
            $this->redirect("Index/index");
        }else{
            if($_REQUEST['gid']!=0&&get_game_name($_REQUEST['gid'])!=''){
                $this->redirect("Game/open_game/game_id/".$_REQUEST['gid']);
            }else{
               $this->redirect("Subscriber/index"); 
            }
        }
     }
}