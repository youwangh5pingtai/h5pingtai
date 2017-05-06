<?php
namespace Media\Controller;
use Think\Controller;
use Com\Wechat;
use Com\WechatAuth;
/**
* 首页
*/
class BaseController extends Controller {
	protected function _initialize(){
      $config = api('Config/lists');
        C($config); //添加配置
        $this->wechat_login();
    }
	public function __construct() {
		parent::__construct();
		
	}

	public function is_login(){
		$user = session('user_auth');
	    if (empty($user)) {
	        return 0;
	    } else {
	        return session('user_auth_sign') == data_auth_sign($user) ? $user['user_id'] : 0;
	    }
	}

	/** * 第三方微信公众号登陆 * */
	public function wechat_login($state=0){
		$len = session("user_auth.user_id");
		if(empty($len) && is_weixin()){
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
            $redirect_uri = "http://".$_SERVER['HTTP_HOST']."/media.php/ThirdLogin/wechat_login";
            var_dump($redirect_uri);exit();
            redirect($auth->getRequestCodeURL($redirect_uri,$state));
		}
		if(get_user_entity(session("user_auth.user_id"))==''&& is_weixin()){
			session('[destroy]');
			$this->wechat_login();
		}
	}

	/** * 第三方微信扫码登陆 * */
	public function wechat_qrcode_login($state=1){
        $len = session("user_auth.user_id");
		if(empty($len) && !is_weixin()){
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
            $redirect_uri = "http://".$_SERVER['HTTP_HOST']."/media.php/ThirdLogin/wechat_login";
            redirect($auth->getQrconnectURL($redirect_uri,$state));
		}
	}


	
    public function lists($model,$p){
        $page = intval($p);
        $page = $page ? $page : 1; //默认显示第一页数据
		$fields = array($model['search_key'],$model['search_type']);
        //获取模型信息
        $model = M('Model')->getByName($model["model"]);
        $model || $this->error('模型不存在！');
        // 关键字搜索
        $map	=	array();
        $key	=	$model['search_key']?$model['search_key']:'title';
        if(isset($_REQUEST[$key])){
            $map[$key]	=	array('like','%'.$_GET[$key].'%');
            unset($_REQUEST[$key]);
        }
        // 条件搜索
        foreach($_REQUEST as $name=>$val){
            if(in_array($name,$fields)){
                $map[$name]	=	$val;
            }
        }
        $row  = empty($model['list_row']) ? 10 : $model['list_row'];
        //读取模型数据列表
        in_array('id', $fields) || array_push($fields, 'id');
        $name = parse_name(get_table_name($model['id']), true);
        $data = M($name)
        /* 查询指定字段，不指定则查询所有字段 */
        ->field(true)
        // 查询条件
        ->where($map)
        /* 默认通过id逆序排列 */
        ->order('id DESC')
        /* 数据分页 */
        ->page($page, $row)
        /* 执行查询 */
        ->select();
        /* 查询记录总数 */
        $count = M($name)->where($map)->count();
        //分页
        if($count > $row){
            $page = new \Think\Page($count, $row);
            $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
            $this->assign('_page', $page->show());
        }
		
		
        $this->assign('model', $model);
        $this->assign('list_data', $data);
        $this->meta_title = $model['title'].'列表';
	}
	
	/**
	* search 
	* lwx
	*/
	public function search($model,$p){
        $page = intval($p);
        $page = $page ? $page : 1; //默认显示第一页数据
        // 关键字搜索
        $map	=	array();
		$sk = $model['search_key']?$model['search_key']:'title';
		$sn = explode(",",$model['search_isnum']);
        $fields = $key	= explode(",",$sk);	
        if(isset($model['search_value'])){
			foreach($key as $k) {
				if (in_array($k,$sn)) {
					$str = $model['search_value'];
					eval("\$result = get_".$k."_code(\"".$str."\",'like');");
					if ($result)
						$map[$k] = "$result";
				} else 
					$map[$k]	=	array('like','%'.$model['search_value'].'%');
			}
			$map['_logic']=$model['search_logic'];
			unset($model['search_value']);
        }
		
		if (isset($model['join'])) {
			$join = $model['join'];
			$joinnum = isset($model['joinnum'])? $model['joinnum'] : 'INNER';
		} else {
			$join=$joinnum="";
		}
		if (isset($model['join1'])) {
			$join1 = $model['join1'];
			$joinnum1 = isset($model['joinnum1'])? $model['joinnum1'] : 'INNER';
		} else {
			$join1=$joinnum1="";
		}
		$m = substr($model['model'],0,1);
		$field = isset($model['field'])?$model['field']:true;
		$table = isset($model['table'])?$model['table']:"__".strtoupper($model['model'])."__ as ".strtolower($m)." ";
		$order = isset($model['order'])?$model['order']:" ".strtolower($m).".id DESC ";
		if (isset($model['where'])) {
			$where['_complex']=$map;
			$where['_string']=$model['where'];
		} else {
			$where['_complex']=$map;
		}
        //获取模型信息
        $model = D('Model')->getByName($model["model"]);
        $model || $this->error('模型不存在！');
        $row = empty($model['list_row']) ? 10 : $model['list_row'];
        //读取模型数据列表
        in_array('id', $fields) || array_push($fields, 'id');
        $name = parse_name(get_table_name($model['id']), true);
        $data = D($name)->table($table)
        /* 查询指定字段，不指定则查询所有字段 */
        ->field($field)
		->join($join,$joinnum)
		->join($join1,$joinnum1)
        // 查询条件
        ->where($where)
        /* 默认通过id逆序排列 */
        ->order($order)
        /* 数据分页 */
        /* ->page($page, $row) */
        /* 执行查询 */
        ->select();
        /* 查询记录总数 */
        $count = D($name)->table($table)->join($join,$joinnum)
		->join($join1,$joinnum1)
		->where($where)->count();
        //分页
        if($count > $row){
            $page = new \Think\Page($count, $row);
            $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
            $this->assign('_page', $page->show());
        }
		
        $this->assign('model', $model);        
        $this->meta_title = $model['title'].'列表';
		if ($count) {
			$total = intval(($count-1)/$row+1);
			return array('list'=>$data,'total'=>$total);
		} else 
			return false;
		
	}

