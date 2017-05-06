<?php
namespace Media\Controller;
use Think\Controller;
class GiftController extends BaseController {
	
	public function index($p=1,$type=null) {
		if(empty($type) || $type == 0){
			$m['name'] = "giftbag";
			$m['map'] = array("status"=>1);
			$data = $this->bind_list($m);
		}else{
			$this->assign("datas",D('Giftbag')->open_service());
		}
		$this->assign("data",$data);
		$this->display();
	}
	
	protected function bind_list($m=null) {
		$model = M($m['name'],'tab_');
		$data  = $model
					->field("tab_giftbag.*,tab_game.icon")
					->join("left join tab_game on tab_giftbag.game_id = tab_game.id")
					->where($m['map'])->order('sort desc')->select();
		return $data;
	}
	
	
	public function detail($id) {
		$game['model']='Giftbag';
		$game['field']="gb.*,g.game_name,g.icon,g.cover";
		$game['table']="__GIFTBAG__ as gb";
		$game['join']="__GAME__ as g on gb.game_id=g.id";
		$game['joinnum']="Left";
		$game['where']=" gb.status=1 and gb.id=$id";
		$data = parent::pdetail($game);
		if($data['novice']==""){
		$data['nvaluenum']=0;
		}else{
		$novice = explode(",",$data['novice']);	
		$data['nvaluenum']=count($novice);			
		}
		$qq_group=M('game_set','tab_')->where(array('game_id'=>$data['game_id']))->find();
		$this->assign("data",$data);
		$this->assign("qq_group",$qq_group['qq_group']);
		$this->display();
	}
	
	/* public function getgift($id) {
		$giftbag = D('Giftbag');
		$sql = "select novice from tab_giftbag where status=1 and id=$id";		
		$data = $giftbag->query($sql);
		if ($data) {
			$data = $data[0];
			$novice = explode(",",$data['novice']);
			$data=null;
			$data['nvalue']=$novice[0];
			
			array_shift($novice);
			array_push($novice,$data['nvalue']);
			$novice1['novice'] = implode(",",$novice);
			$giftbag->where("id=$id")->save($novice1);
			
			$data['status']=1;			
		} else {
			$data['status']=0;
		}
		echo json_encode($data);
	} */
	public function getgift($gameid,$gamename,$giftid,$giftname) {
		if(!is_array(find_uc_account(session('user_auth.account')))){
			$this->ajaxReturn(array('status'=>'0','info'=>'UC用户暂不支持'));exit();
		}
		$users = $this->is_login();		
		if($users) {   
			$list=D('Gift_record');
			$uid = session('user_auth.user_id');
			$info=$list->field('novice')->where("gift_id=$giftid and user_id=$uid")->find();
			if($info) {
				$data=$info['novice'];
				$this->ajaxReturn(array('status'=>'2','info'=>'不要太贪心啊，给别人一个领取的机会吧','url'=>'','nvalue'=>$data));
			} else {
				$giftbag = D('Giftbag');
				$n = $giftbag->field('novice')->where("id=$giftid")->find();
				$n = $n['novice'];
				if (empty($n)) {
					$this->ajaxReturn(array('status'=>'0','info'=>'你来晚了一步，礼包已被领取完了','url'=>'','nvalue'=>''));	
				} else {					
					$novice = explode(",",$n);
					$guid = $novice[0];										
					$data['game_id']=$gameid;
					$data['game_name']=$gamename;
					$data['gift_id']=$giftid;
					$data['gift_name']=$giftname;
					$data['status']=0;
					$data['novice']=$guid;
					$data['user_id']=$uid;
					$data['create_time']=time();
					$list->add($data);
					array_shift($novice);
					$n = implode(",",$novice);
					$giftbag->where("id=$giftid")->setField('novice',$n);
					$this->ajaxReturn(array('status'=>'1','info'=>'恭喜你，领取成功！','url'=>'','nvalue'=>$guid));
				}
			}    
		} else {
			$this->ajaxReturn(array('status'=>'0','info'=>'您还未登陆，请登陆后领取','url'=>U('Subscriber/login')),C('DEFAULT_AJAX_RETURN'));
		}
	}
	
	
	public function getdata($p=1,$type=null) {
		if (!empty($type) && intval($type) === 1) {
			$area['model']="Area";
			$area['field']="a.*,g.game_name,g.game_type,g.icon,g.cover";
			$area['table']="__AREA__ as a";
			$area['join']=" __GAME__ as g on g.id=a.game_id ";
			$area['joinnum']="left";
			//$area['where']=" a.show_status=1 and a.stop_status=1 and from_unixtime(a.start_time,'%Y-%m-%d') > curdate()";
			$time=time();
			$area['where']=" a.show_status=1 and a.stop_status=1 and a.start_time>$time";
			$area['order']="a.start_time";
			$area['limit']=8;
			$area['page']=$p;
			$gl = parent::getlists($area);
			$glist=$this->change($gl['list']);
			if($glist) {
				$data = array(
					'data'		=>	$glist,
					'page' 		=> 	intval($p)+1,
					//'total' 	=> 	$totalpage,
					'status'	=> 1,
				);
			} else
				$data = array(
					'data'		=>	'',
					'page' 		=> 	$p,
					'tatus'	=> 0,
				);
			echo json_encode($data);
		} else {	
			$gift["model"] = "Giftbag";
			$gift['table'] ="__GIFTBAG__ as gb";
			$gift['field'] = 'gb.*,g.game_name,g.cover,g.icon';
			$gift['join'] = " __GAME__ as g on gb.game_id=g.id ";
			$gift['joinnum']="left";
			$gift['order']=' gb.create_time desc';
			$gift['where']=' gb.status=1 ';
			$gift['limit']=8;
			$gift['page']=$p;
			$gl = parent::getlists($gift);
			$glist=$this->change($gl['list']);
			if($glist) {
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
			echo json_encode($data);	
		}
	}
	
}