<?php

namespace Callback\Controller;
use Common\Api\GameApi;
/**
 * 支付回调控制器
 * @author 小纯洁 
 */
class NotifyController extends BaseController {
    /**
    *通知方法
    */
    public function notify($value='')
    {   
        $this->record_logs("aaaaa");
        $apitype = I('get.apitype');#获取支付api类型
        if (IS_POST && !empty($_POST)) {
            $notify = $_POST;
        } elseif (IS_GET && !empty($_GET)) {
            $notify = $_GET;
            unset($notify['method']);
            unset($notify['apitype']);
        } else {
            $this->record_logs("Access Denied");
            exit('Access Denied');
        }
        $pay = new \Think\Pay($apitype, C($apitype));
        if ($pay->verifyNotify($notify)) {
            //获取回调订单信息
            $order_info = $pay->getInfo();
            if ($order_info['status']) {
                $pay_where = substr($order_info['out_trade_no'],0,2);
                $result = false;
                switch ($pay_where) {
                    case 'SP':
                        $result = $this->set_spend($order_info);
                        break;
                    case 'PF':
                        $result = $this->set_deposit($order_info);
                        break;
                    case 'AG':
                        $result = $this->set_agent($order_info); 
                        break;
                    default:
                        exit('accident order data');
                        break;
                }
                if (I('get.method') == "return") {
                    switch ($pay_where) {
                        case 'SP':
                            $map['pay_order_number'] = $order_info['out_trade_no'];
                            $extend_data = M("spend","tab_")->where($map)->find(); 
                            redirect("http://".$_SERVER['HTTP_HOST']."/media.php?s=/Game/open_game/game_id/".$extend_data['game_id']);
                            break;
                        case 'PF':
                            redirect("http://".$_SERVER['HTTP_HOST']."/media.php?s=/Subscriber/index.html");
                            break;
                        default:
                            redirect('http://'.$_SERVER['HTTP_HOST'].'/media.php');
                            break;
                    }
                    
                } else {
                    $pay->notifySuccess();
                }
            }else{
                //$this->error("支付失败！");
                $this->record_logs("支付失败！");
            }
        }else{
            $this->record_logs("支付宝验证失败");
            redirect('http://'.$_SERVER['HTTP_HOST'].'/media.php',3,'支付宝验证失败');
        }
    }

    /**
    *微信支付
    */
    public function weixin_notify(){
        $this->record_logs("212121");
        $request = file_get_contents("php://input");
        $apitype = "swiftpass";
        $pay = new \Think\Pay($apitype, C("weixin"));
        if ($pay->verifyNotify($request)) {
            //获取回调订单信息
            $order_info = $pay->getInfo();
            if ($order_info['status']) {
                $pay_where = substr($order_info['out_trade_no'],0,2);
                $result = false;
                switch ($pay_where) {
                    case 'SP':
                        $result = $this->set_spend($order_info);
                        break;
                    case 'PF':
                        $result = $this->set_deposit($order_info);
                        break;
                    case 'AG':
                        $result = $this->set_agent($order_info); 
                        break;
                    default:
                        exit('accident order data');
                        break;
                }
                if($result){
                    $pay->notifySuccess();
                    switch ($pay_where) {
                        case 'SP':
                            $map['pay_order_number'] = $order_info['out_trade_no'];
                            $extend_data = M('spend','tab_')->where($map)->find(); 
                            redirect("http://".$_SERVER['HTTP_HOST']."/media.php?s=/Game/open_game/game_id/".$extend_data['game_id']);
                            break;
                        case 'PF':
                            redirect("http://".$_SERVER['HTTP_HOST']."/media.php?s=/Subscriber/index.html");
                            break;
                        default:
                            redirect('http://'.$_SERVER['HTTP_HOST'].'/media.php');
                            break;
                    }
                }
            }else{
                //$this->error("支付失败！");
                $this->record_logs("支付失败！");
            }
        }else{
            $this->record_logs("微信验证失败");
        }
    }

    function wite_text($txt,$name){
        $myfile = fopen($name, "w") or die("Unable to open file!");
        fwrite($myfile, $txt);
        fclose($myfile);
    }
}