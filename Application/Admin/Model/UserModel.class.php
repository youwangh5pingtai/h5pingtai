<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.guifox.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: huajie <banhuajie@163.com>
// +----------------------------------------------------------------------

namespace Admin\Model;
use Think\Model;

/**
 * 文档基础模型
 */
class UserModel extends Model{

    /* 自动验证规则 */
    protected $_validate = array(
        array('account', '', -3, self::EXISTS_VALIDATE, 'unique'), //用户名被占用
    );

    /* 自动完成规则 */
    protected $_auto = array(
        array('password', 'think_ucenter_md5', self::MODEL_BOTH, 'function', UC_AUTH_KEY),
        array('anti_addiction', 0, self::MODEL_INSERT),
        array('lock_status', 1, self::MODEL_INSERT),
        array('balance', 0, self::MODEL_INSERT),
        array('cumulative', 0, self::MODEL_INSERT),
        array('vip_level', 0, self::MODEL_INSERT),
        //array('register_ip', 'get_client_ip', self::MODEL_INSERT, 'function'),
        array('register_time', NOW_TIME,self::MODEL_INSERT),
    );

    //protected $this->$tablePrefix = 'tab_'; 
    /**
     * 构造函数
     * @param string $name 模型名称
     * @param string $tablePrefix 表前缀
     * @param mixed $connection 数据库连接信息
     */
    public function __construct($name = '', $tablePrefix = '', $connection = '') {
        /* 设置默认的表前缀 */
        $this->tablePrefix ='tab_';
        /* 执行构造方法 */
        parent::__construct($name, $tablePrefix, $connection);
    }

    public function login($account,$password,$type,$game_id,$game_name){
        $map['account'] = $account;
        /* 获取用户数据 */
        $user = $this->where($map)->find();
        if(is_array($user) && $user['lock_status']){
            /* 验证用户密码 */
            if(think_ucenter_md5($password, UC_AUTH_KEY) === $user['password']){
                $this->updateLogin($user['id']); //更新用户登录信息
                $this->autoLogin($user);
                //$this->user_login_record($user,$type,$game_id,$game_name);
                return $user['id']; //登录成功，返回用户ID
            } else {
                return -2; //密码错误
            }
        } else {
            if($user['lock_status'] === 0 ){
                return -4;
            }
            return -1; //用户不存在或被禁用
        }
    }

    public function third_login($login_data){
        $map['openid'] = $login_data['openid'];
        /* 获取用户数据 */
        $user = $this->where($map)->find();
        if(is_array($user)){
            if($user['fgame_id']==0&&$login_data['fgame_id']!=0&&$login_data['fgame_name']!=''){
                $this->update_third_Login_($user['id'],$login_data['nickname'],$login_data['fgame_id'],$login_data['fgame_name']); //更新用户登录信息
            }else{
                $this->update_third_Login($user['id'],$login_data['nickname']); //更新用户登录信息
            }
            $this->autoLogin($user);
            return $user['id']; //登录成功，返回用户ID
        } else {
            if(empty($user)){
                $data['account']  = $login_data['account'];
                $data['password'] = $login_data['account'];
                $data['nickname'] = $login_data['nickname'];
                $data['phone']    = "";
                $data['openid']   = $login_data['openid'];
                $data['promote_id'] = $login_data['promote_id'];
                $data['promote_account']  = $login_data['promote_account'];
                // $data['third_login_type'] = $login_data['third_login_type'];
                $data['register_way'] = $login_data['register_way'];
                $data['fgame_id'] = $login_data['fgame_id'];
                $data['fgame_name'] = $login_data['fgame_name'];
                $this->register($data);
            }
            return -1; //用户不存在或被禁用
        }
    }
    //用户登录记录
    public function user_login_record($data,$type,$game_id,$game_name){
        $data=array(
            'user_id'=>$data['id'],
            'user_account'=>$data['account'],
            'user_nickname'=>$data['nickname'],
            'game_id'=>$game_id,
            'game_name'=>$game_name,
            'server_id'=>null,
            'type'=>$type,
            'server_name'=>null,
            'login_time'=>NOW_TIME,
            'login_ip'=>get_client_ip(),
        );
            $uid =M('user_login_record','tab_')->add($data);
            return $uid ? $uid : 0; //0-未知错误，大于0登录记录成功
    }
    /**
    *游戏用户注册
    */
    public function register($data){
        $data = array(
            'account'    => $data['account'],
            'password'   => $data['password'],
            'nickname'   => $data['nickname'],
            'phone'      => $data['phone'],
            'openid'     => $data['openid'],
            'promote_id' => $data['promote_id'],
            'promote_account'  => $data['promote_account'],
            'third_login_type' => $data['third_login_type'],
            'register_way' => $data['register_way'],
            'register_ip'  => get_client_ip(),
            'parent_id'=>$data['parent_id'],
            'parent_name'=>$data['parent_name'],
            'fgame_id'=>$data['fgame_id'],
            'fgame_name'=>$data['fgame_name'],
            'register_time'=>$data['register_time'],
        );
        //if(!$this->checkAccount($account)){return -1;}
        /* 添加用户 */
        if($this->create($data)){
            $uid = $this->add();
            $data['id'] = $uid;
            $this->autoLogin($data);
            if(!empty($data['openid'])){
                $this->update_third_Login($data['id'],$data['nickname']);
            }
            return $uid ? $uid : 0; //0-未知错误，大于0-注册成功
        } else {
            return $this->getError(); //错误详情见自动验证注释
        }
    }
    /**
    *修改用户信息
    */
    public function updateUser($data){
        $c_data = $this->create($data);
        if(empty($data['password'])){
            unset($c_data['password']);
        }
        else {
            if(!$this->verifyUser($data['id'],$data['old_password'])){
               return -2;
            }
        }
        return  $this->where("id=".$data['id'])->save($c_data);
    }

