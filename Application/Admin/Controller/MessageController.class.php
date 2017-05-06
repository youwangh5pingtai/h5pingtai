<?php

namespace Admin\Controller;
use User\Api\UserApi as UserApi;

/**
 * 后台首页控制器
 * @author 鬼狐源码社区 <8225001@qq.com>
 */
class MessageController extends ThinkController {
    
    /**
	*纠错列表
    */
    public function feedback($p=0){
        if(isset($_REQUEST['username'])){
        $extend['username'] = array('like','%'.$_REQUEST['username'].'%');
        unset($_REQUEST['username']);
        }
        parent::lists("Feedback",$p,$extend);
    }
}
