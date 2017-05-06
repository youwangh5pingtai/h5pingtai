<?php
namespace Media\Controller;
use Think\Controller;
class SearchController extends BaseController {
/*	public function index() {
		$game_type = M("GameType","tab_");
		$data = $game_type->select();
		$this->assign("game_type",$data);
		$this->display();
	}*/	

	//搜索首页 
	public function index() {
		$this->assign('game_type',D('game')->game_type_count());
		$this->display();
	}
	
	// 异步返回
	public function search($p=1,$keyword='') {
		if(isset($_POST['key'])){
			$map['game_name']=array("like","%".$_POST['key']."%");
		}
		if (isset($_POST['keyword'])) {
			$map['game_type_name']=array("like","%".$keyword."%");
		}
		$map['game_status']=1;
		$game=M("game","tab_")->where($map)->order('sort desc')->select();
		foreach ($game as $key => $value) {
			$game[$key]['picurl'] = get_cover($value['icon'],"path");
		}
		echo json_encode(array("data"=>$game));
	}
}