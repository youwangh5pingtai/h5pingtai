/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50617
Source Host           : localhost:3306
Source Database       : db_h5

Target Server Type    : MYSQL
Target Server Version : 50617
File Encoding         : 65001

Date: 2016-10-13 18:02:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_action
-- ----------------------------
DROP TABLE IF EXISTS `sys_action`;
CREATE TABLE `sys_action` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '行为唯一标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '行为说明',
  `remark` char(140) NOT NULL DEFAULT '' COMMENT '行为描述',
  `rule` text COMMENT '行为规则',
  `log` text COMMENT '日志规则',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统行为表';

-- ----------------------------
-- Records of sys_action
-- ----------------------------
INSERT INTO `sys_action` VALUES ('1', 'user_login', '用户登录', '积分+10，每天一次', 'table:member|field:score|condition:uid={$self} AND status>-1|rule:score+10|cycle:24|max:1;', '[user|get_nickname]在[time|time_format]登录了后台', '1', '1', '1387181220');
INSERT INTO `sys_action` VALUES ('2', 'add_article', '发布文章', '积分+5，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:5', '', '2', '0', '1380173180');
INSERT INTO `sys_action` VALUES ('3', 'review', '评论', '评论积分+1，无限制', 'table:member|field:score|condition:uid={$self}|rule:score+1', '', '2', '1', '1383285646');
INSERT INTO `sys_action` VALUES ('4', 'add_document', '发表文档', '积分+10，每天上限5次', 'table:member|field:score|condition:uid={$self}|rule:score+10|cycle:24|max:5', '[user|get_nickname]在[time|time_format]发表了一篇文章。\r\n表[model]，记录编号[record]。', '2', '0', '1386139726');
INSERT INTO `sys_action` VALUES ('5', 'add_document_topic', '发表讨论', '积分+5，每天上限10次', 'table:member|field:score|condition:uid={$self}|rule:score+5|cycle:24|max:10', '', '2', '0', '1383285551');
INSERT INTO `sys_action` VALUES ('6', 'update_config', '更新配置', '新增或修改或删除配置', '', '', '1', '1', '1383294988');
INSERT INTO `sys_action` VALUES ('7', 'update_model', '更新模型', '新增或修改模型', '', '', '1', '1', '1383295057');
INSERT INTO `sys_action` VALUES ('8', 'update_attribute', '更新属性', '新增或更新或删除属性', '', '', '1', '1', '1383295963');
INSERT INTO `sys_action` VALUES ('9', 'update_channel', '更新导航', '新增或修改或删除导航', '', '', '1', '1', '1383296301');
INSERT INTO `sys_action` VALUES ('10', 'update_menu', '更新菜单', '新增或修改或删除菜单', '', '', '1', '1', '1383296392');
INSERT INTO `sys_action` VALUES ('11', 'update_category', '更新分类', '新增或修改或删除分类', '', '', '1', '1', '1383296765');
INSERT INTO `sys_action` VALUES ('12', 'asasasaas', '212121', '1212112', '', '', '2', '-1', '1464665704');

-- ----------------------------
-- Table structure for sys_action_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_action_log`;
CREATE TABLE `sys_action_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `action_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '行为id',
  `user_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行用户id',
  `action_ip` bigint(20) NOT NULL COMMENT '执行行为者ip',
  `model` varchar(50) NOT NULL DEFAULT '' COMMENT '触发行为的表',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '触发行为的数据id',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '日志备注',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '执行行为的时间',
  PRIMARY KEY (`id`),
  KEY `action_ip_ix` (`action_ip`),
  KEY `action_id_ix` (`action_id`),
  KEY `user_id_ix` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED COMMENT='行为日志表';

-- ----------------------------
-- Records of sys_action_log
-- ----------------------------
INSERT INTO `sys_action_log` VALUES ('1', '1', '1', '2130706433', 'member', '1', 'admin在2016-10-13 17:52登录了后台', '1', '1476352328');

-- ----------------------------
-- Table structure for sys_addons
-- ----------------------------
DROP TABLE IF EXISTS `sys_addons`;
CREATE TABLE `sys_addons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL COMMENT '插件名或标识',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '中文名',
  `description` text COMMENT '插件描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态',
  `config` text COMMENT '配置',
  `author` varchar(40) DEFAULT '' COMMENT '作者',
  `version` varchar(20) DEFAULT '' COMMENT '版本号',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '安装时间',
  `has_adminlist` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否有后台列表',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COMMENT='插件表';

-- ----------------------------
-- Records of sys_addons
-- ----------------------------
INSERT INTO `sys_addons` VALUES ('15', 'EditorForAdmin', '后台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"500px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1383126253', '0');
INSERT INTO `sys_addons` VALUES ('2', 'SiteStat', '站点统计信息', '统计站点的基础信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"1\",\"display\":\"1\",\"status\":\"0\"}', 'thinkphp', '0.1', '1379512015', '0');
INSERT INTO `sys_addons` VALUES ('3', 'DevTeam', '开发团队信息', '开发团队成员信息', '1', '{\"title\":\"OneThink\\u5f00\\u53d1\\u56e2\\u961f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512022', '0');
INSERT INTO `sys_addons` VALUES ('4', 'SystemInfo', '系统环境信息', '用于显示一些服务器的信息', '1', '{\"title\":\"\\u7cfb\\u7edf\\u4fe1\\u606f\",\"width\":\"2\",\"display\":\"1\"}', 'thinkphp', '0.1', '1379512036', '0');
INSERT INTO `sys_addons` VALUES ('5', 'Editor', '前台编辑器', '用于增强整站长文本的输入和显示', '1', '{\"editor_type\":\"2\",\"editor_wysiwyg\":\"1\",\"editor_height\":\"300px\",\"editor_resize_type\":\"1\"}', 'thinkphp', '0.1', '1379830910', '0');
INSERT INTO `sys_addons` VALUES ('6', 'Attachment', '附件', '用于文档模型上传附件', '1', 'null', 'thinkphp', '0.1', '1379842319', '1');
INSERT INTO `sys_addons` VALUES ('9', 'SocialComment', '通用社交化评论', '集成了各种社交化评论插件，轻松集成到系统中。', '1', '{\"comment_type\":\"1\",\"comment_uid_youyan\":\"\",\"comment_short_name_duoshuo\":\"\",\"comment_data_list_duoshuo\":\"\"}', 'thinkphp', '0.1', '1380273962', '0');
INSERT INTO `sys_addons` VALUES ('16', 'UploadImages', '多图上传', '多图上传', '1', 'null', '木梁大囧', '1.2', '1465726636', '0');

-- ----------------------------
-- Table structure for sys_attachment
-- ----------------------------
DROP TABLE IF EXISTS `sys_attachment`;
CREATE TABLE `sys_attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '附件显示名',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件类型',
  `source` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '资源ID',
  `record_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关联记录ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '附件大小',
  `dir` int(12) unsigned NOT NULL DEFAULT '0' COMMENT '上级目录ID',
  `sort` int(8) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `idx_record_status` (`record_id`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='附件表';

-- ----------------------------
-- Records of sys_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for sys_attribute
-- ----------------------------
DROP TABLE IF EXISTS `sys_attribute`;
CREATE TABLE `sys_attribute` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '字段名',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '字段注释',
  `field` varchar(100) NOT NULL DEFAULT '' COMMENT '字段定义',
  `type` varchar(20) NOT NULL DEFAULT '' COMMENT '数据类型',
  `value` varchar(100) NOT NULL DEFAULT '' COMMENT '字段默认值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '备注',
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否显示',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '参数',
  `model_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '模型id',
  `is_must` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否必填',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `validate_rule` varchar(255) NOT NULL DEFAULT '',
  `validate_time` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `error_info` varchar(100) NOT NULL DEFAULT '',
  `validate_type` varchar(25) NOT NULL DEFAULT '',
  `auto_rule` varchar(100) NOT NULL DEFAULT '',
  `auto_time` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `auto_type` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `model_id` (`model_id`)
) ENGINE=MyISAM AUTO_INCREMENT=439 DEFAULT CHARSET=utf8 COMMENT='模型属性表';

