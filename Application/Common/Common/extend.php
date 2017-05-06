<?php
/**
 * 后台公共文件扩展
 * 主要定义后台公共函数库
 */
// lwx 多选字段值判断
function check_field_value($field,$key) {
    if(empty($field) || empty($key)){
        return false;
    }
    $field = explode(",",$field);
    
    if (in_array($key,$field)) {
        return true;
    } else {
        return false;
    }
    
}
function get_user_pid($id)
{
    $map['id']=$id;
    $user=M("user","tab_")->where($map)->find();
    return $user['promote_id'];
}
function game_entity_data($game_id = 0){
    $game = M('game','tab_');
    $map['id'] = $game_id;
    $entity = $game->where($map)->find();
    if(empty($entity)){
        return false;
    }
    return $entity;
}
// 获取游戏名称
function get_game_name($game_id=null,$field='id'){
    $map[$field]=$game_id;
    $data=M('Game','tab_')->where($map)->find();
    if(empty($data)){return false;}
    return $data['game_name'];
}
// lwx 获得所有开放类型
function get_opentype_all() {
    
    $list = M("Opentype","tab_")->where("status=1")->select();

    if (empty($list)) {return '';}

    return $list;
}
// 获取游戏appid
function get_game_appid($game_name=null,$field='game_name'){
    $map[$field]=$game_name;
    $data=M('Game','tab_')->where($map)->find();
    if(empty($data)){return false;}
    return $data['game_appid'];
}
// lwx 获得所有游戏类型
function get_game_type_all() {

    $list = M("Game_type","tab_")->where("status=1")->select();

    if (empty($list)) {return '';}

    return $list;

}
function get_parent_id($id){
    $pdata=M('Promote','tab_')->where(array('id'=>$id))->find();
    if(empty($pdata)){
        return false;
    }else{
        $p_id=$pdata['parent_id'];
        return $p_id;
    }
}
// lwx 获得所有游戏
function get_game_id_all()

 {

    $game = M("game","tab_");

    $map['game_status'] = 1;

    $lists = $game->field("id,game_name")->where($map)->select();

    if(empty($lists)){return false;}

    return $lists;

 }

/**
 * 获取游戏列表
 * @return array，false
 * @author 小纯洁 
 */
 function get_game_list()
 {
    $game = M("game","tab_");
    $map['game_status'] = 1;
    $lists = $game->where($map)->select();
    if(empty($lists)){return false;}
    return $lists;
 }
 //合作模式
function get_pattern($type){
   if($type==0){
        return "CPS";
    }else{
        return "CPA";
    } 
}

/**
*游戏区服名称
*/
function get_area_name($area_id= null){
    if(empty($area_id)){return false;}
    $area_model = D('Server');
    $map['server_num'] = $area_id;
    $name = $area_model->where($map)->find();
    if(empty($name['server_name'])){return false;}
    return $name['server_name'];
}
/**
 * 获取对应游戏类型的文字信息
 */
function get_game_type($type = null){
    if(!isset($type)){
        return false;
    }
    $cl = M("game_type","tab_")->where("status=1 and id=$type")->limit(1)->select();
    return $cl[0]['type_name'];
}
/**
*获取推广员列表
*@return array
*@author 小纯洁
*/
 function get_promote_list(){
    $promote = M("promote","tab_");
    $map['status'] = 1;
    $data = $promote->where($map)->select();
    if(empty($data)){return false;}
    return $data;
 }
 
 /**
*检查链接地址是否有效
*/
function varify_url($url){  
    $check = @fopen($url,"r");  
    if($check){  
     $status = true;  
    }else{  
     $status = false;  
    }    
    return $status;  
} 

/**
获取推广员类型 一级 二级
*/
 function get_promote_type($id=0){
    $promote = M("Promote","tab_");
    $map["id"] = $id;
    $data = $promote->where($map)->find();
    if(empty($data)){return false;}
    $str="";
    switch ($data['parent_id']) {
        case 0:
            $str = "一级公会";
            break;
        
        default:
           $str = "二级公会";
            break;
    }
    
    return $str;
 }

 /**
*获取推广员账号
*@param  $promote_id 推广id
*@return string
*@author 小纯洁
*/
 function get_promote_name($prmote_id=0)
 {
    $promote = M("promote","tab_");
    $map['id'] = $prmote_id;
    $data = $promote->where($map)->find();
    if(empty($data)){return '自然注册';}
    if(empty($data['account'])){return "未知推广";}
    $result = $data['account'];
    return $result;
 }


