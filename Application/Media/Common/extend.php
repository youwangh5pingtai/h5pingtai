<?php

function is_login_user(){
    $user = session('user_auth');
    if (empty($user)) {
        return 0;
    } else {
        return session('user_auth_sign') == data_auth_sign($user) ? $user['user_id'] : 0;
    }
}

function user_play($user_id = 0)
{
    $user_play = M("play","tab_user_");
    $map["user_id"] = $user_id;
    $data = $user_play->where($map)->find();
    if(empty($data)){
        return false;
    }
    return $data;
}

/**
*获取游戏实体
*/
function get_game_entity($data,$field="game_appid"){
    $game = M("Game","tab_");
    $map['status'] = 1;
    $map[$field]   = $data;
    $entity_data   = $game->where($map)->find();
    return $entity_data;
}

function wite_text($txt,$name){
    $myfile = fopen($name, "w") or die("Unable to open file!");
    fwrite($myfile, $txt);
    fclose($myfile);
}

//判断客户端是否是在微信客户端打开
function is_weixin(){ 
	if ( strpos($_SERVER['HTTP_USER_AGENT'], 'MicroMessenger') !== false ) {
		return true;
	}	
	return false;
}

function get_uid()
{
    return session("user_auth.uid");
}

function get_uname(){
    return session("user_auth.account");
}