-- ----------------------------
-- Records of sys_attribute
-- ----------------------------
INSERT INTO `sys_attribute` VALUES ('1', 'uid', '用户ID', 'int(10) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1384508362', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('2', 'name', '标识', 'char(40) NOT NULL ', 'string', '', '同一根节点下标识不重复', '1', '', '1', '0', '1', '1383894743', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('3', 'title', '标题', 'char(80) NOT NULL ', 'string', '', '文档标题', '1', '', '1', '0', '1', '1383894778', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('4', 'category_id', '所属分类', 'int(10) unsigned NOT NULL ', 'string', '', '', '0', '', '1', '0', '1', '1384508336', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('5', 'description', '描述', 'char(140) NOT NULL ', 'textarea', '', '', '1', '', '1', '0', '1', '1383894927', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('6', 'root', '根节点', 'int(10) unsigned NOT NULL ', 'num', '0', '该文档的顶级文档编号', '0', '', '1', '0', '1', '1384508323', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('7', 'pid', '所属ID', 'int(10) unsigned NOT NULL ', 'num', '0', '父文档编号', '0', '', '1', '0', '1', '1384508543', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('8', 'model_id', '内容模型ID', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '该文档所对应的模型', '0', '', '1', '0', '1', '1384508350', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('9', 'type', '内容类型', 'tinyint(3) unsigned NOT NULL ', 'select', '2', '', '1', '1:目录\r\n2:主题\r\n3:段落', '1', '0', '1', '1384511157', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('10', 'position', '推荐位', 'smallint(5) unsigned NOT NULL ', 'checkbox', '0', '多个推荐则将其推荐值相加', '1', '[DOCUMENT_POSITION]', '1', '0', '1', '1383895640', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('11', 'link_id', '外链', 'int(10) unsigned NOT NULL ', 'num', '0', '0-非外链，大于0-外链ID,需要函数进行链接与编号的转换', '1', '', '1', '0', '1', '1383895757', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('12', 'cover_id', '封面', 'int(10) unsigned NOT NULL ', 'picture', '0', '0-无封面，大于0-封面图片ID，需要函数处理', '1', '', '1', '0', '1', '1384147827', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('13', 'display', '可见性', 'tinyint(3) unsigned NOT NULL ', 'radio', '1', '', '1', '0:不可见\r\n1:所有人可见', '1', '0', '1', '1386662271', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `sys_attribute` VALUES ('14', 'deadline', '截至时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '0-永久有效', '1', '', '1', '0', '1', '1387163248', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `sys_attribute` VALUES ('15', 'attach', '附件数量', 'tinyint(3) unsigned NOT NULL ', 'num', '0', '', '0', '', '1', '0', '1', '1387260355', '1383891233', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `sys_attribute` VALUES ('16', 'view', '浏览量', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895835', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('17', 'comment', '评论数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '1', '0', '1', '1383895846', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('18', 'extend', '扩展统计字段', 'int(10) unsigned NOT NULL ', 'num', '0', '根据需求自行使用', '0', '', '1', '0', '1', '1384508264', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('19', 'level', '优先级', 'int(10) unsigned NOT NULL ', 'num', '0', '越高排序越靠前', '1', '', '1', '0', '1', '1383895894', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('20', 'create_time', '创建时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '1', '', '1', '0', '1', '1383895903', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('21', 'update_time', '更新时间', 'int(10) unsigned NOT NULL ', 'datetime', '0', '', '0', '', '1', '0', '1', '1384508277', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('22', 'status', '数据状态', 'tinyint(4) NOT NULL ', 'radio', '0', '', '0', '-1:删除\r\n0:禁用\r\n1:正常\r\n2:待审核\r\n3:草稿', '1', '0', '1', '1384508496', '1383891233', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('23', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '2', '0', '1', '1384511049', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('24', 'content', '文章内容', 'text NOT NULL ', 'editor', '', '', '1', '', '2', '0', '1', '1383896225', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('25', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '参照display方法参数的定义', '1', '', '2', '0', '1', '1383896190', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('26', 'bookmark', '收藏数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '2', '0', '1', '1383896103', '1383891243', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('27', 'parse', '内容解析类型', 'tinyint(3) unsigned NOT NULL ', 'select', '0', '', '0', '0:html\r\n1:ubb\r\n2:markdown', '3', '0', '1', '1387260461', '1383891252', '', '0', '', 'regex', '', '0', 'function');
INSERT INTO `sys_attribute` VALUES ('28', 'content', '下载详细描述', 'text NOT NULL ', 'editor', '', '', '1', '', '3', '0', '1', '1383896438', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('29', 'template', '详情页显示模板', 'varchar(100) NOT NULL ', 'string', '', '', '1', '', '3', '0', '1', '1383896429', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('30', 'file_id', '文件ID', 'int(10) unsigned NOT NULL ', 'file', '0', '需要函数处理', '1', '', '3', '0', '1', '1383896415', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('31', 'download', '下载次数', 'int(10) unsigned NOT NULL ', 'num', '0', '', '1', '', '3', '0', '1', '1383896380', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('32', 'size', '文件大小', 'bigint(20) unsigned NOT NULL ', 'num', '0', '单位bit', '1', '', '3', '0', '1', '1383896371', '1383891252', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('33', 'game_name', '游戏名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('34', 'sort', '排序', 'int(10) unsigned NULL ', 'string', '1', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('35', 'short', '游戏简写', 'varchar(20) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('36', 'game_type_id', '游戏类型id', 'int(10) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('37', 'game_type_name', '游戏类型名称', 'varchar(20) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('38', 'game_score', '游戏评分', 'double(3,0) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('39', 'features', '游戏特征', 'varchar(50) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('40', 'recommend_level', '', 'double(3,0) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('41', 'version', '版本号', 'varchar(10) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('42', 'game_size', '游戏大小', 'varchar(10) NULL ', 'string', '0', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('43', 'icon', '游戏图标', 'int(11) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('44', 'cover', '游戏封面', 'int(11) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('45', 'screenshot', '游戏截图', 'varchar(255) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('46', 'introduction', '游戏简介', 'varchar(300) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('47', 'and_dow_address', '安卓游戏下载地址', 'varchar(255) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('48', 'ios_dow_address', 'ios游戏下载地址', 'varchar(255) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('49', 'game_address', '外部链接游戏地址', 'varchar(255) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('50', 'dow_num', '游戏下载数量', 'int(10) NULL ', 'string', '0', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('51', 'game_status', '游戏状态(0:关闭,1:开启)', 'tinyint(2) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('52', 'recommend_status', '推荐状态(0:否,1是)', 'tinyint(2) NULL ', 'string', '1', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('53', 'pay_status', '充值状态(0:关闭,1:开启)', 'tinyint(2) NULL ', 'string', '1', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('54', 'dow_status', '下载状态(0:关闭,1:开启)', 'tinyint(2) NULL ', 'string', '1', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('55', 'developers', '开发商', 'varchar(30) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('56', 'create_time', '创建时间', 'int(11) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('57', 'discount', '折扣', 'int(3) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('58', 'language', '语言', 'varchar(10) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('59', 'game_appid', '游戏appid', 'varchar(32) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('60', 'game_coin_name', '游戏币名称', 'varchar(10) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('61', 'game_coin_ration', '游戏币比例', 'varchar(10) NULL ', 'string', '', '', '1', '', '4', '0', '1', '1463664513', '1463664513', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('62', 'type_name', '游戏类型名称', 'varchar(20) NULL ', 'string', '', '', '1', '', '5', '0', '1', '1463968087', '1463968087', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('63', 'status', '状态(-1:删除,1:正常)', 'tinyint(2) NULL ', 'string', '1', '', '1', '', '5', '0', '1', '1463968087', '1463968087', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('64', 'status_show', '显示状态(0:不显示,1:显示)', 'tinyint(2) NULL ', 'string', '1', '', '1', '', '5', '0', '1', '1463968087', '1463968087', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('65', 'op_id', '操作人id', 'int(11) NULL ', 'string', '', '', '1', '', '5', '0', '1', '1463968087', '1463968087', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('66', 'op_nickname', '操作人昵称', 'varchar(30) NULL ', 'string', '', '', '1', '', '5', '0', '1', '1463968087', '1463968087', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('67', 'create_time', '添加时间', 'int(11) NULL ', 'string', '', '', '1', '', '5', '0', '1', '1463968087', '1463968087', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('68', 'game_id', '游戏id', 'int(11) NOT NULL ', 'string', '', '', '1', '', '6', '0', '1', '1463982983', '1463982983', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('69', 'game_name', '游戏名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '6', '0', '1', '1463982983', '1463982983', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('70', 'server_name', '区服名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '6', '0', '1', '1463982983', '1463982983', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('71', 'server_num', '对接区服id', 'int(11) NULL ', 'string', '', '', '1', '', '6', '0', '1', '1463982983', '1463982983', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('72', 'recommend_status', '推荐状态(0:否,1:是)', 'tinyint(2) NULL ', 'string', '1', '', '1', '', '6', '0', '1', '1463982983', '1463982983', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('73', 'show_status', '显示状态(0:否,1:是)', 'tinyint(2) NULL ', 'string', '1', '', '1', '', '6', '0', '1', '1463982983', '1463982983', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('74', 'stop_status', '是否停服(0:否,1:是)', 'tinyint(2) NULL ', 'string', '0', '', '1', '', '6', '0', '1', '1463982983', '1463982983', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('75', 'area_status', '区服状态(0:正常,1拥挤,2爆满)', 'tinyint(2) NULL ', 'string', '0', '', '1', '', '6', '0', '1', '1463982983', '1463982983', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('76', 'icon', '区服图标', 'int(11) NULL ', 'string', '', '', '1', '', '6', '0', '1', '1463982983', '1463982983', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('77', 'start_time', '开始时间', 'int(11) NULL ', 'string', '', '', '1', '', '6', '0', '1', '1463982983', '1463982983', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('78', 'desride', '描述', 'varchar(300) NULL ', 'string', '', '', '1', '', '6', '0', '1', '1463982983', '1463982983', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('79', 'prompt', '停服提示', 'varchar(300) NULL ', 'string', '', '', '1', '', '6', '0', '1', '1463982983', '1463982983', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('80', 'parent_id', '父类id', 'int(11) NULL ', 'string', '', '', '1', '', '6', '0', '1', '1463982983', '1463982983', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('81', 'create_time', '创建时间', 'int(11) NULL ', 'string', '', '', '1', '', '6', '0', '1', '1463982983', '1463982983', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('82', 'game_id', '游戏id', 'int(11) NULL ', 'string', '', '', '1', '', '7', '0', '1', '1463985936', '1463985936', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('83', 'game_name', '游戏名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '7', '0', '1', '1463985936', '1463985936', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('84', 'server_id', '区服id', 'int(11) NULL ', 'string', '', '', '1', '', '7', '0', '1', '1463985936', '1463985936', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('85', 'server_name', '区服名称', 'int(30) NULL ', 'string', '', '', '1', '', '7', '0', '1', '1463985936', '1463985936', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('86', 'giftbag_name', '礼包名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '7', '0', '1', '1463985936', '1463985936', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('87', 'giftbag_type', '礼包类型', 'tinyint(2) NULL ', 'string', '', '', '1', '', '7', '0', '1', '1463985936', '1463985936', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('88', 'level', '领取等级', 'int(3) NULL ', 'string', '', '', '1', '', '7', '0', '1', '1463985936', '1463985936', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('89', 'sort', '排序', 'int(10) NULL ', 'string', '0', '', '1', '', '7', '0', '1', '1463985936', '1463985936', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('90', 'status', '状态', 'tinyint(2) NULL ', 'string', '1', '', '1', '', '7', '0', '1', '1463985936', '1463985936', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('91', 'call_api', '调用接口', 'tinyint(2) NULL ', 'string', '0', '', '1', '', '7', '0', '1', '1463985936', '1463985936', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('92', 'tong_server', '是否通服', 'tinyint(2) NULL ', 'string', '0', '', '1', '', '7', '0', '1', '1463985936', '1463985936', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('93', 'novice', '激活码', 'varchar(3000) NULL ', 'string', '', '', '1', '', '7', '0', '1', '1463985936', '1463985936', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('94', 'digest', '摘要', 'varchar(300) NULL ', 'string', '', '', '1', '', '7', '0', '1', '1463985936', '1463985936', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('95', 'desribe', '描述', 'varchar(300) NULL ', 'string', '', '', '1', '', '7', '0', '1', '1463985936', '1463985936', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('96', 'start_time', '开始时间', 'int(11) NULL ', 'string', '', '', '1', '', '7', '0', '1', '1463985936', '1463985936', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('97', 'end_time', '结束时间', 'int(11) NULL ', 'string', '', '', '1', '', '7', '0', '1', '1463985936', '1463985936', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('98', 'create_time', '创建时间', 'int(11) NULL ', 'string', '', '', '1', '', '7', '0', '1', '1463985936', '1463985936', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('99', 'game_id', '游戏id', 'int(11) NULL ', 'string', '', '', '1', '', '8', '0', '1', '1463987676', '1463987676', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('100', 'game_name', '游戏名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '8', '0', '1', '1463987676', '1463987676', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('101', 'server_id', '区服id', 'int(11) NULL ', 'string', '', '', '1', '', '8', '0', '1', '1463987676', '1463987676', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('102', 'server_name', '区服名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '8', '0', '1', '1463987676', '1463987676', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('103', 'gift_id', '礼包id', 'int(11) NULL ', 'string', '', '', '1', '', '8', '0', '1', '1463987676', '1463987676', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('104', 'gift_name', '礼包名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '8', '0', '1', '1463987676', '1463987676', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('105', 'status', '状态(0:未使用,1:已使用)', 'tinyint(2) NULL ', 'string', '1', '', '1', '', '8', '0', '1', '1463987676', '1463987676', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('106', 'novice', '激活码', 'varchar(30) NULL ', 'string', '', '', '1', '', '8', '0', '1', '1463987676', '1463987676', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('107', 'user_id', '用户id', 'int(11) NULL ', 'string', '', '', '1', '', '8', '0', '1', '1463987676', '1463987676', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('108', 'user_account', '用户昵称', 'varchar(30) NULL ', 'string', '', '', '1', '', '8', '0', '1', '1463987676', '1463987676', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('109', 'user_nickname', '用户昵称', 'varchar(30) NULL ', 'string', '', '', '1', '', '8', '0', '1', '1463987676', '1463987676', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('110', 'create_time', '创建时间', 'int(11) NULL ', 'string', '', '', '1', '', '8', '0', '1', '1463987676', '1463987676', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('111', 'account', '账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '9', '0', '1', '1463989240', '1463989240', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('112', 'password', '密码', 'varchar(32) NULL ', 'string', '', '', '1', '', '9', '0', '1', '1463989240', '1463989240', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('113', 'second_pwd', '二级密码', 'varchar(32) NULL ', 'string', '', '', '1', '', '9', '0', '1', '1463989240', '1463989240', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('114', 'nickname', '昵称', 'varchar(30) NULL ', 'string', '', '', '1', '', '9', '0', '1', '1463989240', '1463989240', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('115', 'mobile_phone', '手机号', 'varchar(11) NULL ', 'string', '', '', '1', '', '9', '0', '1', '1463989240', '1463989240', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('116', 'email', '邮箱', 'varchar(50) NULL ', 'string', '', '', '1', '', '9', '0', '1', '1463989240', '1463989240', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('117', 'real_name', '真实姓名', 'varchar(10) NULL ', 'string', '', '', '1', '', '9', '0', '1', '1463989240', '1463989240', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('118', 'bank_name', '银行', 'varchar(50) NULL ', 'string', '', '', '1', '', '9', '0', '1', '1463989240', '1463989240', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('119', 'bank_card', '银行卡', 'varchar(20) NULL ', 'string', '', '', '1', '', '9', '0', '1', '1463989240', '1463989240', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('120', 'money', '金额', 'double(10,2) NULL ', 'string', '0.00', '', '1', '', '9', '0', '1', '1463989240', '1463989240', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('121', 'total_money', '总金额', 'double(10,2) NULL ', 'string', '0.00', '', '1', '', '9', '0', '1', '1463989240', '1463989240', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('122', 'balance_coin', '平台币', 'double(10,2) NULL ', 'string', '0.00', '', '1', '', '9', '0', '1', '1463989240', '1463989240', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('123', 'promote_type', '推广员类型', 'int(2) NULL ', 'string', '1', '', '1', '', '9', '0', '1', '1463989240', '1463989240', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('124', 'status', '状态', 'int(11) NULL ', 'string', '1', '', '1', '', '9', '0', '1', '1463989240', '1463989240', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('125', 'parent_id', '父类ID', 'int(11) NULL ', 'string', '0', '', '1', '', '9', '0', '1', '1463989240', '1463989240', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('126', 'referee_id', '推荐人ID', 'int(11) NULL ', 'string', '0', '', '1', '', '9', '0', '1', '1463989240', '1463989240', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('127', 'create_time', '添加时间', 'int(11) NULL ', 'string', '', '', '1', '', '9', '0', '1', '1463989240', '1463989240', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('128', 'admin_id', '管理员id', 'int(11) NOT NULL ', 'string', '', '', '1', '', '9', '0', '1', '1463989240', '1463989240', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('129', 'user_id', '用户id', 'int(11) NOT NULL ', 'string', '', '', '1', '', '10', '0', '1', '1463997570', '1463997570', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('130', 'user_account', '用户账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '10', '0', '1', '1463997570', '1463997570', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('131', 'user_nickname', '用户昵称', 'varchar(30) NULL ', 'string', '', '', '1', '', '10', '0', '1', '1463997570', '1463997570', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('132', 'promote_id', '推广员id', 'int(11) NULL ', 'string', '', '', '1', '', '10', '0', '1', '1463997570', '1463997570', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('133', 'promote_account', '推广员账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '10', '0', '1', '1463997570', '1463997570', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('134', 'prmoote_id_to', '修改后推广员id', 'int(11) NULL ', 'string', '', '', '1', '', '10', '0', '1', '1463997570', '1463997570', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('135', 'promot_account_to', '修改后推广员账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '10', '0', '1', '1463997570', '1463997570', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('136', 'remark', '备注', 'varchar(100) NULL ', 'string', '', '', '1', '', '10', '0', '1', '1463997570', '1463997570', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('137', 'create_time', '创建时间', 'int(11) NULL ', 'string', '', '', '1', '', '10', '0', '1', '1463997570', '1463997570', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('138', 'op_id', '操作人id', 'int(11) NULL ', 'string', '', '', '1', '', '10', '0', '1', '1463997570', '1463997570', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('139', 'op_account', '操作人账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '10', '0', '1', '1463997570', '1463997570', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('140', 'account', '登陆账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '11', '0', '1', '1463997820', '1463997820', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('141', 'password', '登陆密码', 'varchar(32) NULL ', 'string', '', '', '1', '', '11', '0', '1', '1463997820', '1463997820', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('142', 'nickname', '昵称', 'varchar(30) NULL ', 'string', '', '', '1', '', '11', '0', '1', '1463997820', '1463997820', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('143', 'email', '邮箱', 'varchar(50) NULL ', 'string', '', '', '1', '', '11', '0', '1', '1463997820', '1463997820', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('144', 'phone', '手机号码', 'varchar(15) NULL ', 'string', '', '', '1', '', '11', '0', '1', '1463997820', '1463997820', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('145', 'real_name', '真实姓名', 'varchar(20) NULL ', 'string', '', '', '1', '', '11', '0', '1', '1463997820', '1463997820', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('146', 'idcard', '身份证', 'varchar(20) NULL ', 'string', '', '', '1', '', '11', '0', '1', '1463997820', '1463997820', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('147', 'vip_level', 'vip等级', 'tinyint(2) NULL ', 'string', '0', '', '1', '', '11', '0', '1', '1463997820', '1463997820', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('148', 'cumulative', '累计充值', 'double(10,2) NULL ', 'string', '0.00', '', '1', '', '11', '0', '1', '1463997820', '1463997820', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('149', 'balance', '余额', 'double(10,2) NULL ', 'string', '0.00', '', '1', '', '11', '0', '1', '1463997820', '1463997820', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('150', 'anti_addiction', '防沉迷', 'tinyint(2) NULL ', 'string', '0', '', '1', '', '11', '0', '1', '1463997820', '1463997820', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('151', 'lock_status', '锁定状态', 'tinyint(2) NULL ', 'string', '1', '', '1', '', '11', '0', '1', '1463997820', '1463997820', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('152', 'register_way', '注册方式', 'tinyint(2) NULL ', 'string', '0', '', '1', '', '11', '0', '1', '1463997820', '1463997820', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('153', 'register_time', '注册时间', 'int(11) NULL ', 'string', '', '', '1', '', '11', '0', '1', '1463997820', '1463997820', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('154', 'login_time', '登陆时间', 'int(11) NULL ', 'string', '', '', '1', '', '11', '0', '1', '1463997820', '1463997820', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('155', 'register_ip', '注册ip', 'varchar(16) NOT NULL ', 'string', '', '', '1', '', '11', '0', '1', '1463997820', '1463997820', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('156', 'login_ip', '登陆ip', 'varchar(16) NOT NULL ', 'string', '', '', '1', '', '11', '0', '1', '1463997820', '1463997820', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('157', 'promote_id', '推广id', 'int(11) NOT NULL ', 'string', '0', '', '1', '', '11', '0', '1', '1463997820', '1463997820', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('158', 'promote_account', '推广员账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '11', '0', '1', '1463997820', '1463997820', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('159', 'user_id', '用户ID', 'int(11) NULL ', 'string', '', '', '1', '', '12', '0', '1', '1463997856', '1463997856', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('160', 'user_account', '用户账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '12', '0', '1', '1463997856', '1463997856', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('161', 'user_nickname', '用户昵称', 'varchar(30) NULL ', 'string', '', '', '1', '', '12', '0', '1', '1463997856', '1463997856', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('162', 'game_id', '游戏id', 'int(11) NOT NULL ', 'string', '', '', '1', '', '12', '0', '1', '1463997856', '1463997856', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('163', 'game_name', '游戏名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '12', '0', '1', '1463997856', '1463997856', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('164', 'game_appid', '游戏appid', 'varchar(32) NULL ', 'string', '', '', '1', '', '12', '0', '1', '1463997856', '1463997856', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('165', 'server_id', '区服id', 'int(11) NOT NULL ', 'string', '', '', '1', '', '12', '0', '1', '1463997856', '1463997856', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('166', 'server_name', '区服名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '12', '0', '1', '1463997856', '1463997856', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('167', 'role_id', '角色', 'int(11) NULL ', 'string', '0', '', '1', '', '12', '0', '1', '1463997856', '1463997856', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('168', 'bind_balance', '绑定平台币', 'double NULL ', 'string', '0', '', '1', '', '12', '0', '1', '1463997856', '1463997856', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('169', 'role_name', '角色名称', 'varchar(20) NULL ', 'string', '', '', '1', '', '12', '0', '1', '1463997856', '1463997856', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('170', 'role_level', '等级', 'int(3) NULL ', 'string', '0', '', '1', '', '12', '0', '1', '1463997856', '1463997856', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('171', 'promote_id', '推广员id', 'int(11) NULL ', 'string', '0', '', '1', '', '12', '0', '1', '1463997856', '1463997856', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('172', 'promote_account', '推广员账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '12', '0', '1', '1463997856', '1463997856', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('173', 'game_id', '游戏id', 'int(11) NULL ', 'string', '', '', '1', '', '13', '0', '1', '1463997904', '1463997904', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('174', 'game_name', ' 游戏名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '13', '0', '1', '1463997904', '1463997904', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('175', 'server_id', '区服id', 'int(11) NULL ', 'string', '', '', '1', '', '13', '0', '1', '1463997904', '1463997904', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('176', 'server_name', '区服名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '13', '0', '1', '1463997904', '1463997904', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('177', 'user_id', '用户ID', 'int(11) NULL ', 'string', '', '', '1', '', '13', '0', '1', '1463997904', '1463997904', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('178', 'user_account', '用户账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '13', '0', '1', '1463997904', '1463997904', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('179', 'user_nickname', '用户昵称', 'varchar(30) NULL ', 'string', '', '', '1', '', '13', '0', '1', '1463997904', '1463997904', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('180', 'login_time', '登陆时间', 'int(11) NULL ', 'string', '', '', '1', '', '13', '0', '1', '1463997904', '1463997904', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('181', 'login_ip', '登陆ip', 'varchar(20) NULL ', 'string', '', '', '1', '', '13', '0', '1', '1463997904', '1463997904', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('182', 'type', '类型(1:游戏登陆,2:PC登陆)', 'tinyint(2) NULL ', 'string', '1', '', '1', '', '13', '0', '1', '1463997904', '1463997904', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('183', 'user_id', ' 用户ID', 'int(11) NOT NULL ', 'string', '', '', '1', '', '14', '0', '1', '1464012355', '1464012355', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('184', 'user_account', '用户账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '14', '0', '1', '1464012355', '1464012355', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('185', 'user_nickname', '用户昵称', 'varchar(30) NULL ', 'string', '', '', '1', '', '14', '0', '1', '1464012355', '1464012355', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('186', 'game_id', '游戏id', 'int(11) NULL ', 'string', '', '', '1', '', '14', '0', '1', '1464012355', '1464012355', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('187', 'game_appid', '游戏appid', 'varchar(32) NULL ', 'string', '', '', '1', '', '14', '0', '1', '1464012355', '1464012355', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('188', 'game_name', '游戏名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '14', '0', '1', '1464012355', '1464012355', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('189', 'server_id', '区服id', 'int(11) NULL ', 'string', '', '', '1', '', '14', '0', '1', '1464012355', '1464012355', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('190', 'server_name', '区服名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '14', '0', '1', '1464012355', '1464012355', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('191', 'promote_id', '推广员id', 'int(11) NULL ', 'string', '', '', '1', '', '14', '0', '1', '1464012355', '1464012355', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('192', 'promote_account', '推广员账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '14', '0', '1', '1464012355', '1464012355', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('193', 'order_number', '订单号', 'varchar(30) NULL ', 'string', '', '', '1', '', '14', '0', '1', '1464012355', '1464012355', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('194', 'pay_order_number', '支付订单号', 'varchar(30) NULL ', 'string', '', '', '1', '', '14', '0', '1', '1464012355', '1464012355', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('195', 'props_name', '道具名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '14', '0', '1', '1464012355', '1464012355', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('196', 'pay_amount', '支付金额', 'double(10,2) NULL ', 'string', '', '', '1', '', '14', '0', '1', '1464012355', '1464012355', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('197', 'pay_time', '支付时间', 'int(11) NULL ', 'string', '', '', '1', '', '14', '0', '1', '1464012355', '1464012355', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('198', 'pay_status', '支付状态', 'tinyint(2) NULL ', 'string', '', '', '1', '', '14', '0', '1', '1464012355', '1464012355', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('199', 'pay_game_status', '游戏支付状态', 'tinyint(2) NULL ', 'string', '', '', '1', '', '14', '0', '1', '1464012355', '1464012355', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('200', 'pay_way', '支付方式', 'tinyint(2) NULL ', 'string', '', '', '1', '', '14', '0', '1', '1464012355', '1464012355', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('201', 'spend_ip', '支付IP', 'varchar(20) NULL ', 'string', '', '', '1', '', '14', '0', '1', '1464012355', '1464012355', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('202', 'title', '广告名称', 'char(80) NOT NULL ', 'string', '', '', '1', '', '15', '0', '1', '1464083427', '1464083427', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('203', 'pos_id', '广告位置', 'int(11) NOT NULL ', 'string', '', '', '1', '', '15', '0', '1', '1464083427', '1464083427', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('204', 'data', '图片地址', 'text NOT NULL ', 'string', '', '', '1', '', '15', '0', '1', '1464083427', '1464083427', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('205', 'click_count', '点击量', 'int(11) NOT NULL ', 'string', '', '', '1', '', '15', '0', '1', '1464083427', '1464083427', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('206', 'url', '链接地址', 'varchar(500) NOT NULL ', 'string', '', '', '1', '', '15', '0', '1', '1464083427', '1464083427', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('207', 'sort', '排序', 'int(3) unsigned NOT NULL ', 'string', '0', '', '1', '', '15', '0', '1', '1464083427', '1464083427', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('208', 'status', '状态（0：禁用，1：正常）', 'tinyint(2) NOT NULL ', 'string', '1', '', '1', '', '15', '0', '1', '1464083427', '1464083427', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('209', 'create_time', '开始时间', 'int(11) unsigned NOT NULL ', 'string', '0', '', '1', '', '15', '0', '1', '1464083427', '1464083427', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('210', 'start_time', '', 'int(11) NULL ', 'string', '', '', '1', '', '15', '0', '1', '1464083427', '1464083427', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('211', 'end_time', '结束时间', 'int(11) unsigned NULL ', 'string', '0', '', '1', '', '15', '0', '1', '1464083427', '1464083427', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('212', 'target', '', 'varchar(20) NULL ', 'string', '_blank', '', '1', '', '15', '0', '1', '1464083427', '1464083427', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('213', 'name', '', 'varchar(50) NOT NULL ', 'string', '', '', '1', '', '16', '0', '1', '1464084894', '1464084894', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('214', 'title', '广告位置名称', 'char(80) NOT NULL ', 'string', '', '', '1', '', '16', '0', '1', '1464084894', '1464084894', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('215', 'module', '所在模块 模块/控制器/方法', 'varchar(100) NOT NULL ', 'string', '', '', '1', '', '16', '0', '1', '1464084894', '1464084894', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('216', 'type', '广告位类型 \r\n1.单图\r\n2.多图\r\n3.文字链接\r\n4.代码', 'int(11) unsigned NOT NULL ', 'string', '1', '', '1', '', '16', '0', '1', '1464084894', '1464084894', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('217', 'status', '状态（0：禁用，1：正常）', 'tinyint(2) NOT NULL ', 'string', '1', '', '1', '', '16', '0', '1', '1464084894', '1464084894', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('218', 'data', '额外的数据', 'varchar(500) NOT NULL ', 'string', '', '', '1', '', '16', '0', '1', '1464084894', '1464084894', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('219', 'width', '广告位置宽度', 'char(20) NOT NULL ', 'string', '', '', '1', '', '16', '0', '1', '1464084894', '1464084894', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('220', 'height', '广告位置高度', 'char(20) NOT NULL ', 'string', '', '', '1', '', '16', '0', '1', '1464084894', '1464084894', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('221', 'margin', '边缘', 'varchar(50) NOT NULL ', 'string', '', '', '1', '', '16', '0', '1', '1464084894', '1464084894', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('222', 'padding', '留白', 'varchar(50) NOT NULL ', 'string', '', '', '1', '', '16', '0', '1', '1464084894', '1464084894', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('223', 'theme', '适用主题，默认为all，通用', 'varchar(50) NOT NULL ', 'string', 'all', '', '1', '', '16', '0', '1', '1464084894', '1464084894', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('224', 'order_number', '订单号', 'varchar(30) NULL ', 'string', '', '', '1', '', '17', '0', '1', '1464233084', '1464233084', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('225', 'pay_order_number', '支付订单号', 'varchar(30) NULL ', 'string', '', '', '1', '', '17', '0', '1', '1464233084', '1464233084', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('226', 'user_id', '用户id', 'int(11) NULL ', 'string', '', '', '1', '', '17', '0', '1', '1464233084', '1464233084', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('227', 'user_account', '用户账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '17', '0', '1', '1464233084', '1464233084', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('228', 'user_nickname', '用户昵称', 'varchar(30) NULL ', 'string', '', '', '1', '', '17', '0', '1', '1464233084', '1464233084', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('229', 'promote_id', '推广员ID', 'int(11) NULL ', 'string', '', '', '1', '', '17', '0', '1', '1464233084', '1464233084', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('230', 'promote_account', '推广账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '17', '0', '1', '1464233084', '1464233084', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('231', 'pay_amount', '充值金额', 'double(10,2) NULL ', 'string', '0.00', '', '1', '', '17', '0', '1', '1464233084', '1464233084', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('232', 'pay_status', '充值状态', 'tinyint(2) NULL ', 'string', '0', '', '1', '', '17', '0', '1', '1464233084', '1464233084', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('233', 'pay_way', '支付方式', 'tinyint(2) NULL ', 'string', '0', '', '1', '', '17', '0', '1', '1464233084', '1464233084', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('234', 'pay_source', '支付来源', 'tinyint(2) NULL ', 'string', '0', '', '1', '', '17', '0', '1', '1464233084', '1464233084', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('235', 'pay_ip', '充值IP', 'varchar(20) NULL ', 'string', '', '', '1', '', '17', '0', '1', '1464233084', '1464233084', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('236', 'create_time', '支付时间', 'int(11) NULL ', 'string', '', '', '1', '', '17', '0', '1', '1464233085', '1464233085', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('237', 'order_number', '订单号', 'varchar(30) NULL ', 'string', '', '', '1', '', '18', '0', '1', '1464233863', '1464233863', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('238', 'pay_order_number', '商户订单号', 'varchar(30) NULL ', 'string', '', '', '1', '', '18', '0', '1', '1464233863', '1464233863', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('239', 'user_id', '用户ID', 'int(11) NULL ', 'string', '', '', '1', '', '18', '0', '1', '1464233863', '1464233863', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('240', 'user_account', '用户账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '18', '0', '1', '1464233864', '1464233864', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('241', 'user_nickname', '用户昵称', 'varchar(30) NULL ', 'string', '', '', '1', '', '18', '0', '1', '1464233864', '1464233864', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('242', 'game_id', '游戏id', 'int(11) NULL ', 'string', '', '', '1', '', '18', '0', '1', '1464233864', '1464233864', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('243', 'game_name', '游戏名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '18', '0', '1', '1464233864', '1464233864', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('244', 'server_id', '区服id', 'int(11) NULL ', 'string', '', '', '1', '', '18', '0', '1', '1464233864', '1464233864', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('245', 'server_name', '区服名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '18', '0', '1', '1464233864', '1464233864', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('246', 'amount', '充值金额', 'double(10,2) NULL ', 'string', '', '', '1', '', '18', '0', '1', '1464233864', '1464233864', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('247', 'remark', '备注', 'varchar(100) NULL ', 'string', '', '', '1', '', '18', '0', '1', '1464233864', '1464233864', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('248', 'status', '状态', 'tinyint(2) NULL ', 'string', '0', '', '1', '', '18', '0', '1', '1464233864', '1464233864', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('249', 'op_id', '操作人id', 'int(11) NULL ', 'string', '', '', '1', '', '18', '0', '1', '1464233864', '1464233864', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('250', 'op_account', '操作人账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '18', '0', '1', '1464233864', '1464233864', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('251', 'create_time', '时间', 'int(11) NULL ', 'string', '', '', '1', '', '18', '0', '1', '1464233864', '1464233864', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('252', 'user_id', '用户id', 'int(11) NOT NULL ', 'string', '', '', '1', '', '19', '0', '1', '1464234376', '1464234376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('253', 'user_account', '用户账号', 'varchar(30) NOT NULL ', 'string', '', '', '1', '', '19', '0', '1', '1464234376', '1464234376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('254', 'user_nickname', '用户昵称', 'varchar(30) NOT NULL ', 'string', '', '', '1', '', '19', '0', '1', '1464234376', '1464234376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('255', 'game_id', '游戏id', 'int(11) NOT NULL ', 'string', '', '', '1', '', '19', '0', '1', '1464234376', '1464234376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('256', 'game_appid', '游戏appid', 'varchar(30) NOT NULL ', 'string', '', '', '1', '', '19', '0', '1', '1464234376', '1464234376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('257', 'game_name', '游戏名称', 'varchar(30) NOT NULL ', 'string', '', '', '1', '', '19', '0', '1', '1464234376', '1464234376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('258', 'order_number', '订单号', 'varchar(30) NOT NULL ', 'string', '', '', '1', '', '19', '0', '1', '1464234376', '1464234376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('259', 'pay_order_number', '商户订单号', 'varchar(30) NOT NULL ', 'string', '', '', '1', '', '19', '0', '1', '1464234376', '1464234376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('260', 'props_name', '道具名称', 'varchar(30) NOT NULL ', 'string', '', '', '1', '', '19', '0', '1', '1464234376', '1464234376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('261', 'pay_amount', '金额', 'double(10,2) NOT NULL ', 'string', '0.00', '', '1', '', '19', '0', '1', '1464234376', '1464234376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('262', 'pay_time', '支付时间', 'int(11) NOT NULL ', 'string', '', '', '1', '', '19', '0', '1', '1464234376', '1464234376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('263', 'pay_status', '支付状态', 'tinyint(2) NOT NULL ', 'string', '0', '', '1', '', '19', '0', '1', '1464234376', '1464234376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('264', 'pay_game_status', '游戏支付状态', 'tinyint(2) NOT NULL ', 'string', '0', '', '1', '', '19', '0', '1', '1464234376', '1464234376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('265', 'pay_way', '支付方式', 'tinyint(2) NOT NULL ', 'string', '0', '', '1', '', '19', '0', '1', '1464234376', '1464234376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('266', 'pay_source', '支付来源', 'tinyint(2) NOT NULL ', 'string', '0', '', '1', '', '19', '0', '1', '1464234376', '1464234376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('267', 'spend_ip', '支付ip', 'varchar(16) NOT NULL ', 'string', '', '', '1', '', '19', '0', '1', '1464234376', '1464234376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('399', 'create_time', '时间', 'int(11) NULL ', 'string', '', '', '1', '', '40', '0', '1', '1470391524', '1470391524', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('398', 'contact', '联系人', 'varchar(11) NULL ', 'string', '', '', '1', '', '40', '0', '1', '1470391524', '1470391524', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('397', 'content', '内容', 'varchar(300) NULL ', 'string', '', '', '1', '', '40', '0', '1', '1470391524', '1470391524', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('396', 'nickname', '昵称', 'varchar(30) NULL ', 'string', '', '', '1', '', '40', '0', '1', '1470391524', '1470391524', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('395', 'username', '用户名', 'varchar(30) NULL ', 'string', '', '', '1', '', '40', '0', '1', '1470391524', '1470391524', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('279', 'game_id', '游戏ID', 'int(11) NULL ', 'string', '', '', '1', '', '21', '0', '1', '1464356213', '1464356213', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('280', 'game_name', '游戏名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '21', '0', '1', '1464356213', '1464356213', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('281', 'promote_id', '推广员ID', 'int(11) NULL ', 'string', '', '', '1', '', '21', '0', '1', '1464356213', '1464356213', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('282', 'promote_account', '推广账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '21', '0', '1', '1464356213', '1464356213', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('283', 'ratio', '分成比例', 'int(3) NULL ', 'string', '0', '', '1', '', '21', '0', '1', '1464356213', '1464356213', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('284', 'apply_time', '申请时间', 'int(11) NULL ', 'string', '', '', '1', '', '21', '0', '1', '1464356213', '1464356213', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('285', 'status', '审核状态', 'tinyint(2) NULL ', 'string', '', '', '1', '', '21', '0', '1', '1464356213', '1464356213', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('286', 'enable_status', '操作状态', 'tinyint(2) NULL ', 'string', '', '', '1', '', '21', '0', '1', '1464356213', '1464356213', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('287', 'pack_url', '游戏包地址', 'varchar(255) NULL ', 'string', '', '', '1', '', '21', '0', '1', '1464356213', '1464356213', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('288', 'dow_url', '下载地址', 'varchar(255) NULL ', 'string', '', '', '1', '', '21', '0', '1', '1464356213', '1464356213', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('289', 'dispose_id', '操作人', 'int(11) NULL ', 'string', '', '', '1', '', '21', '0', '1', '1464356213', '1464356213', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('290', 'dispose_time', '操作时间', 'int(11) NULL ', 'string', '', '', '1', '', '21', '0', '1', '1464356213', '1464356213', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('291', 'order_number', '订单号', 'varchar(30) NULL ', 'string', '', '', '1', '', '22', '0', '1', '1464772695', '1464772695', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('292', 'pay_order_number', '支付订单号 ', 'varchar(30) NOT NULL ', 'string', '', '', '1', '', '22', '0', '1', '1464772695', '1464772695', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('293', 'game_id', '游戏ID', 'int(11) NULL ', 'string', '', '', '1', '', '22', '0', '1', '1464772695', '1464772695', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('294', 'game_appid', '游戏APPID', 'varchar(32) NULL ', 'string', '', '', '1', '', '22', '0', '1', '1464772695', '1464772695', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('295', 'game_name', '游戏名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '22', '0', '1', '1464772695', '1464772695', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('296', 'promote_id', '推广员ID', 'int(11) NULL ', 'string', '0', '', '1', '', '22', '0', '1', '1464772695', '1464772695', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('297', 'promote_account', '推广员账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '22', '0', '1', '1464772695', '1464772695', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('298', 'user_id', '用户ID', 'int(11) NULL ', 'string', '', '', '1', '', '22', '0', '1', '1464772695', '1464772695', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('299', 'user_account', '玩家账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '22', '0', '1', '1464772695', '1464772695', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('300', 'user_nickname', '用户昵称', 'varchar(30) NULL ', 'string', '', '', '1', '', '22', '0', '1', '1464772695', '1464772695', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('301', 'amount', '支付金额', 'double(10,2) NULL ', 'string', '0.00', '', '1', '', '22', '0', '1', '1464772695', '1464772695', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('302', 'real_amount', '实际金额', 'double(10,2) NULL ', 'string', '0.00', '', '1', '', '22', '0', '1', '1464772695', '1464772695', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('303', 'status', '支付状态', 'tinyint(2) NULL ', 'string', '0', '', '1', '', '22', '0', '1', '1464772695', '1464772695', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('304', 'pay_type', '类型', 'tinyint(2) NULL ', 'string', '', '', '1', '', '22', '0', '1', '1464772695', '1464772695', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('305', 'create_time', '时间', 'int(11) NULL ', 'string', '', '', '1', '', '22', '0', '1', '1464772695', '1464772695', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('306', 'zhekou', '折扣比例', 'int(11) NOT NULL ', 'string', '0', '', '1', '', '22', '0', '1', '1464772695', '1464772695', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('307', 'promote_id', '推广员ID', 'int(11) NULL ', 'string', '', '', '1', '', '24', '0', '1', '1464945957', '1464945957', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('308', 'game_id', '游戏ID', 'varchar(32) NULL ', 'string', '', '', '1', '', '24', '0', '1', '1464945957', '1464945957', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('309', 'spend_time', '消费时间', 'int(11) NULL ', 'string', '', '', '1', '', '24', '0', '1', '1464945957', '1464945957', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('310', 'reg_num', '注册人数', 'int(10) NULL ', 'string', '0', '', '1', '', '24', '0', '1', '1464945957', '1464945957', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('311', 'spend_num', '消费人数', 'int(10) NULL ', 'string', '0', '', '1', '', '24', '0', '1', '1464945957', '1464945957', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('312', 'money', '金额', 'double(10,2) NULL ', 'string', '0.00', '', '1', '', '24', '0', '1', '1464945957', '1464945957', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('313', 'real_money', '实际金额', 'double(10,2) NULL ', 'string', '0.00', '', '1', '', '24', '0', '1', '1464945957', '1464945957', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('314', 'status', '结算状态', 'tinyint(2) NULL ', 'string', '1', '', '1', '', '24', '0', '1', '1464945957', '1464945957', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('315', 'type', '类型', 'tinyint(2) NULL ', 'string', '0', '', '1', '', '24', '0', '1', '1464945957', '1464945957', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('341', 'link_url', '友链地址', 'varchar(255) NULL ', 'string', '', '', '1', '', '31', '0', '1', '1465202698', '1465202698', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('339', 'create_time', '添加时间', 'int(11) NULL ', 'string', '', '', '1', '', '30', '0', '1', '1465194413', '1465194413', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('337', 'op_id', '操作人id', 'int(11) NULL ', 'string', '', '', '1', '', '30', '0', '1', '1465194413', '1465194413', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('338', 'op_nickname', '操作人昵称', 'varchar(30) NULL ', 'string', '', '', '1', '', '30', '0', '1', '1465194413', '1465194413', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('335', 'status', '状态(-1:删除,1:正常)', 'tinyint(2) NULL ', 'string', '1', '', '1', '', '30', '0', '1', '1465194413', '1465194413', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('340', 'title', '标题', 'varchar(50) NULL ', 'string', '', '', '1', '', '31', '0', '1', '1465202698', '1465202698', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('334', 'type_name', '礼包类型名称', 'varchar(20) NULL ', 'string', '', '', '1', '', '30', '0', '1', '1465194413', '1465194413', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('342', 'link_icon', '图标', 'int(11) NULL ', 'string', '', '', '1', '', '31', '0', '1', '1465202698', '1465202698', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('343', 'status', '状态', 'tinyint(2) NULL ', 'string', '', '', '1', '', '31', '0', '1', '1465202698', '1465202698', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('344', 'type', '类型', 'tinyint(2) NULL ', 'string', '', '', '1', '', '31', '0', '1', '1465202698', '1465202698', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('345', 'remark', '备注', 'varchar(255) NULL ', 'string', '', '', '1', '', '31', '0', '1', '1465202698', '1465202698', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('346', 'create_time', '创建时间', 'int(11) NULL ', 'string', '', '', '1', '', '31', '0', '1', '1465202698', '1465202698', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('347', 'mark', '所属后台', 'varchar(50) NOT NULL', 'string', '0', '0媒体1渠道', '1', '', '31', '0', '1', '1465727293', '1465727293', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `sys_attribute` VALUES ('348', 'game_id', '游戏id', 'int(11) NULL ', 'string', '', '', '1', '', '32', '0', '1', '1465732888', '1465732888', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('349', 'user_id', '用户id', 'int(11) NULL ', 'string', '', '', '1', '', '32', '0', '1', '1465732888', '1465732888', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('350', 'title', '标题', 'varchar(50) NULL ', 'string', '', '', '1', '', '32', '0', '1', '1465732888', '1465732888', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('351', 'content', '内容', 'varchar(300) NULL ', 'string', '', '', '1', '', '32', '0', '1', '1465732888', '1465732888', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('352', 'status', '修复状态(0:未,1:已)', 'tinyint(2) NULL ', 'string', '0', '', '1', '', '32', '0', '1', '1465732888', '1465732888', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('353', 'type', '类型(0:纠错,1:留言)', 'tinyint(2) NULL ', 'string', '0', '', '1', '', '32', '0', '1', '1465732888', '1465732888', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('354', 'op_id', '操作人id', 'int(11) NULL ', 'string', '', '', '1', '', '32', '0', '1', '1465732888', '1465732888', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('355', 'op_account', '操作人账号', 'varchar(20) NULL ', 'string', '', '', '1', '', '32', '0', '1', '1465732888', '1465732888', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('356', 'create_time', '修改时间', 'int(11) NULL ', 'string', '', '', '1', '', '32', '0', '1', '1465732888', '1465732888', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('357', 'create_time', '添加时间', 'int(11) NOT NULL ', 'string', '', '', '1', '', '33', '0', '1', '1465898749', '1465898749', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('358', 'status', '状态', 'int(11) NOT NULL ', 'string', '', '', '1', '', '33', '0', '1', '1465898749', '1465898749', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('359', 'open_name', '开放类型名称', 'varchar(30) NOT NULL ', 'string', '', '', '1', '', '33', '0', '1', '1465898749', '1465898749', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('360', 'icon', '图标', 'int(12) NOT NULL', 'string', '', '', '1', '', '5', '0', '1', '1466150513', '1466150513', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `sys_attribute` VALUES ('361', 'cover', '封面', 'int(12)  NOT NULL', 'string', '', '', '1', '', '5', '0', '1', '1466150535', '1466150535', '', '3', '', 'regex', '', '3', 'function');
INSERT INTO `sys_attribute` VALUES ('362', 'game_id', '游戏id', 'int(11) NULL ', 'string', '', '', '1', '', '35', '0', '1', '1466386454', '1466386454', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('363', 'game_name', '游戏名称', 'varchar(50) NULL ', 'string', '', '', '1', '', '35', '0', '1', '1466386454', '1466386454', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('364', 'money', '金额', 'int(11) NULL ', 'string', '0', '', '1', '', '35', '0', '1', '1466386454', '1466386454', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('365', 'ratio', '返利比例', 'double(5,2) NULL ', 'string', '0.00', '', '1', '', '35', '0', '1', '1466386454', '1466386454', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('366', 'status', '状态(0关闭金额限制 1 开启金额限制)', 'int(11) NULL ', 'string', '', '', '1', '', '35', '0', '1', '1466386454', '1466386454', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('367', 'create_time', '更新时间', 'int(11) NULL ', 'string', '', '', '1', '', '35', '0', '1', '1466386454', '1466386454', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('368', 'pay_order_number', '订单号', 'varchar(30) NULL ', 'string', '', '', '1', '', '36', '0', '1', '1466386503', '1466386503', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('369', 'game_id', '游戏id', 'int(11) NULL ', 'string', '', '', '1', '', '36', '0', '1', '1466386503', '1466386503', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('370', 'game_name', '游戏名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '36', '0', '1', '1466386503', '1466386503', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('371', 'user_id', '用户id', 'int(11) NULL ', 'string', '', '', '1', '', '36', '0', '1', '1466386503', '1466386503', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('372', 'user_name', '用户名', 'varchar(30) NULL ', 'string', '', '', '1', '', '36', '0', '1', '1466386503', '1466386503', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('373', 'pay_amount', '充值金额', 'double(10,2) NULL ', 'string', '0.00', '', '1', '', '36', '0', '1', '1466386503', '1466386503', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('374', 'ratio', '返利比例', 'double(5,2) NULL ', 'string', '0.00', '', '1', '', '36', '0', '1', '1466386503', '1466386503', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('375', 'ratio_amount', '返利平台币', 'double(10,2) NULL ', 'string', '', '', '1', '', '36', '0', '1', '1466386503', '1466386503', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('376', 'promote_id', '推广id', 'int(11) NULL ', 'string', '0', '', '1', '', '36', '0', '1', '1466386503', '1466386503', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('377', 'promote_name', '推广员姓名', 'varchar(30) NULL ', 'string', '', '', '1', '', '36', '0', '1', '1466386503', '1466386503', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('378', 'create_time', '创建时间', 'int(11) NULL ', 'string', '', '', '1', '', '36', '0', '1', '1466386503', '1466386503', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('379', 'push_name', '应用名', 'varchar(30) NULL ', 'string', '', '', '1', '', '37', '0', '1', '1466757612', '1466757612', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('380', 'app_key', '', 'varchar(30) NULL ', 'string', '', '', '1', '', '37', '0', '1', '1466757612', '1466757612', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('381', 'master_secret', '', 'varchar(30) NULL ', 'string', '', '', '1', '', '37', '0', '1', '1466757612', '1466757612', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('382', 'status', '状态(0关闭 1开启)', 'tinyint(2) NULL ', 'string', '', '', '1', '', '37', '0', '1', '1466757612', '1466757612', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('383', 'create_time', '创建时间', 'int(11) NULL ', 'string', '', '', '1', '', '37', '0', '1', '1466757612', '1466757612', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('392', 'push_time', '推送时间', 'int(11) NULL ', 'string', '', '', '1', '', '39', '0', '1', '1466759193', '1466759193', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('391', 'push_time_type', '推送时间(0 立即  1定时)', 'tinyint(2) NULL ', 'string', '', '', '1', '', '39', '0', '1', '1466759193', '1466759193', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('390', 'push_object', '推送类型(0 不限 1 ios 2 安卓 3 winphone)', 'int(11) NULL ', 'string', '', '', '1', '', '39', '0', '1', '1466759193', '1466759193', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('389', 'content', '推送内容', 'text NULL ', 'string', '', '', '1', '', '39', '0', '1', '1466759193', '1466759193', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('393', 'status', '推送状态', 'int(11) NULL ', 'string', '', '', '1', '', '39', '0', '1', '1466759193', '1466759193', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('394', 'create_time', '创建时间', 'int(11) NULL ', 'string', '', '', '1', '', '39', '0', '1', '1466759193', '1466759193', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('413', 'pay_order_number', '支付订单号', 'varchar(30) NULL ', 'string', '', '', '1', '', '42', '0', '1', '1474858375', '1474858375', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('414', 'user_id', ' 用户ID', 'int(11) NOT NULL ', 'string', '', '', '1', '', '42', '0', '1', '1474858375', '1474858375', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('415', 'user_account', '用户账号', 'varchar(30) NULL ', 'string', '', '', '1', '', '42', '0', '1', '1474858375', '1474858375', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('416', 'user_nickname', '用户昵称', 'varchar(30) NULL ', 'string', '', '', '1', '', '42', '0', '1', '1474858375', '1474858375', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('417', 'game_id', '游戏id', 'int(11) NULL ', 'string', '', '', '1', '', '42', '0', '1', '1474858375', '1474858375', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('418', 'game_appid', '游戏appid', 'varchar(32) NULL ', 'string', '', '', '1', '', '42', '0', '1', '1474858375', '1474858375', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('419', 'game_name', '游戏名称', 'varchar(30) NULL ', 'string', '', '', '1', '', '42', '0', '1', '1474858376', '1474858376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('420', 'op_id', '操作人id', 'int(11) NOT NULL ', 'string', '', '', '1', '', '42', '0', '1', '1474858376', '1474858376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('421', 'op_nickname', '操作人昵称', 'varchar(30) NULL ', 'string', '', '', '1', '', '42', '0', '1', '1474858376', '1474858376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('422', 'create_time', '添加时间', 'int(11) NULL ', 'string', '', '', '1', '', '42', '0', '1', '1474858376', '1474858376', '', '0', '', '', '', '0', '');
INSERT INTO `sys_attribute` VALUES ('423', 'type', '区分绑定平台币    1为绑定平台币补单', 'int(11) NULL ', 'string', '0', '', '1', '', '42', '0', '1', '1474858376', '1474858376', '', '0', '', '', '', '0', '');

-- ----------------------------
-- Table structure for sys_auth_extend
-- ----------------------------
DROP TABLE IF EXISTS `sys_auth_extend`;
CREATE TABLE `sys_auth_extend` (
  `group_id` mediumint(10) unsigned NOT NULL COMMENT '用户id',
  `extend_id` mediumint(8) unsigned NOT NULL COMMENT '扩展表中数据的id',
  `type` tinyint(1) unsigned NOT NULL COMMENT '扩展类型标识 1:栏目分类权限;2:模型权限',
  UNIQUE KEY `group_extend_type` (`group_id`,`extend_id`,`type`),
  KEY `uid` (`group_id`),
  KEY `group_id` (`extend_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户组与分类的对应关系表';

-- ----------------------------
-- Records of sys_auth_extend
-- ----------------------------
INSERT INTO `sys_auth_extend` VALUES ('1', '1', '1');
INSERT INTO `sys_auth_extend` VALUES ('1', '1', '2');
INSERT INTO `sys_auth_extend` VALUES ('1', '2', '1');
INSERT INTO `sys_auth_extend` VALUES ('1', '2', '2');
INSERT INTO `sys_auth_extend` VALUES ('1', '3', '1');
INSERT INTO `sys_auth_extend` VALUES ('1', '3', '2');
INSERT INTO `sys_auth_extend` VALUES ('1', '4', '1');
INSERT INTO `sys_auth_extend` VALUES ('1', '37', '1');

-- ----------------------------
-- Table structure for sys_auth_group
-- ----------------------------
DROP TABLE IF EXISTS `sys_auth_group`;
CREATE TABLE `sys_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户组id,自增主键',
  `module` varchar(20) NOT NULL DEFAULT '' COMMENT '用户组所属模块',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '组类型',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '用户组中文名称',
  `description` varchar(80) NOT NULL DEFAULT '' COMMENT '描述信息',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '用户组状态：为1正常，为0禁用,-1为删除',
  `rules` varchar(900) NOT NULL DEFAULT '' COMMENT '用户组拥有的规则id，多个规则 , 隔开',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_auth_group
-- ----------------------------
INSERT INTO `sys_auth_group` VALUES ('1', 'admin', '1', '默认用户组', '', '1', '1,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,81,82,83,84,86,87,88,89,90,91,92,93,94,95,100,102,103,107,108,109,110,195,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,297,298,299,300,301,302');
INSERT INTO `sys_auth_group` VALUES ('2', 'admin', '1', '测试用户', '测试用户', '1', '1,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,81,82,83,84,86,87,88,89,90,91,92,93,94,95,100,102,103,107,108,109,110,195,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,240,241,242,243,244,245,246,247,249,250,251,252,253,254,256,257,258,259,260,261,262,263,264,265,266,267,268,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,291,292,293,294,295,296,297,298,299,300,301,302,308,309,310,311,312,313,314,315,322,323,324,325,326,328,329,330,331,332,333,334,335,336,337,338,339,342,346,347,348,349,352,353,354');
INSERT INTO `sys_auth_group` VALUES ('3', 'admin', '1', '商务后台', '', '1', '1,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,79,80,81,82,83,84,86,87,88,89,90,91,92,93,94,95,100,102,103,107,108,109,110,195,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,240,241,242,243,244,245,246,247,249,250,251,252,253,254,256,257,258,259,260,261,262,263,264,265,266,267,268,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,291,292,293,294,295,296,297,298,299,300,301,302,308,309,310,311,312,313,314,315,322,323,324,325,326,328,329,330,331,332,333,334,335,336,337,338,339,342,344,346,347,348,349,350,351,352,353,354');

-- ----------------------------
-- Table structure for sys_auth_group_access
-- ----------------------------
DROP TABLE IF EXISTS `sys_auth_group_access`;
CREATE TABLE `sys_auth_group_access` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `group_id` mediumint(8) unsigned NOT NULL COMMENT '用户组id',
  `houtai` int(11) DEFAULT '0' COMMENT '所属后台',
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_auth_group_access
-- ----------------------------
INSERT INTO `sys_auth_group_access` VALUES ('2', '1', null);
INSERT INTO `sys_auth_group_access` VALUES ('3', '2', '0');
INSERT INTO `sys_auth_group_access` VALUES ('4', '1', '0');
INSERT INTO `sys_auth_group_access` VALUES ('5', '1', '0');
INSERT INTO `sys_auth_group_access` VALUES ('6', '2', '1');
INSERT INTO `sys_auth_group_access` VALUES ('7', '2', '1');
INSERT INTO `sys_auth_group_access` VALUES ('8', '3', '1');
INSERT INTO `sys_auth_group_access` VALUES ('9', '1', '0');
INSERT INTO `sys_auth_group_access` VALUES ('10', '1', '0');
INSERT INTO `sys_auth_group_access` VALUES ('11', '1', '0');
INSERT INTO `sys_auth_group_access` VALUES ('12', '1', '0');
INSERT INTO `sys_auth_group_access` VALUES ('13', '1', '0');
INSERT INTO `sys_auth_group_access` VALUES ('14', '1', '0');

-- ----------------------------
-- Table structure for sys_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `sys_auth_rule`;
CREATE TABLE `sys_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1-url;2-主菜单',
  `name` char(80) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识',
  `title` char(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=355 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_auth_rule
-- ----------------------------
INSERT INTO `sys_auth_rule` VALUES ('1', 'admin', '2', 'Admin/Index/index', '首页', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('2', 'admin', '2', 'Admin/Article/index', '文章', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('3', 'admin', '2', 'Admin/User/index', '用户', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('4', 'admin', '2', 'Admin/Addons/index', '扩展', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('5', 'admin', '2', 'Admin/Config/group', '系统', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('7', 'admin', '1', 'Admin/article/add', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('8', 'admin', '1', 'Admin/article/edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('9', 'admin', '1', 'Admin/article/setStatus', '改变状态', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('10', 'admin', '1', 'Admin/article/update', '保存', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('11', 'admin', '1', 'Admin/article/autoSave', '保存草稿', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('12', 'admin', '1', 'Admin/article/move', '移动', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('13', 'admin', '1', 'Admin/article/copy', '复制', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('14', 'admin', '1', 'Admin/article/paste', '粘贴', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('15', 'admin', '1', 'Admin/article/permit', '还原', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('16', 'admin', '1', 'Admin/article/clear', '清空', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('17', 'admin', '1', 'Admin/Article/examine', '审核列表', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('18', 'admin', '1', 'Admin/article/recycle', '回收站', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('19', 'admin', '1', 'Admin/User/addaction', '新增用户行为', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('20', 'admin', '1', 'Admin/User/editaction', '编辑用户行为', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('21', 'admin', '1', 'Admin/User/saveAction', '保存用户行为', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('22', 'admin', '1', 'Admin/User/setStatus', '变更行为状态', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('23', 'admin', '1', 'Admin/User/changeStatus?method=forbidUser', '禁用', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('24', 'admin', '1', 'Admin/User/changeStatus?method=resumeUser', '启用', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('25', 'admin', '1', 'Admin/User/changeStatus?method=deleteUser', '删除', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('26', 'admin', '1', 'Admin/User/index', '管理员', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('27', 'admin', '1', 'Admin/User/action', '行为文档', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('28', 'admin', '1', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('29', 'admin', '1', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('30', 'admin', '1', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('31', 'admin', '1', 'Admin/AuthManager/createGroup', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('32', 'admin', '1', 'Admin/AuthManager/editGroup', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('33', 'admin', '1', 'Admin/AuthManager/writeGroup', '保存用户组', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('34', 'admin', '1', 'Admin/AuthManager/group', '授权', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('35', 'admin', '1', 'Admin/AuthManager/access', '访问授权', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('36', 'admin', '1', 'Admin/AuthManager/user', '成员授权', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('37', 'admin', '1', 'Admin/AuthManager/removeFromGroup', '解除授权', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('38', 'admin', '1', 'Admin/AuthManager/addToGroup', '保存成员授权', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('39', 'admin', '1', 'Admin/AuthManager/category', '分类授权', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('40', 'admin', '1', 'Admin/AuthManager/addToCategory', '保存分类授权', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('41', 'admin', '1', 'Admin/AuthManager/index', '角色管理', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('42', 'admin', '1', 'Admin/Addons/create', '创建', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('43', 'admin', '1', 'Admin/Addons/checkForm', '检测创建', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('44', 'admin', '1', 'Admin/Addons/preview', '预览', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('45', 'admin', '1', 'Admin/Addons/build', '快速生成插件', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('46', 'admin', '1', 'Admin/Addons/config', '设置', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('47', 'admin', '1', 'Admin/Addons/disable', '禁用', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('48', 'admin', '1', 'Admin/Addons/enable', '启用', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('49', 'admin', '1', 'Admin/Addons/install', '安装', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('50', 'admin', '1', 'Admin/Addons/uninstall', '卸载', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('51', 'admin', '1', 'Admin/Addons/saveconfig', '更新配置', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('52', 'admin', '1', 'Admin/Addons/adminList', '插件后台列表', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('53', 'admin', '1', 'Admin/Addons/execute', 'URL方式访问插件', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('54', 'admin', '1', 'Admin/Addons/index', '插件管理', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('55', 'admin', '1', 'Admin/Addons/hooks', '钩子管理', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('56', 'admin', '1', 'Admin/model/add', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('57', 'admin', '1', 'Admin/model/edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('58', 'admin', '1', 'Admin/model/setStatus', '改变状态', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('59', 'admin', '1', 'Admin/model/update', '保存数据', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('60', 'admin', '1', 'Admin/Model/index', '模型管理', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('61', 'admin', '1', 'Admin/Config/edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('62', 'admin', '1', 'Admin/Config/del', '删除', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('63', 'admin', '1', 'Admin/Config/add', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('64', 'admin', '1', 'Admin/Config/save', '保存', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('65', 'admin', '1', 'Admin/Config/group', '网站设置', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('66', 'admin', '1', 'Admin/Config/index', '配置管理', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('67', 'admin', '1', 'Admin/Channel/add', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('68', 'admin', '1', 'Admin/Channel/edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('69', 'admin', '1', 'Admin/Channel/del', '删除', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('70', 'admin', '1', 'Admin/Channel/index', '导航管理', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('71', 'admin', '1', 'Admin/Category/edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('72', 'admin', '1', 'Admin/Category/add', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('73', 'admin', '1', 'Admin/Category/remove', '删除', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('74', 'admin', '1', 'Admin/Category/index', '分类管理', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('75', 'admin', '1', 'Admin/file/upload', '上传控件', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('76', 'admin', '1', 'Admin/file/uploadPicture', '上传图片', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('77', 'admin', '1', 'Admin/file/download', '下载', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('94', 'admin', '1', 'Admin/AuthManager/modelauth', '模型授权', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('79', 'admin', '1', 'Admin/article/batchOperate', '导入', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('80', 'admin', '1', 'Admin/Database/index?type=export', '备份数据库', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('81', 'admin', '1', 'Admin/Database/index?type=import', '还原数据库', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('82', 'admin', '1', 'Admin/Database/export', '备份', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('83', 'admin', '1', 'Admin/Database/optimize', '优化表', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('84', 'admin', '1', 'Admin/Database/repair', '修复表', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('86', 'admin', '1', 'Admin/Database/import', '恢复', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('87', 'admin', '1', 'Admin/Database/del', '删除', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('88', 'admin', '1', 'Admin/User/add', '新增用户', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('89', 'admin', '1', 'Admin/Attribute/index', '属性管理', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('90', 'admin', '1', 'Admin/Attribute/add', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('91', 'admin', '1', 'Admin/Attribute/edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('92', 'admin', '1', 'Admin/Attribute/setStatus', '改变状态', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('93', 'admin', '1', 'Admin/Attribute/update', '保存数据', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('95', 'admin', '1', 'Admin/AuthManager/addToModel', '保存模型授权', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('96', 'admin', '1', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('97', 'admin', '1', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('98', 'admin', '1', 'Admin/Config/menu', '后台菜单管理', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('99', 'admin', '1', 'Admin/Article/mydocument', '内容', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('100', 'admin', '1', 'Admin/Menu/index', '菜单管理', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('101', 'admin', '1', 'Admin/other', '其他', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('102', 'admin', '1', 'Admin/Menu/add', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('103', 'admin', '1', 'Admin/Menu/edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('104', 'admin', '1', 'Admin/Think/lists?model=article', '文章管理', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('105', 'admin', '1', 'Admin/Think/lists?model=download', '下载管理', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('106', 'admin', '1', 'Admin/Think/lists?model=config', '配置管理', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('107', 'admin', '1', 'Admin/Action/actionlog', '行为日志', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('108', 'admin', '1', 'Admin/User/updatePassword', '修改密码', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('109', 'admin', '1', 'Admin/User/updateNickname', '修改昵称', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('110', 'admin', '1', 'Admin/action/edit', '查看行为日志', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('205', 'admin', '1', 'Admin/think/add', '新增数据', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('111', 'admin', '2', 'Admin/article/index', '文档列表', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('112', 'admin', '2', 'Admin/article/add', '新增', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('113', 'admin', '2', 'Admin/article/edit', '编辑', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('114', 'admin', '2', 'Admin/article/setStatus', '改变状态', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('115', 'admin', '2', 'Admin/article/update', '保存', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('116', 'admin', '2', 'Admin/article/autoSave', '保存草稿', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('117', 'admin', '2', 'Admin/article/move', '移动', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('118', 'admin', '2', 'Admin/article/copy', '复制', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('119', 'admin', '2', 'Admin/article/paste', '粘贴', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('120', 'admin', '2', 'Admin/article/batchOperate', '导入', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('121', 'admin', '2', 'Admin/article/recycle', '回收站', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('122', 'admin', '2', 'Admin/article/permit', '还原', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('123', 'admin', '2', 'Admin/article/clear', '清空', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('124', 'admin', '2', 'Admin/User/add', '新增用户', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('125', 'admin', '2', 'Admin/User/action', '用户行为', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('126', 'admin', '2', 'Admin/User/addAction', '新增用户行为', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('127', 'admin', '2', 'Admin/User/editAction', '编辑用户行为', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('128', 'admin', '2', 'Admin/User/saveAction', '保存用户行为', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('129', 'admin', '2', 'Admin/User/setStatus', '变更行为状态', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('130', 'admin', '2', 'Admin/User/changeStatus?method=forbidUser', '禁用会员', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('131', 'admin', '2', 'Admin/User/changeStatus?method=resumeUser', '启用会员', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('132', 'admin', '2', 'Admin/User/changeStatus?method=deleteUser', '删除会员', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('133', 'admin', '2', 'Admin/AuthManager/index', '权限管理', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('134', 'admin', '2', 'Admin/AuthManager/changeStatus?method=deleteGroup', '删除', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('135', 'admin', '2', 'Admin/AuthManager/changeStatus?method=forbidGroup', '禁用', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('136', 'admin', '2', 'Admin/AuthManager/changeStatus?method=resumeGroup', '恢复', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('137', 'admin', '2', 'Admin/AuthManager/createGroup', '新增', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('138', 'admin', '2', 'Admin/AuthManager/editGroup', '编辑', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('139', 'admin', '2', 'Admin/AuthManager/writeGroup', '保存用户组', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('140', 'admin', '2', 'Admin/AuthManager/group', '授权', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('141', 'admin', '2', 'Admin/AuthManager/access', '访问授权', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('142', 'admin', '2', 'Admin/AuthManager/user', '成员授权', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('143', 'admin', '2', 'Admin/AuthManager/removeFromGroup', '解除授权', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('144', 'admin', '2', 'Admin/AuthManager/addToGroup', '保存成员授权', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('145', 'admin', '2', 'Admin/AuthManager/category', '分类授权', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('146', 'admin', '2', 'Admin/AuthManager/addToCategory', '保存分类授权', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('147', 'admin', '2', 'Admin/AuthManager/modelauth', '模型授权', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('148', 'admin', '2', 'Admin/AuthManager/addToModel', '保存模型授权', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('149', 'admin', '2', 'Admin/Addons/create', '创建', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('150', 'admin', '2', 'Admin/Addons/checkForm', '检测创建', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('151', 'admin', '2', 'Admin/Addons/preview', '预览', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('152', 'admin', '2', 'Admin/Addons/build', '快速生成插件', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('153', 'admin', '2', 'Admin/Addons/config', '设置', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('154', 'admin', '2', 'Admin/Addons/disable', '禁用', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('155', 'admin', '2', 'Admin/Addons/enable', '启用', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('156', 'admin', '2', 'Admin/Addons/install', '安装', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('157', 'admin', '2', 'Admin/Addons/uninstall', '卸载', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('158', 'admin', '2', 'Admin/Addons/saveconfig', '更新配置', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('159', 'admin', '2', 'Admin/Addons/adminList', '插件后台列表', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('160', 'admin', '2', 'Admin/Addons/execute', 'URL方式访问插件', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('161', 'admin', '2', 'Admin/Addons/hooks', '钩子管理', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('162', 'admin', '2', 'Admin/Model/index', '模型管理', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('163', 'admin', '2', 'Admin/model/add', '新增', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('164', 'admin', '2', 'Admin/model/edit', '编辑', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('165', 'admin', '2', 'Admin/model/setStatus', '改变状态', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('166', 'admin', '2', 'Admin/model/update', '保存数据', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('167', 'admin', '2', 'Admin/Attribute/index', '属性管理', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('168', 'admin', '2', 'Admin/Attribute/add', '新增', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('169', 'admin', '2', 'Admin/Attribute/edit', '编辑', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('170', 'admin', '2', 'Admin/Attribute/setStatus', '改变状态', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('171', 'admin', '2', 'Admin/Attribute/update', '保存数据', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('172', 'admin', '2', 'Admin/Config/index', '配置管理', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('173', 'admin', '2', 'Admin/Config/edit', '编辑', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('174', 'admin', '2', 'Admin/Config/del', '删除', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('175', 'admin', '2', 'Admin/Config/add', '新增', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('176', 'admin', '2', 'Admin/Config/save', '保存', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('177', 'admin', '2', 'Admin/Menu/index', '菜单管理', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('178', 'admin', '2', 'Admin/Channel/index', '导航管理', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('179', 'admin', '2', 'Admin/Channel/add', '新增', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('180', 'admin', '2', 'Admin/Channel/edit', '编辑', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('181', 'admin', '2', 'Admin/Channel/del', '删除', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('182', 'admin', '2', 'Admin/Category/index', '分类管理', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('183', 'admin', '2', 'Admin/Category/edit', '编辑', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('184', 'admin', '2', 'Admin/Category/add', '新增', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('185', 'admin', '2', 'Admin/Category/remove', '删除', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('186', 'admin', '2', 'Admin/Category/move', '移动', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('187', 'admin', '2', 'Admin/Category/merge', '合并', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('188', 'admin', '2', 'Admin/Database/index?type=export', '备份数据库', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('189', 'admin', '2', 'Admin/Database/export', '备份', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('190', 'admin', '2', 'Admin/Database/optimize', '优化表', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('191', 'admin', '2', 'Admin/Database/repair', '修复表', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('192', 'admin', '2', 'Admin/Database/index?type=import', '还原数据库', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('193', 'admin', '2', 'Admin/Database/import', '恢复', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('194', 'admin', '2', 'Admin/Database/del', '删除', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('195', 'admin', '2', 'Admin/other', '其他', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('196', 'admin', '2', 'Admin/Menu/add', '新增', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('197', 'admin', '2', 'Admin/Menu/edit', '编辑', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('198', 'admin', '2', 'Admin/Think/lists?model=article', '应用', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('199', 'admin', '2', 'Admin/Think/lists?model=download', '下载管理', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('200', 'admin', '2', 'Admin/Think/lists?model=config', '应用', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('201', 'admin', '2', 'Admin/Action/actionlog', '行为日志', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('202', 'admin', '2', 'Admin/User/updatePassword', '修改密码', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('203', 'admin', '2', 'Admin/User/updateNickname', '修改昵称', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('204', 'admin', '2', 'Admin/action/edit', '查看行为日志', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('206', 'admin', '1', 'Admin/think/edit', '编辑数据', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('207', 'admin', '1', 'Admin/Menu/import', '导入', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('208', 'admin', '1', 'Admin/Model/generate', '生成', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('209', 'admin', '1', 'Admin/Addons/addHook', '新增钩子', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('210', 'admin', '1', 'Admin/Addons/edithook', '编辑钩子', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('211', 'admin', '1', 'Admin/Article/sort', '文档排序', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('212', 'admin', '1', 'Admin/Config/sort', '排序', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('213', 'admin', '1', 'Admin/Menu/sort', '排序', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('214', 'admin', '1', 'Admin/Channel/sort', '排序', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('215', 'admin', '1', 'Admin/Category/operate/type/move', '移动', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('216', 'admin', '1', 'Admin/Category/operate/type/merge', '合并', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('217', 'admin', '1', 'Admin/article/index', '文档列表', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('218', 'admin', '1', 'Admin/think/lists', '数据列表', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('219', 'admin', '1', 'Admin/Game/add', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('220', 'admin', '1', 'Admin/Game/edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('221', 'admin', '1', 'Admin/GameType/add', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('222', 'admin', '1', 'Admin/GameType/edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('223', 'admin', '1', 'Admin/Server/add', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('224', 'admin', '1', 'Admin/Server/edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('225', 'admin', '1', 'Admin/Giftbag/add', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('226', 'admin', '1', 'Admin/Giftbag/edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('227', 'admin', '1', 'Admin/Promote/add', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('228', 'admin', '1', 'Admin/Promote/edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('229', 'admin', '1', 'Admin/Adv/edit_media_adv_pos', '编辑媒体广告位', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('230', 'admin', '1', 'Admin/Adv/edit_app_adv_pos', '编辑app广告位', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('231', 'admin', '1', 'Admin/Adv/media_adv_lists', '媒体广告列表', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('232', 'admin', '1', 'Admin/Adv/edit_media_adv', '编辑媒体广告', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('233', 'admin', '1', 'Admin/Adv/add_media_adv', '新增媒体广告', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('234', 'admin', '1', 'Admin/Adv/app_adv_lists', 'app广告列表', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('235', 'admin', '1', 'Admin/Adv/add_app_adv', '新增app广告', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('236', 'admin', '1', 'Admin/Adv/edit_app_adv', '编辑app广告', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('237', 'admin', '1', 'Admin/Adv/edit_adv', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('238', 'admin', '1', 'Admin/GameSource/add', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('239', 'admin', '1', 'Admin/GameSource/edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('240', 'admin', '1', 'Admin/Mend/edit', '渠道补链', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('241', 'admin', '1', 'Admin/Game/lists', '游戏管理', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('242', 'admin', '1', 'Admin/Promote/lists', '渠道管理', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('243', 'admin', '1', 'Admin/Site/media', '基本配置', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('244', 'admin', '1', 'Admin/Stat/daily', '日常统计', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('245', 'admin', '1', 'Admin/GameType/lists', '游戏分类', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('246', 'admin', '1', 'Admin/Mend/lists', '渠道补链', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('247', 'admin', '1', 'Admin/Adv/media_adv_pos_lists', '广告管理', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('248', 'admin', '1', 'Admin/#', '代充额度', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('249', 'admin', '1', 'Admin/Server/lists', '游戏区服', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('250', 'admin', '1', 'Admin/Mend/record', '补链记录', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('251', 'admin', '1', 'Admin/Logo/media_logo', '图标设置', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('252', 'admin', '2', 'Admin/Game/lists', '游戏', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('253', 'admin', '1', 'Admin/Promote/ch_reg_list', '渠道注册', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('254', 'admin', '1', 'Admin/Site/app', '基本配置', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('255', 'admin', '1', 'Admin/GameSource/lists', '游戏原包', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('256', 'admin', '1', 'Admin/Giftbag/lists', '礼包管理', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('257', 'admin', '2', 'Admin/Promote/lists', '渠道', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('258', 'admin', '1', 'Admin/Adv/app_adv_pos_lists', '广告管理', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('259', 'admin', '1', 'Admin/Giftbag/record', '领取记录', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('260', 'admin', '1', 'Admin/Promote/spend_list', '渠道充值', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('261', 'admin', '2', 'Admin/Site/media', '站点', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('262', 'admin', '1', 'Admin/Adv/adv_lists', '广告列表', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('263', 'admin', '1', 'Admin/Member/user_info', '平台用户', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('264', 'admin', '2', 'Admin/Stat/daily', '统计', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('265', 'admin', '1', 'Admin/Logo/app_logo', '图标设置', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('266', 'admin', '1', 'Admin/Tool/smsset', '短信设置', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('267', 'admin', '1', 'Admin/Member/login_record', '登陆记录', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('268', 'admin', '1', 'Admin/Site/channel', '基本配置', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('269', 'admin', '1', 'Admin/Tool/storage', '文件存储', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('270', 'admin', '1', 'Admin/Spend/lists', '游戏消费记录', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('271', 'admin', '1', 'Admin/Logo/channel_logo', '图标设置', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('272', 'admin', '1', 'Admin/Tool/payset', '支付设置', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('273', 'admin', '1', 'Admin/Deposit/lists', '平台币充值记录', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('274', 'admin', '1', 'Admin/Tool/email', '邮件设置', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('275', 'admin', '1', 'Admin/Provide/lists', '后台充值记录', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('276', 'admin', '1', 'Admin/Tool/thirdparty', '第三方登陆', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('277', 'admin', '1', 'Admin/BindSpend/lists', '绑币使用记录', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('278', 'admin', '1', 'Admin/Member/edit', '用户编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('279', 'admin', '1', 'Admin/Apply/edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('280', 'admin', '1', 'Admin/Query/withdraw_add', '提现添加', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('281', 'admin', '1', 'Admin/Provide/bdfirstpay', '后台充值', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('282', 'admin', '1', 'Admin/GiftbagType/add', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('283', 'admin', '1', 'Admin/Links/add', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('284', 'admin', '1', 'Admin/Links/edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('285', 'admin', '1', 'Admin/GiftbagType/edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('286', 'admin', '1', 'Admin/stat/pay_way', '来款统计', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('287', 'admin', '1', 'Admin/stat/cpa_login', '登陆统计', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('288', 'admin', '1', 'Admin/stat/cpa_register', '注册统计', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('289', 'admin', '1', 'Admin/Apply/lists', '分包管理', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('290', 'admin', '1', 'Admin/Links/lists', '友情链接', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('291', 'admin', '1', 'Admin/stat/cpa_spend', '消费统计', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('292', 'admin', '1', 'Admin/stat/userretention', '留存统计', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('293', 'admin', '1', 'Admin/Promote/agent_list', '代充记录', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('294', 'admin', '1', 'Admin/stat/userarpu', 'ARPU统计', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('295', 'admin', '1', 'Admin/GiftbagType/lists', '礼包类型', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('296', 'admin', '1', 'Admin/Query/bill', '渠道对账', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('297', 'admin', '1', 'Admin/Query/settlement', '渠道结算', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('298', 'admin', '1', 'Admin/Query/withdraw', '渠道提现', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('299', 'admin', '1', 'Admin/Promote/pay_limit_add', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('300', 'admin', '1', 'Admin/Promote/pay_limit_edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('301', 'admin', '2', 'Admin/Article/mydocument', '文章', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('302', 'admin', '1', 'Admin/Promote/pay_limit', '代充额度', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('303', 'admin', '1', 'Admin/Links/lists/mark/1', '友情链接', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('304', 'admin', '1', 'Admin/Game/addopen', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('305', 'admin', '1', 'Admin/Game/editopen/', '编辑', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('306', 'admin', '1', 'Admin/Game/openlist', '开放类型', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('307', 'admin', '1', 'Admin/Links/lists/mark/0', '友情链接', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('308', 'admin', '1', 'Admin/Message/wrong', '纠错管理', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('309', 'admin', '1', 'Admin/Opentype/lists', '开放类型', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('310', 'admin', '1', 'Admin/Opentype/edit', '修改', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('311', 'admin', '1', 'Admin/Opentype/add', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('312', 'admin', '1', 'Admin/Rebate/lists', '返利设置', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('313', 'admin', '1', 'Admin/Rebatelist/lists', '游戏返利', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('314', 'admin', '1', 'Admin/Rebate/add', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('315', 'admin', '1', 'Admin/Rebate/edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('316', 'admin', '1', 'Admin/Push/pushsetlsit', '推送设置', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('317', 'admin', '1', 'Admin/Push/pushlist', '发送通知', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('318', 'admin', '1', 'Admin/Push/add', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('319', 'admin', '1', 'Admin/push/add_list', '新增', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('320', 'admin', '1', 'Admin/push/edit_list', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('321', 'admin', '1', 'Admin/Push/edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('322', 'admin', '1', 'Admin/Apply/package', '打包', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('323', 'admin', '1', 'Admin/Apply/set_status', '审核', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('324', 'admin', '1', 'Admin/GameType/set_status', '启用/禁用', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('325', 'admin', '1', 'Admin/Message/set_status', '修复', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('326', 'admin', '1', 'Admin/Rebatelist/del', '删除', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('327', 'admin', '1', 'Admin/Links/lists/remark/ch', '友情链接', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('328', 'admin', '1', 'Admin/Action/clear', '清除', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('329', 'admin', '1', 'Admin/Action/remove', '删除', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('330', 'admin', '1', 'Admin/Member/delprovide', '删除', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('331', 'admin', '1', 'Admin/Provide/batch', '充值', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('332', 'admin', '1', 'Admin/Provide/delprovide', '删除', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('333', 'admin', '1', 'Admin/Game/del', '删除', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('334', 'admin', '1', 'Admin/Game/sort', '排序', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('335', 'admin', '1', 'Admin/Game/set_status', '推荐/不推荐', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('336', 'admin', '1', 'Admin/Promote/set_status', '启用', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('337', 'admin', '1', 'Admin/Query/settl', '结算', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('338', 'admin', '1', 'Admin/Links/del', '删除', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('339', 'admin', '1', 'Admin/Adv/del_adv', '删除', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('340', 'admin', '1', 'Admin/Game/editopen', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('341', 'admin', '1', 'Admin/Links/lists/remark/pc', '友情链接', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('342', 'admin', '1', 'Admin/Wechat/index', '公众号设置', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('343', 'admin', '1', 'Admin/File/shard_upload', '想', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('344', 'admin', '1', 'Admin/User/edit', '编辑', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('345', 'admin', '1', 'Admin/Member/del', '删除', '-1', '');
INSERT INTO `sys_auth_rule` VALUES ('346', 'admin', '1', 'Admin/Member/bind_balance', '绑定平台余额查看', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('347', 'admin', '1', 'Admin/Member/chax', '充值记录查看', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('348', 'admin', '1', 'Admin/Member/denglu', '游戏登录记录', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('349', 'admin', '1', 'Admin/Server/del', '删除', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('350', 'admin', '1', 'Admin/Giftbag/del', '删除', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('351', 'admin', '1', 'Admin/Rebate/del', '删除', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('352', 'admin', '1', 'Admin/Apply/del', '删除', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('353', 'admin', '1', 'Admin/Links/chlists', '友情链接', '1', '');
INSERT INTO `sys_auth_rule` VALUES ('354', 'admin', '1', 'Admin/Links/pclists', 'PC友情链接', '1', '');

-- ----------------------------
-- Table structure for sys_category
-- ----------------------------
DROP TABLE IF EXISTS `sys_category`;
CREATE TABLE `sys_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(30) NOT NULL COMMENT '标志',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `list_row` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '列表每页行数',
  `meta_title` varchar(50) NOT NULL DEFAULT '' COMMENT 'SEO的网页标题',
  `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `template_index` varchar(100) NOT NULL DEFAULT '' COMMENT '频道页模板',
  `template_lists` varchar(100) NOT NULL DEFAULT '' COMMENT '列表页模板',
  `template_detail` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑页模板',
  `model` varchar(100) NOT NULL DEFAULT '' COMMENT '列表绑定模型',
  `model_sub` varchar(100) NOT NULL DEFAULT '' COMMENT '子文档绑定模型',
  `type` varchar(100) NOT NULL DEFAULT '' COMMENT '允许发布的内容类型',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `allow_publish` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许发布内容',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '可见性',
  `reply` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否允许回复',
  `check` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发布的文章是否需要审核',
  `reply_model` varchar(100) NOT NULL DEFAULT '',
  `extend` text COMMENT '扩展设置',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  `icon` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '分类图标',
  `groups` varchar(255) NOT NULL DEFAULT '' COMMENT '分组定义',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COMMENT='分类表';

-- ----------------------------
-- Records of sys_category
-- ----------------------------
-- INSERT INTO `sys_category` VALUES ('1', 'blog', '渠道站', '0', '0', '10', '', '', '', '', '', '', '', '2,3', '2', '2,1', '0', '0', '1', '0', '0', '1', '', '1379474947', '1464794659', '1', '0', '');
INSERT INTO `sys_category` VALUES ('2', 'tui_gg', '游戏公告', '1', '1', '10', '', '', '', '', '', '', '', '2', '2', '2,1,3', '0', '1', '1', '0', '1', '1', '', '1379475028', '1472692924', '1', '0', '');
INSERT INTO `sys_category` VALUES ('39', 'tui_zx', '游戏资讯', '1', '1', '10', '', '', '', '', '', '', '', '2', '2', '2', '0', '1', '1', '0', '0', '', null, '1464794769', '1464794833', '1', '0', '');
INSERT INTO `sys_category` VALUES ('40', 'tui_about', '关于我们', '1', '3', '10', '', '', '', '', '', '', '', '2', '2', '2', '0', '1', '1', '0', '0', '', null, '1464794803', '1472692452', '1', '0', '');
INSERT INTO `sys_category` VALUES ('41', 'media', '媒体站', '0', '1', '10', '', '', '', '', '', '', '', '2', '2', '2,1', '0', '1', '1', '0', '0', '', null, '1464826817', '1464827190', '1', '0', '');
INSERT INTO `sys_category` VALUES ('42', 'media_gg', '游戏公告', '41', '6', '10', '', '', '', '', '', '', '', '2', '2', '2', '0', '1', '1', '0', '0', '', null, '1464826928', '1464827209', '1', '0', '');
INSERT INTO `sys_category` VALUES ('43', 'media_new', '游戏新闻', '41', '5', '10', '', '', '', '', '', '', '', '2', '2', '2', '0', '1', '1', '0', '0', '', null, '1464826955', '1464827207', '1', '0', '');
INSERT INTO `sys_category` VALUES ('44', 'media_activity', '游戏活动', '41', '4', '10', '', '', '', '', '', '', '', '2', '2', '2', '0', '1', '1', '0', '0', '', null, '1464827047', '1464827205', '1', '0', '');
INSERT INTO `sys_category` VALUES ('45', 'media_partner', '合作伙伴', '41', '3', '10', '', '', '', '', '', '', '', '2', '2', '2', '0', '1', '1', '0', '0', '', null, '1464827079', '1464827202', '1', '0', '');
INSERT INTO `sys_category` VALUES ('46', 'media_collaborate', '商务合作', '41', '2', '10', '', '', '', '', '', '', '', '2', '2', '2', '0', '1', '1', '0', '0', '', null, '1464827119', '1464827200', '1', '0', '');
INSERT INTO `sys_category` VALUES ('47', 'media_about', '关于我们', '41', '1', '10', '', '', '', '', '', '', '', '2', '2', '2', '0', '1', '1', '0', '0', '', null, '1464827148', '1464827198', '1', '0', '');
INSERT INTO `sys_category` VALUES ('48', 'media_supervise', '家长监督', '41', '7', '10', '', '', '', '', '', '', '', '2', '2', '2', '0', '1', '0', '0', '0', '', null, '1464827180', '1476191257', '1', '0', '');
INSERT INTO `sys_category` VALUES ('49', 'agreement', '用户注册协议', '41', '8', '10', '', '', '', '', '', '', '', '2', '2', '2', '0', '1', '1', '0', '0', '', '', '1471255674', '1471258925', '1', '0', '');
INSERT INTO `sys_category` VALUES ('51', 'rule', '用户协议', '1', '4', '10', '', '', '', '', '', '', '', '2', '2', '2', '0', '1', '1', '0', '0', '', null, '1471413253', '1471413283', '1', '0', '');

-- ----------------------------
-- Table structure for sys_channel
-- ----------------------------
DROP TABLE IF EXISTS `sys_channel`;
CREATE TABLE `sys_channel` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '频道ID',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级频道ID',
  `title` char(30) NOT NULL COMMENT '频道标题',
  `url` char(100) NOT NULL COMMENT '频道连接',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '导航排序',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `target` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '新窗口打开',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_channel
-- ----------------------------
INSERT INTO `sys_channel` VALUES ('1', '0', '首页', 'Index/index', '3', '1379475111', '1379923177', '1', '0');
INSERT INTO `sys_channel` VALUES ('2', '0', '游戏公告', 'Article/lists?category=tui_gg', '2', '1379475131', '1464830131', '1', '0');
INSERT INTO `sys_channel` VALUES ('3', '0', '游戏资讯', 'Article/lists?category=tui_zx', '1', '1379475154', '1464830178', '1', '0');
INSERT INTO `sys_channel` VALUES ('4', '0', '关于我们', 'Article/detail?id=6', '0', '1466730873', '1466733900', '1', '0');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `name` varchar(30) NOT NULL DEFAULT '' COMMENT '配置名称',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '配置说明',
  `category` tinyint(3) NOT NULL COMMENT '配置分类',
  `group` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置分组',
  `extra` varchar(255) NOT NULL DEFAULT '' COMMENT '配置值',
  `remark` varchar(100) NOT NULL DEFAULT '' COMMENT '配置说明',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `value` text COMMENT '配置值',
  `sort` smallint(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`),
  KEY `type` (`type`),
  KEY `group` (`group`)
) ENGINE=MyISAM AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('1', 'WEB_SITE_TITLE', '1', '网站标题', '0', '1', '', '网站标题前台显示标题', '1378898976', '1379235274', '1', '溪谷H5后台', '0');
INSERT INTO `sys_config` VALUES ('2', 'WEB_SITE_DESCRIPTION', '2', '网站描述', '0', '1', '', '网站搜索引擎描述', '1378898976', '1379235841', '1', 'H5系统管理中心', '1');
INSERT INTO `sys_config` VALUES ('3', 'WEB_SITE_KEYWORD', '2', '网站关键字', '0', '1', '', '网站搜索引擎关键字', '1378898976', '1381390100', '1', '', '8');
INSERT INTO `sys_config` VALUES ('4', 'WEB_SITE_CLOSE', '4', '关闭站点', '0', '1', '0:关闭,1:开启', '站点关闭后其他用户不能访问，管理员可以正常访问', '1378898976', '1379235296', '1', '1', '1');
INSERT INTO `sys_config` VALUES ('9', 'CONFIG_TYPE_LIST', '3', '配置类型列表', '0', '4', '', '主要用于数据解析和页面表单的生成', '1378898976', '1464137919', '1', '0:数字\r\n1:字符\r\n2:文本\r\n3:数组\r\n4:枚举\r\n5:图片', '2');
INSERT INTO `sys_config` VALUES ('10', 'WEB_SITE_ICP', '1', '网站备案号', '0', '1', '', '工业与信息化部备案', '1378900335', '1465029319', '1', '', '9');
INSERT INTO `sys_config` VALUES ('11', 'DOCUMENT_POSITION', '3', '文档推荐位', '0', '2', '', '文档推荐位，推荐到多个位置KEY值相加即可', '1379053380', '1379235329', '1', '1:列表推荐\r\n2:频道推荐\r\n4:首页推荐', '3');
INSERT INTO `sys_config` VALUES ('12', 'DOCUMENT_DISPLAY', '3', '文档可见性', '0', '2', '', '文章可见性仅影响前台显示，后台不收影响', '1379056370', '1379235322', '1', '0:所有人可见\r\n1:仅注册会员可见\r\n2:仅管理员可见', '4');
INSERT INTO `sys_config` VALUES ('13', 'COLOR_STYLE', '4', '后台色系', '0', '1', 'default_color:默认\r\nblue_color:紫罗兰', '后台颜色风格', '1379122533', '1379235904', '1', 'default_color', '10');
INSERT INTO `sys_config` VALUES ('20', 'CONFIG_GROUP_LIST', '3', '配置分组', '0', '4', '', '配置分组', '1379228036', '1384418383', '1', '1:基本\r\n2:内容\r\n3:用户\r\n4:系统', '4');
INSERT INTO `sys_config` VALUES ('21', 'HOOKS_TYPE', '3', '钩子的类型', '0', '4', '', '类型 1-用于扩展显示内容，2-用于扩展业务处理', '1379313397', '1379313407', '1', '1:视图\r\n2:控制器', '6');
INSERT INTO `sys_config` VALUES ('22', 'AUTH_CONFIG', '3', 'Auth配置', '0', '4', '', '自定义Auth.class.php类配置', '1379409310', '1379409564', '1', 'AUTH_ON:1\r\nAUTH_TYPE:2', '8');
INSERT INTO `sys_config` VALUES ('23', 'OPEN_DRAFTBOX', '4', '是否开启草稿功能', '0', '2', '0:关闭草稿功能\r\n1:开启草稿功能\r\n', '新增文章时的草稿功能配置', '1379484332', '1379484591', '1', '1', '1');
INSERT INTO `sys_config` VALUES ('24', 'DRAFT_AOTOSAVE_INTERVAL', '0', '自动保存草稿时间', '0', '2', '', '自动保存草稿的时间间隔，单位：秒', '1379484574', '1386143323', '1', '60', '2');
INSERT INTO `sys_config` VALUES ('25', 'LIST_ROWS', '0', '后台每页记录数', '0', '2', '', '后台数据每页显示记录数', '1379503896', '1380427745', '1', '15', '10');
INSERT INTO `sys_config` VALUES ('26', 'USER_ALLOW_REGISTER', '4', '是否允许用户注册', '0', '3', '0:关闭注册\r\n1:允许注册', '是否开放用户注册', '1379504487', '1379504580', '1', '1', '3');
INSERT INTO `sys_config` VALUES ('27', 'CODEMIRROR_THEME', '4', '预览插件的CodeMirror主题', '0', '4', '3024-day:3024 day\r\n3024-night:3024 night\r\nambiance:ambiance\r\nbase16-dark:base16 dark\r\nbase16-light:base16 light\r\nblackboard:blackboard\r\ncobalt:cobalt\r\neclipse:eclipse\r\nelegant:elegant\r\nerlang-dark:erlang-dark\r\nlesser-dark:lesser-dark\r\nmidnight:midnight', '详情见CodeMirror官网', '1379814385', '1384740813', '1', 'ambiance', '3');
INSERT INTO `sys_config` VALUES ('28', 'DATA_BACKUP_PATH', '1', '数据库备份根路径', '0', '4', '', '路径必须以 / 结尾', '1381482411', '1381482411', '1', './Data/', '5');
INSERT INTO `sys_config` VALUES ('29', 'DATA_BACKUP_PART_SIZE', '0', '数据库备份卷大小', '0', '4', '', '该值用于限制压缩后的分卷最大长度。单位：B；建议设置20M', '1381482488', '1381729564', '1', '20971520', '7');
INSERT INTO `sys_config` VALUES ('30', 'DATA_BACKUP_COMPRESS', '4', '数据库备份文件是否启用压缩', '0', '4', '0:不压缩\r\n1:启用压缩', '压缩备份文件需要PHP环境支持gzopen,gzwrite函数', '1381713345', '1381729544', '1', '1', '9');
INSERT INTO `sys_config` VALUES ('31', 'DATA_BACKUP_COMPRESS_LEVEL', '4', '数据库备份文件压缩级别', '0', '4', '1:普通\r\n4:一般\r\n9:最高', '数据库备份文件的压缩级别，该配置在开启压缩时生效', '1381713408', '1381713408', '1', '9', '10');
INSERT INTO `sys_config` VALUES ('32', 'DEVELOP_MODE', '4', '开启开发者模式', '0', '4', '0:关闭\r\n1:开启', '是否开启开发者模式', '1383105995', '1383291877', '1', '1', '11');
INSERT INTO `sys_config` VALUES ('33', 'ALLOW_VISIT', '3', '不受限控制器方法', '0', '0', '', '', '1386644047', '1386644741', '1', '0:article/draftbox\r\n1:article/mydocument\r\n2:Category/tree\r\n3:Index/verify\r\n4:file/upload\r\n5:file/download\r\n6:user/updatePassword\r\n7:user/updateNickname\r\n8:user/submitPassword\r\n9:user/submitNickname\r\n10:file/uploadpicture', '0');
INSERT INTO `sys_config` VALUES ('34', 'DENY_VISIT', '3', '超管专限控制器方法', '0', '0', '', '仅超级管理员可访问的控制器方法', '1386644141', '1386644659', '1', '0:Addons/addhook\r\n1:Addons/edithook\r\n2:Addons/delhook\r\n3:Addons/updateHook\r\n4:Admin/getMenus\r\n5:Admin/recordList\r\n6:AuthManager/updateRules\r\n7:AuthManager/tree', '0');
INSERT INTO `sys_config` VALUES ('36', 'ADMIN_ALLOW_IP', '2', '后台允许访问IP', '0', '4', '', '多个用逗号分隔，如果不配置表示不限制IP访问', '1387165454', '1387165553', '1', '', '12');
INSERT INTO `sys_config` VALUES ('37', 'SHOW_PAGE_TRACE', '4', '是否显示页面Trace', '0', '4', '0:关闭\r\n1:开启', '是否显示页面Trace信息', '1387165685', '1387165685', '1', '0', '1');
INSERT INTO `sys_config` VALUES ('38', 'PC_SET_TITLE', '1', '媒体官网标题设置', '1', '1', '哈哈', '用于显示媒体官网标题', '1464056166', '1474457288', '1', 'H5游戏', '0');
INSERT INTO `sys_config` VALUES ('39', 'CONFIG_CATEGORY_LIST', '3', '配置分组', '0', '4', '', '设置分组', '1464057350', '1464075821', '1', '1:媒体官网\r\n2:渠道官网\r\n3:APP设置\r\n4:管理后台', '0');
INSERT INTO `sys_config` VALUES ('40', 'PC_SET_META_KEY', '1', '媒体网站关键词设置', '1', '1', '', '网站关键词', '1464073412', '1464073714', '1', '溪谷 H5', '1');
INSERT INTO `sys_config` VALUES ('41', 'PC_SET_META_DESC', '2', '媒体网站描述设置', '1', '1', '', '网站描述', '1464073618', '1464073728', '1', '推广联盟_推广联盟中心', '2');
INSERT INTO `sys_config` VALUES ('42', 'PC_SET_COPYRIGHT', '2', '媒体官网版权信息设置', '1', '1', '', '媒体官网版权信息设置', '1464074257', '1464074463', '1', '© 徐州梦创信息科技有限公司 版权所有 2016 vlcms.com', '3');
INSERT INTO `sys_config` VALUES ('43', 'PC_SET_LICENSE', '1', '网络文化经营许可证编号', '1', '1', '', '网络文化经营许可证编号', '1464074566', '1464074566', '1', '201603210825', '1');
INSERT INTO `sys_config` VALUES ('44', 'PC_SET_FOR_THE_RECORD', '1', '网站备案号', '1', '1', '', '工业与信息化部备案', '1464074923', '1465029306', '1', '苏ICP备15062631号-1', '1');
INSERT INTO `sys_config` VALUES ('45', 'PC_SET_SERVER_TEL', '1', '客服电话', '1', '2', '', '客服联系电话或手机', '1464075195', '1464075195', '1', '0516-83463372', '0');
INSERT INTO `sys_config` VALUES ('46', 'PC_SET_SERVER_QQ', '1', '客服QQ', '1', '2', '', '客服QQ', '1464075627', '1464075647', '1', '97471547', '0');
INSERT INTO `sys_config` VALUES ('47', 'PC_SET_SERVER_EMAIL', '1', '客服邮箱', '1', '2', '', '客服邮箱', '1464075697', '1464075750', '1', '836333669@qq.com', '0');
INSERT INTO `sys_config` VALUES ('48', 'CH_SET_META_KEY', '1', '媒体网站关键词设置', '2', '1', '', '网站关键词', '1464073412', '1464073714', '1', '溪谷 H5', '1');
INSERT INTO `sys_config` VALUES ('49', 'CH_SET_META_DESC', '2', '媒体网站描述设置', '2', '1', '', '网站描述', '1464073618', '1464073728', '1', '推广联盟_推广联盟中心', '2');
INSERT INTO `sys_config` VALUES ('50', 'CH_SET_COPYRIGHT', '2', '媒体官网版权信息设置', '2', '1', '', '媒体官网版权信息设置', '1464074257', '1464074463', '1', '© 徐州梦创信息科技有限公司 版权所有 2016 vlcms.com', '3');
INSERT INTO `sys_config` VALUES ('51', 'CH_SET_LICENSE', '1', '网络文化经营许可证编号', '2', '1', '', '网络文化经营许可证编号', '1464074566', '1464074566', '1', '32132132132', '1');
INSERT INTO `sys_config` VALUES ('52', 'CH_SET_FOR_THE_RECORD', '1', '网站备案号', '2', '1', '', '工业与信息化部备案', '1464074923', '1465029259', '1', '苏ICP备15062631号-3', '1');
INSERT INTO `sys_config` VALUES ('53', 'CH_SET_SERVER_TEL', '1', '客服电话', '2', '2', '', '客服联系电话或手机', '1464075195', '1464075195', '1', '0516-83463372', '0');
INSERT INTO `sys_config` VALUES ('54', 'CH_SET_SERVER_QQ', '1', '客服QQ', '2', '2', '', '客服QQ', '1464075627', '1464075647', '1', '97471547', '0');
INSERT INTO `sys_config` VALUES ('55', 'CH_SET_SERVER_EMAIL', '1', '客服邮箱', '2', '2', '', '客服邮箱', '1464075697', '1464075750', '1', '836333669@qq.com', '0');
INSERT INTO `sys_config` VALUES ('56', 'PC_SET_LOGO', '5', '媒体网站logo', '1', '0', '', '190px * 60px', '1464137707', '1465810704', '1', '30', '0');
INSERT INTO `sys_config` VALUES ('57', 'PC_SET_QRCODE', '5', '设置媒体官网二维码', '1', '0', '', '设置媒体官网二维码 430px * 430px', '1464148155', '1465810731', '1', '31', '0');
INSERT INTO `sys_config` VALUES ('58', 'PC_SET_ICO', '5', '设置媒体官网ico图标', '1', '0', '', '设置媒体官网ico图标，16px * 16px', '1464148189', '1465810764', '1', '36', '0');
INSERT INTO `sys_config` VALUES ('59', 'CH_SET_LOGO', '5', '渠道LOGO设置', '2', '0', '', '248px * 60px', '1464157183', '1465810537', '1', '35', '0');
INSERT INTO `sys_config` VALUES ('60', 'CH_SET_QRCODE', '5', '设置渠道官网二维码', '2', '0', '', '430px * 430px', '1464157237', '1465810575', '0', '', '0');
INSERT INTO `sys_config` VALUES ('61', 'CH_SET_ICO', '5', '设置渠道官网ico图标', '2', '0', '', '请上传后缀为.ico的图标，16px * 16px', '1464157295', '1465810640', '1', '34', '0');
INSERT INTO `sys_config` VALUES ('62', 'APP_SET_COVER', '5', '设置APP开机画面', '3', '0', '', '用户手机APP的初始画面', '1464157375', '1464157691', '1', '88', '0');
INSERT INTO `sys_config` VALUES ('63', 'CH_SET_TITLE', '1', '渠道官网标题', '2', '1', '', '渠道官网标题', '1464339818', '1464339818', '1', '推广联盟', '0');
INSERT INTO `sys_config` VALUES ('64', 'PC_WORK_TIME', '1', '工作时间', '1', '2', '', '工作时间', '1465216166', '1465216263', '1', '8:30-20:00', '3');
INSERT INTO `sys_config` VALUES ('65', 'PC_T_EMAIL', '1', '投诉邮箱', '1', '2', '', '投诉邮箱', '1465216195', '1465216255', '1', '836333669@qq.com', '4');
INSERT INTO `sys_config` VALUES ('66', 'CH_SET_ADDRESS', '1', '公司地址', '2', '2', '', '公司办公地址', '1465724290', '1465724290', '1', '徐州', '0');
INSERT INTO `sys_config` VALUES ('67', 'SITE_ICO', '5', '后台网址ico图标', '0', '1', '', '后台网址ico图标，16px * 16px', '1465785677', '1465868164', '1', '28', '3');
INSERT INTO `sys_config` VALUES ('68', 'HT_LOGO', '5', '后台LOGO', '0', '1', '', '后台LOGO，184px * 49px', '1465785711', '1465868114', '1', '29', '4');
INSERT INTO `sys_config` VALUES ('69', 'APP_QQ_GROUP', '0', '官方玩家群', '3', '1', '', '官方玩家群', '1466139794', '1466495929', '1', '454978038', '0');
INSERT INTO `sys_config` VALUES ('70', 'APP_NETWORK', '1', 'PC官网地址', '3', '1', '', 'PC官网地址', '1466140005', '1466495991', '1', 'http://www.vlcms.com/', '0');
INSERT INTO `sys_config` VALUES ('71', 'APP_QQ', '0', '客服QQ号', '3', '1', '', '客服QQ号', '1466140048', '1466140048', '1', '97471547', '0');
INSERT INTO `sys_config` VALUES ('72', 'APP_WEIXIN', '1', '微信公众号', '3', '1', '', '微信公众号', '1466140091', '1466140091', '1', '梦创科技', '0');
INSERT INTO `sys_config` VALUES ('73', 'APP_ICON', '1', 'APP图标', '3', '1', '', 'APP图标', '1466140129', '1466141841', '0', 'http://admin.vlcms.com/Uploads/Picture/2016-06-07/575638bc64e72.png', '0');
INSERT INTO `sys_config` VALUES ('74', 'APP_VERSION', '1', 'APP版本号', '3', '1', '', 'APP版本号', '1466151638', '1466153664', '1', '2.0', '0');
INSERT INTO `sys_config` VALUES ('77', 'APP_NAME', '2', 'APP名称', '3', '1', '', 'APP名称', '1466385075', '1466385075', '1', '溪谷H5盒子', '0');
INSERT INTO `sys_config` VALUES ('76', 'APP_DOWNLOAD', '1', 'APP下载地址', '3', '1', '', 'app下载地址连接', '1466153743', '1466153820', '1', 'http://dl.vlcms.com/dl/Gameapp.apk', '0');
INSERT INTO `sys_config` VALUES ('79', 'ABOUT_ICO', '5', '关于我们图标', '3', '1', '', '关于我们图标', '1466496505', '1466496505', '1', '63', '13');
INSERT INTO `sys_config` VALUES ('80', 'APP_DOWNLOAD1', '1', 'APP下载地址', '3', '1', '', 'APP下载地址', '1466995341', '1466995341', '0', 'http://dl.vlcms.com/dl/Gameapp.apk', '0');
INSERT INTO `sys_config` VALUES ('81', 'PC_SET_LOGO_URL', '1', 'logo链接', '1', '0', '', 'logo链接', '1467098119', '1467098119', '1', '', '0');
INSERT INTO `sys_config` VALUES ('82', 'URL_ROUTE_SUFFIX', '1', '伪静态后缀设置', '0', '4', '', '如：html,jsp,php', '1474614274', '1474882321', '1', 'html', '0');
INSERT INTO `sys_config` VALUES ('83', 'URL_ROUTE_MODEL', '4', 'URL模式', '0', '4', '0:普通模式,1:PATHINFO模式,2:REWRITE模式,3:兼容模式', '普通模式不支持伪静态后缀', '1474884059', '1474884059', '1', '3', '0');
INSERT INTO `sys_config` VALUES ('84', 'UC_SET', '4', '是否开启UCenter', '0', '3', '0:关闭\r\n1:开启', '是否开启UC', '1379504487', '1474961450', '1', '0', '59');

-- ----------------------------
-- Table structure for sys_document
-- ----------------------------
DROP TABLE IF EXISTS `sys_document`;
CREATE TABLE `sys_document` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `name` char(40) NOT NULL DEFAULT '' COMMENT '标识',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '标题',
  `category_id` int(10) unsigned NOT NULL COMMENT '所属分类',
  `group_id` smallint(3) unsigned NOT NULL COMMENT '所属分组',
  `description` char(140) NOT NULL DEFAULT '' COMMENT '描述',
  `root` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '根节点',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '所属ID',
  `model_id` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容模型ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '2' COMMENT '内容类型',
  `position` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '推荐位',
  `link_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '外链',
  `cover_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '封面',
  `display` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '可见性',
  `deadline` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '截至时间',
  `attach` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '附件数量',
  `view` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '浏览量',
  `comment` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '扩展统计字段',
  `level` int(10) NOT NULL DEFAULT '0' COMMENT '优先级',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `admin` int(11) NOT NULL DEFAULT '0' COMMENT '文档创建者',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '数据状态',
  PRIMARY KEY (`id`),
  KEY `idx_category_status` (`category_id`,`status`),
  KEY `idx_status_type_pid` (`status`,`uid`,`pid`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='文档模型基础表';

-- ----------------------------
-- Records of sys_document
-- ----------------------------
INSERT INTO `sys_document` VALUES ('1', '1', '', '111', '2', '0', '', '0', '0', '2', '2', '0', '0', '0', '1', '1476966300', '0', '0', '0', '0', '0', '1468565700', '1476347001', '1', '1');
INSERT INTO `sys_document` VALUES ('2', '1', '', '11111', '43', '0', '1111', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '1470392653', '1470392653', '1', '1');
INSERT INTO `sys_document` VALUES ('3', '1', '', '用户协议', '51', '0', '', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '1471413300', '1471413824', '1', '1');
INSERT INTO `sys_document` VALUES ('4', '1', '', '用户注册协议', '49', '0', '', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '0', '0', '0', '0', '1471413360', '1471413993', '1', '1');
INSERT INTO `sys_document` VALUES ('5', '1', '', '关于我们', '47', '0', '', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '1', '0', '0', '0', '1472692720', '1472692720', '1', '1');
INSERT INTO `sys_document` VALUES ('6', '1', '', '关于我们', '40', '0', '', '0', '0', '2', '2', '0', '0', '0', '1', '0', '0', '11', '0', '0', '0', '1472692953', '1472692953', '1', '1');
INSERT INTO `sys_document` VALUES ('7', '1', '', '111111111111', '44', '0', '啊实打实大师的飒飒飒飒的撒', '0', '0', '2', '2', '0', '0', '23', '1', '0', '0', '13', '0', '0', '0', '1474851900', '1476235632', '1', '1');
INSERT INTO `sys_document` VALUES ('8', '1', '', '22222222', '44', '0', '', '0', '0', '2', '2', '0', '0', '27', '1', '1475198460', '0', '0', '0', '0', '0', '1474851900', '1474852913', '1', '1');

-- ----------------------------
-- Table structure for sys_document_article
-- ----------------------------
DROP TABLE IF EXISTS `sys_document_article`;
CREATE TABLE `sys_document_article` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '文章内容',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `bookmark` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型文章表';

-- ----------------------------
-- Records of sys_document_article
-- ----------------------------
INSERT INTO `sys_document_article` VALUES ('1', '0', '1111', '', '0');
INSERT INTO `sys_document_article` VALUES ('2', '0', '11111', '', '0');
INSERT INTO `sys_document_article` VALUES ('3', '0', '<div class=\"reg_list\">\r\n  <div class=\"reg_form rule section\">\r\n   <h2>\r\n      最终用户协议\r\n    </h2>\r\n   <p>\r\n     您\r\n在溪谷游戏进行注册时，须提供真实、有效的身份识别资料，并应在前述资料发生变更时，及时于溪谷游戏网进行线上更新。若您所提供的资料与事实不符或所提供\r\n的资料业已变更而未更新或有任何误导之嫌而导致溪谷游戏无法为您提供或继续提供服务的，您应自行承担由此引发的损失而与溪谷游戏无关。\r\n    </p>\r\n    <p>\r\n     您须\r\n了解和认可，溪谷游戏账号的使用权仅归属于原始注册人。未经溪谷游戏的事先书面同意，您不得以任何形式将自身溪谷游戏账号及密码转让、赠予、出借、售卖予\r\n第三方或者以其他方式许可非初始注册人对其进行使用，否则溪谷游戏有权封禁、删除该账号。如您并非当前所使用溪谷游戏账号的原始注册人，您应立即停止对该\r\n账号的一切使用及操作，同时溪谷游戏有权依原始注册人之请求或依自身判断将该账号重新交予原始注册人使用，由此引发的全部责任及损失与溪谷游戏无关。\r\n您有义务妥善保管在注册时获得的账号及密码，如因黑客、第三人行为或您自身保管疏忽导致账号、密码遭他人非法使用并给您造成损失的，溪谷游戏就此不承担任\r\n何责任。\r\n    </p>\r\n    <p>\r\n     如您发现自身账号遭他人非法使用或有异常使用的情形，应立即通知溪谷游戏，并提供与原始注册人相一致的个人有效身份信息。溪谷游戏在核实您所提供的个人有效身份信息后，将尽可能为您维护自身合法权利提供必要协助，但溪谷游戏并不承诺您一定能通过该途径找回溪谷游戏账号。\r\n   </p>\r\n  </div>\r\n</div>', '', '0');
INSERT INTO `sys_document_article` VALUES ('4', '0', '<div class=\"container cf\">\r\n  <div class=\"user-single-main\">\r\n    <div class=\"content-main\">\r\n      <h1>\r\n        用户注册服务协议\r\n      </h1>\r\n     <h2>\r\n        前言\r\n      </h2>\r\n     <p>\r\n       本《用户注册服务协议》协议（以下简称“<strong>本协议</strong>”）是由您（以下称为“<strong>用户</strong>”）与三七互娱（上海）科技有限公司（以下称为“<strong>溪谷游戏</strong>”）就溪谷游戏在其和／或其关联公司的网页游戏平台上所提供的产品和服务（包括溪谷游戏的网站以及溪谷游戏现在正在提供和将来可能向用户提供的游戏服务和其他网络服务，以下统称为“<strong>产品和服务</strong>”）所订立的协议。\r\n     </p>\r\n      <p>\r\n       <strong class=\"orange\">如\r\n果用户进入溪谷游戏网站或其下游戏的用户注册页面，确认已经阅读、同意本协议的条款并完成注册，或者通过其他任何方式获得和使用溪谷游戏所提供的产品和服\r\n务，则视为用户已经详细阅读了本协议的内容，同意遵守本协议的约定。用户不应再以不了解本协议内容为由拒绝履行本协议。</strong>因此，为保障用户的权益，请于注册使用溪谷游戏所提供的各种产品和服务之前，仔细阅读本协议全文。此外，依据本协议第十六条，溪谷游戏有权不时对本协议进行修改与更新，请用户留意查看本协议的最新版本。\r\n      </p>\r\n      <h2>\r\n        一、服务内容\r\n      </h2>\r\n     <p>\r\n       1. 溪谷游戏产品和服务的具体内容由溪谷游戏根据实际情况提供，例如网络游戏、论坛（BBS）、聊天室、电子邮件等。溪谷游戏保留随时变更、中断或终止部分或全部产品和服务的权利。\r\n      </p>\r\n      <p>\r\n       2. 溪谷游戏在提供产品和服务时，可能会对部分用户收取一定的费用。在此情况下，相关页面上会有明确的提示。如用户不同意支付该等费用，可选择不接受相应的产品和服务。\r\n      </p>\r\n      <p>\r\n       3. 溪谷游戏通过服务器端设备接入互联网为用户提供产品和服务，除此之外与产品和服务有关的设备（如电脑、调制解调器及其他与接入互联网有关的装置）及所需的费用（如为接入互联网而支付的电话费及上网费）均应由用户自行负担。\r\n     </p>\r\n      <p>\r\n       4. 用户应使用正版软件接受产品和服务，软件费用由用户自行负担。\r\n      </p>\r\n      <h2>\r\n        二、帐号名称和密码\r\n     </h2>\r\n     <p>\r\n       1. 用户阅读并同意本协议，成功完成注册后，即成为溪谷游戏的注册用户，取得溪谷游戏用户帐号（以下称“<strong>溪谷游戏帐号</strong>”）。溪谷游戏帐号名称在注册之后不可变更，而帐号对应的密码则可以通过溪谷游戏提供的客户服务进行修改。\r\n     </p>\r\n      <p>\r\n       2. 用户对于溪谷游戏帐号及密码的保管以及使用该帐号和密码所进行的一切行为负有完全的责任。禁止将溪谷游戏帐号或密码销售、转让或出借、共享给他人使用。<strong class=\"orange\">因为用户的保管疏忽或任何第三方行为，导致用户的溪谷游戏帐号或密码遭他人非法使用，以及因此而产生的任何后果，溪谷游戏均不承担任何责任。</strong> \r\n     </p>\r\n      <p>\r\n       3. 用户发现其溪谷游戏帐号或密码被他人非法使用或有使用异常情况的，应及时根据溪谷游戏不时公布的处理方式通知溪谷游戏，并有权请求溪谷游戏采取措施暂停该帐号的登录和使用。溪谷游戏根据用户身份核对结果，决定是否暂停乙方帐号的登录和使用。\r\n      </p>\r\n      <h2>\r\n        三、帐号注册信息\r\n      </h2>\r\n     <p>\r\n       1. 提供注册信息\r\n     </p>\r\n      <p>\r\n       （1）在申请溪谷游戏帐号时（或注册后补充信息时），用户应当向溪谷游戏提供最新、详细及真实准确的个人注册信息。前述个人注册信息包括：用户的溪谷游戏帐号名称、密码及注册溪谷游戏帐号（或补充、更新帐号信息时）输入的所有信息。<strong class=\"orange\">用户在此承诺：用户以其真实身份注册成为溪谷游戏的用户，并保证所提供的个人身份资料信息真实、完整、有效，依据法律规定和必备条款约定对所提供的信息承担相应的法律责任。</strong> \r\n     </p>\r\n      <p>\r\n       （2）所有由用户提供的个人注册信息将可能被溪谷游戏用来作为认定溪谷游戏帐号的关联性以及辨别用户身份的依据。用户同意应溪谷游戏的要求，随时提供该等信息的证明材料，以便溪谷游戏核实用户身份。\r\n     </p>\r\n      <p>\r\n       （3）<strong class=\"orange\">如果用户提供给溪谷游戏的信息不准确，或不真实，或不合法有效，或已变更而未及时更新，或有任何误导之嫌，溪谷游戏有权中止或终止该用户使用溪谷游戏的任何服务</strong>。\r\n溪谷游戏有权审查乙方注册所提供的身份信息是否真实、有效，并应积极地采取技术与管理等合理措施保障用户帐号的安全、有效；用户有义务妥善保管其帐号及密\r\n码，并正确、安全地使用其帐号及密码。任何一方未尽上述义务导致帐号密码遗失、帐号被盗等情形而给对方或他人的权利造成损害的，应当承担由此产生的法律责\r\n任。\r\n     </p>\r\n      <p>\r\n       2. 修改注册信息\r\n     </p>\r\n      <p>\r\n       用户可以在任何时间，通过溪谷游戏官方网站在该时点提供的服务或溪谷游戏公布的在该时点可用的其他途\r\n径，更新或修改用户申请注册时所提供的信息。但是，用户在注册溪谷游戏帐号时（或注册后补充信息时）填写的真实姓名、证件号码，以及溪谷游戏帐号名称本\r\n身，在帐号注册成功后（或补充信息后）无法进行修改，请用户慎重填写各类注册信息。\r\n     </p>\r\n      <p>\r\n       3. 用户同意，与其溪谷游戏帐号相关的一切资料、数据和记录（包括但不限于登录记录、登录后行为记录、点卡信息等）均以溪谷游戏系统记录的数据为准。\r\n     </p>\r\n      <h2>\r\n        四、信息披露与保护\r\n     </h2>\r\n     <p>\r\n       1. 本协议第三条所描述的注册信息，以及用户在使用产品和服务时存储在溪谷游戏控制范围内的非公开信息（以下合称“<strong>用户信息</strong>”），应按照本条约定进行披露及保护。\r\n      </p>\r\n      <p>\r\n       2.\r\n为了向用户提供更好的产品和服务，在用户自愿选择使用溪谷游戏的产品和服务的情况下，或者明示同意提供信息的情况下，溪谷游戏可能会收集用户信息，并可能\r\n对这些信息进行分析和整合。在用户使用溪谷游戏的产品和服务时，服务器可能会自动记录部分用户信息，这些信息都将成为溪谷游戏商业秘密的一部分。\r\n      </p>\r\n      <p>\r\n       3. 保护用户（特别是未成年人用户）的隐私是溪谷游戏的一项基本原则。溪谷游戏一贯积极地采取技术与管理等方面的合理措施保障用户信息的安全、保密。\r\n     </p>\r\n      <p>\r\n       4. 除本协议第四条第4款所列六项情形之外，溪谷游戏保证不对外公开或向第三方披露、提供用户信息。六项除外情形如下：\r\n     </p>\r\n      <p>\r\n       （1）用户（或者用户的监护人）要求或同意溪谷游戏披露用户信息；\r\n     </p>\r\n      <p>\r\n       （2）有关法律法规、监管机构规章或自律组织规则要求溪谷游戏披露用户信息；\r\n      </p>\r\n      <p>\r\n       （3）司法机关或行政机关基于法定程序要求溪谷游戏披露用户信息；\r\n     </p>\r\n      <p>\r\n       （4）为保护溪谷游戏的知识产权和其他权益，需要披露用户信息；\r\n      </p>\r\n      <p>\r\n       （5）在紧急情况下为保护其他用户和社会公众的利益，需要披露用户信息；\r\n      </p>\r\n      <p>\r\n       （6）根据本协议其他条款的规定，溪谷游戏认为确有必要披露用户信息的其他情况。\r\n      </p>\r\n      <p>\r\n       5. 为了向用户正常地提供产品和服务，溪谷游戏可能需要向溪谷游戏的技术服务商、溪谷游戏的关联公司或其他第三方传送部分用户信息，在这些第三方承诺其将承担至少与溪谷游戏同等的保密义务的前提下，溪谷游戏将向这些第三方传送用户信息，用户对此予以理解和同意。\r\n      </p>\r\n      <p>\r\n       6. 在不透露单个用户隐私资料的前提下，溪谷游戏有权对整个用户信息数据库进行技术分析并对已进行分析、整理后的用户数据库进行商业上的利用。\r\n      </p>\r\n      <p>\r\n       7. 溪谷游戏将采取商业上合理可行的方式保护用户的个人信息的安全。溪谷游戏使用通常可以获得的安全技术和程序来保护用户的个人信息不被未经授权地访问、使用或泄漏。<strong class=\"orange\">对于非因溪谷游戏的故意及重大过失而造成用户帐号的丢失或用户个人信息的泄密，溪谷游戏不承担任何责任。</strong> \r\n     </p>\r\n      <h2>\r\n        五、用户的基本权利\r\n     </h2>\r\n     <p>\r\n       1. 用户可以根据本协议以及溪谷游戏不时公布和变更的其他规则使用溪谷游戏提供的产品和服务。\r\n     </p>\r\n      <p>\r\n       2. 用户可以自愿选择通过手机绑定溪谷游戏提供的页面，从而在第一时间获得溪谷游戏提供的游戏活动、优惠信息等内容。\r\n      </p>\r\n      <p>\r\n       3. 用户有权在使用溪谷游戏提供的产品和服务期间监督溪谷游戏及溪谷游戏的工作人员是否按照溪谷游戏所公布的标准向用户提供产品和服务，也可以随时向溪谷游戏提出与产品和服务有关的意见和建议。\r\n      </p>\r\n      <p>\r\n       4. 如果用户不同意本协议条款，或对溪谷游戏后来修改、更新的条款有异议，或对溪谷游戏所提供的产品和服务不满意，用户可以随时选择停止使用溪谷游戏的产品和服务。<strong class=\"orange\">如果用户选择停止使用溪谷游戏的产品和服务，溪谷游戏不再对用户承担任何义务和责任。</strong> \r\n     </p>\r\n      <h2>\r\n        六、用户行为守则\r\n      </h2>\r\n     <p>\r\n       1. 用户同意按照包括本协议在内的、溪谷游戏不时发布或变更的各类规则规范自己的行为，从而接受并使用溪谷游戏的产品和服务。用户对登录后其所持帐号产生的行为依法享有权利和承担责任。<strong class=\"orange\">用户进一步同意，在违反这些规则时，按照本协议第六条第14款、第15款、第十四条及其他相关条款的规定承担违规后果和违约责任。</strong> \r\n      </p>\r\n      <p>\r\n       2. 用户在使用溪谷游戏帐号期间，须遵守与互联网信息发布相关的法律、法规及通常适用的互联网一般道德和礼仪的规范，用户将自行承担用户所发布的信息内容的责任。用户发布的各类信息，不得包含以下内容：\r\n      </p>\r\n      <p>\r\n       （1）违背宪法所确定的基本原则的；\r\n     </p>\r\n      <p>\r\n       （2）危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；\r\n      </p>\r\n      <p>\r\n       （3）损害国家荣誉和利益的；\r\n      </p>\r\n      <p>\r\n       （4）煽动民族仇恨、民族歧视，破坏民族团结的；\r\n     </p>\r\n      <p>\r\n       （5）破坏国家宗教政策，宣扬邪教和封建迷信的；\r\n     </p>\r\n      <p>\r\n       （6）散布谣言，扰乱社会秩序，破坏社会稳定的；\r\n     </p>\r\n      <p>\r\n       （7）传播淫秽、色情、赌博、暴力、凶杀、恐怖信息或者教唆犯罪的；\r\n      </p>\r\n      <p>\r\n       （8）侮辱、诽谤或恶意用言语攻击他人，侵害他人合法权益的；\r\n     </p>\r\n      <p>\r\n       （9）侵犯任何第三者的知识产权，版权或公众／私人权利的；\r\n      </p>\r\n      <p>\r\n       （10）违反人文道德、风俗习惯的；\r\n     </p>\r\n      <p>\r\n       （11）破坏游戏正常秩序的；\r\n      </p>\r\n      <p>\r\n       （12）含有法律、行政法规禁止的其他内容的。\r\n      </p>\r\n      <p>\r\n       3. 用户的溪谷游戏帐号名称及游戏中的人物、帮派等名称应当遵守合法、健康的原则，不允许使用包括但不限于涉及种族、宗教、政治、国家领导人、淫秽、低俗、诽谤、恐吓、欺诈性的、攻击性的、污辱性的、可能引起误会的、违禁药品等内容的名称。\r\n      </p>\r\n      <p>\r\n       4. 用户应当对自己在游戏中的言行负责，尤其不得：\r\n     </p>\r\n      <p>\r\n       （1）通过任何方式、行为散布或传播低俗、不雅信息；\r\n     </p>\r\n      <p>\r\n       （2）通过任何方式、行为冒充平台或游戏系统向其他用户散布或传播虚假信息；\r\n      </p>\r\n      <p>\r\n       （3）通过任何方式或途径引起纷争；\r\n     </p>\r\n      <p>\r\n       （4）通过任何方式、行为散布或传播、使用私服、木马、外挂、病毒及此类信息；\r\n     </p>\r\n      <p>\r\n       （5）通过任何方式、行为散布或传播代练的信息；\r\n     </p>\r\n      <p>\r\n       （6）通过任何方式、行为传播或进行除溪谷游戏提供的交易途径之外的游戏帐号、虚拟货币、虚拟道具的线下交易；\r\n      </p>\r\n      <p>\r\n       （7）大量传播相同的、类似的短语或无意义的文字，或者任何与溪谷游戏平台及其游戏无关的信息；\r\n     </p>\r\n      <p>\r\n       （8）宣扬、鼓动任何游戏虚拟世界之外的暴力行为；\r\n      </p>\r\n      <p>\r\n       （9）泄露其它用户、非用户或溪谷游戏平台员工的任何游戏世界和现实世界信息；\r\n     </p>\r\n      <p>\r\n       （10）宣传或发布违法信息、违反社会公德的信息，或不利于精神文明建设的信息，包括但不限于色情、赌博、邪教、恐怖主义等内容；\r\n     </p>\r\n      <p>\r\n       （11）其他不符合法律法规、社会公德或游戏规则的言论或行为。\r\n      </p>\r\n      <p>\r\n       5. 用户不得干扰、阻碍溪谷游戏正常地提供产品和服务，尤其不得：\r\n      </p>\r\n      <p>\r\n       （1）攻击、侵入溪谷游戏的网站服务器或使网站服务器过载；\r\n      </p>\r\n      <p>\r\n       （2）破解、修改溪谷游戏提供的客户端程序；\r\n     </p>\r\n      <p>\r\n       （3）攻击、侵入溪谷游戏的游戏服务器或游戏服务器端程序或使游戏服务器过载；\r\n     </p>\r\n      <p>\r\n       （4）不合理地干扰或阻碍他人使用溪谷游戏所提供的产品和服务；\r\n      </p>\r\n      <p>\r\n       （5）利用程序的漏洞和错误（Bug）破坏游戏的正常进行或传播该漏洞或错误（Bug）；\r\n      </p>\r\n      <p>\r\n       （6）直接或间接利用游戏Bug（包括游戏系统、程序、设定等方面存在的漏洞或不合理的现象）、程序漏洞获利或扰乱游戏秩序，或者利用Bug、漏洞达到个人目的；\r\n      </p>\r\n      <p>\r\n       （7）\r\n制作、使用、发布、传播任何形式的妨碍游戏公平性的辅助工具或程序（指用于在游戏中获取优势，但不属于溪谷游戏平台或各游戏软件的一部分的任何文件或程\r\n序），包括作弊性质的外挂以及相关辅助性质的外挂等（包括但不限于自动打怪、自动练级、自动吃药、自动完成任务、加速性质或超出游戏设定范围等操作）；\r\n     </p>\r\n      <p>\r\n       （8）不得修改客户端程序，使之改变或者新增或者减少溪谷游戏平台所预先设定的功能，或者导致客户端向服务器发送的数据出现异常的一切行为。\r\n      </p>\r\n      <p>\r\n       6. 用户不得扰乱游戏秩序，尤其不得：\r\n     </p>\r\n      <p>\r\n       （1）长时间停留在特殊地点或敏感地区（包括但不限于活动报名人、“移民使者”、传送人、传送点等处），干扰其他用户游戏；\r\n      </p>\r\n      <p>\r\n       （2）进行恶意PK、清场、敲诈、勒索等行为；\r\n      </p>\r\n      <p>\r\n       （3）扬言进行或煽动其他用户或非用户参与非正常游戏内容的行为（包括但不限于游行、聚众闹事等）；\r\n     </p>\r\n      <p>\r\n       （4）以相似昵称的人物冒充他人好友、冒充NPC或官方角色等方式在游戏内外进行欺诈。\r\n     </p>\r\n      <p>\r\n       7. 用户可以与游戏管理员（以下称为“<strong>GM</strong>”）进行交流，但在与GM交流时，不得做出以下行为：\r\n     </p>\r\n      <p>\r\n       （1）冒充系统或GM；\r\n     </p>\r\n      <p>\r\n       （2）欺骗或试图欺骗GM，包括但不限于误导GM、拒绝提供信息、提供虚假信息以及任何试图“诈骗”GM的行为；\r\n     </p>\r\n      <p>\r\n       （3）违反或忽视GM做出的提示。在游戏中，为了确保大多数用户的共同利益，维护正常的游戏秩序，GM可能会提示用户执行某些操作或停止执行某些操作，用户不得忽视或阻挠该项工作的进行；\r\n      </p>\r\n      <p>\r\n       （4）干扰GM工作。干扰GM工作包括但不限于：向GM索取任何游戏虚拟物品（包括但不限于虚拟货币、游戏道具等），频繁呼叫GM或发送无实质性内容的请求，反复向GM发送已解答或解决问题的帮助请求；\r\n     </p>\r\n      <p>\r\n       （5）辱骂、威胁或恶意攻击GM。\r\n      </p>\r\n      <p>\r\n       8. 用户必须保管好自己的帐号和密码，由于用户的原因导致帐号和密码泄密而造成的后果均将由用户自行承担。\r\n     </p>\r\n      <p>\r\n       9. 用户仅能以个人身份使用溪谷游戏所提供的产品和服务，用户不能利用溪谷游戏所提供的产品和服务从事商业目的的活动，也不能利用溪谷游戏的产品和服务进行销售或其他商业目的的活动。\r\n     </p>\r\n      <p>\r\n       10. 除非获得溪谷游戏的书面许可，否则，用户不得利用溪谷游戏的任何产品和服务及其任何内容牟取商业利益，包括但不限于充当游戏道具交易中介收取中介费，以营利为目的销售游戏道具等。\r\n      </p>\r\n      <p>\r\n       11. 用户不得利用溪谷游戏提供的产品和服务从事以下活动：\r\n     </p>\r\n      <p>\r\n       （1）未经允许，进入计算机信息网络或者使用计算机信息网络资源的；\r\n      </p>\r\n      <p>\r\n       （2）未经允许，对计算机信息网络功能进行删除、修改或者增加的；\r\n     </p>\r\n      <p>\r\n       （3）未经允许，对进入计算机信息网络中存储、处理或者传输的数据和应用程序进行删除、修改或者增加的；\r\n     </p>\r\n      <p>\r\n       （4）故意制作、传播计算机病毒等破坏性程序的；\r\n     </p>\r\n      <p>\r\n       （5）其他危害计算机信息网络安全的行为。\r\n      </p>\r\n      <p>\r\n       12. 用户同意以游戏程序中的监测数据作为判断用户是否有通过使用外挂程序等方法进行的游戏作弊行为的依据。\r\n      </p>\r\n      <p>\r\n       13. 如果溪谷游戏发现用户行为或者数据异常，可以观察及记录该用户行为，并以观察和记录的结果作为判断用户是否实施了违反本协议用户行为守则的依据。\r\n      </p>\r\n      <p class=\"strong\">\r\n        溪\r\n谷游戏积极保护用户的帐号、虚拟物品及虚拟货币的安全，为此，溪谷游戏对盗号及盗号相关行为展开严厉的打击。溪谷游戏发现或者怀疑存在包括但不限于以下的\r\n盗号及盗号相关行为时，有权视情况按照本协议第六条第14款、第15款、第十四条及其他相关条款的规定处理，同时，溪谷游戏保留进一步追诉的权利：（1）\r\n盗取帐号；（2）盗取虚拟物品；（3）盗取虚拟货币；（4）盗取帐号或/及密码；（5）异常IP下的物品转移；（6）其他盗号及盗号相关行为。为了维护游\r\n戏的公平与秩序，即使用户没有主动的参与盗号，但是用户的物品来源于盗号或者盗号相关行为的，溪谷游戏也有权自行判断回收、冻结涉及盗号的物品及帐号。用\r\n户应该配合溪谷游戏对盗号及盗号相关行为的调查。用户应该自觉维护游戏的秩序，溪谷游戏发现或者怀疑存在虚假的盗号投诉时，有权视情况按照本协议第六条第\r\n14款、第15款、第十四条及其他相关条款的规定处理。\r\n     </p>\r\n      <div class=\"strong\">\r\n        <p>\r\n         14. 若用户实施违反本条所述用户行为守则的行为，溪谷游戏有权视行为严重程度，向该用户施加以下一项或若干项违规后果，该用户应承担该等不利后果：\r\n       </p>\r\n        <p>\r\n         （1）警告：警告是针对轻微违反游戏政策而做出的教育导向，它是用于正常管理游戏运行的一种方式。\r\n        </p>\r\n        <p>\r\n         （2）禁言：关闭违规用户的部分或全部聊天频道，强制暂停违规用户角色的线上对话功能，使该角色无法与其他用户对话，直到此次处罚到期或是取消。\r\n        </p>\r\n        <p>\r\n         （3）强制离线：强制让违规用户离开当前游戏，结束该用户当前游戏程序的执行。\r\n       </p>\r\n        <p>\r\n         （4）封停帐号：暂停或永久终止违规用户使用溪谷游戏帐号登录某款游戏的权利。\r\n       </p>\r\n        <p>\r\n         （5）删除档案：将违规用户在某个游戏世界中的人物档案删除，不让该人物再出现在游戏世界。\r\n       </p>\r\n        <p>\r\n         （6）删除帐号：永久终止违规用户通过溪谷游戏帐号登录溪谷游戏平台的权利，包括但不限于用户注册信息、角色信息、等级物品、游戏货币等游戏数据库中的全部数据都将被永久封禁。\r\n       </p>\r\n        <p>\r\n         （7）收回游戏虚拟物品：对于违规用户因欺诈或其他违规行为而获取的游戏虚拟物品，包括但不限于游戏虚拟货币、虚拟物品，进行收回。\r\n        </p>\r\n        <p>\r\n         （8）修改名称：强制修改违规用户论坛昵称、游戏人物或帮派等的名称。\r\n       </p>\r\n        <p>\r\n         （9）解散组织：解散违规用户成立的帮派、公会等组织。\r\n        </p>\r\n        <p>\r\n         （10）倒扣数值：针对游戏角色游戏数值进行扣除，包括但不限于游戏角色等级、金钱、经验等。\r\n        </p>\r\n        <p>\r\n         （11）封禁IP：暂时或永久禁止违规用户在某一异常IP登录某款游戏的某个服务器。\r\n        </p>\r\n        <p>\r\n         （12）承担法律责任：违规用户的不当行为对他人或者溪谷游戏造成损害，或者与现行法律规定相违背的，违规用户应依法承担相应的民事、行政和／或刑事责任，例如，用户在进行游戏过程中侵犯第三方知识产权或其他权利而导致被权利人索赔的，由用户直接承担责任。\r\n       </p>\r\n        <p>\r\n         15．\r\n若用户实施违反本条所述用户行为守则的行为，溪谷游戏还有权要求违规用户向溪谷游戏承担违约责任，包括但不限于恢复原状，消除影响，对给溪谷游戏造成的直\r\n接及间接损失或额外的成本支出进行赔偿，以及在溪谷游戏首先承担了因违规用户行为导致的行政处罚或侵权损害赔偿责任后，由溪谷游戏向违规用户追偿。\r\n        </p>\r\n      </div>\r\n      <h2>\r\n        七、游戏管理\r\n      </h2>\r\n     <p>\r\n       1. 游戏管理员\r\n      </p>\r\n      <p>\r\n       （1）游戏管理员即GM（Game Master），指维护和管理游戏虚拟世界秩序的溪谷游戏在线工作人员。\r\n     </p>\r\n      <p>\r\n       （2）GM不会干预游戏的正常秩序，不会以任何方式索要用户的个人资料和密码，不负责解决用户之间的私人纠纷或回答游戏的攻略、诀窍等问题。\r\n      </p>\r\n      <p>\r\n       （3）用户在游戏中应当尊重、理解并配合GM的工作，如有任何意见，应通过专用信箱向客户服务中心申诉和举报。\r\n      </p>\r\n      <p>\r\n       2. 游戏信息转移。溪谷游戏有权根据产品和服务的提供状况，安排拆分或合并游戏服务器。在对用户游戏权益没有重大影响的情况下，<strong class=\"orange\">溪谷游戏有权将用户在游戏中的人物信息、角色档案转移到其它游戏服务器。</strong> \r\n      </p>\r\n      <p>\r\n       3.\r\n家长监护系统。溪谷游戏遵从国家政策，针对某些特定的游戏开设“未成年人家长监护系统”，若父母（监护人）同意未成年人（尤其是十岁以下子女）使用产品和\r\n服务，必须以父母（监护人）名义申请注册溪谷游戏帐号。在使用产品和服务时，父母（监护人）应以监护人身份判断产品和服务是否适合未成年人。如果用户未满\r\n18周岁（或溪谷游戏无法识别用户的年龄），则用户将受到“未成年人家长监护系统”的约束。<strong class=\"orange\">溪谷游戏将有权根据有关规则以及家长的要求，对用户创建或使用溪谷游戏帐号关联的游戏帐号进行限制，包括但不限于临时或永久冻结帐号，部分或者全部终止提供溪谷游戏各项产品和服务。</strong> \r\n     </p>\r\n      <p>\r\n       4. 防沉迷系统\r\n      </p>\r\n      <p>\r\n       （1）如果用户未满法定年龄（或溪谷游戏无法识别用户的年龄），则用户在游戏内的活动将受到“游戏防沉迷系统”监测；如果用户拥有一个以上溪谷游戏帐号，则该“游戏防沉迷系统”将同时适用于该用户的所有溪谷游戏帐号；\r\n      </p>\r\n      <p>\r\n       （2）“游戏防沉迷系统”通过按照连续游戏时间来逐级扣减游戏内收益的方式，对用户长时间连续游戏的行为进行规制；\r\n      </p>\r\n      <p>\r\n       （3）用户需提供真实完整的信息以便溪谷游戏识别用户的身份并向有关部门提交实名认证信息，<strong class=\"orange\">如因提供的资料不真实而产生的后果由用户自行承担。</strong> \r\n      </p>\r\n      <p>\r\n       5. 在现有的技术条件下，溪谷游戏将尽合理的商业努力并根据有关监管部门的要求开发并维护“未成年人家长监护系统”、“游戏防沉迷系统”与实名认证系统，按“现状”提供给用户使用。由于技术不可避免的局限性以及系统运作各环节受外界的影响，<strong class=\"orange\">溪谷游戏不保证各系统不存在任何漏洞，不保证各系统能随时正常运作，亦不保证监护或认证效果完全正确真实或满足用户的需求。溪谷游戏不提供任何适用法律明确规定之外的明示或默示担保，不对此承担任何责任。</strong> \r\n     </p>\r\n      <h2>\r\n        八、资费政策\r\n      </h2>\r\n     <p>\r\n       1. 溪谷游戏产品和服务的收费信息以及有关的资费标准、收费方式、购买方式及其他有关资费政策的信息，在溪谷游戏相关平台或游戏网站（包括但不限于溪谷.com、溪谷wan.com和相应游戏官方网站等网站）上作出说明。\r\n     </p>\r\n      <p>\r\n       2.\r\n溪谷游戏有权决定溪谷游戏所提供的产品和服务的资费标准和收费方式，溪谷游戏可能会就不同的产品和服务制定不同的资费标准和收费方式，也可能按照溪谷游戏\r\n所提供的产品和服务的不同阶段确定不同的资费标准和收费方式。另外，溪谷游戏也可能不时地修改溪谷游戏的资费政策。溪谷游戏会将有关产品和服务的收费信息\r\n以及与该产品和服务有关的资费标准、收费方式、购买方式或其他有关资费政策的信息放置在该产品和服务相关网页的显著位置。\r\n     </p>\r\n      <p>\r\n       3. 对于溪谷游戏的收费产品和服务，用户应该按照溪谷游戏确定的资费政策购买溪谷游戏的产品和服务。<strong class=\"orange\">如果用户未按溪谷游戏确定的资费政策购买溪谷游戏的产品和服务，溪谷游戏可以立即停止向用户提供该产品和服务。</strong> \r\n     </p>\r\n      <p class=\"strong\">\r\n        4.\r\n除非法律另有明文规定，否则用户不得要求溪谷游戏返还用户已经支付予溪谷游戏的任何资费（以下简称“退款”），无论该等资费是否已被消费。溪谷游戏有权决\r\n定是否、何时、以何种方式向用户退款。溪谷游戏同意退款的，用户应补偿支付时使用信用卡、手机等支付渠道产生的费用，溪谷游戏有权在返还用户的资费中直接\r\n扣收。溪谷游戏在产品和服务提供过程中赠送的充值金额、虚拟货币、虚拟道具等，不予退款或变现。\r\n     </p>\r\n      <h2>\r\n        九、虚拟物品\r\n      </h2>\r\n     <p>\r\n       1. 溪谷游戏提供的产品和服务（包括但不限于游戏平台、游戏、论坛）中的各种虚拟物品，不限于金币、银两、道具、装备等，其所有权归溪谷游戏所有。用户只能在合乎法律和游戏规则的情况下拥有对虚拟物品的使用权。<strong class=\"orange\">用户一旦购买了虚拟道具的使用权，将视为已经进入消费过程，不得以任何理由要求退还该虚拟道具。</strong> \r\n      </p>\r\n      <p class=\"strong\">\r\n        2. 除服务器大规模断线外，由于地方网络问题、个人操作问题等个别原因造成的角色被删或回档、虚拟物品或金钱的损失，溪谷游戏无需向用户承担任何责任。\r\n      </p>\r\n      <p>\r\n       3. 鉴于网上交易的复杂性，溪谷游戏禁止用户进行游戏虚拟物品买卖线下交易及线下交易相关行为。<strong class=\"strong\">溪\r\n谷游戏反对用户自行进行虚拟物品买卖线下交易及线下交易相关行为（包括但不限于参与线下交易、协助线下交易者操作及转移游戏虚拟物品等一系列行为），并且\r\n不保护线下交易产生的任何交易结果，用户之间进行线下交易行为发生的任何问题、纠纷，包括但不限于被虚假交易信息诈骗金钱或者游戏虚拟物品的，均与溪谷游\r\n戏无关，用户将自行负责，溪谷游戏不负责赔偿或追回因受骗造成的损失。</strong> \r\n     </p>\r\n      <p>\r\n       4. <strong class=\"orange\">溪谷游戏不认可用户线下交易所产生的交易结果，用户通过线下交易所获得的游戏虚拟物品将被认定为来源不符合游戏规则。</strong>溪谷游戏有权按照本协议第六条的约定，对线下交易及线下交易相关行为涉及的游戏虚拟物品、游戏角色与溪谷游戏帐号采取相应的措施。\r\n     </p>\r\n      <h2>\r\n        十、服务方式、内容的变动与个人资料转移\r\n     </h2>\r\n     <p>\r\n       1. 溪谷游戏将尽力持续地向用户提供产品和服务，但是溪谷游戏并不排除溪谷游戏可能会停止提供任何产品和服务的可能性，也不排除任何改变游戏服务或其他网络服务的服务方式、服务内容的可能性。\r\n     </p>\r\n      <p>\r\n       2. 为增加并丰富溪谷游戏之游戏及其他网络服务的内容，游戏和游戏平台在运行时可能不定期更新并调整其包含的功能。在游戏和游戏平台更新后，一切游戏和游戏平台内的操作、内容、设定，将以游戏和游戏平台中的公告内容为准。\r\n     </p>\r\n      <p>\r\n       3. 如果溪谷游戏停止提供某一项产品和服务，或改变某一项产品和服务的方式或内容，溪谷游戏将会事先通知用户，并尽力寻找适当的服务提供者以接替溪谷游戏继续提供产品和服务。\r\n     </p>\r\n      <p>\r\n       4.\r\n在本条第3款所述情况下，溪谷游戏可能会将用户的个人资料（包括有关的帐号和密码信息及个人资料）转移给该继续提供服务的一方，也可能根据需要，永久封存\r\n原有资料以推行新的游戏方式。用户在此同意溪谷游戏有权做此转移和提供，并且同意在溪谷游戏完成转移和提供之后，溪谷游戏将不再对用户原有资料承担任何义\r\n务和责任。但是，溪谷游戏并不保证溪谷游戏届时一定能够找到适当的服务提供者或服务方式以代替溪谷游戏继续提供产品和服务，也不保证溪谷游戏找到的服务提\r\n供者所提供的产品和服务或者改变的游戏方式能够满足用户的要求。\r\n      </p>\r\n      <h2>\r\n        十一、服务中断或终止\r\n      </h2>\r\n     <p>\r\n       1. 如发生下列任何一种情形，溪谷游戏有权随时中断或终止向用户提供本协议项下的游戏服务和其他网络服务，对于因而产生的不便和损失，<strong class=\"strong\">溪谷游戏不承担任何责任：</strong> \r\n     </p>\r\n      <p>\r\n       （1）用户提供的个人资料不真实；\r\n      </p>\r\n      <p>\r\n       （2）用户违反本协议中规定的用户行为准则。\r\n     </p>\r\n      <div class=\"strong\">\r\n        <p>\r\n         2. 在下列情况下，溪谷游戏有权注销用户创造的角色，并删除该角色的所有记录：\r\n        </p>\r\n        <p>\r\n         （1）用户注册的游戏角色未达到一定游戏要求，并且在该角色所关联的游戏分区中可用游戏点数或游戏时间为零的情况下，连续一定时间未通过该角色登录过该游戏；\r\n        </p>\r\n        <p>\r\n         （2）用户自行删除的角色，自删除之日起一定时间内没有恢复的；\r\n        </p>\r\n        <p>\r\n         （3）用户在注册帐号第一个月时间内或连续6个月时间内，没有使用过此帐号的（包括使用此帐号登录游戏、登录网站或充值）。\r\n        </p>\r\n      </div>\r\n      <p>\r\n       3. 关于溪谷游戏所提供的不同产品和服务注销角色的具体条件，请参见各个产品和服务的具体规定，或相关产品和服务的官方网站上的具体规定。\r\n      </p>\r\n      <p>\r\n       4. 为了保障游戏及游戏平台网站和服务器的正常运行，溪谷游戏需要定期或不定期对游戏及游戏平台网站和服务器进行停机维护，或针对突发事件进行紧急停机维护。<strong class=\"orange\">因上述情况而造成的正常服务中断、中止，用户予以理解并同意，</strong>溪谷游戏则有义务尽力避免服务中断并将中断时间限制在最短时间内。\r\n     </p>\r\n      <div class=\"strong\">\r\n        <p>\r\n         5. 发生下列情形之一时，溪谷游戏有权不经提前通知，终止或中断游戏服务器所提供之全部或部分服务，对因此而产生的不便或损失，溪谷游戏对用户或第三人均不承担任何责任：\r\n       </p>\r\n        <p>\r\n         （1）定期检查或施工，更新软硬件等；\r\n        </p>\r\n        <p>\r\n         （2）服务器遭受损害，无法正常运作；\r\n        </p>\r\n        <p>\r\n         （3）突发性的软硬件设备与电子通信设备故障；\r\n        </p>\r\n        <p>\r\n         （4）网络提供商线路或其他故障；\r\n        </p>\r\n        <p>\r\n         （5）在紧急情况之下依照法律的规定或为用户及第三者之人身安全；\r\n       </p>\r\n        <p>\r\n         （6）第三方原因或其他不可抗力的情形。\r\n       </p>\r\n      </div>\r\n      <p>\r\n       6. 不管产品和服务由于任何原因终止，用户应采取相应的措施自行处理游戏及游戏平台上的虚拟物品。<strong>用户不得因终止服务而要求溪谷游戏承担除用户已经购买但尚未使用的游戏虚拟货币以外任何形式的赔偿或补偿责任</strong>，包括但不限于因不再能继续使用游戏帐号、游戏内虚拟物品等而要求的赔偿。\r\n      </p>\r\n      <h2>\r\n        十二、有限保证及免责声明\r\n      </h2>\r\n     <p>\r\n       1. 对于溪谷游戏的产品和服务，溪谷游戏仅作本条所述有限保证，该有限保证取代任何文档、包装、或其他资料中的任何其他明示或默示的保证（若有）。\r\n      </p>\r\n      <p>\r\n       2. 溪谷游戏仅以“现有状况且包含所有错误”的形式提供相关的产品、软件或程序及任何支持服务，并仅保证：\r\n     </p>\r\n      <p>\r\n       （1）溪谷游戏所提供的产品和服务能基本符合溪谷游戏正式公布的要求；\r\n     </p>\r\n      <p>\r\n       （2）溪谷游戏所提供的相关产品和服务基本与溪谷游戏正式公布的服务承诺相符；\r\n     </p>\r\n      <p>\r\n       （3）溪谷游戏仅在商业上允许的合理范围内尽力解决溪谷游戏在提供产品和服务过程中所遇到的任何问题。\r\n      </p>\r\n      <p>\r\n       3. 在适用法律允许的最大范围内，溪谷游戏明确表示不提供任何其他类型的保证，不论是明示的或默示的，包括但不限于适销性、适用性、可靠性、准确性、完整性、无病毒以及无错误的任何默示保证和责任。\r\n      </p>\r\n      <p>\r\n       4. 在适用法律允许的最大范围内，溪谷游戏并不担保溪谷游戏所提供的产品和服务一定能满足用户的要求，也不担保提供的产品和服务不会被中断，并且不担保产品和服务的及时性、安全性及不受干扰，亦不担保无错误发生，以及信息能准确、及时、顺利地传送。\r\n      </p>\r\n      <p>\r\n       5. 用户理解并同意：通过溪谷游戏的产品和服务取得的任何信息、资料，是否信任及使用，完全取决于用户自己，并<strong class=\"orange\">由用户承担由该等信任及使用带来的系统受损、资料丢失以及其它任何风险。</strong>溪谷游戏对在产品和服务中提及的任何商品购物服务、交易进程、招聘信息，尤其是第三方发出的信息，都不作担保。\r\n     </p>\r\n      <p>\r\n       6. 如有系统故障、安全漏洞（Security Vulnerability）、程序缺陷（Bug）、程序出错等问题，<strong class=\"orange\">溪谷游戏有权把游戏的资料还原到一定日期，以维护游戏之平衡。用户不得因此要求补偿或赔偿。</strong> \r\n     </p>\r\n      <p>\r\n       7. 在适用法律允许的最大范围内，<strong class=\"orange\">溪谷游戏对用户因使用溪谷游戏的产品和服务引起的任何间接、偶然、意外、特殊或继起的损害（包括但不限于人身伤害、隐私泄漏、因未能履行包括诚信或合理谨慎在内的任何责任、因过失和因任何其他金钱上的损失或其他损失而造成的损害赔偿）不负责任，</strong>这些损害可能来自：用户或他人不正当使用产品和服务、在网上购买商品或类似服务、在网上进行交易、非法使用服务或用户传送的信息有所变动。\r\n     </p>\r\n      <div class=\"strong\">\r\n        <p>\r\n         8.\r\n溪谷游戏对本协议项下涉及的境内外基础电信运营商的固定及移动通信网络的故障，各类技术缺陷、覆盖范围限制、不可抗力、计算机病毒、黑客攻击、用户所在位\r\n置、用户关机、合作方因素、他人故意或过失行为或其他非溪谷游戏技术能力范围内的原因造成的服务中断、用户发送的数据或短信息的内容丢失、出现乱码、错误\r\n接收、无法接收、迟延接收等等，均不承担责任。\r\n        </p>\r\n        <p>\r\n         9. 由于用户个人失误、错误或不当操作导致的任何后果，由用户自行承担责任，溪谷游戏不予任何赔偿或补偿。\r\n       </p>\r\n      </div>\r\n      <h2>\r\n        十三、知识产权及信息所有权\r\n     </h2>\r\n     <p>\r\n       1.\r\n溪谷游戏通过产品和服务提供的游戏软件（包括具备客户端软件及不具备客户端软件的游戏）、其他软件、信息、作品及资料，其著作权、专利权、商标专用权及其\r\n它知识产权，均为溪谷游戏或其相应权利人所有。除非事先经 \r\n溪谷游戏书面合法授权，或法律另有明文规定，任何人不得擅自以任何形式使用、复制、传播、伪造、模仿、修改、改编、翻译、汇编、出版、进行反编译或反汇编\r\n等反向工程，<strong class=\"orange\">否则溪谷游戏有权立即终止向用户提供产品和服务，并依法追究其知识产权侵权责任，要求用户赔偿溪谷游戏的一切损失。</strong> \r\n     </p>\r\n      <p>\r\n       2.\r\n用户在使用产品和服务过程中产生并储存于溪谷游戏服务器中的任何数据信息（包括但不限于帐号数据信息、角色数据信息、等级物品数据信息等，但用户的姓名、\r\n身份证号、电话号码等个人身份数据信息除外）属于游戏或游戏平台的一部分，由溪谷游戏所有并进行管理，用户有权在遵守游戏规则的前提下通过溪谷游戏指定的\r\n途径对属于自身帐号的数据信息进行修改、转移、处分。\r\n     </p>\r\n      <p>\r\n       3. 为保证准确及避免争议，本协议涉及到的有关技术方面的数据、信息，用户同意以溪谷游戏服务器所储存的数据作为判断标准。溪谷游戏保证该数据的真实性。\r\n     </p>\r\n      <h2>\r\n        十四、损害赔偿\r\n     </h2>\r\n     <p class=\"strong\">\r\n        用\r\n户若违反本协议或可适用的法律法规，导致溪谷游戏的母公司、子公司、其他关联公司、附属机构及其人员，受雇人、代理人及其他一切相关履行辅助人员因此受到\r\n损害或支出任何衍生费用（包括但不限于支付上述法律主体须就用户的违约或违法行为所进行的一切辩护或索偿诉讼及相关和解之法律费用），用户应承担补偿相关\r\n费用及支付损害赔偿的责任。\r\n      </p>\r\n      <h2>\r\n        十五、协议的终止\r\n      </h2>\r\n     <p>\r\n       用户应遵守本协议及有关法律法规的规定。溪谷游戏有权判断用户是否违反本协议。<strong class=\"orange\">若溪谷游戏认定用户违反本协议或任何法律法规，溪谷游戏有权在无需向用户进行事先通知的情况之下，立即暂停或终止用户的帐号并删除用户帐号中的所有相关资料、档案及任何记录，以及限制、停止或取消用户的使用资格。</strong> \r\n      </p>\r\n      <h2>\r\n        十六、修改和解释权\r\n     </h2>\r\n     <p>\r\n       1. 为了向用户及时、更好地提供产品和服务，基于对溪谷游戏本身、用户及市场状况不断变化的考虑，溪谷游戏保留随时修改、新增、删除本协议条款的权利。修改、新增、删除本协议条款时，<strong class=\"orange\">溪谷游戏将于官方网站公告修改、新增、删除的事实，而不另行对用户进行个别通知。</strong>若用户不同意溪谷游戏所修改、新增、删除的内容，可立即停止使用溪谷游戏所提供的服务。<strong class=\"orange\">若用户继续使用溪谷游戏提供的服务，则视同用户同意并接受本协议条款修改、新增、删除后的内容，且不得因此而要求任何补偿或赔偿。</strong> \r\n      </p>\r\n      <p class=\"orange\">\r\n        2. 未经溪谷游戏事先书面同意，用户不得转让其在本协议项下的权利或义务。溪谷游戏有权通过溪谷游戏的子公司或其他关联公司行使其在本协议项下的权利或履行本协议项下的义务。\r\n     </p>\r\n      <h2>\r\n        十七、广告与外部链接\r\n      </h2>\r\n     <p>\r\n       1.\r\n溪谷游戏的产品和服务中可能包含他人的商业广告或其它活动促销的广告。这些内容由广告商或商品／服务提供者提供并承担相应责任，溪谷游戏仅提供刊登内容的\r\n媒介。用户通过溪谷游戏或溪谷游戏所链接的网站所购买的该等服务或商品，其交易行为仅存于用户与该等商品或服务的提供者之间，与溪谷游戏无关，<strong class=\"orange\">溪谷游戏不就用户与该商品或服务的提供者之间所产生的交易行为承担任何法律责任。</strong> \r\n      </p>\r\n      <p>\r\n       2. 用户可能在使用溪谷游戏的产品和服务过程中链接到第三方的站点。第三方的站点不由溪谷游戏控制，并且<strong class=\"orange\">溪谷游戏也不对任何第三方站点的内容、第三方站点包含的任何链接、第三方站点的任何更改或更新负责。</strong>溪\r\n谷游戏仅为了提供便利的目的而向用户提供这些到第三方站点的链接，溪谷游戏所提供的这些链接并不意味着溪谷游戏认可该第三方站点，不意味着溪谷游戏担保其\r\n真实性、完整性、实时性或可信度。这些个人、公司或组织与溪谷游戏间亦不存在任何雇用、委任、代理、合伙或其它类似的关系。用户需要检查并遵守该第三方站\r\n点的相关规定。\r\n     </p>\r\n      <p>\r\n       3. 用户理解并同意溪谷游戏通过电子邮件、短信或者其他方式向用户发送产品和服务或其他相关商业信息。\r\n     </p>\r\n      <h2>\r\n        十八、其他约定\r\n     </h2>\r\n     <p>\r\n       1. 本协议的订立、效力、解释、履行及争议解决适用中华人民共和国法律。如果本协议的任何内容与法律相抵触，应以法律规定为准。\r\n     </p>\r\n      <p>\r\n       2. 本协议的任何条款部分或全部无效的，不影响其它条款的效力。\r\n     </p>\r\n      <p class=\"strong\">\r\n        3. 就本协议产生的争议及纠纷，用户与溪谷游戏应友好协商解决。协商不成的，任何一方有权向本协议签订地人民法院提起诉讼。\r\n     </p>\r\n      <p class=\"strong\">\r\n        4. 本协议于用户完成溪谷游戏帐号注册之日在上海市嘉定区签订并生效。即便用户没有完成溪谷游戏帐号注册，但通过其他任何方式获得和使用溪谷游戏所提供的产品和服务的，本协议视为在该用户获得及使用产品和服务之日签订并生效。\r\n     </p>\r\n    </div>\r\n    <div class=\"content-footer\">\r\n      <p>\r\n       为\r\n用户营造舒适、公平、富有人情味的游戏环境是我们的目的。溪谷游戏平台关注用户需求，随时敞开心扉接纳不同地域、年龄和文化背景的用户。不论是在各自工作\r\n岗位上行使着自己的使命的溪谷游戏工作人员，或是数以万计在溪谷游戏平台游戏中扮演不同角色的用户，都对网游抱怀着许多的期待和梦想。我们对尊重游戏规则\r\n和尊重他人的用户满怀感激和敬意，让我们携手创造一个绿色的游戏环境！\r\n      </p>\r\n      <p>\r\n       青少年用户必须遵守全国青少年网络文明公约：要善于网上学习，不浏览不良信息；要诚实友好交流，不侮辱欺诈他人；要增强自护意识，不随意约会网友；要维护网络安全，不破坏网络秩序；要有益身心健康，不沉溺虚拟时空。\r\n     </p>\r\n    </div>\r\n    <div class=\"fixed\">\r\n     <a>返回注册</a> \r\n    </div>\r\n  </div>\r\n</div>', '', '0');
INSERT INTO `sys_document_article` VALUES ('5', '0', '12131313', '', '0');
INSERT INTO `sys_document_article` VALUES ('6', '0', '12121', '', '0');
INSERT INTO `sys_document_article` VALUES ('7', '0', '上面的查询条件仅仅是一个简单的相等判断，可以使用查询表达式支持更多的SQL查询语法，并且可以用于数组或者对象方式的查询（下面仅以数组方式为例说明），查询表达式的使用格式：<br />\r\n$map[\'字段名\']  = array(\'表达式\',\'查询条件\');<br />\r\n表达式不分大小写，支持的查询表达式有下面几种，分别表示的含义是：上面的查询条件仅仅是一个简单的相等判断，可以使用查询表达式支持更多的SQL查询语法，并且可以用于数组或者对象方式的查询（下面仅以数组方式为例说明），查询表达式的使用格式：<br />\r\n$map[\'字段名\']  = array(\'表达式\',\'查询条件\');<br />\r\n表达式不分大小写，支持的查询表达式有下面几种，分别表示的含义是：上面的查询条件仅仅是一个简单的相等判断，可以使用查询表达式支持更多的SQL查询语法，并且可以用于数组或者对象方式的查询（下面仅以数组方式为例说明），查询表达式的使用格式：<br />\r\n$map[\'字段名\']  = array(\'表达式\',\'查询条件\');<br />\r\n<p>\r\n 表达式不分大小写，支持的查询表达式有下面几种，分别表示的含义是：\r\n</p>\r\n<p>\r\n <img src=\"/Uploads/Editor/2016-09-26/57e87f6972bda.jpg\" alt=\"\" /> \r\n</p>', '', '0');
INSERT INTO `sys_document_article` VALUES ('8', '0', '222222222222222222222222222222', '', '0');

-- ----------------------------
-- Table structure for sys_document_download
-- ----------------------------
DROP TABLE IF EXISTS `sys_document_download`;
CREATE TABLE `sys_document_download` (
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文档ID',
  `parse` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '内容解析类型',
  `content` text NOT NULL COMMENT '下载详细描述',
  `template` varchar(100) NOT NULL DEFAULT '' COMMENT '详情页显示模板',
  `file_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件ID',
  `download` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下载次数',
  `size` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文档模型下载表';

-- ----------------------------
-- Records of sys_document_download
-- ----------------------------

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` char(20) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` char(30) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(5) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(40) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `location` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文件保存位置',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '远程地址',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上传时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_md5` (`md5`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='文件表';

-- ----------------------------
-- Records of sys_file
-- ----------------------------

-- ----------------------------
-- Table structure for sys_hooks
-- ----------------------------
DROP TABLE IF EXISTS `sys_hooks`;
CREATE TABLE `sys_hooks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(40) NOT NULL DEFAULT '' COMMENT '钩子名称',
  `description` text COMMENT '描述',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '类型',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `addons` varchar(255) NOT NULL DEFAULT '' COMMENT '钩子挂载的插件 ''，''分割',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_hooks
-- ----------------------------
INSERT INTO `sys_hooks` VALUES ('1', 'pageHeader', '页面header钩子，一般用于加载插件CSS文件和代码', '1', '0', '', '1');
INSERT INTO `sys_hooks` VALUES ('2', 'pageFooter', '页面footer钩子，一般用于加载插件JS文件和JS代码', '1', '0', 'ReturnTop', '1');
INSERT INTO `sys_hooks` VALUES ('3', 'documentEditForm', '添加编辑表单的 扩展内容钩子', '1', '0', 'Attachment', '1');
INSERT INTO `sys_hooks` VALUES ('4', 'documentDetailAfter', '文档末尾显示', '1', '0', 'Attachment,SocialComment', '1');
INSERT INTO `sys_hooks` VALUES ('5', 'documentDetailBefore', '页面内容前显示用钩子', '1', '0', '', '1');
INSERT INTO `sys_hooks` VALUES ('6', 'documentSaveComplete', '保存文档数据后的扩展钩子', '2', '0', 'Attachment', '1');
INSERT INTO `sys_hooks` VALUES ('7', 'documentEditFormContent', '添加编辑表单的内容显示钩子', '1', '0', 'Editor', '1');
INSERT INTO `sys_hooks` VALUES ('8', 'adminArticleEdit', '后台内容编辑页编辑器', '1', '1378982734', 'EditorForAdmin', '1');
INSERT INTO `sys_hooks` VALUES ('13', 'AdminIndex', '首页小格子个性化显示', '1', '1382596073', 'SiteStat,SystemInfo,DevTeam', '1');
INSERT INTO `sys_hooks` VALUES ('14', 'topicComment', '评论提交方式扩展钩子。', '1', '1380163518', 'Editor', '1');
INSERT INTO `sys_hooks` VALUES ('16', 'app_begin', '应用开始', '2', '1384481614', '', '1');
INSERT INTO `sys_hooks` VALUES ('17', 'UploadImages', '多图片上传', '1', '1465785232', 'UploadImages', '1');

-- ----------------------------
-- Table structure for sys_links
-- ----------------------------
DROP TABLE IF EXISTS `sys_links`;
CREATE TABLE `sys_links` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `mark` varchar(50) NOT NULL DEFAULT '0' COMMENT '所属后台',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_links
-- ----------------------------

-- ----------------------------
-- Table structure for sys_member
-- ----------------------------
DROP TABLE IF EXISTS `sys_member`;
CREATE TABLE `sys_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `nickname` char(16) NOT NULL DEFAULT '' COMMENT '昵称',
  `sex` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '性别',
  `birthday` date NOT NULL DEFAULT '0000-00-00' COMMENT '生日',
  `qq` char(10) NOT NULL DEFAULT '' COMMENT 'qq号',
  `score` mediumint(8) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '会员状态',
  PRIMARY KEY (`uid`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of sys_member
-- ----------------------------

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文档ID',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '标题',
  `pp` int(11) DEFAULT '0' COMMENT '商务后台权限',
  `pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID',
  `sort` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '排序（同级有效）',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `hide` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否隐藏',
  `tip` varchar(255) NOT NULL DEFAULT '' COMMENT '提示',
  `group` varchar(50) DEFAULT '' COMMENT '分组',
  `is_dev` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否仅开发者模式可见',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=278 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '首页', '1', '0', '1', 'Index/index', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('2', '文章', '0', '0', '2', 'Article/mydocument', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('3', '文档列表', '0', '2', '0', 'article/index', '1', '', '内容', '0', '1');
INSERT INTO `sys_menu` VALUES ('4', '新增', '0', '3', '0', 'article/add', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('5', '编辑', '0', '3', '0', 'article/edit', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('6', '改变状态', '0', '3', '0', 'article/setStatus', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('7', '保存', '0', '3', '0', 'article/update', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('8', '保存草稿', '0', '3', '0', 'article/autoSave', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('9', '移动', '0', '3', '0', 'article/move', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('10', '复制', '0', '3', '0', 'article/copy', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('11', '粘贴', '0', '3', '0', 'article/paste', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('12', '导入', '0', '3', '0', 'article/batchOperate', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('13', '回收站', '0', '2', '0', 'article/recycle', '1', '', '内容', '0', '1');
INSERT INTO `sys_menu` VALUES ('14', '还原', '0', '13', '0', 'article/permit', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('15', '清空', '0', '13', '0', 'article/clear', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('16', '用户', '0', '0', '3', 'User/index', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('17', '管理员', '0', '16', '1', 'User/index', '0', '', '管理组', '0', '1');
INSERT INTO `sys_menu` VALUES ('18', '新增用户', '0', '17', '0', 'User/add', '0', '添加新用户', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('19', '行为文档', '0', '16', '4', 'User/action', '0', '', '管理组', '0', '1');
INSERT INTO `sys_menu` VALUES ('20', '新增用户行为', '0', '19', '0', 'User/addaction', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('21', '编辑用户行为', '0', '19', '0', 'User/editaction', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('22', '保存用户行为', '0', '19', '0', 'User/saveAction', '0', '\"用户->用户行为\"保存编辑和新增的用户行为', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('23', '变更行为状态', '0', '19', '0', 'User/setStatus', '0', '\"用户->用户行为\"中的启用,禁用和删除权限', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('24', '禁用会员', '0', '19', '0', 'User/changeStatus?method=forbidUser', '0', '\"用户->用户信息\"中的禁用', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('25', '启用会员', '0', '19', '0', 'User/changeStatus?method=resumeUser', '0', '\"用户->用户信息\"中的启用', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('26', '删除会员', '0', '19', '0', 'User/changeStatus?method=deleteUser', '0', '\"用户->用户信息\"中的删除', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('27', '角色管理', '0', '16', '2', 'AuthManager/index', '0', '', '管理组', '0', '1');
INSERT INTO `sys_menu` VALUES ('28', '删除', '0', '27', '0', 'AuthManager/changeStatus?method=deleteGroup', '0', '删除用户组', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('29', '禁用', '0', '27', '0', 'AuthManager/changeStatus?method=forbidGroup', '0', '禁用用户组', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('30', '恢复', '0', '27', '0', 'AuthManager/changeStatus?method=resumeGroup', '0', '恢复已禁用的用户组', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('31', '新增', '0', '27', '0', 'AuthManager/createGroup', '0', '创建新的用户组', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('32', '编辑', '0', '27', '0', 'AuthManager/editGroup', '0', '编辑用户组名称和描述', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('33', '保存用户组', '0', '27', '0', 'AuthManager/writeGroup', '0', '新增和编辑用户组的\"保存\"按钮', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('34', '授权', '0', '27', '0', 'AuthManager/group', '0', '\"后台 \\ 用户 \\ 用户信息\"列表页的\"授权\"操作按钮,用于设置用户所属用户组', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('35', '访问授权', '0', '27', '0', 'AuthManager/access', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"访问授权\"操作按钮', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('36', '成员授权', '0', '27', '0', 'AuthManager/user', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"成员授权\"操作按钮', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('37', '解除授权', '0', '27', '0', 'AuthManager/removeFromGroup', '0', '\"成员授权\"列表页内的解除授权操作按钮', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('38', '保存成员授权', '0', '27', '0', 'AuthManager/addToGroup', '0', '\"用户信息\"列表页\"授权\"时的\"保存\"按钮和\"成员授权\"里右上角的\"添加\"按钮)', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('39', '分类授权', '0', '27', '0', 'AuthManager/category', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"分类授权\"操作按钮', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('40', '保存分类授权', '0', '27', '0', 'AuthManager/addToCategory', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('41', '模型授权', '0', '27', '0', 'AuthManager/modelauth', '0', '\"后台 \\ 用户 \\ 权限管理\"列表页的\"模型授权\"操作按钮', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('42', '保存模型授权', '0', '27', '0', 'AuthManager/addToModel', '0', '\"分类授权\"页面的\"保存\"按钮', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('43', '扩展', '0', '0', '10', 'Addons/index', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('44', '插件管理', '0', '43', '1', 'Addons/index', '0', '', '扩展', '0', '1');
INSERT INTO `sys_menu` VALUES ('45', '创建', '0', '44', '0', 'Addons/create', '0', '服务器上创建插件结构向导', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('46', '检测创建', '0', '44', '0', 'Addons/checkForm', '0', '检测插件是否可以创建', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('47', '预览', '0', '44', '0', 'Addons/preview', '0', '预览插件定义类文件', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('48', '快速生成插件', '0', '44', '0', 'Addons/build', '0', '开始生成插件结构', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('49', '设置', '0', '44', '0', 'Addons/config', '0', '设置插件配置', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('50', '禁用', '0', '44', '0', 'Addons/disable', '0', '禁用插件', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('51', '启用', '0', '44', '0', 'Addons/enable', '0', '启用插件', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('52', '安装', '0', '44', '0', 'Addons/install', '0', '安装插件', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('53', '卸载', '0', '44', '0', 'Addons/uninstall', '0', '卸载插件', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('54', '更新配置', '0', '44', '0', 'Addons/saveconfig', '0', '更新插件配置处理', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('55', '插件后台列表', '0', '44', '0', 'Addons/adminList', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('56', 'URL方式访问插件', '0', '44', '0', 'Addons/execute', '0', '控制是否有权限通过url访问插件控制器方法', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('57', '钩子管理', '0', '43', '2', 'Addons/hooks', '0', '', '扩展', '0', '1');
INSERT INTO `sys_menu` VALUES ('58', '模型管理', '0', '68', '8', 'Model/index', '0', '', '系统设置', '0', '1');
INSERT INTO `sys_menu` VALUES ('59', '新增', '0', '58', '0', 'model/add', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('60', '编辑', '0', '58', '0', 'model/edit', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('61', '改变状态', '0', '58', '0', 'model/setStatus', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('62', '保存数据', '0', '58', '0', 'model/update', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('63', '属性管理', '0', '68', '1', 'Attribute/index', '1', '网站属性配置。', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('64', '新增', '0', '63', '0', 'Attribute/add', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('65', '编辑', '0', '63', '0', 'Attribute/edit', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('66', '改变状态', '0', '63', '0', 'Attribute/setStatus', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('67', '保存数据', '0', '63', '0', 'Attribute/update', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('68', '系统', '0', '0', '9', 'Config/group', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('69', '网站设置', '0', '68', '6', 'Config/group', '0', '', '系统设置', '0', '1');
INSERT INTO `sys_menu` VALUES ('70', '配置管理', '0', '68', '9', 'Config/index', '0', '', '系统设置', '0', '1');
INSERT INTO `sys_menu` VALUES ('71', '编辑', '0', '70', '0', 'Config/edit', '0', '新增编辑和保存配置', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('72', '删除', '0', '70', '0', 'Config/del', '0', '删除配置', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('73', '新增', '0', '70', '0', 'Config/add', '0', '新增配置', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('74', '保存', '0', '70', '0', 'Config/save', '0', '保存配置', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('75', '菜单管理', '0', '68', '10', 'Menu/index', '0', '', '系统设置', '0', '1');
INSERT INTO `sys_menu` VALUES ('76', '导航管理', '0', '68', '11', 'Channel/index', '0', '', '系统设置', '0', '1');
INSERT INTO `sys_menu` VALUES ('77', '新增', '0', '76', '0', 'Channel/add', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('78', '编辑', '0', '76', '0', 'Channel/edit', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('79', '删除', '0', '76', '0', 'Channel/del', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('80', '分类管理', '0', '68', '7', 'Category/index', '0', '', '系统设置', '0', '1');
INSERT INTO `sys_menu` VALUES ('81', '编辑', '0', '80', '0', 'Category/edit', '0', '编辑和保存栏目分类', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('82', '新增', '0', '80', '0', 'Category/add', '0', '新增栏目分类', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('83', '删除', '0', '80', '0', 'Category/remove', '0', '删除栏目分类', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('84', '移动', '0', '80', '0', 'Category/operate/type/move', '0', '移动栏目分类', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('85', '合并', '0', '80', '0', 'Category/operate/type/merge', '0', '合并栏目分类', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('86', '备份数据库', '0', '68', '2', 'Database/index?type=export', '0', '', '数据备份', '0', '1');
INSERT INTO `sys_menu` VALUES ('87', '备份', '0', '86', '0', 'Database/export', '0', '备份数据库', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('88', '优化表', '0', '86', '0', 'Database/optimize', '0', '优化数据表', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('89', '修复表', '0', '86', '0', 'Database/repair', '0', '修复数据表', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('90', '还原数据库', '0', '68', '3', 'Database/index?type=import', '0', '', '数据备份', '0', '1');
INSERT INTO `sys_menu` VALUES ('91', '恢复', '0', '90', '0', 'Database/import', '0', '数据库恢复', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('92', '删除', '0', '90', '0', 'Database/del', '0', '删除备份文件', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('93', '其他', '0', '0', '11', 'other', '1', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('96', '新增', '0', '75', '0', 'Menu/add', '0', '', '系统设置', '0', '1');
INSERT INTO `sys_menu` VALUES ('98', '编辑', '0', '75', '0', 'Menu/edit', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('106', '行为日志', '0', '16', '3', 'Action/actionlog', '0', '', '管理组', '0', '1');
INSERT INTO `sys_menu` VALUES ('108', '修改密码', '0', '16', '5', 'User/updatePassword', '1', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('109', '修改昵称', '0', '16', '6', 'User/updateNickname', '1', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('110', '查看行为日志', '0', '106', '0', 'action/edit', '1', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('112', '新增数据', '0', '58', '0', 'think/add', '1', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('113', '编辑数据', '0', '58', '0', 'think/edit', '1', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('114', '导入', '0', '75', '0', 'Menu/import', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('115', '生成', '0', '58', '0', 'Model/generate', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('116', '新增钩子', '0', '57', '0', 'Addons/addHook', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('117', '编辑钩子', '0', '57', '0', 'Addons/edithook', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('118', '文档排序', '0', '3', '0', 'Article/sort', '1', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('119', '排序', '0', '70', '0', 'Config/sort', '1', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('120', '排序', '0', '75', '0', 'Menu/sort', '1', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('121', '排序', '0', '76', '0', 'Channel/sort', '1', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('122', '数据列表', '0', '58', '0', 'think/lists', '1', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('123', '审核列表', '0', '3', '0', 'Article/examine', '1', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('124', '游戏', '0', '0', '4', 'Game/lists', '0', '游戏管理', '游戏管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('125', '游戏管理', '0', '124', '1', 'Game/lists', '0', '游戏管理', '游戏管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('126', '新增', '0', '125', '0', 'Game/add', '0', '新增游戏', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('127', '编辑', '0', '125', '0', 'Game/edit', '0', '编辑游戏', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('128', '游戏分类', '0', '124', '2', 'GameType/lists', '0', '游戏类型管理', '游戏管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('129', '新增', '0', '128', '0', 'GameType/add', '0', '新增游戏类型', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('130', '编辑', '0', '128', '0', 'GameType/edit', '0', '编辑游戏类型', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('131', '游戏区服', '0', '124', '3', 'Server/lists', '0', '游戏区服', '游戏管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('132', '新增', '0', '131', '0', 'Server/add', '0', '新增区服', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('133', '编辑', '0', '131', '0', 'Server/edit', '0', '编辑游戏区服', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('134', '礼包管理', '0', '124', '5', 'Giftbag/lists', '0', '礼包管理', '礼包管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('135', '领取记录', '0', '124', '6', 'Giftbag/record', '0', '礼包管理', '礼包管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('136', '新增', '0', '134', '0', 'Giftbag/add', '0', '新增礼包', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('137', '编辑', '0', '134', '0', 'Giftbag/edit', '0', '礼包管理', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('139', '渠道管理', '1', '138', '1', 'Promote/lists', '0', '渠道管理', '渠道管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('140', '新增', '0', '139', '0', 'Promote/add', '0', '新增渠道', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('141', '编辑', '0', '139', '0', 'Promote/edit', '0', '编辑渠道', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('142', '渠道补链', '0', '138', '2', 'Mend/lists', '0', '渠道补链', '渠道管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('143', '补链记录', '0', '138', '3', 'Mend/record', '0', '补链记录', '渠道管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('144', '渠道注册', '1', '138', '4', 'Promote/ch_reg_list', '0', '渠道注册用户', '渠道数据', '0', '1');
INSERT INTO `sys_menu` VALUES ('145', '渠道充值', '1', '138', '6', 'Promote/spend_list', '0', '', '渠道数据', '0', '1');
INSERT INTO `sys_menu` VALUES ('146', '代充记录', '1', '138', '7', 'Promote/agent_list', '0', '', '渠道数据', '0', '1');
INSERT INTO `sys_menu` VALUES ('147', '代充额度', '0', '138', '8', 'Promote/pay_limit', '0', '', '渠道数据', '0', '1');
INSERT INTO `sys_menu` VALUES ('148', '渠道对账', '1', '138', '9', 'Query/bill', '0', '', '渠道对账', '0', '1');
INSERT INTO `sys_menu` VALUES ('149', '渠道结算', '0', '138', '10', 'Query/settlement', '0', '', '渠道对账', '0', '1');
INSERT INTO `sys_menu` VALUES ('150', '渠道提现', '0', '138', '11', 'Query/withdraw', '0', '', '渠道对账', '0', '1');
INSERT INTO `sys_menu` VALUES ('151', '平台用户', '0', '16', '7', 'Member/user_info', '0', '', '用户组', '0', '1');
INSERT INTO `sys_menu` VALUES ('152', '登陆记录', '0', '16', '8', 'Member/login_record', '0', '', '用户组', '0', '1');
INSERT INTO `sys_menu` VALUES ('153', '游戏消费记录', '0', '16', '9', 'Spend/lists', '0', '', '充值组', '0', '1');
INSERT INTO `sys_menu` VALUES ('154', '平台币充值记录', '0', '16', '10', 'Deposit/lists', '0', '', '充值组', '0', '1');
INSERT INTO `sys_menu` VALUES ('155', '后台充值记录', '0', '16', '12', 'Provide/lists', '0', '', '充值组', '0', '1');
INSERT INTO `sys_menu` VALUES ('156', '绑币使用记录', '0', '16', '13', 'BindSpend/lists', '0', '', '充值组', '0', '1');
INSERT INTO `sys_menu` VALUES ('157', '站点', '0', '0', '7', 'Site/media', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('158', '基本配置', '0', '157', '1', 'Site/media', '0', '媒体官网的基本配置', '媒体官网', '0', '1');
INSERT INTO `sys_menu` VALUES ('159', '广告管理', '0', '157', '2', 'Adv/media_adv_pos_lists', '0', '', '媒体官网', '0', '1');
INSERT INTO `sys_menu` VALUES ('163', '广告管理', '0', '157', '5', 'Adv/app_adv_pos_lists', '1', '', 'APP管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('164', '编辑媒体广告位', '0', '159', '0', 'Adv/edit_media_adv_pos', '0', '编辑媒体广告位', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('165', '编辑app广告位', '0', '163', '0', 'Adv/edit_app_adv_pos', '0', '编辑app广告位', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('166', '媒体广告列表', '0', '159', '0', 'Adv/media_adv_lists', '0', '媒体广告列表', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('167', '编辑媒体广告', '0', '159', '0', 'Adv/edit_media_adv', '0', '编辑媒体广告', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('168', '新增媒体广告', '0', '159', '0', 'Adv/add_media_adv', '0', '新增媒体广告', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('169', 'app广告列表', '0', '163', '0', 'Adv/app_adv_lists', '0', 'app广告列表', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('170', '新增app广告', '0', '163', '0', 'Adv/add_app_adv', '0', '新增app广告', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('171', '编辑app广告', '0', '163', '0', 'Adv/edit_app_adv', '0', '编辑app广告', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('172', '广告列表', '0', '157', '6', 'Adv/adv_lists', '0', '', '广告列表', '0', '1');
INSERT INTO `sys_menu` VALUES ('173', '编辑', '0', '172', '0', 'Adv/edit_adv', '0', '编辑广告', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('174', '图标设置', '0', '157', '3', 'Logo/media_logo', '0', '', '媒体官网', '0', '1');
INSERT INTO `sys_menu` VALUES ('175', '图标设置', '0', '157', '7', 'Logo/app_logo', '1', '', 'APP管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('177', '短信设置', '0', '68', '12', 'Tool/smsset', '0', '', '扩展工具', '0', '1');
INSERT INTO `sys_menu` VALUES ('179', '支付设置', '0', '68', '14', 'Tool/payset', '0', '', '扩展工具', '0', '1');
INSERT INTO `sys_menu` VALUES ('180', '第三方登陆', '0', '68', '16', 'Tool/thirdparty', '0', '', '扩展工具', '0', '1');
INSERT INTO `sys_menu` VALUES ('181', '邮件设置', '0', '68', '15', 'Tool/email', '0', '', '扩展工具', '0', '1');
INSERT INTO `sys_menu` VALUES ('182', '日常统计', '0', '160', '1', 'Stat/daily', '0', '', '日常统计', '0', '1');
INSERT INTO `sys_menu` VALUES ('183', '来款统计', '0', '160', '2', 'stat/pay_way', '0', '', '日常统计', '0', '1');
INSERT INTO `sys_menu` VALUES ('184', '登陆统计', '0', '160', '3', 'stat/cpa_login', '0', '', 'CPS统计', '0', '1');
INSERT INTO `sys_menu` VALUES ('185', '注册统计', '0', '160', '4', 'stat/cpa_register', '0', '', 'CPS统计', '0', '1');
INSERT INTO `sys_menu` VALUES ('186', '消费统计', '0', '160', '5', 'stat/cpa_spend', '0', '', 'CPS统计', '0', '1');
INSERT INTO `sys_menu` VALUES ('187', '留存统计', '0', '160', '6', 'stat/userretention', '0', '', '运营分析', '0', '1');
INSERT INTO `sys_menu` VALUES ('188', 'ARPU统计', '1', '160', '7', 'stat/userarpu', '0', '', '运营分析', '0', '1');
INSERT INTO `sys_menu` VALUES ('255', '充值记录查看', '0', '151', '0', 'Member/chax', '0', '', '用户编辑', '0', '1');
INSERT INTO `sys_menu` VALUES ('190', '新增', '0', '189', '0', 'GameSource/add', '0', '上传游戏原包', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('191', '编辑', '0', '189', '0', 'GameSource/edit', '0', '编辑游戏原包', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('192', '渠道补链', '0', '142', '0', 'Mend/edit', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('194', '用户编辑', '0', '151', '0', 'Member/edit', '0', '', '平台用户', '0', '1');
INSERT INTO `sys_menu` VALUES ('195', '分包管理', '1', '138', '4', 'Apply/lists', '0', '', '渠道管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('196', '编辑', '1', '195', '0', 'Apply/edit', '0', '', '分包管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('197', '提现添加', '0', '150', '0', 'Query/withdraw_add', '0', '', '渠道提现', '0', '1');
INSERT INTO `sys_menu` VALUES ('199', '礼包类型', '0', '124', '7', 'GiftbagType/lists', '1', '', '礼包管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('200', '后台充值', '0', '16', '11', 'Provide/bdfirstpay', '0', '', '充值组', '0', '1');
INSERT INTO `sys_menu` VALUES ('201', '编辑', '0', '199', '1', 'GiftbagType/edit', '0', '', '礼包类型', '0', '1');
INSERT INTO `sys_menu` VALUES ('202', '新增', '0', '199', '0', 'GiftbagType/add', '0', '', '礼包类型', '0', '1');
INSERT INTO `sys_menu` VALUES ('204', 'PC友情链接', '0', '157', '4', 'Links/pclists', '0', '', '媒体官网', '0', '1');
INSERT INTO `sys_menu` VALUES ('205', '新增', '0', '204', '0', 'Links/add', '0', '', '友情链接', '0', '1');
INSERT INTO `sys_menu` VALUES ('206', '编辑', '0', '204', '0', 'Links/edit', '0', '', '友情链接', '0', '1');
INSERT INTO `sys_menu` VALUES ('208', '新增', '0', '147', '0', 'Promote/pay_limit_add', '0', '', '代充额度', '0', '1');
INSERT INTO `sys_menu` VALUES ('209', '编辑', '0', '147', '0', 'Promote/pay_limit_edit', '0', '', '代充额度', '0', '1');
INSERT INTO `sys_menu` VALUES ('211', '意见反馈', '0', '124', '5', 'Message/feedback', '0', '', '游戏管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('213', '新增', '0', '212', '0', 'Game/addopen', '0', '', '开放类型', '0', '1');
INSERT INTO `sys_menu` VALUES ('214', '编辑', '0', '212', '1', 'Game/editopen', '0', '', '开发类型', '0', '1');
INSERT INTO `sys_menu` VALUES ('215', '开放类型', '0', '124', '0', 'Opentype/lists', '0', '', '游戏管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('216', '新增', '0', '215', '0', 'Opentype/add', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('217', '修改', '0', '215', '0', 'Opentype/edit', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('220', '新增', '0', '218', '0', 'Rebate/add', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('221', '编辑', '0', '218', '0', 'Rebate/edit', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('222', '打包', '0', '195', '0', 'Apply/package', '0', '', '分包管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('254', '绑定平台余额查看', '0', '151', '0', 'Member/bind_balance', '0', '', '用户编辑', '0', '1');
INSERT INTO `sys_menu` VALUES ('224', '新增', '0', '223', '0', 'Push/add', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('225', '编辑', '0', '223', '0', 'Push/edit', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('253', '编辑', '0', '17', '0', 'User/edit', '0', '', '管理员', '0', '1');
INSERT INTO `sys_menu` VALUES ('227', '新增', '0', '226', '0', 'push/add_list', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('228', '编辑', '0', '226', '0', 'push/edit_list', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('229', '审核', '0', '195', '0', 'Apply/set_status', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('230', '启用', '0', '17', '0', 'User/changeStatus?method=resumeUser', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('231', '禁用', '0', '17', '0', 'User/changeStatus?method=forbidUser', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('232', '删除', '0', '17', '0', 'User/changeStatus?method=deleteUser', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('233', '清除', '0', '106', '0', 'Action/clear', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('234', '删除', '0', '106', '0', 'Action/remove', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('235', '删除', '0', '152', '0', 'Member/delprovide', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('236', '充值', '0', '155', '0', 'Provide/batch', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('237', '删除', '0', '155', '0', 'Provide/delprovide', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('238', '删除', '0', '125', '0', 'Game/del', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('239', '排序', '0', '125', '0', 'Game/sort', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('240', '推荐/不推荐', '0', '125', '0', 'Game/set_status', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('241', '删除', '0', '219', '0', 'Rebatelist/del', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('242', '启用/禁用', '0', '128', '0', 'GameType/set_status', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('243', '修复', '0', '211', '0', 'Message/set_status', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('244', '审核/拉黑', '0', '139', '0', 'Promote/set_status', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('245', '锁定/解锁', '0', '144', '0', 'Promote/set_status', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('246', '结算', '0', '149', '0', 'Query/settl', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('247', '启用/禁用', '0', '159', '0', 'Promote/set_status', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('248', '删除', '0', '204', '0', 'Links/del', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('249', '启用', '0', '163', '0', 'Promote/set_status', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('250', '删除', '0', '172', '0', 'Adv/del_adv', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('252', '想', '0', '189', '0', 'File/shard_upload', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('256', '游戏登录记录', '0', '151', '0', 'Member/denglu', '0', '', '用户编辑', '0', '1');
INSERT INTO `sys_menu` VALUES ('257', '删除', '0', '131', '0', 'Server/del', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('258', '删除', '0', '134', '0', 'Giftbag/del', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('259', '删除', '0', '218', '0', 'Rebate/del', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('260', '删除', '0', '195', '0', 'Apply/del', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('261', '渠道结算', '0', '138', '0', 'Query/cpsettlement', '0', '', 'CP结算', '0', '1');
INSERT INTO `sys_menu` VALUES ('263', '游戏管理', '0', '262', '1', 'MixGame/lists', '0', '', '混服管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('264', '混服设置', '0', '262', '2', 'MixGame/setlists', '0', '', '混服管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('265', '合作者管理', '0', '262', '3', 'MixUser/lists', '0', '', '混服管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('266', '实时注册', '0', '262', '4', 'MixReal/lists', '0', '', '混服管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('267', '实时充值', '0', '262', '5', 'MixPay/lists', '0', '', '混服管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('268', '结算管理', '0', '262', '6', '#', '0', '', '混服管理', '0', '1');
INSERT INTO `sys_menu` VALUES ('271', '新增', '0', '265', '0', 'MixUser/add', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('272', '编辑', '0', '265', '0', 'MixUser/edit', '0', '', '', '0', '1');
INSERT INTO `sys_menu` VALUES ('275', '添加', '0', '277', '0', 'Route/add', '0', '', '扩展工具', '0', '1');
INSERT INTO `sys_menu` VALUES ('276', '编辑', '0', '277', '0', 'Route/edit', '0', '', '扩展工具', '0', '1');
INSERT INTO `sys_menu` VALUES ('277', '路由设置', '0', '68', '0', 'Route/lists', '0', '', '扩展工具', '0', '1');

-- ----------------------------
-- Table structure for sys_model
-- ----------------------------
DROP TABLE IF EXISTS `sys_model`;
CREATE TABLE `sys_model` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '模型ID',
  `name` char(30) NOT NULL DEFAULT '' COMMENT '模型标识',
  `title` char(30) NOT NULL DEFAULT '' COMMENT '模型名称',
  `extend` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '继承的模型',
  `relation` varchar(30) NOT NULL DEFAULT '' COMMENT '继承与被继承模型的关联字段',
  `need_pk` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '新建表时是否需要主键字段',
  `field_sort` text COMMENT '表单字段排序',
  `field_group` varchar(255) NOT NULL DEFAULT '1:基础' COMMENT '字段分组',
  `attribute_list` text COMMENT '属性列表（表的字段）',
  `attribute_alias` varchar(255) NOT NULL DEFAULT '' COMMENT '属性别名定义',
  `template_list` varchar(100) NOT NULL DEFAULT '' COMMENT '列表模板',
  `template_add` varchar(100) NOT NULL DEFAULT '' COMMENT '新增模板',
  `template_edit` varchar(100) NOT NULL DEFAULT '' COMMENT '编辑模板',
  `list_grid` text COMMENT '列表定义',
  `list_row` smallint(2) unsigned NOT NULL DEFAULT '10' COMMENT '列表数据长度',
  `search_key` varchar(50) NOT NULL DEFAULT '' COMMENT '默认搜索字段',
  `search_list` varchar(255) NOT NULL DEFAULT '' COMMENT '高级搜索的字段',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `engine_type` varchar(25) NOT NULL DEFAULT 'MyISAM' COMMENT '数据库引擎',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='文档模型表';

-- ----------------------------
-- Records of sys_model
-- ----------------------------
INSERT INTO `sys_model` VALUES ('1', 'document', '基础文档', '0', '', '1', '{\"1\":[\"2\",\"3\",\"5\",\"9\",\"10\",\"11\",\"12\",\"13\",\"14\",\"16\",\"17\",\"19\",\"20\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\ntitle:标题:[EDIT]\r\ntype:类型\r\nupdate_time:最后更新\r\nstatus:状态\r\nlevel:优先级\r\nadmin|get_admin_name:创建者\r\nview:浏览\r\nid:操作:[EDIT]|编辑,[DELETE]|删除', '0', '', '', '1383891233', '1476236189', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('2', 'article', '文章', '1', '', '1', '{\"1\":[\"3\",\"24\",\"2\",\"5\"],\"2\":[\"9\",\"13\",\"19\",\"10\",\"12\",\"16\",\"17\",\"26\",\"20\",\"14\",\"11\",\"25\"]}', '1:基础,2:扩展', '', '', '', '', '', '', '0', '', '', '1383891243', '1387260622', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('3', 'download', '下载', '1', '', '1', '{\"1\":[\"3\",\"28\",\"30\",\"32\",\"2\",\"5\",\"31\"],\"2\":[\"13\",\"10\",\"27\",\"9\",\"12\",\"16\",\"17\",\"19\",\"11\",\"20\",\"14\",\"29\"]}', '1:基础,2:扩展', '', '', '', '', '', '', '0', '', '', '1383891252', '1387260449', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('4', 'game', '游戏', '0', '', '1', '{\"1\":[\"53\",\"54\",\"52\",\"51\",\"49\",\"50\",\"55\",\"56\",\"60\",\"61\",\"59\",\"58\",\"57\",\"48\",\"47\",\"38\",\"39\",\"37\",\"36\",\"34\",\"35\",\"40\",\"41\",\"45\",\"46\",\"44\",\"43\",\"42\",\"33\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\nsort:排序\r\ngame_name:游戏名称\r\ngame_type_name:游戏类型\r\ngame_appid:游戏appid\r\ngame_status|get_info_status:显示状态\r\nrecommend_status|get_info_status_*1:推荐状态\r\nmix_status|get_info_status*13:混服状态\r\ngame_api:接口缩写\r\nid:操作:[EDIT]&id=[id]|编辑,Game/del?ids=[id]|删除', '10', 'game_name', 'game_name', '1463664513', '1476349939', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('5', 'GameType', '游戏类型', '0', '', '1', '{\"1\":[\"360\",\"361\",\"66\",\"67\",\"65\",\"64\",\"63\",\"62\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\ntype_name:游戏类型\r\nstatus_show|get_info_status*8:显示状态\r\nsort:排序\r\nop_nickname:操作人\r\ncreate_time|set_show_time:添加时间\r\nid:操作:[EDIT]&id=[id]|编辑,GameType/del?ids=[id]|删除', '10', 'type_name', '', '1463968087', '1474978223', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('6', 'Server', '游戏区服', '0', '', '1', '{\"1\":[\"77\",\"76\",\"78\",\"79\",\"81\",\"80\",\"75\",\"74\",\"70\",\"69\",\"71\",\"72\",\"73\",\"68\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\ngame_name:游戏名称\r\nserver_name:区服名称\r\nshow_status|get_info_status:显示状态\r\nstart_time|set_show_time:开服时间\r\nid:操作:[EDIT]&id=[id]|编辑,Server/del?ids=[id]|删除', '10', 'server_name', '', '1463982982', '1470277154', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('7', 'giftbag', '礼包管理', '0', '', '1', '{\"1\":[\"94\",\"93\",\"92\",\"95\",\"96\",\"98\",\"97\",\"91\",\"90\",\"85\",\"84\",\"83\",\"86\",\"87\",\"89\",\"88\",\"82\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\ngame_name:游戏名称\r\ngiftbag_name:礼包名称\r\nsort:排序\r\nnovice|arr_count:剩余数量\r\nstatus|get_info_status:状态\r\nid:操作:[EDIT]&id=[id]|编辑,Giftbag/del?ids=[id]|删除', '10', 'giftbag_name', '', '1463985936', '1474975322', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('8', 'GiftRecord', '礼包记录', '0', '', '1', '{\"1\":[\"107\",\"106\",\"108\",\"109\",\"110\",\"105\",\"104\",\"100\",\"101\",\"102\",\"103\",\"99\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\ngame_name:游戏名称\r\ngift_name:礼包名称\r\nuser_id|get_user_account:用户账号\r\nnovice:礼包卡号\r\ncreate_time|set_show_time*time:领取时间', '10', 'game_name', '', '1463987676', '1465874967', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('9', 'promote', '渠道管理', '0', '', '1', '{\"1\":[\"123\",\"122\",\"121\",\"124\",\"125\",\"128\",\"127\",\"126\",\"120\",\"119\",\"114\",\"113\",\"112\",\"115\",\"116\",\"118\",\"117\",\"111\"]}', '1:基础', '', '', '', '', '', 'id:渠道ID\r\naccount:渠道账号\r\nadmin_id|get_admin_nickname:所属专员\r\nreal_name:姓名\r\nmobile_phone:手机\r\nparent_id|get_top_promote|id:上线渠道\r\nstatus|get_info_status*3:状态\r\nparent_id|get_qu_promote:渠道等级\r\ncreate_time|set_show_time:注册时间\r\nlast_login_time|set_show_time:最后登陆时间\r\nid:操作:[EDIT]&id=[id]|查看', '10', '', '', '1463989240', '1470046724', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('10', 'mend', '补链管理', '0', '', '1', '{\"1\":[\"136\",\"137\",\"138\",\"139\",\"135\",\"134\",\"130\",\"131\",\"132\",\"133\",\"129\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\nuser_account:账号\r\nuser_nickname:昵称\r\npromote_id:推广员编号\r\npromote_account:推广员账号\r\npromote_id_to:修改后编号\r\npromote_account_to:修改后账号\r\ncreate_time:时间\r\nop_account:操作人账号', '10', '', '', '1463997570', '1464332332', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('11', 'user', '用户信息', '0', '', '1', '{\"1\":[\"153\",\"152\",\"151\",\"154\",\"155\",\"158\",\"157\",\"156\",\"150\",\"149\",\"143\",\"142\",\"141\",\"144\",\"145\",\"148\",\"147\",\"146\",\"140\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\naccount:账号\r\nnickname:昵称\r\npromote_id:推广员编号\r\npromote_account:所属渠道\r\nbalance:余额\r\nlock_status|get_status_text*1:锁定状态\r\nlogin_time:登陆时间\r\nregister_way:注册方式\r\nregister_time:注册时间\r\nlogin_ip:登陆IP\r\nregister_ip:注册IP', '10', '', '', '1463997820', '1465292937', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('12', 'UserPlay', '玩家信息', '0', '', '1', '{\"1\":[\"168\",\"167\",\"169\",\"170\",\"172\",\"171\",\"166\",\"165\",\"161\",\"160\",\"162\",\"163\",\"164\",\"159\"]}', '1:基础', '', '', '', '', '', 'id:编号', '10', '', '', '1463997856', '1463997966', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('13', 'UserLoginRecord', '用户登陆记录', '0', '', '1', '{\"1\":[\"179\",\"180\",\"181\",\"182\",\"178\",\"177\",\"174\",\"175\",\"176\",\"173\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\nuser_account:用户名\r\nuser_nickname:昵称\r\ngame_id:游戏ID\r\ngame_name:游戏名称\r\nlogin_time:登陆时间', '10', '', '', '1463997904', '1465892986', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('14', 'spend', '消费记录', '0', '', '1', '{\"1\":[\"196\",\"195\",\"194\",\"197\",\"198\",\"201\",\"200\",\"199\",\"193\",\"192\",\"186\",\"185\",\"184\",\"187\",\"188\",\"190\",\"191\",\"189\",\"183\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\npay_order_number:订单号\r\nuser_nickname:用户昵称\r\ngame_name:游戏名称\r\npay_amount:充值金额\r\npay_time|set_show_time:充值时间\r\npay_way|get_pay_way:充值方式\r\npay_status|get_info_status*12:充值状态\r\npay_game_status|get_info_status*7:游戏充值状态\r\nspend_ip:充值ip', '10', '', '', '1464012355', '1474894407', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('15', 'adv', '广告管理', '0', '', '1', '{\"1\":[\"209\",\"210\",\"211\",\"212\",\"208\",\"207\",\"203\",\"204\",\"205\",\"206\",\"202\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\ntitle:标题\r\npos_id:广告位\r\ndata:图片\r\nurl:链接地址\r\nsort:排序\r\nstatus:状态\r\nstart_time:开始时间\r\nend_time:结束时间\r\ntarget:打开方式', '10', '', '', '1464083427', '1464099752', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('16', 'AdvPos', '广告位', '0', '', '1', '{\"1\":[\"220\",\"221\",\"222\",\"223\",\"219\",\"218\",\"214\",\"215\",\"216\",\"217\",\"213\"]}', '1:基础', '', '', '', '', '', 'id:编号', '10', '', '', '1464084894', '1464087047', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('17', 'deposit', '平台币充值', '0', '', '1', '{\"1\":[\"233\",\"232\",\"234\",\"235\",\"236\",\"231\",\"230\",\"226\",\"225\",\"227\",\"228\",\"229\",\"224\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\npay_order_number:订单号\r\nuser_nickname:用户昵称\r\npromote_id|get_promote_name:所属渠道\r\npay_amount:支付金额\r\ncreate_time|set_show_time:支付时间\r\npay_status|get_info_status*12:支付状态\r\npay_way|get_pay_way:支付方式\r\npay_ip:支付IP', '10', '', '', '1464233084', '1467965048', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('18', 'provide', '平台币发放', '0', '', '1', '{\"1\":[\"247\",\"246\",\"248\",\"249\",\"251\",\"250\",\"245\",\"244\",\"239\",\"238\",\"240\",\"241\",\"243\",\"242\",\"237\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\npay_order_number:订单号\r\ngame_name:游戏名称\r\nuser_nickname:用户昵称\r\namount:发放金额\r\nstatus|get_info_status*9:状态\r\nop_account:操作人\r\ncreate_time|set_show_time:发放时间', '10', '', '', '1464233863', '1467965218', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('19', 'BindSpend', '绑定平台币消费', '0', '', '1', '{\"1\":[\"263\",\"262\",\"261\",\"264\",\"265\",\"267\",\"266\",\"260\",\"259\",\"254\",\"253\",\"255\",\"256\",\"258\",\"257\",\"252\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\npay_order_number:订单号\r\nuser_nickname:用户昵称\r\ngame_name:游戏名称\r\npromote_account:所属渠道\r\npay_amount:充值金额\r\npay_time|set_show_time:充值时间\r\npay_way|get_pay_way:充值方式\r\npay_status|get_info_status*12:支付状态\r\npay_game_status|get_info_status*7:游戏充值状态\r\nspend_ip:充值IP', '10', '', '', '1464234376', '1474948896', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('40', 'feedback', '意见反馈', '0', '', '1', '{\"1\":[\"395\",\"396\",\"397\",\"398\",\"399\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\nusername:用户账号\r\ncontent:内容\r\ncontact:联系人\r\ncreate_time|set_show_time:提交时间', '10', '', '', '1470391523', '1470391698', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('21', 'Apply', '游戏申请管理', '0', '', '1', '{\"1\":[\"287\",\"286\",\"288\",\"289\",\"290\",\"285\",\"284\",\"280\",\"281\",\"282\",\"283\",\"279\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\ngame_id|get_game_name:游戏名称\r\npromote_id|get_promote_name:渠道账号\r\nratio|ratio_stytl:分成比例\r\napply_time|set_show_time:申请时间\r\nstatus|get_info_status*5:申请状态\r\ndispose_id|get_admin_nickname:操作人\r\ndispose_time|set_show_time:操作时间\r\nid:操作:Apply/[EDIT]|编辑', '10', '', '', '1464356213', '1467965953', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('22', 'agent', '代充记录', '0', '', '1', '{\"1\":[\"302\",\"301\",\"300\",\"303\",\"304\",\"306\",\"305\",\"299\",\"298\",\"293\",\"292\",\"294\",\"295\",\"297\",\"296\",\"291\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\nuser_account:代充账号\r\ngame_name:代充游戏\r\namount:代充金额\r\nreal_amount:实扣金额\r\nzhekou:折扣比例\r\npay_status|get_info_status*7:充值状态\r\npromote_account:所属渠道\r\npromote_id|get_belong_admin:所属管理员\r\ncreate_time|set_show_time:创建时间', '10', '', '', '1464772695', '1465789172', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('24', 'settlement', '结算表', '0', '', '1', '', '1:基础', '', '', '', '', '', null, '10', '', '', '1464945956', '1464945956', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('30', 'GiftbagType', '礼包类型', '0', '', '1', '{\"1\":[\"334\",\"335\",\"338\",\"337\",\"339\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\ntype_name:礼包类型\r\nstatus|get_info_status*8:显示状态\r\nop_nickname:操作人\r\ncreate_time|set_show_time:添加时间\r\nid:操作:[EDIT]&id=[id]|编辑,GiftbagType/del?ids=[id]|删除', '10', '', '', '1465194413', '1474978204', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('31', 'Links', '友情链接', '0', '', '1', '{\"1\":[\"345\",\"347\",\"346\",\"344\",\"343\",\"340\",\"342\",\"341\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\ntitle:标题\r\nlink_url:链接\r\nstatus|get_info_status:状态\r\ncreate_time|set_show_time:添加时间\r\nid:操作:[EDIT]&id=[id]|编辑,Links/del?ids=[id]|删除', '10', '', '', '1465202697', '1465727927', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('32', 'message', '留言纠错', '0', '', '1', '{\"1\":[\"354\",\"355\",\"356\",\"353\",\"352\",\"349\",\"350\",\"351\",\"348\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\ngame_id|get_game_name:游戏名称\r\ntitle:错误内容\r\ncreate_time|set_show_time:提交时间\r\nstatus|get_info_status*6:修复状态\r\nop_account:操作人', '10', '', '', '1465732888', '1465733083', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('33', 'opentype', '开放类型', '0', '', '1', '{\"1\":[\"359\",\"358\",\"357\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\nopen_name:类型名称\r\nstatus|get_info_status:状态\r\ncreate_time|set_show_time:添加时间\r\nid:操作:[EDIT]&id=[id]|编辑,Opentype/del?ids=[id]|删除', '10', '', '', '1465898749', '1466149206', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('35', 'rebate', '返利设置', '0', '', '1', '{\"1\":[\"366\",\"367\",\"365\",\"364\",\"363\",\"362\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\ngame_name:游戏名称\r\nstatus|get_info_status:是否开启金额限制\r\nratio|ratio_stytl:返利比例\r\ncreate_time|set_show_time:添加时间\r\nid:操作:[EDIT]&id=[id]|编辑,rebate/del?ids=[id]|删除', '10', '', '', '1466386454', '1466389821', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('36', 'RebateList', '游戏返利', '0', '', '1', '{\"1\":[\"375\",\"376\",\"377\",\"378\",\"374\",\"373\",\"369\",\"370\",\"371\",\"372\",\"368\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\npay_order_number:订单号\r\nuser_id|get_user_account:用户名\r\ngame_name:游戏名称\r\npay_amount:充值金额\r\nratio|ratio_stytl:返利比例\r\nratio_amount:返利金额\r\npromote_id|get_promote_name:所属推广员\r\ncreate_time|set_show_time:添加时间\r\nid:操作:rebatelist/del?ids=[id]|删除', '10', '', '', '1466386503', '1466386622', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('37', 'push', '推送设置', '0', '', '1', '{\"1\":[\"383\",\"382\",\"381\",\"380\",\"379\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\npush_name:应用名称\r\napp_key:app_key\r\nmaster_secret:master_secret\r\nstatus|get_info_status:状态\r\ncreate_time|set_show_time:添加时间\r\nid:操作:[EDIT]&id=[id]|编辑,push/del?ids=[id]|删除', '10', '', '', '1466757612', '1466990427', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('39', 'PushNotice', '发送通知', '0', '', '1', '{\"1\":[\"393\",\"394\",\"389\",\"390\",\"391\",\"392\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\npush_name:应用名称\r\ncontent:推送内容\r\npush_object|get_phone_type:推送类型\r\npush_time_type|get_push_time:时间设置\r\npush_time|set_show_time:推送时间\r\ncreate_time|set_show_time:添加时间\r\nid:操作:push/del_list?ids=[id]|删除', '10', '', '', '1466759193', '1466990401', '1', 'MyISAM');
INSERT INTO `sys_model` VALUES ('42', 'Repair_Record', '补单记录', '0', '', '1', '{\"1\":[\"420\",\"421\",\"422\",\"423\",\"419\",\"418\",\"414\",\"415\",\"416\",\"417\",\"413\"]}', '1:基础', '', '', '', '', '', 'id:编号\r\npay_order_number:订单号\r\nuser_account:用户账号\r\nuser_nickname:用户昵称\r\ngame_name:游戏名称\r\nop_nickname:操作人\r\ncreate_time:补单时间', '10', '', '', '1474858375', '1474858394', '1', 'MyISAM');

-- ----------------------------
-- Table structure for sys_picture
-- ----------------------------
DROP TABLE IF EXISTS `sys_picture`;
CREATE TABLE `sys_picture` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id自增',
  `path` varchar(255) NOT NULL DEFAULT '' COMMENT '路径',
  `url` varchar(255) NOT NULL DEFAULT '' COMMENT '图片链接',
  `md5` char(32) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` char(40) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_picture
-- ----------------------------

-- ----------------------------
-- Table structure for sys_short_message
-- ----------------------------
DROP TABLE IF EXISTS `sys_short_message`;
CREATE TABLE `sys_short_message` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `phone` varchar(20) NOT NULL COMMENT '电话号码',
  `send_status` varchar(10) NOT NULL COMMENT '短信发送状态',
  `send_time` varchar(15) NOT NULL COMMENT '发送时间',
  `smsId` varchar(40) NOT NULL COMMENT '发送短信唯一标识',
  `create_time` int(10) unsigned NOT NULL COMMENT '记录时间',
  `pid` varchar(40) NOT NULL COMMENT '渠道id',
  `status` tinyint(2) NOT NULL COMMENT '状态',
  `ratio` int(10) unsigned NOT NULL COMMENT '比率',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=156 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of sys_short_message
-- ----------------------------
INSERT INTO `sys_short_message` VALUES ('1', '18361253866', '000000', '1468491681', '2359a5a89be402d6a82745413252c6fb', '1468491714', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('2', '18752107527', '000000', '1468551416', '5744cb8bf28f28a067bc997dcf601713', '1468551420', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('3', '18333333333', '000000', '1468551528', '1bc3e554f898dfd2c510ebb69e1ae360', '1468551561', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('4', '15353535353', '000000', '1468551706', 'aee3b10223f04f3fdd91d83caa7d1a4d', '1468551738', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('5', '15656565656', '000000', '1468552770', '60b230e77cbfd609288bd53898fc3c8f', '1468552803', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('6', '15454545454', '000000', '1468552807', 'afe7abdd0e46d001aaff1dec7769b4fa', '1468552840', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('7', '15858585858', '000000', '1468552924', '6538bfb94012cdf43692271e5e03eb68', '1468552957', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('8', '15353535353', '000000', '1468553123', '47c7e73c9f287039719e78554307bf8b', '1468553155', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('9', '15656565656', '000000', '1468553373', '46fa2c706e3e798a3cd77d66dc097bf3', '1468553406', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('10', '15959595959', '000000', '1468553807', 'e0ead9e75a98c898ad941b26224398df', '1468553840', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('11', '18752107527', '000000', '1468575990', 'e0ad362f28d2cf9f82d25d38c4bc92b6', '1468575993', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('12', '18752107527', '000000', '1469099296', 'f58882b8e707297e151df70826ee17cb', '1469099297', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('13', '15996941564', '000000', '1469100840', '5a4b346222c868c44a2b21109c8b10a7', '1469100841', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('14', '15996941564', '000000', '1469100879', 'b013ac85ad637d7e6d9412fff38e2833', '1469100881', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('15', '15996941564', '000000', '1469100948', '901b3f28a321768cc495710a271ef8b8', '1469100949', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('16', '18752107527', '000000', '1469151654', '837a75f4bef0fc823998be5df8870879', '1469151655', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('17', 'wan001', '100015', '', '', '1469153100', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('18', 'wan001', '100015', '', '', '1469153201', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('19', '', '100008', '', '', '1469170075', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('20', '', '100008', '', '', '1469170313', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('21', '', '100008', '', '', '1469171884', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('22', '15852317853', '000000', '1469172179', 'c2cc3e9f4a72b03555f379bb6da7bfdf', '1469172180', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('23', '15852317853', '000000', '1469172184', '8b2540386cc2f788481128888813ef8e', '1469172185', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('24', '15852317853', '000000', '1469172241', '50987702bd3a2bcf20c08900a6e8f4db', '1469172243', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('25', '15852317853', '000000', '1469172312', 'cc5971603d954fa50fdb8c679827bab0', '1469172313', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('26', '15852317853', '000000', '1469172732', '680c39ad8640167bf3465826c8454cbb', '1469172733', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('27', '15852317853', '000000', '1469175543', '044e13e77eac6e6708c600cde85df178', '1469175544', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('28', '15852317853', '000000', '1469175705', 'b9d0116d344596ce1b4a6fb434534030', '1469175706', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('29', '15852317853', '000000', '1469175768', 'ad37ce6784d150206ad49efb73bbe57b', '1469175769', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('30', '15852317853', '000000', '1469176063', '1ddb0e3349ae22e0e0b9dccc75fa2390', '1469176064', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('31', '15852317853', '000000', '1469176178', '852109daa3a92f0ac901deb27a990c6d', '1469176179', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('32', '15852317853', '000000', '1469176235', 'd980a604dbe109e60e6a8f28b1fe1707', '1469176237', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('33', '15852317853', '000000', '1469176275', 'ebea7a87f6fab810141aaa772f3ceee4', '1469176276', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('34', '15852317853', '000000', '1469176344', 'e244f51dcdf63a8ca84e88ba464c4629', '1469176345', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('35', '15852317853', '000000', '1469176959', 'b4701d7d91ef51b5d6c351fb59081d54', '1469176961', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('36', '18752107527', '000000', '1469178146', 'ddd7e0d028cd4d71851c91b2abee5bf4', '1469178147', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('37', '18752107527', '000000', '1469178300', 'c41e8c40fbecbd4c9f2372771513dd50', '1469178301', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('38', '18752107527', '000000', '1469178395', '0a4e5a1a139e5d39f1124d44c9c76320', '1469178396', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('39', '18752107527', '000000', '1469178656', '14c1e8cf0e80acf24b922f25582ca332', '1469178657', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('40', '18752107527', '000000', '1469178802', '5713d11cbbd7b9ed145aa9b1a0a0cac4', '1469178804', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('41', '18752107527', '000000', '1469178895', '15e867041d3967a757346013a0c97458', '1469178897', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('42', '18752107527', '000000', '1469179063', 'fc8d5c98c6d17459f41661e7a8d1836f', '1469179064', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('43', '18752107527', '000000', '1469179131', '020dc8c30b43b360911902b368d66c7b', '1469179132', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('44', '18752107527', '000000', '1469179211', '726842a4b65193bd66dfeefe8ca0c373', '1469179213', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('45', '18752107527', '000000', '1469179381', '13643091a9e65d2fa637314b8c0df3e8', '1469179382', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('46', '13218555399', '000000', '1469179502', 'b06a3f5f1a25c8a749302c6dcbd4f234', '1469179503', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('47', '18752107527', '000000', '1469179732', 'cfc21aee3c30aa28606550e0b7fc1110', '1469179733', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('48', '18752107527', '000000', '1469179840', 'ee99299c65cc71b733c50b6caa4e34f3', '1469179841', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('49', '18752107527', '000000', '1469179931', '75539696e03f1c5546a62528ccaa6a1a', '1469179933', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('50', '18752107527', '000000', '1469179998', 'd8e7b7ee73611d9e90d6d1d1e182d308', '1469179999', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('51', '18752107527', '000000', '1469181552', 'bc96c2df89b1258078e2b475b7e6d329', '1469181553', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('52', '18361253866', '000000', '1469181824', 'f193161651c2b4e95808353131f3c52a', '1469181825', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('53', '18361253866', '000000', '1469182438', '36e0b94d60569d15ad18fc458f0e16ee', '1469182440', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('54', '18361253866', '000000', '1469182621', 'afc3124ca8d9ec83e47833c8fd36d462', '1469182622', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('55', '18361253866', '000000', '1469182715', '6b88bc1f66e3b47b54ebd0388baddb38', '1469182717', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('56', '18361253866', '000000', '1469183363', 'c7ff472c47e9ced7210d26de8fa02c6f', '1469183364', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('57', '18752107527', '000000', '1469414830', '4dfa169196afb2a52308891f772411d3', '1469414830', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('58', '15959595959', '000000', '1469516528', 'a5b309f23ca84746dbab8f3841f5993f', '1469516563', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('59', '18752107527', '000000', '1469521734', 'b1a53859934dfa4cf5446526768d6ebf', '1469521735', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('60', '15050838825', '000000', '1470139558', 'f7fca369cafc3d076abe822f5fae99b0', '1470139559', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('61', '15050838825', '000000', '1470139873', 'bfa0f2a83cbe1cfbc06e8cab0dc4cbce', '1470139875', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('62', '15050838825', '000000', '1470139990', '00d2b0779b87c2e9562fe7057775b1f1', '1470139992', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('63', '15050838825', '000000', '1470140066', 'cadf34f1192528fc3b377233331d9236', '1470140067', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('64', '15050838825', '000000', '1470140165', '6a0a81ddb404145e5ef0a958677f47bc', '1470140166', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('65', '15050838886', '000000', '1470140374', '6939bffd87e28b241b43ca6fca02d45d', '1470140376', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('66', '15050873888', '000000', '1470141223', '380e409fa75c026b1678a54c3edbcf8d', '1470141225', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('67', '15055567845', '000000', '1470141336', 'c87c87b4cac62c7621673cc446d78efa', '1470141338', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('68', '15050838825', '000000', '1470141396', '19de0b14a443120519673581c95c9f2a', '1470141398', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('69', '15050888881', '000000', '1470141492', 'd6b143ee65292d376308394fddda3492', '1470141494', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('70', '15055555555', '000000', '1470141575', '1e03a11f6c5a823b7cac0b90b88dcdc3', '1470141577', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('71', '15158481234', '000000', '1470141672', '11658418d3cadb31515db7f91db68b8e', '1470141674', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('72', '15081541856', '000000', '1470141799', '0b4acb10951635783e819da16aaf34e0', '1470141801', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('73', '15050838182', '000000', '1470141885', 'c9e5b54e497d8c230c8f14ed31dfb3c8', '1470141887', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('74', '15050838825', '000000', '1470187300', 'e794e3d05fd8b02ea0d2b90a348efd7c', '1470187303', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('75', '18361253866', '000000', '1470205351', 'fadcb5b9466aa1f768cd6280ba6541f9', '1470205386', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('76', '15151515151', '000000', '1470205524', '16465604355baab310255de1615fcb82', '1470205558', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('77', '15858585858', '000000', '1470300396', '0e2b50c8457b6889be5799d7a23699b6', '1470300431', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('78', '15858585858', '000000', '1470301664', '9f8a711a6dd0c3e8bdb3fb36eb60e623', '1470301698', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('79', '15454545454', '000000', '1470302002', 'c5f71f0c5705c78e3c77949c1bb013d1', '1470302037', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('80', '15454545454', '000000', '1470302124', 'e950644a7f5e5e6f1db33e780f828062', '1470302159', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('81', '15858585858', '000000', '1470302334', '113c419c2c4a5d9e2387a7d2164bc437', '1470302369', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('82', '15858585858', '000000', '1470302428', '4cf4c1a1cf03dde25d68b06ac8e1830a', '1470302463', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('83', '15353535353', '000000', '1470304351', '966bf6746c9bd42c2f451163fe9ff6d6', '1470304386', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('84', '18361253866', '000000', '1473304517', '80ca75f8db592470004e98a549e32c74', '1473304558', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('85', '15689568988', '000000', '1473320962', '3bdc5af91851c641f0862e4b067b4541', '1473321003', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('86', '18361253666', '000000', '1473324249', '6e37e69418526e8102790e25ab7ba77f', '1473324290', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('87', '15858585899', '000000', '1473324521', '5a7612f344e46ade424369338b819fea', '1473324562', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('88', '15858686868', '000000', '1473325055', 'fd3cb0eac19d8a0d40184deeafa8e1e9', '1473325096', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('89', '18631253801', '000000', '1473325738', '1640712fde79f7aca1565e4ad2639bd3', '1473325780', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('90', '18361253802', '000000', '1473326018', '62a5bf2d07ca53b7c9e4bfe6efa17531', '1473326060', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('91', '18361253803', '000000', '1473326086', '4554af27de47d5ff08ec8aca649a6188', '1473326127', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('92', '18361253804', '000000', '1473326165', '44e87ac90f86e9d224cde90689522098', '1473326207', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('93', '18361253801', '000000', '1473326411', 'cebb9836da1e3b9b112041c965d37df6', '1473326452', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('94', '18361253804', '000000', '1473326563', '009cc73a049f4071fd10652af6618e7a', '1473326604', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('95', '18361253805', '000000', '1473326648', 'e785325b37f60a92dc98e41ca6399ea7', '1473326689', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('96', '18361253806', '000000', '1473326974', '883cb5fa14971fc8d2a0a0abc51ea63c', '1473327015', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('97', '18361253807', '000000', '1473327094', '90c637db38506bf9bda41f6f84b61e87', '1473327135', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('98', '18361253807', '000000', '1473327109', 'e2cbc8774f0e3730ada29838c53376c5', '1473327150', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('99', '18361253808', '000000', '1473327289', 'df2f5e65003c83bda82042b4464ed33e', '1473327330', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('100', '18361253809', '000000', '1473327391', '883f61b98315e34c2542ebbcf3595c14', '1473327432', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('101', '18361253810', '000000', '1473327479', 'f850e4507c08ca2f28bca854f15a8769', '1473327520', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('102', '18361253810', '000000', '1473327550', '734c78db8a3d6bca812b8697aa5fa562', '1473327592', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('103', '18361253811', '000000', '1473327722', 'd790b4d4deba0c8abe1ad50963d2c7d0', '1473327763', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('104', '18361253811', '000000', '1473327902', '02f8d5be3d6237283026b73c0fda0977', '1473327943', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('105', '18361253812', '000000', '1473327936', 'fe921e3feb261dc311bf5ba7438b6e2c', '1473327977', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('106', '18361253866', '000000', '1473644876', '9b08c86d6208008a1804012ec033d52c', '1473644916', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('107', '15757575757', '000000', '1473825206', '8b1d8f0d261094f9a5713aa45ca94a92', '1473825248', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('108', '18361253861', '000000', '1474168234', '3b9db45a42f0cdf9fbd03e1e11c72155', '1474168278', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('109', '18361253862', '000000', '1474168298', '5c124305c32c0a9bca3c14229ffd14e9', '1474168342', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('110', 'aaaaaaaa', '100015', '', '', '1474547357', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('111', '18989898989', '000000', '1474851650', '9c05972fd44c44c27f9ed813e5676488', '1474851652', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('112', '15454545541', '000000', '1474942997', 'f94ce989239b09fd63fe04c2a5414bc0', '1474943000', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('113', '15656565656', '000000', '1475029694', 'aa857f71376a3cf93b6503255fb9e226', '1475029696', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('114', '15656565656', '000000', '1475029766', '26b8b12cdd40d57c8779a5ad8535cfc6', '1475029769', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('115', '15656565656', '000000', '1475029937', '1ac78185ed1e35cdba25306481366ed7', '1475029939', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('116', '18361258888', '000000', '1475030852', '5509dc4fb00f6bae8a1de458e7e437e7', '1475030855', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('117', '18666888585', '000000', '1475030876', '07a372de01c2ef1f39bc2afffe8b44fb', '1475030878', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('118', '15050838888', '000000', '1476102926', 'a8c250f8f1a2456ca7ebe4365ffb9e22', '1476102926', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('119', '15050838825', '000000', '1476103961', '3ec579254ec862c46bade188cdaf5431', '1476103961', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('120', '15050838825', '000000', '1476167583', '09cad74d9e1bfe62be68d4d20b4461f2', '1476167585', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('121', 'qweqwe', '100015', '', '', '1476167895', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('122', '15050838825', '000000', '1476169458', 'b6414e439cee8eea38341d256cf8e3d1', '1476169460', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('123', 'xzxcvaSddazsd', '100015', '', '', '1476171820', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('124', '15050838825', '000000', '1476171977', 'cda3f49ee0bb53abcea5d7cfd4f67753', '1476171979', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('125', '15050838823', '000000', '1476176132', '6a0c2c04753e164607c14667f88b663a', '1476176134', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('126', '15089648545', '000000', '1476176367', '6a2cf0187176cb728a43c598780c2474', '1476176369', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('127', '15656568989', '000000', '1476177476', '42555e3965b7f218802e7341684e73a5', '1476177483', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('128', '18111111111', '000000', '1476177522', '9454669c057b296326fa04462cc556ee', '1476177529', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('129', '18361253866', '000000', '1476177545', '0dbe8ded54cedddf51a03808efecf07f', '1476177552', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('130', '18366666666', '000000', '1476178468', '14c902a535dab26d33a785e8da9526b9', '1476178474', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('131', '18361253866', '000000', '1476178508', '5040c55acd36d1114a012b97b4d0e60a', '1476178514', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('132', '15050821234', '000000', '1476234377', '0dc13b973d0cec87885d995d7263fe8a', '1476234379', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('133', '15050465481', '000000', '1476234565', '6ab02ae34678fd34665ad3bf70264c8b', '1476234568', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('134', '18361253866', '000000', '1476234752', '4ea1fe3d2812d4ca14b074b0d223d872', '1476234758', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('135', '15050838820', '000000', '1476235705', 'e8fbc746ca64c26b43186c3ffa09d2be', '1476235708', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('136', '15865644441', '000000', '1476235819', 'e12949bf7168cbefb56339e47aa8e3d8', '1476235822', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('137', '15785645641', '000000', '1476235873', '5f674ddbb066abf81bf97de51573521c', '1476235876', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('138', '15789756423', '000000', '1476235884', 'aedf60e0ff0c7e33b0be6522b2c9afb8', '1476235887', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('139', '15050838825', '000000', '1476236008', 'b891058eb25c31834fc086a7dba7437c', '1476236011', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('140', '15050838825', '000000', '1476236072', '412ef9f462b312ad52a817be155d6ba8', '1476236075', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('141', '15050838825', '000000', '1476236313', '88beacbe1f90d414f035cbb4ac8066f3', '1476236315', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('142', '15050838825', '000000', '1476236694', '3ac10689c3150dcc1ec1f7c34f7bba51', '1476236697', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('143', '18061126068', '000000', '1476236751', 'fa16a5d3473078d2eaab3ccf5b6d567a', '1476236754', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('144', '18761426095', '000000', '1476237006', 'c65a0f35a53509da1ff25cede844cdd5', '1476237009', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('145', '18761426095', '000000', '1476237302', '93a8d8059d0b627cfc651823347549b7', '1476237305', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('146', '15050838825', '000000', '1476237545', '2ed9abcb266a2088bdc618f3f49a81ee', '1476237547', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('147', '15050838825', '000000', '1476240247', '4eef6120be1f0676354dfadc04ae0e45', '1476240250', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('148', '15008388512', '000000', '1476240319', 'e710bd852c53d9db3c0edb4736e273cf', '1476240322', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('149', '15008388512', '000000', '1476240350', '639c4e96c8325890cb63b6fb66c9e104', '1476240353', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('150', '15008388512', '000000', '1476240368', 'aec65734c1d40196bd14e9f86da72b93', '1476240371', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('151', '15050838825', '000000', '1476240656', '511f16b60add5256a164611966f4ecde', '1476240659', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('152', '18761426095', '000000', '1476240728', '630f70fb2be27ae67405341d0d2c6716', '1476240731', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('153', '18761426095', '000000', '1476240762', '464c7012d1e087b860ef3e8ecb7f062c', '1476240765', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('154', '18761426095', '000000', '1476240830', '08374d85db270e9c2e777ee24281c6f4', '1476240833', '0', '0', '0');
INSERT INTO `sys_short_message` VALUES ('155', '18361253866', '000000', '1476266189', 'fb17b03ee9452105eb94b6b1072e691d', '1476266196', '0', '0', '0');

-- ----------------------------
-- Table structure for sys_ucenter_admin
-- ----------------------------
DROP TABLE IF EXISTS `sys_ucenter_admin`;
CREATE TABLE `sys_ucenter_admin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '管理员ID',
  `member_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '管理员用户ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '管理员状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of sys_ucenter_admin
-- ----------------------------

-- ----------------------------
-- Table structure for sys_ucenter_app
-- ----------------------------
DROP TABLE IF EXISTS `sys_ucenter_app`;
CREATE TABLE `sys_ucenter_app` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '应用ID',
  `title` varchar(30) NOT NULL COMMENT '应用名称',
  `url` varchar(100) NOT NULL COMMENT '应用URL',
  `ip` char(15) NOT NULL DEFAULT '' COMMENT '应用IP',
  `auth_key` varchar(100) NOT NULL DEFAULT '' COMMENT '加密KEY',
  `sys_login` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '同步登陆',
  `allow_ip` varchar(255) NOT NULL DEFAULT '' COMMENT '允许访问的IP',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '应用状态',
  PRIMARY KEY (`id`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='应用表';

-- ----------------------------
-- Records of sys_ucenter_app
-- ----------------------------

-- ----------------------------
-- Table structure for sys_ucenter_member
-- ----------------------------
DROP TABLE IF EXISTS `sys_ucenter_member`;
CREATE TABLE `sys_ucenter_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` char(16) NOT NULL COMMENT '用户名',
  `password` char(32) NOT NULL COMMENT '密码',
  `email` char(32) NOT NULL COMMENT '用户邮箱',
  `mobile` char(15) NOT NULL DEFAULT '' COMMENT '用户手机',
  `reg_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '注册IP',
  `last_login_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` bigint(20) NOT NULL DEFAULT '0' COMMENT '最后登录IP',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(4) DEFAULT '0' COMMENT '用户状态',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of sys_ucenter_member
-- ----------------------------

-- ----------------------------
-- Table structure for sys_ucenter_setting
-- ----------------------------
DROP TABLE IF EXISTS `sys_ucenter_setting`;
CREATE TABLE `sys_ucenter_setting` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '设置ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '配置类型（1-用户配置）',
  `value` text NOT NULL COMMENT '配置数据',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='设置表';

-- ----------------------------
-- Records of sys_ucenter_setting
-- ----------------------------

-- ----------------------------
-- Table structure for sys_url
-- ----------------------------
DROP TABLE IF EXISTS `sys_url`;
CREATE TABLE `sys_url` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '链接唯一标识',
  `url` char(255) NOT NULL DEFAULT '' COMMENT '链接地址',
  `short` char(100) NOT NULL DEFAULT '' COMMENT '短网址',
  `status` tinyint(2) NOT NULL DEFAULT '2' COMMENT '状态',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_url` (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='链接表';

-- ----------------------------
-- Records of sys_url
-- ----------------------------

-- ----------------------------
-- Table structure for sys_userdata
-- ----------------------------
DROP TABLE IF EXISTS `sys_userdata`;
CREATE TABLE `sys_userdata` (
  `uid` int(10) unsigned NOT NULL COMMENT '用户id',
  `type` tinyint(3) unsigned NOT NULL COMMENT '类型标识',
  `target_id` int(10) unsigned NOT NULL COMMENT '目标id',
  UNIQUE KEY `uid` (`uid`,`type`,`target_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_userdata
-- ----------------------------

-- ----------------------------
-- Table structure for tab_adv
-- ----------------------------
DROP TABLE IF EXISTS `tab_adv`;
CREATE TABLE `tab_adv` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` char(80) NOT NULL DEFAULT '' COMMENT '广告名称',
  `pos_id` int(11) NOT NULL COMMENT '广告位置',
  `data` text NOT NULL COMMENT '图片地址',
  `click_count` int(11) NOT NULL COMMENT '点击量',
  `url` varchar(500) NOT NULL COMMENT '链接地址',
  `sort` int(3) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态（0：禁用，1：正常）',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '开始时间',
  `start_time` int(11) DEFAULT NULL,
  `end_time` int(11) unsigned DEFAULT '0' COMMENT '结束时间',
  `target` varchar(20) DEFAULT '_blank',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='广告表';

-- ----------------------------
-- Records of tab_adv
-- ----------------------------

-- ----------------------------
-- Table structure for tab_adv_pos
-- ----------------------------
DROP TABLE IF EXISTS `tab_adv_pos`;
CREATE TABLE `tab_adv_pos` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(50) NOT NULL,
  `title` char(80) NOT NULL DEFAULT '' COMMENT '广告位置名称',
  `module` varchar(100) NOT NULL COMMENT '所在模块 模块/控制器/方法',
  `type` int(11) unsigned NOT NULL DEFAULT '1' COMMENT '广告位类型 \r\n1.单图\r\n2.多图\r\n3.文字链接\r\n4.代码',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态（0：禁用，1：正常）',
  `data` varchar(500) NOT NULL COMMENT '额外的数据',
  `width` char(20) NOT NULL DEFAULT '' COMMENT '广告位置宽度',
  `height` char(20) NOT NULL DEFAULT '' COMMENT '广告位置高度',
  `margin` varchar(50) NOT NULL COMMENT '边缘',
  `padding` varchar(50) NOT NULL COMMENT '留白',
  `theme` varchar(50) NOT NULL DEFAULT 'all' COMMENT '适用主题，默认为all，通用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='广告位置表';

-- ----------------------------
-- Records of tab_adv_pos
-- ----------------------------
INSERT INTO `tab_adv_pos` VALUES ('1', 'slider_media', '媒体首页轮播图', 'media', '1', '1', '', '1200px', '300px', '0', '0', 'all');
INSERT INTO `tab_adv_pos` VALUES ('2', 'index_top_media', '媒体首页顶部广告', 'media', '1', '1', '', '120px', '50px', '0', '0', 'all');
INSERT INTO `tab_adv_pos` VALUES ('3', 'slider_app', 'app首页轮播图', 'app', '3', '1', '', '120px', '30px', '0', '0', 'all');
INSERT INTO `tab_adv_pos` VALUES ('4', 'index_mid_media', '媒体首页中部广告', 'media', '1', '1', '', '120px', '50px', '0', '0', 'all');
INSERT INTO `tab_adv_pos` VALUES ('5', 'index_bottom_media', '媒体首页底部广告', 'media', '1', '1', '', '120px', '50px', '0', '0', 'all');
INSERT INTO `tab_adv_pos` VALUES ('6', 'game_top_media', '游戏首页顶部广告', 'media', '1', '1', '', '120px', '50px', '0', '0', 'all');
INSERT INTO `tab_adv_pos` VALUES ('7', 'gift_top_media', '礼包首页顶部广告', 'media', '1', '1', '', '120px', '50px', '0', '0', 'all');
INSERT INTO `tab_adv_pos` VALUES ('8', 'ceshi', '测试', 'media', '1', '1', '', '120px', '50px', '0', '0', 'all');

-- ----------------------------
-- Table structure for tab_agent
-- ----------------------------
DROP TABLE IF EXISTS `tab_agent`;
CREATE TABLE `tab_agent` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `order_number` varchar(30) DEFAULT NULL COMMENT '订单号',
  `pay_order_number` varchar(30) NOT NULL COMMENT '支付订单号 ',
  `game_id` int(11) DEFAULT NULL COMMENT '游戏ID',
  `game_appid` varchar(32) DEFAULT NULL COMMENT '游戏APPID',
  `game_name` varchar(30) DEFAULT NULL COMMENT '游戏名称',
  `promote_id` int(11) DEFAULT '0' COMMENT '推广员ID',
  `promote_account` varchar(30) DEFAULT NULL COMMENT '推广员账号',
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `user_account` varchar(30) DEFAULT NULL COMMENT '玩家账号',
  `user_nickname` varchar(30) DEFAULT NULL COMMENT '用户昵称',
  `amount` double(10,2) DEFAULT '0.00' COMMENT '支付金额',
  `real_amount` double(10,2) DEFAULT '0.00' COMMENT '实际金额',
  `pay_way` tinyint(2) DEFAULT NULL COMMENT '支付方式 1支付宝 2微信',
  `pay_status` tinyint(2) DEFAULT '0' COMMENT '支付状态',
  `pay_type` tinyint(2) DEFAULT NULL COMMENT '类型',
  `create_time` int(11) DEFAULT NULL COMMENT '时间',
  `zhekou` int(11) NOT NULL DEFAULT '0' COMMENT '折扣比例',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='代理充值记录';

-- ----------------------------
-- Records of tab_agent
-- ----------------------------

-- ----------------------------
-- Table structure for tab_apply
-- ----------------------------
DROP TABLE IF EXISTS `tab_apply`;
CREATE TABLE `tab_apply` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `game_id` int(11) DEFAULT NULL COMMENT '游戏ID',
  `game_name` varchar(30) DEFAULT NULL COMMENT '游戏名称',
  `promote_id` int(11) DEFAULT NULL COMMENT '推广员ID',
  `promote_account` varchar(30) DEFAULT NULL COMMENT '推广账号',
  `ratio` double(5,2) DEFAULT '0.00' COMMENT '分成比例',
  `apply_time` int(11) DEFAULT NULL COMMENT '申请时间',
  `status` tinyint(2) DEFAULT NULL COMMENT '审核状态',
  `enable_status` tinyint(2) DEFAULT NULL COMMENT '操作状态',
  `pack_url` varchar(255) DEFAULT NULL COMMENT '游戏包地址',
  `dow_url` varchar(255) DEFAULT NULL COMMENT '下载地址',
  `dispose_id` int(11) DEFAULT NULL COMMENT '操作人',
  `dispose_time` int(11) DEFAULT NULL COMMENT '操作时间',
  `register_url` varchar(255) DEFAULT NULL COMMENT '注册登录url',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='游戏申请表';

-- ----------------------------
-- Records of tab_apply
-- ----------------------------

-- ----------------------------
-- Table structure for tab_bill
-- ----------------------------
DROP TABLE IF EXISTS `tab_bill`;
CREATE TABLE `tab_bill` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `bill_number` varchar(80) NOT NULL COMMENT '对账单号',
  `bill_time` varchar(30) NOT NULL COMMENT '对账时间',
  `promote_id` int(11) DEFAULT NULL COMMENT '推广员ID',
  `promote_account` varchar(30) DEFAULT NULL COMMENT '推广员账号',
  `game_id` int(11) DEFAULT NULL COMMENT '游戏ID',
  `game_name` varchar(30) NOT NULL COMMENT '游戏名称',
  `total_money` double(10,2) DEFAULT '0.00' COMMENT '充值总额',
  `total_number` int(19) unsigned NOT NULL COMMENT '注册人数',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `bill_start_time` int(19) unsigned NOT NULL COMMENT '对账开始时间',
  `bill_end_time` int(19) unsigned NOT NULL COMMENT '对账结束时间',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `settlement_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '结算状态',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tab_bill
-- ----------------------------

-- ----------------------------
-- Table structure for tab_bind_spend
-- ----------------------------
DROP TABLE IF EXISTS `tab_bind_spend`;
CREATE TABLE `tab_bind_spend` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `user_account` varchar(30) NOT NULL COMMENT '用户账号',
  `user_nickname` varchar(30) NOT NULL COMMENT '用户昵称',
  `game_id` int(11) NOT NULL COMMENT '游戏id',
  `game_appid` varchar(30) NOT NULL COMMENT '游戏appid',
  `game_name` varchar(30) NOT NULL COMMENT '游戏名称',
  `order_number` varchar(30) NOT NULL COMMENT '订单号',
  `pay_order_number` varchar(30) NOT NULL COMMENT '商户订单号',
  `props_name` varchar(30) NOT NULL COMMENT '道具名称',
  `pay_amount` double(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `pay_time` int(11) NOT NULL COMMENT '支付时间',
  `pay_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '支付状态',
  `pay_game_status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '游戏支付状态',
  `extend` varchar(32) DEFAULT NULL COMMENT '通知游戏方扩展(一般是游戏方透传)',
  `pay_way` tinyint(2) NOT NULL DEFAULT '0' COMMENT '支付方式',
  `pay_source` tinyint(2) NOT NULL DEFAULT '0' COMMENT '支付来源',
  `spend_ip` varchar(16) NOT NULL COMMENT '支付ip',
  `promote_account` varchar(30) NOT NULL COMMENT '推广员账号',
  `promote_id` int(11) NOT NULL DEFAULT '0' COMMENT '推广员id 0自然注册',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='绑定消费表';

-- ----------------------------
-- Records of tab_bind_spend
-- ----------------------------

-- ----------------------------
-- Table structure for tab_deposit
-- ----------------------------
DROP TABLE IF EXISTS `tab_deposit`;
CREATE TABLE `tab_deposit` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `order_number` varchar(30) DEFAULT NULL COMMENT '订单号',
  `pay_order_number` varchar(30) DEFAULT NULL COMMENT '支付订单号',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `user_account` varchar(30) DEFAULT NULL COMMENT '用户账号',
  `user_nickname` varchar(30) DEFAULT NULL COMMENT '用户昵称',
  `promote_id` int(11) DEFAULT NULL COMMENT '推广员ID',
  `promote_account` varchar(30) DEFAULT NULL COMMENT '推广账号',
  `pay_amount` double(10,2) DEFAULT '0.00' COMMENT '充值金额',
  `pay_status` tinyint(2) DEFAULT '0' COMMENT '充值状态',
  `pay_way` tinyint(2) DEFAULT '0' COMMENT '支付方式',
  `pay_source` tinyint(2) DEFAULT '0' COMMENT '支付来源',
  `pay_ip` varchar(20) DEFAULT NULL COMMENT '充值IP',
  `create_time` int(11) DEFAULT NULL COMMENT '支付时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='平台币充值记录';

-- ----------------------------
-- Records of tab_deposit
-- ----------------------------

-- ----------------------------
-- Table structure for tab_down_stat
-- ----------------------------
DROP TABLE IF EXISTS `tab_down_stat`;
CREATE TABLE `tab_down_stat` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `promote_id` int(11) DEFAULT NULL COMMENT '推广员id',
  `game_id` int(11) DEFAULT NULL COMMENT '游戏id',
  `number` int(2) DEFAULT '1' COMMENT '下载次数',
  `create_time` int(11) DEFAULT NULL COMMENT '时间',
  `type` int(2) DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='下载统计表';

-- ----------------------------
-- Records of tab_down_stat
-- ----------------------------

-- ----------------------------
-- Table structure for tab_feedback
-- ----------------------------
DROP TABLE IF EXISTS `tab_feedback`;
CREATE TABLE `tab_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `username` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '用户名',
  `nickname` varchar(30) CHARACTER SET utf8 DEFAULT NULL COMMENT '昵称',
  `content` varchar(300) CHARACTER SET utf8 DEFAULT NULL COMMENT '内容',
  `contact` varchar(11) CHARACTER SET utf8 DEFAULT NULL COMMENT '联系人',
  `create_time` int(11) DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tab_feedback
-- ----------------------------

-- ----------------------------
-- Table structure for tab_game
-- ----------------------------
DROP TABLE IF EXISTS `tab_game`;
CREATE TABLE `tab_game` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `game_name` varchar(30) DEFAULT NULL COMMENT '游戏名称',
  `sort` int(10) unsigned DEFAULT '1' COMMENT '排序',
  `short` varchar(20) DEFAULT NULL COMMENT '游戏简写',
  `game_type_id` int(10) DEFAULT NULL COMMENT '游戏类型id',
  `game_type_name` varchar(20) DEFAULT NULL COMMENT '游戏类型名称',
  `game_score` double(3,0) DEFAULT NULL COMMENT '游戏评分',
  `features` varchar(50) DEFAULT NULL COMMENT '游戏特征',
  `recommend_level` double(3,0) DEFAULT NULL,
  `version` varchar(10) DEFAULT NULL COMMENT '版本号',
  `game_size` varchar(10) DEFAULT '0' COMMENT '游戏大小',
  `icon` int(11) DEFAULT NULL COMMENT '游戏图标',
  `cover` int(11) DEFAULT NULL COMMENT '游戏封面',
  `screenshot` varchar(255) DEFAULT NULL COMMENT '游戏截图',
  `introduction` varchar(300) DEFAULT NULL COMMENT '游戏简介',
  `game_api` varchar(50) DEFAULT NULL COMMENT '接口简写',
  `and_dow_address` varchar(255) NOT NULL COMMENT '安卓游戏下载地址',
  `ios_dow_address` varchar(255) DEFAULT NULL COMMENT 'ios游戏下载地址',
  `game_address` varchar(255) DEFAULT NULL COMMENT '外部链接游戏地址',
  `dow_num` int(10) DEFAULT '0' COMMENT '游戏下载数量',
  `game_status` tinyint(2) DEFAULT NULL COMMENT '游戏状态(0:关闭,1:开启)',
  `pay_status` tinyint(2) DEFAULT '1' COMMENT '充值状态(0:关闭,1:开启)',
  `dow_status` tinyint(2) DEFAULT '1' COMMENT '下载状态(0:关闭,1:开启)',
  `mix_status` tinyint(2) DEFAULT '0' COMMENT '是否参与混服(0:不参与,1:参与)',
  `developers` varchar(30) DEFAULT NULL COMMENT '开发商',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `discount` double(4,2) DEFAULT NULL COMMENT '折扣',
  `language` varchar(10) DEFAULT NULL COMMENT '语言',
  `game_appid` varchar(32) DEFAULT NULL COMMENT '游戏appid',
  `game_coin_name` varchar(10) DEFAULT NULL COMMENT '游戏币名称',
  `game_coin_ration` varchar(10) DEFAULT NULL COMMENT '游戏币比例',
  `category` tinyint(2) DEFAULT '0' COMMENT '游戏开放类型',
  `ratio` double(5,2) DEFAULT '0.00' COMMENT '分成比例',
  `money` int(11) DEFAULT '0' COMMENT '注册单价',
  `recommend_status` varchar(10) NOT NULL DEFAULT '1' COMMENT '推荐状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏表';

-- ----------------------------
-- Records of tab_game
-- ----------------------------

-- ----------------------------
-- Table structure for tab_game_set
-- ----------------------------
DROP TABLE IF EXISTS `tab_game_set`;
CREATE TABLE `tab_game_set` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `game_id` int(11) NOT NULL COMMENT '游戏ID',
  `login_notify_url` varchar(255) DEFAULT NULL COMMENT '游戏登陆通知地址',
  `pay_notify_url` varchar(255) DEFAULT NULL COMMENT '游戏支付通知地址',
  `game_role_url` varchar(255) DEFAULT NULL COMMENT '游戏角色获取地址',
  `game_gift_url` varchar(255) DEFAULT NULL COMMENT '游戏礼包领取地址',
  `game_key` varchar(32) DEFAULT NULL COMMENT '游戏key',
  `access_key` varchar(32) DEFAULT NULL COMMENT '访问秘钥',
  `agent_id` varchar(32) DEFAULT NULL COMMENT '代理id(合作方标示)',
  `game_pay_appid` varchar(32) DEFAULT NULL COMMENT '游戏支付APPID',
  `qq_group` varchar(32) DEFAULT NULL COMMENT 'qq群',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏设置表（游戏对接时调用）';

-- ----------------------------
-- Records of tab_game_set
-- ----------------------------

-- ----------------------------
-- Table structure for tab_game_source
-- ----------------------------
DROP TABLE IF EXISTS `tab_game_source`;
CREATE TABLE `tab_game_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `game_id` int(11) DEFAULT NULL COMMENT '游戏id',
  `game_name` varchar(30) DEFAULT NULL COMMENT '游戏名称',
  `file_id` int(11) DEFAULT NULL COMMENT '文件id',
  `file_name` varchar(30) DEFAULT NULL COMMENT '文件名称',
  `file_url` varchar(255) DEFAULT NULL COMMENT '文件路径',
  `file_size` varchar(30) NOT NULL COMMENT '文件大小',
  `file_type` tinyint(2) DEFAULT NULL COMMENT '原包类型',
  `op_id` int(11) DEFAULT NULL COMMENT '操作人id',
  `op_account` varchar(30) DEFAULT NULL COMMENT '操作人名称',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_time` int(11) DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='游戏原包';

-- ----------------------------
-- Records of tab_game_source
-- ----------------------------

-- ----------------------------
-- Table structure for tab_game_type
-- ----------------------------
DROP TABLE IF EXISTS `tab_game_type`;
CREATE TABLE `tab_game_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `type_name` varchar(20) DEFAULT NULL COMMENT '游戏类型名称',
  `icon` int(12) NOT NULL COMMENT '图标',
  `cover` int(12) NOT NULL COMMENT '封面',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态(-1:删除,1:正常)',
  `status_show` tinyint(2) DEFAULT '1' COMMENT '显示状态(0:不显示,1:显示)',
  `op_id` int(11) DEFAULT NULL COMMENT '操作人id',
  `op_nickname` varchar(30) DEFAULT NULL COMMENT '操作人昵称',
  `create_time` int(11) DEFAULT NULL COMMENT '添加时间',
  `sort` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏类型表';

-- ----------------------------
-- Records of tab_game_type
-- ----------------------------

-- ----------------------------
-- Table structure for tab_giftbag
-- ----------------------------
DROP TABLE IF EXISTS `tab_giftbag`;
CREATE TABLE `tab_giftbag` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `game_id` int(11) DEFAULT NULL COMMENT '游戏id',
  `game_name` varchar(30) DEFAULT NULL COMMENT '游戏名称',
  `server_id` int(11) DEFAULT NULL COMMENT '区服id',
  `server_name` varchar(30) DEFAULT NULL COMMENT '区服名称',
  `giftbag_name` varchar(30) DEFAULT NULL COMMENT '礼包名称',
  `giftbag_type` tinyint(2) DEFAULT NULL COMMENT '礼包类型',
  `level` int(3) DEFAULT NULL COMMENT '领取等级',
  `sort` int(10) DEFAULT '0' COMMENT '排序',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态',
  `call_api` tinyint(2) DEFAULT '0' COMMENT '调用接口',
  `tong_server` tinyint(2) DEFAULT '0' COMMENT '是否通服',
  `recommend_status` tinyint(2) DEFAULT NULL COMMENT '礼包推荐状态',
  `novice` varchar(3000) DEFAULT NULL COMMENT '激活码',
  `digest` varchar(300) DEFAULT NULL COMMENT '摘要',
  `desribe` varchar(300) DEFAULT NULL COMMENT '描述',
  `start_time` int(11) DEFAULT NULL COMMENT '开始时间',
  `end_time` int(11) DEFAULT NULL COMMENT '结束时间',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='礼包管理';

-- ----------------------------
-- Records of tab_giftbag
-- ----------------------------

-- ----------------------------
-- Table structure for tab_giftbag_type
-- ----------------------------
DROP TABLE IF EXISTS `tab_giftbag_type`;
CREATE TABLE `tab_giftbag_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `type_name` varchar(20) DEFAULT NULL COMMENT '礼包类型名称',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `op_id` int(11) DEFAULT NULL COMMENT '操作人id',
  `op_nickname` varchar(30) DEFAULT NULL COMMENT '操作人昵称',
  `create_time` int(11) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_giftbag_type
-- ----------------------------

-- ----------------------------
-- Table structure for tab_gift_record
-- ----------------------------
DROP TABLE IF EXISTS `tab_gift_record`;
CREATE TABLE `tab_gift_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `game_id` int(11) DEFAULT NULL COMMENT '游戏id',
  `game_name` varchar(30) DEFAULT NULL COMMENT '游戏名称',
  `server_id` int(11) DEFAULT NULL COMMENT '区服',
  `server_name` varchar(30) DEFAULT NULL COMMENT '区服名称',
  `gift_id` int(11) DEFAULT NULL COMMENT '礼包id',
  `gift_name` varchar(30) DEFAULT NULL COMMENT '礼包名称',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态(0:未使用,1:已使用)',
  `novice` varchar(30) DEFAULT NULL COMMENT '激活码',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `user_account` varchar(30) DEFAULT NULL COMMENT '用户昵称',
  `user_nickname` varchar(30) DEFAULT NULL COMMENT '用户昵称',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='礼包领取记录';

-- ----------------------------
-- Records of tab_gift_record
-- ----------------------------

-- ----------------------------
-- Table structure for tab_links
-- ----------------------------
DROP TABLE IF EXISTS `tab_links`;
CREATE TABLE `tab_links` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `title` varchar(50) DEFAULT NULL COMMENT '标题',
  `link_url` varchar(255) DEFAULT NULL COMMENT '友链地址',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态',
  `type` tinyint(2) DEFAULT NULL COMMENT '类型',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `mark` varchar(50) DEFAULT '0' COMMENT '0媒体 1渠道',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_links
-- ----------------------------

-- ----------------------------
-- Table structure for tab_mend
-- ----------------------------
DROP TABLE IF EXISTS `tab_mend`;
CREATE TABLE `tab_mend` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `user_account` varchar(30) DEFAULT NULL COMMENT '用户账号',
  `user_nickname` varchar(30) DEFAULT NULL COMMENT '用户昵称',
  `promote_id` int(11) DEFAULT NULL COMMENT '推广员id',
  `promote_account` varchar(30) DEFAULT NULL COMMENT '推广员账号',
  `promote_id_to` int(11) DEFAULT NULL COMMENT '修改后推广员id',
  `promote_account_to` varchar(30) DEFAULT NULL COMMENT '修改后推广员账号',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `op_id` int(11) DEFAULT NULL COMMENT '操作人id',
  `op_account` varchar(30) DEFAULT NULL COMMENT '操作人账号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_mend
-- ----------------------------

-- ----------------------------
-- Table structure for tab_message
-- ----------------------------
DROP TABLE IF EXISTS `tab_message`;
CREATE TABLE `tab_message` (
  `qq` varchar(20) DEFAULT NULL COMMENT 'QQ号',
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `game_id` int(11) DEFAULT NULL COMMENT '游戏id',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `title` varchar(50) DEFAULT NULL COMMENT '标题',
  `content` varchar(300) DEFAULT NULL COMMENT '内容',
  `status` tinyint(2) DEFAULT '0' COMMENT '修复状态(0:未,1:已)',
  `type` tinyint(2) DEFAULT '0' COMMENT '类型(0:纠错,1:留言)',
  `op_id` int(11) DEFAULT NULL COMMENT '操作人id',
  `op_account` varchar(20) DEFAULT NULL COMMENT '操作人账号',
  `create_time` int(11) DEFAULT NULL COMMENT '修改时间',
  `123` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='留言';

-- ----------------------------
-- Records of tab_message
-- ----------------------------

-- ----------------------------
-- Table structure for tab_opentype
-- ----------------------------
DROP TABLE IF EXISTS `tab_opentype`;
CREATE TABLE `tab_opentype` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` int(11) NOT NULL COMMENT '添加时间',
  `status` int(11) NOT NULL COMMENT '状态',
  `open_name` varchar(30) NOT NULL COMMENT '开放类型名称',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tab_opentype
-- ----------------------------

-- ----------------------------
-- Table structure for tab_promote
-- ----------------------------
DROP TABLE IF EXISTS `tab_promote`;
CREATE TABLE `tab_promote` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `account` varchar(30) DEFAULT NULL COMMENT '账号',
  `password` varchar(32) DEFAULT NULL COMMENT '密码',
  `second_pwd` varchar(32) DEFAULT NULL COMMENT '二级密码',
  `nickname` varchar(30) DEFAULT NULL COMMENT '昵称',
  `mobile_phone` varchar(11) DEFAULT NULL COMMENT '手机号',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `real_name` varchar(10) DEFAULT NULL COMMENT '真实姓名',
  `bank_name` varchar(50) DEFAULT NULL COMMENT '银行',
  `bank_card` varchar(20) DEFAULT NULL COMMENT '银行卡',
  `money` double(10,2) DEFAULT '0.00' COMMENT '金额',
  `total_money` double(10,2) DEFAULT '0.00' COMMENT '总金额',
  `balance_coin` double(10,2) DEFAULT '0.00' COMMENT '平台币',
  `promote_type` int(2) DEFAULT '1' COMMENT '推广员类型',
  `status` int(11) DEFAULT '1' COMMENT '状态',
  `parent_id` int(11) DEFAULT '0' COMMENT '父类ID',
  `pay_limit` int(11) DEFAULT '0' COMMENT '代充额度',
  `referee_id` int(11) DEFAULT '0' COMMENT '推荐人ID',
  `set_pay_time` int(11) DEFAULT NULL COMMENT '代充额度设置时间',
  `last_login_time` int(11) DEFAULT NULL COMMENT '最后登陆时间',
  `create_time` int(11) DEFAULT NULL COMMENT '添加时间',
  `admin_id` int(11) NOT NULL COMMENT '管理员id',
  `mark1` varchar(255) DEFAULT NULL COMMENT '基本信息备注',
  `bank_area` varchar(255) DEFAULT NULL COMMENT '开户地点',
  `account_openin` varchar(255) DEFAULT NULL COMMENT '开户网点',
  `bank_account` varchar(255) DEFAULT NULL COMMENT '银行户名',
  `mark2` varchar(255) DEFAULT NULL COMMENT '结算信息备注',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='推广员';

-- ----------------------------
-- Records of tab_promote
-- ----------------------------

-- ----------------------------
-- Table structure for tab_provide
-- ----------------------------
DROP TABLE IF EXISTS `tab_provide`;
CREATE TABLE `tab_provide` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `order_number` varchar(30) DEFAULT NULL COMMENT '订单号',
  `pay_order_number` varchar(30) DEFAULT NULL COMMENT '商户订单号',
  `cost` int(11) DEFAULT '0' COMMENT '是否计算成本',
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `user_account` varchar(30) DEFAULT NULL COMMENT '用户账号',
  `user_nickname` varchar(30) DEFAULT NULL COMMENT '用户昵称',
  `game_id` int(11) DEFAULT NULL COMMENT '游戏id',
  `game_name` varchar(30) DEFAULT NULL COMMENT '游戏名称',
  `promote_id` int(11) DEFAULT '0' COMMENT '推广id',
  `promote_account` varchar(30) DEFAULT NULL COMMENT '推广员姓名',
  `server_id` int(11) DEFAULT NULL COMMENT '区服id',
  `server_name` varchar(30) DEFAULT NULL COMMENT '区服名称',
  `amount` double(10,2) DEFAULT NULL COMMENT '充值金额',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `status` tinyint(2) DEFAULT '0' COMMENT '状态',
  `op_id` int(11) DEFAULT NULL COMMENT '操作人id',
  `op_account` varchar(30) DEFAULT NULL COMMENT '操作人账号',
  `create_time` int(11) DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='平台币发发放记录';

-- ----------------------------
-- Records of tab_provide
-- ----------------------------

-- ----------------------------
-- Table structure for tab_rebate
-- ----------------------------
DROP TABLE IF EXISTS `tab_rebate`;
CREATE TABLE `tab_rebate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `game_id` int(11) DEFAULT NULL COMMENT '游戏id',
  `game_name` varchar(50) DEFAULT NULL COMMENT '游戏名称',
  `money` int(11) DEFAULT '0' COMMENT '金额',
  `ratio` double(5,2) DEFAULT '0.00' COMMENT '返利比例',
  `status` int(11) DEFAULT NULL COMMENT '状态(0关闭金额限制 1 开启金额限制)',
  `create_time` int(11) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_rebate
-- ----------------------------

-- ----------------------------
-- Table structure for tab_rebate_list
-- ----------------------------
DROP TABLE IF EXISTS `tab_rebate_list`;
CREATE TABLE `tab_rebate_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pay_order_number` varchar(30) DEFAULT NULL COMMENT '订单号',
  `game_id` int(11) DEFAULT NULL COMMENT '游戏id',
  `game_name` varchar(30) DEFAULT NULL COMMENT '游戏名称',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `user_name` varchar(30) DEFAULT NULL COMMENT '用户名',
  `pay_amount` double(10,2) DEFAULT '0.00' COMMENT '充值金额',
  `ratio` double(5,2) DEFAULT '0.00' COMMENT '返利比例',
  `ratio_amount` double(10,2) DEFAULT NULL COMMENT '返利平台币',
  `promote_id` int(11) DEFAULT '0' COMMENT '推广id',
  `promote_name` varchar(30) DEFAULT NULL COMMENT '推广员姓名',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_rebate_list
-- ----------------------------

-- ----------------------------
-- Table structure for tab_repair_record
-- ----------------------------
DROP TABLE IF EXISTS `tab_repair_record`;
CREATE TABLE `tab_repair_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `pay_order_number` varchar(30) DEFAULT NULL COMMENT '支付订单号',
  `user_id` int(11) NOT NULL COMMENT ' 用户ID',
  `user_account` varchar(30) DEFAULT NULL COMMENT '用户账号',
  `user_nickname` varchar(30) DEFAULT NULL COMMENT '用户昵称',
  `game_id` int(11) DEFAULT NULL COMMENT '游戏id',
  `game_appid` varchar(32) DEFAULT NULL COMMENT '游戏appid',
  `game_name` varchar(30) DEFAULT NULL COMMENT '游戏名称',
  `op_id` int(11) NOT NULL COMMENT '操作人id',
  `op_nickname` varchar(30) DEFAULT NULL COMMENT '操作人昵称',
  `create_time` int(11) DEFAULT NULL COMMENT '添加时间',
  `type` int(11) DEFAULT '0' COMMENT '区分绑定平台币    1为绑定平台币补单',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_repair_record
-- ----------------------------

-- ----------------------------
-- Table structure for tab_route
-- ----------------------------
DROP TABLE IF EXISTS `tab_route`;
CREATE TABLE `tab_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '路由id',
  `full_url` varchar(255) DEFAULT NULL COMMENT '完整url， 如：portal/list/index?id=1',
  `url` varchar(255) DEFAULT NULL COMMENT '实际显示的url',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态，1：启用 ;0：不启用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='url路由表';

-- ----------------------------
-- Records of tab_route
-- ----------------------------

-- ----------------------------
-- Table structure for tab_server
-- ----------------------------
DROP TABLE IF EXISTS `tab_server`;
CREATE TABLE `tab_server` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `game_id` int(11) NOT NULL COMMENT '游戏id',
  `game_name` varchar(30) DEFAULT NULL COMMENT '游戏名称',
  `server_name` varchar(30) DEFAULT NULL COMMENT '区服名称',
  `server_num` int(11) DEFAULT NULL COMMENT '对接区服id',
  `recommend_status` tinyint(2) DEFAULT '1' COMMENT '推荐状态(0:否,1:是)',
  `show_status` tinyint(2) DEFAULT '1' COMMENT '显示状态(0:否,1:是)',
  `stop_status` tinyint(2) DEFAULT '0' COMMENT '是否停服(0:否,1:是)',
  `server_status` tinyint(2) DEFAULT '0' COMMENT '区服状态(0:正常,1拥挤,2爆满)',
  `icon` int(11) DEFAULT NULL COMMENT '区服图标',
  `start_time` int(11) DEFAULT NULL COMMENT '开始时间',
  `desride` varchar(300) DEFAULT NULL COMMENT '描述',
  `prompt` varchar(300) DEFAULT NULL COMMENT '停服提示',
  `parent_id` int(11) DEFAULT NULL COMMENT '父类id',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='游戏区服表';

-- ----------------------------
-- Records of tab_server
-- ----------------------------

-- ----------------------------
-- Table structure for tab_settlement
-- ----------------------------
DROP TABLE IF EXISTS `tab_settlement`;
CREATE TABLE `tab_settlement` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `promote_id` int(11) DEFAULT NULL COMMENT '推广员ID',
  `game_id` varchar(32) DEFAULT NULL COMMENT '游戏ID',
  `status` tinyint(2) DEFAULT '1' COMMENT '结算状态',
  `ti_status` int(11) DEFAULT '-1' COMMENT '提现状态(-1未申请 0 申请中 1 已通过 2 已驳回)',
  `game_name` varchar(40) NOT NULL COMMENT '游戏名称',
  `promote_account` varchar(55) NOT NULL COMMENT '推广员账号',
  `total_money` double(10,2) DEFAULT NULL COMMENT '充值总额',
  `total_number` int(19) unsigned NOT NULL DEFAULT '0' COMMENT '注册人数',
  `settlement_number` varchar(60) NOT NULL COMMENT '结算单号',
  `pattern` int(11) NOT NULL DEFAULT '0' COMMENT '合作模式',
  `ratio` double(5,2) unsigned DEFAULT '0.00' COMMENT 'CPS分成比例(%)',
  `money` double(10,2) unsigned DEFAULT '0.00' COMMENT 'CPA注册单价(元)',
  `sum_money` double(10,2) DEFAULT '0.00' COMMENT '结算金额',
  `create_time` int(11) DEFAULT NULL COMMENT '结算时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_settlement
-- ----------------------------

-- ----------------------------
-- Table structure for tab_son_settlement
-- ----------------------------
DROP TABLE IF EXISTS `tab_son_settlement`;
CREATE TABLE `tab_son_settlement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `settlement_number` varchar(30) DEFAULT NULL,
  `settlement_start_time` int(11) DEFAULT NULL COMMENT '结算开始时间',
  `settlement_end_time` int(11) DEFAULT NULL COMMENT '结算结束时间',
  `game_id` int(11) DEFAULT NULL COMMENT '游戏id',
  `game_name` varchar(30) DEFAULT NULL COMMENT '游戏名称',
  `promote_id` int(11) DEFAULT NULL COMMENT '推广id(子账号id)',
  `promote_account` varchar(30) DEFAULT NULL COMMENT '子账号',
  `pattern` int(11) DEFAULT NULL COMMENT '合作模式',
  `sum_money` double DEFAULT NULL COMMENT '充值总额',
  `reg_number` int(11) DEFAULT NULL COMMENT '注册人数',
  `ratio` double(11,0) DEFAULT NULL COMMENT '分成比例',
  `money` double(11,0) DEFAULT NULL COMMENT '注册单价',
  `jie_money` double DEFAULT NULL COMMENT '结算金额',
  `create_time` int(11) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_son_settlement
-- ----------------------------

-- ----------------------------
-- Table structure for tab_spend
-- ----------------------------
DROP TABLE IF EXISTS `tab_spend`;
CREATE TABLE `tab_spend` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_id` int(11) NOT NULL COMMENT ' 用户ID',
  `user_account` varchar(30) DEFAULT NULL COMMENT '用户账号',
  `user_nickname` varchar(30) DEFAULT NULL COMMENT '用户昵称',
  `game_id` int(11) DEFAULT NULL COMMENT '游戏id',
  `game_appid` varchar(32) DEFAULT NULL COMMENT '游戏appid',
  `game_name` varchar(30) DEFAULT NULL COMMENT '游戏名称',
  `server_id` int(11) DEFAULT NULL COMMENT '区服id',
  `server_name` varchar(30) DEFAULT NULL COMMENT '区服名称',
  `promote_id` int(11) DEFAULT NULL COMMENT '推广员id',
  `promote_account` varchar(30) DEFAULT NULL COMMENT '推广员账号',
  `order_number` varchar(30) DEFAULT NULL COMMENT '订单号',
  `pay_order_number` varchar(30) DEFAULT NULL COMMENT '支付订单号',
  `props_name` varchar(30) DEFAULT NULL COMMENT '道具名称',
  `pay_amount` double(10,2) DEFAULT NULL COMMENT '支付金额',
  `pay_time` int(11) DEFAULT NULL COMMENT '支付时间',
  `pay_status` tinyint(2) DEFAULT NULL COMMENT '支付状态',
  `pay_game_status` tinyint(2) DEFAULT NULL COMMENT '游戏支付状态',
  `extend` varchar(32) DEFAULT NULL COMMENT '通知游戏方扩展(一般是游戏方透传)',
  `pay_way` tinyint(2) DEFAULT NULL COMMENT '支付方式',
  `spend_ip` varchar(20) DEFAULT NULL COMMENT '支付IP',
  `is_check` int(11) DEFAULT '1' COMMENT '是否对账  1参与 2不参与 3参与(已对账) 4不参与(已对账)',
  `selle_status` int(11) NOT NULL DEFAULT '0' COMMENT 'CP结算 0未结算1 结算',
  `selle_ratio` double(5,2) DEFAULT '0.00' COMMENT 'cp分成比例',
  `sub_status` int(11) NOT NULL DEFAULT '0' COMMENT '子渠道结算状态',
  `selle_time` varchar(30) DEFAULT NULL COMMENT 'cp结算时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_spend
-- ----------------------------

-- ----------------------------
-- Table structure for tab_tool
-- ----------------------------
DROP TABLE IF EXISTS `tab_tool`;
CREATE TABLE `tab_tool` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `name` varchar(30) DEFAULT NULL COMMENT '标识',
  `title` varchar(30) DEFAULT NULL COMMENT '标题',
  `config` text COMMENT '配置文件内容',
  `template` text COMMENT '模板内容',
  `type` tinyint(3) DEFAULT NULL COMMENT '类型',
  `status` tinyint(3) DEFAULT NULL COMMENT '状态',
  `create_time` int(11) DEFAULT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COMMENT='扩展工具表';

-- ----------------------------
-- Records of tab_tool
-- ----------------------------
INSERT INTO `tab_tool` VALUES ('1', 'sms_set', '短信设置', '{\"smtp\":\"\",\"smtp_account\":\"\",\"smtp_password\":\"\",\"smtp_port\":\"\"}', '1', '1', '1', '1464164373');
INSERT INTO `tab_tool` VALUES ('2', 'oss_storage', 'OSS存储', '{\"bucket\":\"xgceshi\",\"accesskeyid\":\"\",\"accesskeysecr\":\"\",\"domain\":\"oss-cn-shenzhen.aliyuncs.com\"}', null, '1', '0', '1464164373');
INSERT INTO `tab_tool` VALUES ('3', 'qiniu_storage', '七牛存储', '{\"bucket\":\"22\",\"accesskeyid\":\"222\",\"accesskeysecr\":\"22\",\"domain\":\"22\"}', null, '1', '1', '1464164373');
INSERT INTO `tab_tool` VALUES ('4', 'alipay', '支付宝设置', '{\"partner\":\"\",\"key\":\"\",\"email\":\"@qq.com\"}', null, '1', '0', '1464164373');
INSERT INTO `tab_tool` VALUES ('5', 'weixin', '微信设置', '{\"partner\":\"\",\"email\":\"\",\"key\":\"\"}', null, '1', '0', '1464164373');
INSERT INTO `tab_tool` VALUES ('6', 'email_set', '邮件设置', null, null, '1', '1', '1464164373');
INSERT INTO `tab_tool` VALUES ('7', 'qq_login', 'QQ登陆设置', '{\"appid\":\"\",\"key\":\"\",\"account\":\"1\"}', null, '1', '1', '1464164373');
INSERT INTO `tab_tool` VALUES ('8', 'wx_login', '微信登陆设置', '{\"appid\":\"\",\"appsecret\":\"\"}', null, '1', '1', '1464164373');
INSERT INTO `tab_tool` VALUES ('9', 'heepay', '汇付宝设置', '{\"partner\":\"\",\"email\":\"\",\"key\":\"\"}', null, '1', '1', '1464164373');
INSERT INTO `tab_tool` VALUES ('10', 'wechat', '微信公众号', '{\"appid\":\"\",\"appsecret\":\"\",\"token\":\"\",\"key\":\"\",\"message\":{\"first_msg\":\"2222\",\"default_msg\":\"22222\"}}', '{\"nav\":{\"1\":{\"title\":[\"\\u7f51\\u7ad9\\u9996\\u9875\",\"\\u4e2a\\u4eba\\u540e\\u53f0\"],\"url\":[\"http:\\/\\/h5.vlcms.com\",\"\"]},\"2\":{\"pid\":[\"\",\"\"],\"title\":[\"\\u6211\\u7684\\u540e\\u53f0\",\"\\u5173\\u4e8e\\u6211\\u4eec\"],\"marak\":[\"1\",\"2\"],\"url\":[\"http:\\/\\/h5.vlcms.com\\/media.php?s=\\/Subscriber\\/index.html\",\"http:\\/\\/h5.vlcms.com\\/media.php?s=\\/Subscriber\\/about.html\"]}}}', '1', '1', '1464164373');

-- ----------------------------
-- Table structure for tab_user
-- ----------------------------
DROP TABLE IF EXISTS `tab_user`;
CREATE TABLE `tab_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `account` varchar(30) DEFAULT NULL COMMENT '登陆账号',
  `password` varchar(32) DEFAULT NULL COMMENT '登陆密码',
  `promote_id` int(11) NOT NULL DEFAULT '0' COMMENT '推广id',
  `promote_account` varchar(30) DEFAULT NULL COMMENT '推广员账号',
  `parent_id` int(11) DEFAULT '0' COMMENT '父类id',
  `parent_name` varchar(30) DEFAULT NULL COMMENT '父类名称',
  `fgame_id` int(11) DEFAULT '0',
  `fgame_name` varchar(30) DEFAULT NULL,
  `nickname` varchar(30) DEFAULT NULL COMMENT '昵称',
  `sex` int(11) DEFAULT '0' COMMENT '性别(0 男 1 女)',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(15) DEFAULT NULL COMMENT '手机号码',
  `real_name` varchar(20) DEFAULT NULL COMMENT '真实姓名',
  `idcard` varchar(20) DEFAULT NULL COMMENT '身份证',
  `vip_level` tinyint(2) DEFAULT '0' COMMENT 'vip等级',
  `cumulative` double(10,2) DEFAULT '0.00' COMMENT '累计充值',
  `balance` double(10,2) DEFAULT '0.00' COMMENT '余额',
  `anti_addiction` tinyint(2) DEFAULT '0' COMMENT '防沉迷',
  `lock_status` tinyint(2) DEFAULT '1' COMMENT '锁定状态',
  `register_way` tinyint(2) DEFAULT '0' COMMENT '注册方式',
  `register_time` int(11) DEFAULT NULL COMMENT '注册时间',
  `login_time` int(11) DEFAULT NULL COMMENT '登陆时间',
  `register_ip` varchar(16) NOT NULL COMMENT '注册ip',
  `login_ip` varchar(16) NOT NULL COMMENT '登陆ip',
  `is_check` int(11) NOT NULL DEFAULT '1' COMMENT '是否对账  1参与 2不参与 3参与(已对账) 4不参与(已对账)',
  `sub_status` int(11) DEFAULT '0' COMMENT '子渠道结算状态(0未结算 1已结算)',
  `collection` varchar(255) DEFAULT NULL COMMENT '游戏收藏  id',
  `user_type` smallint(2) DEFAULT '0' COMMENT '用户类型 0：用户，1：混服',
  `mix_user_id` int(11) DEFAULT '0' COMMENT '所属混服站点（所属混服用户）',
  `openid` varchar(255) DEFAULT NULL COMMENT '用户标识',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of tab_user
-- ----------------------------

-- ----------------------------
-- Table structure for tab_user_login_record
-- ----------------------------
DROP TABLE IF EXISTS `tab_user_login_record`;
CREATE TABLE `tab_user_login_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `game_id` int(11) DEFAULT NULL COMMENT '游戏id',
  `game_name` varchar(30) DEFAULT NULL COMMENT ' 游戏名称',
  `server_id` int(11) DEFAULT NULL COMMENT '区服id',
  `server_name` varchar(30) DEFAULT NULL COMMENT '区服名称',
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `user_account` varchar(30) DEFAULT NULL COMMENT '用户账号',
  `user_nickname` varchar(30) DEFAULT NULL COMMENT '用户昵称',
  `login_time` int(11) DEFAULT NULL COMMENT '登陆时间',
  `login_ip` varchar(20) DEFAULT NULL COMMENT '登陆ip',
  `type` tinyint(2) DEFAULT '1' COMMENT '类型(1:游戏登陆,2:PC登陆)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tab_user_login_record
-- ----------------------------

-- ----------------------------
-- Table structure for tab_user_play
-- ----------------------------
DROP TABLE IF EXISTS `tab_user_play`;
CREATE TABLE `tab_user_play` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `user_id` int(11) DEFAULT NULL COMMENT '用户ID',
  `user_account` varchar(30) DEFAULT NULL COMMENT '用户账号',
  `user_nickname` varchar(30) DEFAULT NULL COMMENT '用户昵称',
  `game_id` int(11) NOT NULL COMMENT '游戏id',
  `game_name` varchar(30) DEFAULT NULL COMMENT '游戏名称',
  `game_appid` varchar(32) DEFAULT NULL COMMENT '游戏appid',
  `server_id` int(11) NOT NULL COMMENT '区服id',
  `server_name` varchar(30) DEFAULT NULL COMMENT '区服名称',
  `role_id` int(11) DEFAULT '0' COMMENT '角色',
  `bind_balance` double(10,2) DEFAULT '0.00' COMMENT '绑定平台币',
  `role_name` varchar(20) DEFAULT NULL COMMENT '角色名称',
  `role_level` int(3) DEFAULT '0' COMMENT '等级',
  `promote_id` int(11) DEFAULT '0' COMMENT '推广员id',
  `promote_account` varchar(30) DEFAULT NULL COMMENT '推广员账号',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='玩家表';

-- ----------------------------
-- Records of tab_user_play
-- ----------------------------

-- ----------------------------
-- Table structure for tab_withdraw
-- ----------------------------
DROP TABLE IF EXISTS `tab_withdraw`;
CREATE TABLE `tab_withdraw` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `settlement_number` varchar(50) DEFAULT NULL COMMENT '结算单号',
  `sum_money` double DEFAULT NULL COMMENT '结算金额',
  `promote_id` int(11) DEFAULT NULL COMMENT '推广员id',
  `promote_account` varchar(30) DEFAULT NULL COMMENT '推广姓名',
  `create_time` int(11) DEFAULT NULL COMMENT '申请时间',
  `end_time` int(11) DEFAULT NULL COMMENT '完成时间',
  `status` int(11) DEFAULT '0' COMMENT '提现状态(-1未申请 0 申请中 1 已通过 2 已驳回)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='结算表';

-- ----------------------------
-- Records of tab_withdraw
-- ----------------------------