/**
*获取推广员父类账号
*@param  $promote_id 推广id
*@param  $isShow bool 
*@return string
*@author 小纯洁
*/
 function get_parent_promote($prmote_id=0,$isShwo=true)
 {
    $promote = M("promote","tab_");
    $map['parent_id'] = $prmote_id;
    $data = $promote->where($map)->find();
    if(empty($data)){return false;}
    $result = "";
    if($isShwo){
        $result = "[{$data['account']}]";
    }
    else{
        $result = $data['account'];
    }
    return $result;
 }
/**
*获取推广员父类账号  改写
*@param  $promote_id 推广id
*@param  $isShow bool 
*@return string
*@author yyh
*/
function get_parent_promote_($prmote_id=0,$isShwo=true)
 {
    $promote = M("promote","tab_");
    $map['id'] = $prmote_id;//本推广员的id
    $data1 = $promote->where($map)->find();//本推广员的记录
    if(empty($data1)){return false;}
    if($data1['parent_id']==0){return false;}
    if($data1['parent_id']){
        $map1['id']=$data1['parent_id'];
    }
    $data = $promote->where($map1)->find();//父类的记录
    $result = "";
    if($isShwo){
        $result = "[{$data['account']}]";
    }
    else{
        $result = $data['account'];
    }
    return $result;
 }
/**
*获取推广员子账号
*/
 function get_prmoote_chlid_account($id=0){
    $promote = M("promote","tab_");
    $map['status'] = 1;
    $map["parent_id"] = $id;
    $data = $promote->where($map)->select();
    if(empty($data)){return "";}
    return $data;
 }

/**
*获取管理员昵称
*/
 function get_admin_name($id=0){
    if($id==null){
        $id=0;
    }
    $data = M("Member")->find($id);
    if(empty($data)){return "";}
    return $data['nickname'];
 }

 
 /**
 *获取用户实体
 */
 function get_user_entity($id=0,$isAccount = false){
    $user = M('user',"tab_");
    if($isAccount){
        $map['account'] = $id;
        $data = $user->where($map)->find();
    }
    else{
        $data = $user->find($id);
    }
    if(empty($data)){
        return false;
    }
    return $data;
 }
 //获取游戏信息
function get_game($id)
{

}
/**
*设置状态文本
*/
 function get_status_text($index=1,$mark=1){
    $data_text = array(
        0  => array( 0 => '失败' ,1 => '成功'),
        1  => array( 0 => '锁定' ,1 => '正常'),
        2  => array( 0 => '未申' ,1 => '已审' , 2 => '拉黑'),
        3  =>array(0=>'不参与',1=>'已参与'),
    );
    return $data_text[$index][$mark];
 }


/**
* 生成唯一的APPID
* @param  $str_key 加密key
* @return string
* @author 小纯洁 
*/
function generate_game_appid($str_key=""){
    $guid = '';  
    $data = $str_key;  
    $data .= $_SERVER ['REQUEST_TIME'];     
    $data .= $_SERVER ['HTTP_USER_AGENT']; 
    $data .= $_SERVER ['SERVER_ADDR'];       
    $data .= $_SERVER ['SERVER_PORT'];      
    $data .= $_SERVER ['REMOTE_ADDR'];     
    $data .= $_SERVER ['REMOTE_PORT'];     
    $hash = strtoupper ( hash ( 'MD4', $guid . md5 ( $data ) ) ); //ABCDEFZHIJKLMNOPQISTWARY
    $guid .= substr ( $hash, 0, 9 ) . substr ( $hash, 17, 8 ) ; 
    return $guid;
}