	public function pagelists($model,$p){
        $page = intval($p);
        $page = $page ? $page : 1; //默认显示第一页数据	
 
		if (empty($model['where']))			
			$map = " ";
		else $map = $model['where'];
		
		if (empty($model['order']))			
			$mapo = " id DESC ";
		else $mapo = $model['order'];
        //获取模型信息
        $model = M('Model')->getByName($model["model"]);
        $model || $this->error('模型不存在！');
        $row    = empty($model['list_row']) ? 10 : $model['list_row'];
        //读取模型数据列表
        $name = parse_name(get_table_name($model['id']), true);
        $data = M($name)
        /* 查询指定字段，不指定则查询所有字段 */
        ->field(true)
        // 查询条件
        ->where($map)
        /* 默认通过id逆序排列 */
        ->order($mapo)
        /* 数据分页 */
        ->page($page, $row)
        /* 执行查询 */
        ->select();
        /* 查询记录总数 */
        $count = M($name)->where($map)->count();
        //分页
        if($count > $row){
            $page = new \Think\Page($count, $row);
            $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
            $this->assign('_page', $page->show());
        }
		
        $this->assign('model', $model);
        $this->assign('plist_data', $data);
        $this->meta_title = $model['title'].'列表';
	}
	
	public function plists($model,$p){
        $page = intval($p);
        $page = $page ? $page : 1; //默认显示第一页数据	
		$map=array();
		$map[] = " 1 ";
		$tablename = C('DB_PREFIX').strtolower($model["model"]);
		$m = M($name)->query("SHOW COLUMNS FROM ".$tablename);
		foreach($m as $n) {
			$fields[]=$tablename.'.'.$n['Field'];
		}
		// 条件搜索
        foreach($_REQUEST as $name=>$val){
            if(in_array($tablename.'.'.$name,$fields)){
                $map[$tablename.'.'.$name]	=	$val;
            }
        }

		if (empty($model['order']))			
			$mapo = $tablename.".id DESC ";
		else $mapo = $tablename.'.'.$model['order'];
		if (empty($model['join']))			
			$mapj = null;
		else {
			$mapj = $model['join'];
			$mapd=$model['direction'];
		}
		if (!empty($model['field'])) {
			$f = explode(',',$model['field']);
			foreach($f as $i) {
				$fields[]=$i;
			}
		}
        //获取模型信息
        $model = M('Model')->getByName($model["model"]);
        $model || $this->error('模型不存在！');
        $row    = empty($model['list_row']) ? 10 : $model['list_row'];
        //读取模型数据列表
        $name = parse_name(get_table_name($model['id']), true);
		if (empty($mapj)) {
			$data = M($name)
			/* 查询指定字段，不指定则查询所有字段 */
			->field(true)
			// 查询条件
			->where($map)
			/* 默认通过id逆序排列 */
			->order($mapo)
			/* 数据分页 */
			->page($page, $row)
			/* 执行查询 */
			->select();
		
		} else {
			$data = M($name)
			->field($fields)
			->join($mapj,$mapd)
			->where($map)
			->order($mapo)
			->page($page, $row)
			->select();
		}
			/* 查询记录总数 */
        $count = M($name)->where($map)->count();
        //分页
        if($count > $row){
            $page = new \Think\Page($count, $row);
            $page->setConfig('theme','%FIRST% %UP_PAGE% %LINK_PAGE% %DOWN_PAGE% %END% %HEADER%');
            $this->assign('_page', $page->show());
        }
		
        $this->assign('model', $model);
        $this->assign('plist_data', $data);
        $this->meta_title = $model['title'].'列表';
	}
	
