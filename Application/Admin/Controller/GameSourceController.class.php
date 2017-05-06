<?php

namespace Admin\Controller;
use User\Api\UserApi as UserApi;

/**
 * 后台首页控制器
 * @author 鬼狐源码社区 <8225001@qq.com>
 */
class GameSourceController extends ThinkController {
	const model_name = 'GameSource';

    public function lists(){
        if(isset($_REQUEST['game_name'])){
            $extend['game_name']=array('like','%'.$_REQUEST['game_name'].'%');
            unset($_REQUEST['game_name']);
        }
    	parent::lists(self::model_name,$_GET["p"],$extend);
    }

    public function add($value='')
    {
    	if(IS_POST){
    		if(empty($_POST['game_id'])){
                $this->error('游戏名称不能为空');
            }
            $map['game_id']=$_POST['game_id'];
            $map['file_type'] = $_POST['file_type'];
            $d = D('Game_source')->where($map)->find();
            $source = A('Source','Event');
            if(empty($d)){
                $source->add_source();
            }
            else{
                $source->update_source($d['id']);
            }
    	}
    	else{
    		$this->display();
    	}
    	
    }
}