/**
*随机生成字符串
*@param  $len int 字符串长度
*@return string
*@author 小纯洁
*/
function sp_random_string($len = 6) {
    $chars = array(
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
        "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v",
        "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G",
        "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R",
        "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2",
        "3", "4", "5", "6", "7", "8", "9"
    );
    $charsLen = count($chars) - 1;
    shuffle($chars);    // 将数组打乱
    $output = "";
    for ($i = 0; $i < $len; $i++) {
        $output .= $chars[mt_rand(0, $charsLen)];
    }
    return $output;
}
//判断支付设置
//yyh
function pay_set_status($type){
    $sta=M('tool','tab_')->field('status')->where(array('name'=>$type))->find();
    return $sta['status'];
}
//获取推广员父类id
function get_fu_id($id){
    $map['id']=$id;
    $pro=M("promote","tab_")->where($map)->find();
    if(null==$pro||$pro['parent_id']==0){
        return 0;
    }else{
    return $pro['parent_id'];
    }
}
function get_parent_name($id){
    $map['id']=$id;
    $pro=M("promote","tab_")->where($map)->find();
     if(null!=$pro&&$pro['parent_id']>0){
        $pro_map['id']=$pro['parent_id'];
        $pro_p=M("promote","tab_")->where($pro_map)->find();
        return $pro_p['account'];
     }else if($pro['parent_id']==0){
        return $pro['account'];
     }else{
        return false;
     }
}
//获取当前子渠道
function get_zi_promote_id($id){
    $map['parent_id']=$id;
    $pro=M("promote","tab_")->field('id')->where($map)->select();
    if(null==$pro){
        return 0;
    }else{
    for ($i=0; $i <count($pro); $i++) { 
        $sd[]=implode(",", $pro[$i]);
    }
    return  implode(",", $sd);    
    }
    
    // return  implode(",", $pro['id']);
}

function is_mobile_request()   {    
    $_SERVER['ALL_HTTP'] = isset($_SERVER['ALL_HTTP']) ? $_SERVER['ALL_HTTP'] : '';    
    $mobile_browser = '0';    
    if(preg_match('/(up.browser|up.link|mmp|symbian|smartphone|midp|wap|phone|iphone|ipad|ipod|android|xoom)/i', strtolower($_SERVER['HTTP_USER_AGENT'])))     $mobile_browser++;    
    if((isset($_SERVER['HTTP_ACCEPT'])) and (strpos(strtolower($_SERVER['HTTP_ACCEPT']),'application/vnd.wap.xhtml+xml') !== false))     
        $mobile_browser++;    
    if(isset($_SERVER['HTTP_X_WAP_PROFILE']))     
        $mobile_browser++;    
    if(isset($_SERVER['HTTP_PROFILE']))     
        $mobile_browser++;    
        $mobile_ua = strtolower(substr($_SERVER['HTTP_USER_AGENT'],0,4));    
        $mobile_agents = 
        array(       
            'w3c ','acs-','alav','alca','amoi','audi','avan','benq','bird','blac',       
            'blaz','brew','cell','cldc','cmd-','dang','doco','eric','hipt','inno',       
            'ipaq','java','jigs','kddi','keji','leno','lg-c','lg-d','lg-g','lge-',       
            'maui','maxo','midp','mits','mmef','mobi','mot-','moto','mwbp','nec-',       
            'newt','noki','oper','palm','pana','pant','phil','play','port','prox',       
            'qwap','sage','sams','sany','sch-','sec-','send','seri','sgh-','shar',       
            'sie-','siem','smal','smar','sony','sph-','symb','t-mo','teli','tim-',       
            'tosh','tsm-','upg1','upsi','vk-v','voda','wap-','wapa','wapi','wapp',       
            'wapr','webc','winw','winw','xda','xda-'     
        );    
    if(in_array($mobile_ua, $mobile_agents))     
        $mobile_browser++;    
    if(strpos(strtolower($_SERVER['ALL_HTTP']), 'operamini') !== false)     
        $mobile_browser++;    
    // Pre-final check to reset everything if the user is on Windows    
    if(strpos(strtolower($_SERVER['HTTP_USER_AGENT']), 'windows') !== false)     
        $mobile_browser=0;    
    // But WP7 is also Windows, with a slightly different characteristic    
    if(strpos(strtolower($_SERVER['HTTP_USER_AGENT']), 'windows phone') !== false)     
        $mobile_browser++;    if($mobile_browser>0)     
        return true;    
    else   
        return false; 
}
