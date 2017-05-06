<?php
namespace Media\Controller;
use Think\Controller;
use User\Api\MemberApi;
use Common\Api\GameApi;
use Com\Wechat;
use Com\WechatAuth;


class ThirdLoginController extends Controller {
    public function wechat_login(){
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
        // $login_data['headimgurl'] = $userInfo['headimgurl'];
        $login_data['openid']     = $userInfo['unionid'];
        $login_data['promote_id']        = 0;
        $login_data['promote_account']   = "自然注册";
        // $login_data['third_login_type']  = 2;
        $login_data['register_way']=3;
        session("wechat_token",null);
        
        
        $len = session("wechat_token");
        if(empty($len)){    
            session(array('expire' => $token['expires_in']));
            $token['headimgurl'] = $userInfo['headimgurl'];
            session("wechat_token", $token);
        }
        $user = new MemberApi();
        $result = $user->third_login($login_data);
        if($_GET['state'] == 0){
            $this->redirect("Index/index");
        }else{
            $this->redirect("Subscriber/index");
        }
     }
}