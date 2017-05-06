<?php
// +----------------------------------------------------------------------
// | 徐州梦创信息科技有限公司—专业的游戏运营，推广解决方案.
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.vlcms.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: kefu@vlcms.com QQ：97471547
// +----------------------------------------------------------------------
namespace Admin\Event;

use Think\Controller;

/**
 * 后台首页控制器
 * 
 * @author 鬼狐源码社区 <8225001@qq.com>
 */
class StatEvent extends Controller
{

    /**
     * 充值统计
     */
    public function spend_statistics()
    {
        $model_name = "spend";
        $serach_field = "pay_time";
        $field = "sum(pay_amount) as amount,pay_way";
        $group = "pay_way";
        $order = "pay_way ASC";
        $last_month_amount = $this->last_month_data($model_name, $serach_field, $field, $group, $order);
        $last_month_total = array_sum(array(
            $last_month_amount[0]["amount"],
            $last_month_amount[1]["amount"],
            $last_month_amount[2]["amount"]
        ));
        foreach ($last_month_amount as $key => $value) {
            switch ($value['pay_way']) {
                case 0:
                    $ptb =$ptb + $value["amount"];
                    break;
                case 1: // 支付宝
                    $alipay = $alipay + $value["amount"];
                    break;
                case 2: // 微信
                    $weixin = $weixin + $value["amount"];
                    break;
            }
        }
        $last_data = array(
            $ptb,
            $alipay,
            $weixin,
            $last_month_total == "" ? 0 : $last_month_total
        );
        $this_month_amount = $this->this_month_data($model_name, $serach_field, $field, $group, $order);
        $this_month_total = array_sum(array(
            $this_month_amount[0]["amount"],
            $this_month_amount[1]["amount"],
            $this_month_amount[2]["amount"]
        ));
        foreach ($this_month_amount as $key => $value) {
            switch ($value['pay_way']) {
                case 0:
                    $ptb2 = $ptb2 + $value["amount"];
                    break;
                case 1:
                    $alipay2 = $alipay2 + $value["amount"];
                    break;
                case 2:
                    $weixin2 = $weixin2 + $value["amount"];
                    break;
            }
        }
        $this_data = array(
            $ptb2,
            $alipay2,
            $weixin2,
            $this_month_total == "" ? 0 : $this_month_total
        );
        $this->assign("spend_last_data", $last_data);
        $this->assign("spend_this_data", $this_data);
    }

    /**
     * 注册统计
     */
    public function register_statistics()
    {
        $model_name = "User";
        $serach_field = "register_time";
        $field = "count(id) as counts,register_way";
        $group = "register_way";
        $order = "register_way ASC";
        $last_month1 = $this->last_month_data($model_name, $serach_field, $field, $group, $order);
        foreach($last_month1 as $k=>$val){
            $value[]=$val['register_way'];
        }
        $kvalue=array_flip($value);
        for ($i=1; $i <5; $i++) { 
            if(!in_array($i,$value)){
                $last_month[$i]=array('counts'=>0,'register_way'=>$i);
            }else{
                $kk=$kvalue[$i];
                $last_month[$i]=$last_month1[$kk];
            }
        }
        for ($i=1; $i <5 ; $i++) { 
            $last_month2[]=$last_month[$i]["counts"];
        }
        $last_month_total = array_sum($last_month2);
        arsort($last_month);
        $last_data=$last_month;
        $last_data[]=$last_month_total;


        $this_month1 = $this->this_month_data($model_name, $serach_field, $field, $group, $order);
        foreach($this_month1 as $k=>$val){
            $this_value[]=$val['register_way'];
        }
        $this_kvalue=array_flip($this_value);
        for ($this_i=1; $this_i <5; $this_i++) { 
            if(!in_array($this_i,$this_value)){
                $this_month[$this_i]=array('counts'=>0,'register_way'=>$this_i);
            }else{
                $this_kk=$this_kvalue[$this_i];
                $this_month[$this_i]=$this_month1[$this_kk];
            }
        }
        for ($this_a=1; $this_a <5 ; $this_a++) { 
            $this_month2[]=$this_month[$this_a]["counts"];
        }
        $this_month_total = array_sum($this_month2);
        arsort($this_month);
        $this_data=$this_month;
        $this_data[]=$this_month_total;
        $this->assign("reg_last_data", $last_data);
        $this->assign("reg_this_data", $this_data);
    }