    /**
     * 获取详情页数据
     * @param  integer $id 文档ID
     * @return array       详细数据
     */
    public function detail($id){
        /* 获取基础数据 */
        $info = $this->field(true)->find($id);
        if(!(is_array($info) || 1 !== $info['status'])){
            $this->error = '文档被禁用或已删除！';
            return false;
        }

        /* 获取模型数据 */
        $logic  = $this->logic($info['model_id']);
        $detail = $logic->detail($id); //获取指定ID的数据
        if(!$detail){
            $this->error = $logic->getError();
            return false;
        }
        $info = array_merge($info, $detail);

        return $info;
    }

    /**
    *检查账号是否存在
    */
    protected function checkAccount($account){
        $map['account'] = $account;
        $data = $this->where($map)->find();
        if(empty($data)){return true;}
        return false;
    }
    
    // 检查用户 lwx
    public function checkUsername($account){
        $map['account'] = $account;
        $data = $this->where($map)->find();
        if(empty($data)){return true;}
        return false;
    }
    
    // 更改密码  lwx 2015-05-20
    public function updatePassword($id,$password) {
        $map['id']=$id;
        $data['password']=think_ucenter_md5($password, UC_AUTH_KEY);
        $return = $this->where($map)->save($data);
        if ($return == true)
            return true;
        else 
            return false;
    }
    
    public function checkPassword($account,$password) {
        $map['account'] = $account;
        $map['password'] = think_ucenter_md5($password, UC_AUTH_KEY);
        $user = $this->where($map)->find();
        if(is_array($user) && $user['lock_status']){
            return true;
        } else {
            return false; 
        }
    }
    

    protected function updateLogin($uid){
        $model = M('User','tab_');
        $data["id"] = $uid;
        $data["login_time"] = NOW_TIME;
        $data["login_ip"]   = get_client_ip();
        $model->save($data);
    }

    protected function update_third_Login($uid,$nickname){
        $model = M('User','tab_');
        $data["id"] = $uid;
        $data['nickname'] = $nickname;
        $data["login_time"] = NOW_TIME;
        $data["login_ip"]   = get_client_ip();
        $model->save($data);
    }
    protected function update_third_Login_($uid,$nickname,$fgame_id,$fgame_name){

        $model = M('User','tab_');

        $data["id"] = $uid;

        $data['nickname'] = $nickname;

        $data["login_time"] = NOW_TIME;
        $data["fgame_id"] = $fgame_id;
        $data["fgame_name"] = $fgame_name;
        $data["login_ip"]   = get_client_ip();

        $model->save($data);

    }
    /**
     * 自动登录用户
     * @param  integer $user 用户信息数组
     */
    private function autoLogin($user){
        /* 记录登录SESSION和COOKIES */
        $auth = array(
            'user_id'   => $user['id'],
            'account'   => $user['account'],
            'nickname'  => $user['nickname'],
        );
        session('user_auth', $auth);
        session('user_auth_sign', data_auth_sign($auth));
    }
    /**
    *更新玩家信息
    */
    public function updateInfo($data){
        $new_data = $this->create($data);
        if(empty($data['password'])){unset($new_data['password']);}
        $return = $this->save($new_data);
        return $return;
    }

    /**
     * 验证用户密码
     * @param int $uid 用户id
     * @param string $password_in 密码
     * @return true 验证成功，false 验证失败
     * @author huajie <banhuajie@163.com>
     */
    protected function verifyUser($uid, $password_in){
        $password = $this->getFieldById($uid, 'password');
        if(think_ucenter_md5($password_in, UC_AUTH_KEY) === $password){
            return true;
        }
        return false;
    }

    /**
     * 创建时间不写则取当前时间
     * @return int 时间戳
     * @author huajie <banhuajie@163.com>
     */
    protected function getCreateTime(){
        $create_time    =   I('post.create_time');
        return $create_time?strtotime($create_time):NOW_TIME;
    }


    /**
     * 生成不重复的name标识
     * @author huajie <banhuajie@163.com>
     */
    private function generateName(){
        $str = 'abcdefghijklmnopqrstuvwxyz0123456789';	//源字符串
        $min = 10;
        $max = 39;
        $name = false;
        while (true){
            $length = rand($min, $max);	//生成的标识长度
            $name = substr(str_shuffle(substr($str,0,26)), 0, 1);	//第一个字母
            $name .= substr(str_shuffle($str), 0, $length);
            //检查是否已存在
            $res = $this->getFieldByName($name, 'id');
            if(!$res){
                break;
            }
        }
        return $name;
    }
}