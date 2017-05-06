<?php
namespace Media\Controller;
use Think\Controller;
use Common\Api\GameApi;
/**
* 首页
*/
class IndexController extends BaseController {

    public function index(){
        $game=M('Game','tab_');
        $map['game_status']=1;
        $map['recommend_status']=array('like','%1%');
        $recommend=$game->where($map)->count();
        $recommend?$recommend:0;
        $map['recommend_status']=array('like','%3%');
        $newsgamecount=$game->where($map)->count();
        $newsgamecount?$newsgamecount:0;
        $map['recommend_status']=array('like','%2%');
        $playgamecount=$game->where($map)->count();
        $playgamecount?$playgamecount:0;
        $this->assign('recommendcount',$recommend);
        $this->assign('newsgamecount',$newsgamecount);
        $this->assign('playgamecount',$playgamecount);
		$this->display();
	}
    public function open_game()
    {
        $up = D("User")->isLogin();
        if (empty($up) || 1 != $up['status']) {
            }
        $GameApi=new GameApi();
        $uid=$_REQUEST['uid'];
        $game_id=$_REQUEST['game_id'];
        $login_url=get_login_notify_url($game_id);
        $promote_id=$_REQUEST['promote_id'];
        if($promote_id>0){
            $pid=$promote_id;
        }else{
            $pid =$_REQUEST['pid']==""?0:$_REQUEST['pid'];
        }
        $GameApi->game_login($uid,$game_id,$login_url,$pid);
    }
	
}  