    /**
     * 本年总充值
     */
    public function spend_statistics_year()
    {
        $model_name = "spend";
        $serach_field = "pay_time";
        $field = "FROM_UNIXTIME(pay_time, '%c') as month,sum(pay_amount) as amount";
        $group = "FROM_UNIXTIME(pay_time,'%Y%m%d')";
        $order = "pay_time ASC";
        $map["pay_status"] = 1;
        $year_total = $this->data_year($model_name, $map, $serach_field, $field, $group, $order);
        $map["promote_id"] = array(
            "neq",
            "0"
        );
        $map2["promote_id"] = array(
            "eq",
            "0"
        );
        $map2["pay_status"] = 1;
        $year_promote = $this->data_year($model_name, $map, $serach_field, $field, $group, $order, $where);
        $ziran_promote = $this->data_year($model_name, $map2, $serach_field, $field, $group, $order, $where);
        $this->assign("ziran_promote", $ziran_promote);
        $this->assign("year_total", $year_total);
        $this->assign("year_promote", $year_promote);
    }

    /**
     * 本年总注册
     */
    public function register_statistics_year()
    {
        $model_name = "User";
        $serach_field = "register_time";
        $field = "FROM_UNIXTIME(register_time, '%c') as month,count(id) as counts";
        $group = "FROM_UNIXTIME(register_time,'%c')";
        $order = "register_time ASC";
        $map["lock_status"] = 1;
        $last_data = $this->user_data_year($model_name, $map, $serach_field, $field, $group, $order);
        $map["promote_id"] = array(
            "neq",
            "0"
        );
        $map2["promote_id"] = array(
            "eq",
            "0"
        );
        $this_data = $this->user_data_year($model_name, $map, $serach_field, $field, $group, $order);
        $ziran_data = $this->user_data_year($model_name, $map2, $serach_field, $field, $group, $order);
        $this->assign("reg_data_year", $last_data);
        $this->assign("prom_data_year", $this_data);
        $this->assign("ziran_data_year", $ziran_data);
    }

    /**
     * 上月数据
     */
    public function last_month_data($model_name, $serach_field, $field = true, $group = "", $order = "")
    {
        $last_month_start = strtotime(date("Y-m-d H:i:s", mktime(0, 0, 0, date("m") - 1, 1, date("Y"))));
        $last_month_end = strtotime(date("Y-m-d H:i:s", mktime(23, 59, 59, date("m"), 0, date("Y"))));
        
        $map[$serach_field] = array(
            "BETWEEN",
            array(
                $last_month_start,
                $last_month_end
            )
        );
        $model = D($model_name);
        $data = $model->field($field)
            ->where($map)
            ->group($group)
            ->order($order)
            ->select();
        return $data;
    }

    /**
     * 本月数据
     */
    protected function this_month_data($model_name, $serach_field, $field = true, $group = "", $order = "")
    {
        $this_month_start = strtotime(date("Y-m-d H:i:s", mktime(0, 0, 0, date("m"), 1, date("Y"))));
        $this_month_end = strtotime(date("Y-m-d H:i:s", mktime(23, 59, 59, date("m"), date("t"), date("Y"))));
        $map[$serach_field] = array(
            "BETWEEN",
            array(
                $this_month_start,
                $this_month_end
            )
        );
        $model = D($model_name);
        $data = $model->field($field)
            ->where($map)
            ->group($group)
            ->order($order)
            ->select();
        return $data;
    }

    /**
     * 本年数据 根据月份分组
     */
    protected function data_year($model_name, $map, $serach_field, $field = true, $group = "", $order = "")
    {
        $this_year_start = strtotime(date("Y-m-d H:i:s", mktime(0, 0, 0, 1, 1, date("Y"))));
        $this_year_end = strtotime(date("Y-m-d H:i:s", mktime(23, 59, 59, 12, 31, date("Y"))));
        $map[$serach_field] = array(
            "BETWEEN",
            array(
                $this_year_start,
                $this_year_end
            )
        );
        $model = D($model_name);
        $data = $model->field($field)
            ->where($map)
            ->group($group)
            ->order($order)
            ->select();
        $data = i_array_column($data, 'amount', 'month');
        return $data;
    }

    protected function user_data_year($model_name, $map, $serach_field, $field = true, $group = "", $order = "", $where = "")
    {
        $this_year_start = strtotime(date("Y-m-d H:i:s", mktime(0, 0, 0, 1, 1, date("Y"))));
        $this_year_end = strtotime(date("Y-m-d H:i:s", mktime(23, 59, 59, 12, 31, date("Y"))));
        $map[$serach_field] = array(
            "BETWEEN",
            array(
                $this_year_start,
                $this_year_end
            )
        );
        $model = D($model_name);
        $data = $model->field($field)
            ->where($map)
            ->group($group)
            ->order($order)
            ->select();
         $data = i_array_column($data, 'counts', 'month');
        return $data;
    }
}
