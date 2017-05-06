<?php
// +----------------------------------------------------------------------
// | OneThink [ WE CAN DO IT JUST THINK IT ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013 http://www.guifox.com All rights reserved.
// +----------------------------------------------------------------------
// | Author: 鬼狐源码社区 <8225001@qq.com> <http://www.guifox.com>
// +----------------------------------------------------------------------

namespace Admin\Controller;
use User\Api\UserApi as UserApi;

/**
 * 后台首页控制器
 * @author 鬼狐源码社区 <8225001@qq.com>
 */
class IndexController extends AdminController {

    /**
     * 后台首页
     * @author 鬼狐源码社区 <8225001@qq.com>
     */
    public function index(){
        $this->meta_title = '管理首页';
        $this->display();
    }

}