	public function getlists($model) {
		if (isset($model['join'])) {
			$join = $model['join'];
			$joinnum = isset($model['joinnum'])? $model['joinnum'] : 'INNER';
		} else {
			$join=$joinnum="";
		}
		if (isset($model['join1'])) {
			$join1 = $model['join1'];
			$joinnum1 = isset($model['joinnum1'])? $model['joinnum1'] : 'INNER';
		} else {
			$join1=$joinnum1="";
		}
		$m = substr($model['model'],0,1);
		$field = isset($model['field'])?$model['field']:true;
		$table = isset($model['table'])?$model['table']:"__".strtoupper($model['model'])."__ as ".strtolower($m)." ";
		$order = isset($model['order'])?$model['order']:" ".strtolower($m).".id DESC ";
		$mo = D($model['model']);
		$list = $mo->field($field)->table($table)
		->join($join,$joinnum)
		->join($join1,$joinnum1)
		->where($model['where'])
		->order($order)->limit($model['limit'])
		->page($model['page'])->select();
		$count = $mo->table($table)->join($join,$joinnum)
		->join($join1,$joinnum1)->where($model['where'])->count();
		$totalpage = intval(($count-1)/$model['limit']+1);	
		return array('list'=>$list,'total'=>$totalpage);
	}
	
	public function getlist($model) {
		if (isset($model['join'])) {
			$join = $model['join'];
			$joinnum = isset($model['joinnum'])? $model['joinnum'] : 'INNER';
		} else {
			$join=$joinnum="";
		}
		if (isset($model['join1'])) {
			$join1 = $model['join1'];
			$joinnum1 = isset($model['joinnum1'])? $model['joinnum1'] : 'INNER';
		} else {
			$join1=$joinnum1="";
		}
		$m = substr($model['model'],0,1);
		$field = isset($model['field'])?$model['field']:true;
		$table = isset($model['table'])?$model['table']:"__".strtoupper($model['model'])."__ as ".strtolower($m)." ";
		$order = isset($model['order'])?$model['order']:" ".strtolower($m).".id DESC ";
		$mo = D($model['model']);
		$list = $mo->field($field)->table($table)
		->join($join,$joinnum)
		->join($join1,$joinnum1)
		->where($model['where'])
		->order($order)->limit($model['limit'])
		->page($model['page'])->select();
		$count = $mo->table($table)->join($join,$joinnum)
		->join($join1,$joinnum1)->where($model['where'])->count();
		return array('list'=>$list,'count'=>$count);
	}
	
	public function getdata($model) {
		if(isset($model['field'])) $field = $model['field'];
		else $field = true;
		$mo = D($model['model']);
		$list = $mo->field($field) ->join($model['joins'])->where($model['where'])
		->order($model['order'])->limit($model['limit'])
		->page($model['page'])->select();
		return $list;
	}
	
	public function showlist($model,$num=10) {
		if ($num==-1) $num="";
		if (isset($model['join'])) {
			$join = $model['join'];
			$joinnum = isset($model['joinnum'])? $model['joinnum'] : 'INNER';
		} else
			$join=$joinnum="";
		$m = substr($model['model'],0,1);
		$field = isset($model['field'])?$model['field']:true;
		$table = isset($model['table'])?$model['table']:"__".strtoupper($model['model'])."__ as ".strtolower($m)." ";
		$mo = D($model['model']);
		$list = $mo->field($field)->table($table)->join($join,$joinnum)->where($model['where'])->order($model['order'])->limit($num)->select();
		return $list;
	}
	
	public function detail($model) {
		if (isset($model['djoin'])) {
			$join = $model['djoin'];
			$joinnum = isset($model['djoinnum'])? $model['djoinnum'] : 'INNER';
		} else
			$join=$joinnum="";
		$m = substr($model['model'],0,1);
		$field = isset($model['dfield'])?$model['dfield']:true;
		$table = isset($model['dtable'])?$model['dtable']:"__".strtoupper($model['model'])."__ as ".strtolower($m)." ";
		$mo = D($model['model']);
		$data = $mo->field($field)->table($table)->join($join,$joinnum)->where($model['dwhere'])->order($model['dorder'])->find();
		return $data;
	}
    
    public function pdetail($model) {
		if (isset($model['join'])) {
			$join = $model['join'];
			$joinnum = isset($model['joinnum'])? $model['joinnum'] : 'INNER';
		} else{
			$join=$joinnum="";
		}
		$m = substr($model['model'],0,1);
		$field = isset($model['field'])?$model['field']:true;
		$table = isset($model['table'])?$model['table']:"__".strtoupper($model['model'])."__ as ".strtolower($m)." ";
		$mo = D($model['model']);
		$data = $mo->field($field)->table($table)->join($join,$joinnum)->where($model['where'])->order($model['order'])->find();
		return $data;
	}
}