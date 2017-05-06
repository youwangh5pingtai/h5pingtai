<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.guifox.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 鬼狐源码社区 <8225001@qq.com> <http://www.guifox.com>
// +----------------------------------------------------------------------

namespace Admin\Model;
use Think\Model;

/**
 * 用户模型
 * @author 鬼狐源码社区 <8225001@qq.com>
 */

class UserLoginRecordModel extends Model {

    protected $_validate = array(
        
    );

    /* 自动完成规则 */
    protected $_auto = array(
    );

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
}
