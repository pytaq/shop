/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50520
Source Host           : localhost:3306
Source Database       : shop

Target Server Type    : MYSQL
Target Server Version : 50520
File Encoding         : 65001

Date: 2019-07-12 20:35:07
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `attachment`
-- ----------------------------
DROP TABLE IF EXISTS `attachment`;
CREATE TABLE `attachment` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `uid` int(10) unsigned NOT NULL COMMENT 'userId',
  `filename` varchar(255) NOT NULL COMMENT '文件名字',
  `attachment` varchar(255) NOT NULL COMMENT '附件',
  `type` tinyint(3) unsigned NOT NULL COMMENT '1为图片',
  `createtime` int(10) unsigned NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of attachment
-- ----------------------------

-- ----------------------------
-- Table structure for `bonus_good`
-- ----------------------------
DROP TABLE IF EXISTS `bonus_good`;
CREATE TABLE `bonus_good` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '优惠券ID',
  `bonus_type_id` mediumint(8) NOT NULL COMMENT '优惠券类型ID',
  `good_id` int(10) NOT NULL COMMENT '商品ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bonus_good
-- ----------------------------

-- ----------------------------
-- Table structure for `bonus_type`
-- ----------------------------
DROP TABLE IF EXISTS `bonus_type`;
CREATE TABLE `bonus_type` (
  `type_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '优惠券类型',
  `type_name` varchar(60) NOT NULL DEFAULT '' COMMENT '类型名称',
  `type_money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '优惠券金额',
  `send_type` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '发放类型',
  `deleted` int(1) NOT NULL DEFAULT '0',
  `min_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '最小数量',
  `max_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '最大数量',
  `send_start_date` int(11) NOT NULL DEFAULT '0' COMMENT '发放开始时间',
  `send_end_date` int(11) NOT NULL DEFAULT '0' COMMENT '发放结束时间',
  `use_start_date` int(11) NOT NULL DEFAULT '0' COMMENT '可以用券的开始日期',
  `use_end_date` int(11) NOT NULL DEFAULT '0' COMMENT '可以用券的结束日期',
  `min_goods_amount` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '最小商品数量',
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bonus_type
-- ----------------------------

-- ----------------------------
-- Table structure for `bonus_user`
-- ----------------------------
DROP TABLE IF EXISTS `bonus_user`;
CREATE TABLE `bonus_user` (
  `bonus_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '优惠券ID',
  `bonus_type_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券类型ID',
  `bonus_sn` varchar(20) NOT NULL DEFAULT '' COMMENT '订单号',
  `openid` varchar(50) NOT NULL DEFAULT '' COMMENT '验证ID',
  `deleted` int(1) NOT NULL DEFAULT '0' COMMENT '是否移除',
  `isuse` int(1) NOT NULL DEFAULT '0' COMMENT '是否可用',
  `used_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '使用时间',
  `order_id` mediumint(8) unsigned NOT NULL DEFAULT '0' COMMENT '订单号',
  `collect_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '得到优惠券的时间',
  `createtime` int(10) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`bonus_id`),
  KEY `openid` (`openid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bonus_user
-- ----------------------------

-- ----------------------------
-- Table structure for `config`
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `title` varchar(50) NOT NULL COMMENT '商城名称',
  `address` varchar(100) NOT NULL COMMENT '商城公司地址',
  `webtitle` varchar(50) NOT NULL COMMENT '浏览器标题',
  `email` varchar(50) NOT NULL COMMENT '商城邮箱',
  `keyword` varchar(100) NOT NULL COMMENT '商城关键字',
  `description` varchar(200) NOT NULL COMMENT '商城描述',
  `phone` varchar(50) NOT NULL COMMENT '商城电话',
  `icp` varchar(50) NOT NULL COMMENT '备案号',
  `logo` varchar(200) DEFAULT NULL COMMENT '商城logo图',
  `tongjicode` longtext COMMENT '商城第三方统计js代码',
  `kfcode` longtext COMMENT '商城第三方客服代码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES ('21', '惠特集商城', '重庆市渝中区两路口', '惠特集', '999888@qq.com', '网上购物,网上商城,家电,手机,电脑,服装,居家,母婴,美妆,个护,食品,生鲜,京东', '重庆本地快速配送的优质商城', '400-777-888', '渝B2-20110050-2', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0oSDSANnOPAAADGh7PIv4829.png', '                                                                                    <script>\nvar _hmt = _hmt || [];\n(function() {\n  var hm = document.createElement(\"script\");\n  hm.src = \"https://hm.baidu.com/hm.js?5d97579683fd910de47a9477b8ea2ab3\";\n  var s = document.getElementsByTagName(\"script\")[0]; \n  s.parentNode.insertBefore(hm, s);\n})();\n</script>\n', '<script type=\"text/javascript\" src=\"http://webchat.7moor.com/javascripts/7moorInit.js?accessId=5d8477d0-79a7-11e5-a21d-a319553981f9&autoShow=true\"  async=\"async\"></script>\n \n <button onclick=\"qimoChatClick()\">在线咨询</button>\n');

-- ----------------------------
-- Table structure for `delivery_mode`
-- ----------------------------
DROP TABLE IF EXISTS `delivery_mode`;
CREATE TABLE `delivery_mode` (
  `id` int(5) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `deliveryexplain` varchar(20) NOT NULL COMMENT '配送说明',
  `deliveryfee` double(5,2) NOT NULL COMMENT '配送小费',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of delivery_mode
-- ----------------------------
INSERT INTO `delivery_mode` VALUES ('3', '顺丰快递', '15.00');
INSERT INTO `delivery_mode` VALUES ('4', '天天快递', '12.00');
INSERT INTO `delivery_mode` VALUES ('6', '京东快递', '15.00');
INSERT INTO `delivery_mode` VALUES ('7', '自提', '0.00');

-- ----------------------------
-- Table structure for `dispatch`
-- ----------------------------
DROP TABLE IF EXISTS `dispatch`;
CREATE TABLE `dispatch` (
  `id` int(7) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL DEFAULT '',
  `name` varchar(120) NOT NULL DEFAULT '',
  `sendtype` int(5) NOT NULL DEFAULT '1' COMMENT '0为快递，1为自提',
  `desc` text NOT NULL,
  `configs` text NOT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dispatch
-- ----------------------------

-- ----------------------------
-- Table structure for `gold_order`
-- ----------------------------
DROP TABLE IF EXISTS `gold_order`;
CREATE TABLE `gold_order` (
  `createtime` int(10) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '0',
  `paytime` int(10) DEFAULT '0' COMMENT '支付时间',
  `price` decimal(10,2) NOT NULL,
  `openid` varchar(40) NOT NULL,
  `ordersn` varchar(20) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of gold_order
-- ----------------------------

-- ----------------------------
-- Table structure for `gold_teller`
-- ----------------------------
DROP TABLE IF EXISTS `gold_teller`;
CREATE TABLE `gold_teller` (
  `createtime` int(10) NOT NULL,
  `status` int(2) NOT NULL DEFAULT '0' COMMENT '0未审核-1拒绝1审核功成',
  `fee` decimal(10,2) NOT NULL,
  `openid` varchar(40) NOT NULL,
  `ordersn` varchar(20) DEFAULT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of gold_teller
-- ----------------------------

-- ----------------------------
-- Table structure for `member`
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member` (
  `email` varchar(20) NOT NULL,
  `credit` int(11) NOT NULL DEFAULT '0' COMMENT '积分',
  `gold` double NOT NULL DEFAULT '0' COMMENT '余额',
  `openid` varchar(50) NOT NULL,
  `realname` varchar(20) NOT NULL,
  `mobile` varchar(11) NOT NULL,
  `pwd` varchar(50) NOT NULL,
  `salt` varchar(20) DEFAULT NULL COMMENT 'MD5盐',
  `createtime` int(10) NOT NULL,
  `istemplate` int(1) DEFAULT '0' COMMENT '是否为临时账户 1是，0为否',
  `status` int(1) DEFAULT '1' COMMENT '0为禁用，1为可用',
  `experience` int(11) DEFAULT '0' COMMENT '账户经验值',
  `avatar` varchar(200) DEFAULT '' COMMENT '用户头像',
  `outgold` double NOT NULL DEFAULT '0' COMMENT '已提取余额',
  `outgoldinfo` varchar(1000) DEFAULT '0' COMMENT '提款信息 序列化',
  `weixin_openid` varchar(100) DEFAULT '' COMMENT '微信openid',
  `alipay_openid` varchar(50) DEFAULT '' COMMENT '阿里openid',
  PRIMARY KEY (`openid`),
  KEY `idx_member_from_user` (`openid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES ('1212@qq.com', '11', '120', '12', '李家旺', '121212', 'lijiawang', null, '20190701', '0', '0', '111', '李家旺', '12', '12', null, null);
INSERT INTO `member` VALUES ('16547313@qq.com', '0', '0', '13', '445', '55', '66', null, '20190707', '1', '0', '0', '', '0', '0', null, null);
INSERT INTO `member` VALUES ('422470668@qq.com', '99', '100', '8b14450f-c834-41ce-9a7d-09b43704ead8', '刘奕', '18723010804', 'liuyi', null, '20190702', '1', '1', '100', '刘奕', '10', '10', null, null);

-- ----------------------------
-- Table structure for `member_paylog`
-- ----------------------------
DROP TABLE IF EXISTS `member_paylog`;
CREATE TABLE `member_paylog` (
  `createtime` int(10) NOT NULL,
  `remark` varchar(100) NOT NULL,
  `fee` decimal(10,2) NOT NULL,
  `openid` varchar(40) NOT NULL,
  `type` varchar(30) NOT NULL COMMENT 'usegold使用金额 addgold充值金额 usecredit使用积分 addcredit充值积分',
  `pid` bigint(20) NOT NULL AUTO_INCREMENT,
  `account_fee` decimal(10,2) NOT NULL COMMENT '账户剩余积分或余额',
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of member_paylog
-- ----------------------------

-- ----------------------------
-- Table structure for `modules`
-- ----------------------------
DROP TABLE IF EXISTS `modules`;
CREATE TABLE `modules` (
  `displayorder` int(11) NOT NULL DEFAULT '0',
  `icon` varchar(30) NOT NULL,
  `group` varchar(30) NOT NULL,
  `title` varchar(30) NOT NULL,
  `version` decimal(5,2) NOT NULL,
  `name` varchar(30) NOT NULL,
  `isdisable` int(1) DEFAULT '0' COMMENT '模块是否禁用',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of modules
-- ----------------------------

-- ----------------------------
-- Table structure for `modules_menu`
-- ----------------------------
DROP TABLE IF EXISTS `modules_menu`;
CREATE TABLE `modules_menu` (
  `href` varchar(200) NOT NULL,
  `title` varchar(50) NOT NULL,
  `module` varchar(30) NOT NULL,
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of modules_menu
-- ----------------------------

-- ----------------------------
-- Table structure for `paylog`
-- ----------------------------
DROP TABLE IF EXISTS `paylog`;
CREATE TABLE `paylog` (
  `paytype` varchar(30) NOT NULL COMMENT '支付方式',
  `paymaney` varchar(10) NOT NULL COMMENT '支付金额',
  `ptype` varchar(10) NOT NULL COMMENT '支付类型',
  `typename` varchar(30) NOT NULL COMMENT '支付方式',
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pId` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of paylog
-- ----------------------------
INSERT INTO `paylog` VALUES ('微信支付', '10', '网银', '中国银行', '1', '0');
INSERT INTO `paylog` VALUES ('微信支付', '20', '网银', '余额支付', '2', '0');
INSERT INTO `paylog` VALUES ('微信支付', '30', '网银', '工商银行', '3', '0');
INSERT INTO `paylog` VALUES ('银联', '0', '网银', '邮储银行', '4', '1');
INSERT INTO `paylog` VALUES ('银联', '100', '网银', '建设银行', '5', '2');
INSERT INTO `paylog` VALUES ('银联', '50', '网银', '农业银行', '6', '3');
INSERT INTO `paylog` VALUES ('货到付款', '1000', '现金', '现金', '7', '4');

-- ----------------------------
-- Table structure for `paylog_alipay`
-- ----------------------------
DROP TABLE IF EXISTS `paylog_alipay`;
CREATE TABLE `paylog_alipay` (
  `createtime` int(10) NOT NULL COMMENT '创建时间',
  `alipay_safepid` varchar(50) DEFAULT NULL,
  `buyer_email` varchar(50) DEFAULT NULL COMMENT '买家邮箱',
  `buyer_id` varchar(50) DEFAULT NULL COMMENT '买家ID',
  `out_trade_no` varchar(50) DEFAULT NULL,
  `seller_email` varchar(50) DEFAULT NULL COMMENT '卖家邮箱',
  `seller_id` varchar(50) DEFAULT NULL COMMENT '卖家id',
  `total_fee` decimal(10,2) DEFAULT NULL COMMENT '交易金额',
  `trade_no` varchar(50) DEFAULT NULL COMMENT '交易编号',
  `body` varchar(200) DEFAULT NULL,
  `orderid` int(10) DEFAULT NULL COMMENT '订单id',
  `ordersn` varchar(50) DEFAULT NULL,
  `reason` varchar(100) DEFAULT NULL,
  `presult` varchar(50) DEFAULT NULL COMMENT 'success 或error',
  `order_table` varchar(50) DEFAULT NULL COMMENT '订单类型 shop_order gold_order',
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of paylog_alipay
-- ----------------------------

-- ----------------------------
-- Table structure for `paylog_unionpay`
-- ----------------------------
DROP TABLE IF EXISTS `paylog_unionpay`;
CREATE TABLE `paylog_unionpay` (
  `createtime` int(10) NOT NULL COMMENT '创建时间',
  `txnTime` int(10) DEFAULT NULL COMMENT '交易时间',
  `txnAmt` decimal(10,2) DEFAULT NULL COMMENT '交易金额',
  `queryid` varchar(50) DEFAULT NULL COMMENT '交易查询流水号',
  `currencyCode` varchar(10) DEFAULT NULL COMMENT '交易币种',
  `reqReserved` varchar(100) DEFAULT NULL COMMENT '请求保留域',
  `settleAmt` decimal(10,2) DEFAULT NULL COMMENT '清算金额',
  `settleCurrencyCode` varchar(10) DEFAULT NULL COMMENT '清算币种',
  `traceTime` int(10) DEFAULT NULL COMMENT '交易传输时间',
  `traceNo` varchar(50) DEFAULT NULL COMMENT '系统跟踪号',
  `merId` varchar(50) DEFAULT NULL COMMENT '商户代码',
  `orderid` int(10) DEFAULT NULL COMMENT '订单id',
  `ordersn` varchar(50) DEFAULT NULL,
  `reason` varchar(100) DEFAULT NULL,
  `presult` varchar(50) DEFAULT NULL COMMENT 'success 或error',
  `order_table` varchar(50) DEFAULT NULL COMMENT '订单类型 shop_order gold_order',
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of paylog_unionpay
-- ----------------------------

-- ----------------------------
-- Table structure for `paylog_weixin`
-- ----------------------------
DROP TABLE IF EXISTS `paylog_weixin`;
CREATE TABLE `paylog_weixin` (
  `createtime` int(10) NOT NULL,
  `timeend` int(10) DEFAULT NULL,
  `total_fee` decimal(10,2) DEFAULT NULL COMMENT '交易金额',
  `mchId` varchar(50) DEFAULT NULL COMMENT '商户id',
  `openid` varchar(50) DEFAULT NULL COMMENT '验证id',
  `transaction_id` varchar(50) DEFAULT NULL COMMENT '交易id',
  `out_trade_no` varchar(50) DEFAULT NULL COMMENT '贸易id',
  `orderid` int(10) DEFAULT NULL COMMENT '订单id',
  `ordersn` varchar(50) DEFAULT NULL COMMENT '订单号',
  `reason` varchar(100) DEFAULT NULL,
  `presult` varchar(50) DEFAULT NULL COMMENT 'success 或error',
  `order_table` varchar(50) DEFAULT NULL COMMENT '订单类型 shop_order gold_order',
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of paylog_weixin
-- ----------------------------

-- ----------------------------
-- Table structure for `payment`
-- ----------------------------
DROP TABLE IF EXISTS `payment`;
CREATE TABLE `payment` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL DEFAULT '' COMMENT '商品编码',
  `name` varchar(120) NOT NULL DEFAULT '',
  `desc` text NOT NULL,
  `order` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '订单',
  `configs` text NOT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `iscod` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `online` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pay_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of payment
-- ----------------------------

-- ----------------------------
-- Table structure for `rank_model`
-- ----------------------------
DROP TABLE IF EXISTS `rank_model`;
CREATE TABLE `rank_model` (
  `rank_level` int(3) NOT NULL DEFAULT '0' COMMENT '等级',
  `rank_name` varchar(50) DEFAULT NULL COMMENT '等级名称',
  `experience` int(11) DEFAULT '0',
  PRIMARY KEY (`rank_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of rank_model
-- ----------------------------
INSERT INTO `rank_model` VALUES ('1', '普通会员', '10000');
INSERT INTO `rank_model` VALUES ('2', '白银会员', '50000');
INSERT INTO `rank_model` VALUES ('3', '黄金会员', '100000');

-- ----------------------------
-- Table structure for `shop_address`
-- ----------------------------
DROP TABLE IF EXISTS `shop_address`;
CREATE TABLE `shop_address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '地址id',
  `openid` varchar(50) NOT NULL COMMENT '信息',
  `realname` varchar(20) NOT NULL COMMENT '真实名字',
  `mobile` varchar(11) NOT NULL COMMENT '手机号码',
  `province` varchar(30) DEFAULT NULL COMMENT '省份',
  `city` varchar(30) NOT NULL COMMENT '城市',
  `area` varchar(30) NOT NULL COMMENT '区',
  `address` varchar(300) NOT NULL COMMENT '地址',
  `isdefault` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '0为否，1是',
  `deleted` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_address
-- ----------------------------
INSERT INTO `shop_address` VALUES ('1', '8b14450f-c834-41ce-9a7d-09b43704ead8', '刘奕', '18723010804', '', '重庆', '南坪', '万达广场', '1', '0');
INSERT INTO `shop_address` VALUES ('2', '8b14450f-c834-41ce-9a7d-09b43704ead8', '刘奕', '18723010804', null, '重庆', '渝中', '文化宫', '0', '0');

-- ----------------------------
-- Table structure for `shop_adv`
-- ----------------------------
DROP TABLE IF EXISTS `shop_adv`;
CREATE TABLE `shop_adv` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '图片id',
  `link` varchar(255) NOT NULL DEFAULT '' COMMENT '链接',
  `thumb` varchar(255) DEFAULT '' COMMENT '图片内容',
  `displayorder` int(11) DEFAULT '0' COMMENT '显示顺序',
  `enabled` int(11) DEFAULT '0' COMMENT '启用',
  PRIMARY KEY (`id`),
  KEY `indx_enabled` (`enabled`),
  KEY `indx_displayorder` (`displayorder`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_adv
-- ----------------------------
INSERT INTO `shop_adv` VALUES ('24', '/admin/manage/user', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0oSr6ATJbsAADkbiG5Imw885.jpg', '1', '1');
INSERT INTO `shop_adv` VALUES ('25', '/admin/manage/role', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0oSxmAZJcvAADQXfYZd90316.jpg', '1', '1');
INSERT INTO `shop_adv` VALUES ('26', '/admin/manage/roleUser', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0oSySAUMn6AADPlkPYMfQ36.jpeg', '1', '1');
INSERT INTO `shop_adv` VALUES ('27', '/admin/manage/menu', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0oSz6AIYgsAAD5crmjXs4676.jpg', '1', '1');
INSERT INTO `shop_adv` VALUES ('28', '/admin/manage/member', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0oS1KAAZZLAAEalogPkek616.jpg', '1', '1');

-- ----------------------------
-- Table structure for `shop_cart`
-- ----------------------------
DROP TABLE IF EXISTS `shop_cart`;
CREATE TABLE `shop_cart` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  `goodsid` int(11) NOT NULL COMMENT '商品编号',
  `goodstype` tinyint(1) NOT NULL DEFAULT '1' COMMENT '商品类别',
  `session_id` varchar(50) NOT NULL,
  `total` int(10) unsigned NOT NULL COMMENT '总计',
  `optionid` int(10) DEFAULT '0' COMMENT '分类信息自动编号',
  `marketprice` decimal(10,2) DEFAULT '0.00' COMMENT '市场价格',
  PRIMARY KEY (`id`),
  KEY `idx_openid` (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_cart
-- ----------------------------

-- ----------------------------
-- Table structure for `shop_category`
-- ----------------------------
DROP TABLE IF EXISTS `shop_category`;
CREATE TABLE `shop_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类',
  `commission` int(10) unsigned DEFAULT '0' COMMENT '推荐该类商品所能获得的佣金',
  `name` varchar(50) NOT NULL COMMENT '分类名称',
  `thumb` varchar(255) DEFAULT NULL COMMENT '分类图片',
  `thumbadv` varchar(255) DEFAULT NULL COMMENT '分类广告图片',
  `thumbadvurl` varchar(255) DEFAULT NULL COMMENT '分类广告url',
  `parentid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上级分类ID,0为第一级',
  `isrecommand` int(10) DEFAULT '0' COMMENT '推荐',
  `description` varchar(500) DEFAULT NULL COMMENT '分类介绍',
  `displayorder` tinyint(3) unsigned DEFAULT '0' COMMENT '排序',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否开启',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_category
-- ----------------------------
INSERT INTO `shop_category` VALUES ('1', '10', '生鲜水果', null, null, '', '0', '1', '分类介绍', '1', '0', '1');
INSERT INTO `shop_category` VALUES ('2', '10', '海鲜水产', null, null, '', '1', '1', '海鲜水产', '1', '0', '1');
INSERT INTO `shop_category` VALUES ('11', '1', '三文鱼', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0lnW-AKrERAAFlfQLrta0208.jpg', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0lnP-ASQIcAAAtjL_7TH0018.jpg', '', '2', '1', '三文鱼', '0', '1', '1');
INSERT INTO `shop_category` VALUES ('14', '10', '粮油副食', null, null, '', '0', '1', '粮油副食', '0', '1', '1');
INSERT INTO `shop_category` VALUES ('16', '10', '菌菇干货', null, null, '', '14', '1', '菌菇干货', '0', '1', '1');
INSERT INTO `shop_category` VALUES ('17', '1', '木耳', 'http://huiteji.oss-cn-hangzhou.aliyuncs.com/Storage/Plat/ImageAd/201712151156550109500.jpg', null, '', '16', '1', '好吃的木耳', '0', '1', '1');
INSERT INTO `shop_category` VALUES ('18', '10', '居家日用', null, null, '', '0', '1', '居家日用', '0', '1', '1');
INSERT INTO `shop_category` VALUES ('19', '10', '厨具', null, null, '', '18', '1', '家用厨具', '0', '1', '1');
INSERT INTO `shop_category` VALUES ('20', '1', '锅具', 'http://huiteji.oss-cn-hangzhou.aliyuncs.com/Storage/Plat/ImageAd/201801041615108392170.jpg', null, '', '19', '1', '家用锅具', '0', '1', '1');
INSERT INTO `shop_category` VALUES ('21', '10', '食品酒水', '', '', '', '0', '1', '食品酒水', '0', '1', '1');
INSERT INTO `shop_category` VALUES ('22', '10', '高端白酒', null, null, '', '21', '1', '高端白酒', '0', '1', '1');
INSERT INTO `shop_category` VALUES ('23', '1', '贵州茅台', 'http://huiteji.oss-cn-hangzhou.aliyuncs.com/Storage/Plat/ImageAd/201801111632012385520.jpg\" width=\"50\" height=\"50\"', null, '', '22', '1', '贵州茅台', '0', '1', '1');
INSERT INTO `shop_category` VALUES ('26', '0', '鱼类', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0lno-Abd05AABHlLoCk-k833.jpg', '', '', '2', '1', '鱼类', '0', '1', '1');
INSERT INTO `shop_category` VALUES ('27', '0', '贝类', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0lnq-AIvHSAAEZISndrMY977.jpg', '', '', '2', '1', '贝类', null, '1', '1');
INSERT INTO `shop_category` VALUES ('28', '0', '蟹类', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0lsFaANv22AAEGCiALugI794.jpg', '', '', '2', '1', '蟹类', null, '1', '1');
INSERT INTO `shop_category` VALUES ('29', '0', '虾类', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0lsIWAfCetAAEb_s5yHic965.jpg', '', '', '2', '1', '虾类', null, '1', '1');
INSERT INTO `shop_category` VALUES ('30', '0', '大闸蟹', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0lsKyAC-MVAAGitrf0lT4418.jpg', '', '', '2', '1', '大闸蟹', null, '1', '1');
INSERT INTO `shop_category` VALUES ('31', '0', '鸡枞油', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0lsQ2AX7ECAAHee2XXTlo647.jpg', '', '', '16', '1', '鸡枞油', null, '1', '1');
INSERT INTO `shop_category` VALUES ('32', '0', '野生松茸干', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0lsTyAOgRwAAMTy_m7J3Q921.jpg', '', '', '16', '1', '野生松茸干', null, '1', '1');
INSERT INTO `shop_category` VALUES ('33', '0', '宽叶海带', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0lsVyAD0jIAAAkYNKnbq0010.jpg', '', '', '16', '1', '宽叶海带', null, '1', '1');
INSERT INTO `shop_category` VALUES ('34', '0', '香菇', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0lsXqAacRxAAKFpYIh3xE060.jpg', '', '', '16', '1', '香菇', null, '1', '1');
INSERT INTO `shop_category` VALUES ('35', '0', '水具酒具', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0lsdqAJBBIAAAIIDQsnOI583.jpg', '', '', '19', '1', '水具酒具', null, '1', '1');
INSERT INTO `shop_category` VALUES ('36', '0', '餐具', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0lsf6AbC4AAAAis2PdN9s874.jpg', '', '', '19', '1', '餐具', null, '1', '1');
INSERT INTO `shop_category` VALUES ('37', '0', '功能厨具', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0lsiGAPMbDAAAMLZ4pt_4960.jpg', '', '', '19', '1', '功能厨具', null, '1', '1');
INSERT INTO `shop_category` VALUES ('38', '0', '咖啡具', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0lsjqAcQvlAAA0Jxuf8iM246.png', '', '', '19', '1', '咖啡具', null, '1', '1');
INSERT INTO `shop_category` VALUES ('39', '0', '新鲜水果', '', '', '', '1', '1', '新鲜水果', null, '1', '1');
INSERT INTO `shop_category` VALUES ('40', '0', '巫山脆李', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0ltZWAQKEiAACOInTVBy0789.jpg', '', '', '39', '1', '巫山脆李', null, '1', '1');
INSERT INTO `shop_category` VALUES ('41', '0', '苹果', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0ltcGAcaTzAAA5nOKaCJA902.jpg', '', '', '39', '1', '苹果', null, '1', '1');
INSERT INTO `shop_category` VALUES ('42', '0', '五粮液', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0oTQWAZH8hAAA1l9UQjoo001.jpg', '', '', '22', '1', '五粮液', null, '1', '1');
INSERT INTO `shop_category` VALUES ('43', '0', '精品白酒', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0oTS-AfFGOAAAtgy7gNp0625.jpg', '', '', '22', '1', '精品白酒', null, '1', '1');
INSERT INTO `shop_category` VALUES ('44', '7', '啤酒', '', '', '', '21', '1', '啤酒', null, '1', '1');
INSERT INTO `shop_category` VALUES ('45', '0', '国产啤酒', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0oTZ2AHZeQAABLDUG-V1g533.jpg', '', '', '44', '1', '', null, '1', '1');
INSERT INTO `shop_category` VALUES ('46', '0', '黑啤', 'http://192.168.13.180/group1/M00/00/00/wKgNtF0oTcOABJCRAACpoSX5k8g373.jpg', '', '', '44', '1', '黑啤', null, '1', '1');

-- ----------------------------
-- Table structure for `shop_dispatch`
-- ----------------------------
DROP TABLE IF EXISTS `shop_dispatch`;
CREATE TABLE `shop_dispatch` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分类',
  `dispatchname` varchar(50) NOT NULL COMMENT '派件名字',
  `sendtype` int(5) NOT NULL DEFAULT '1' COMMENT '0为快递，1为自提',
  `firstprice` decimal(10,2) NOT NULL COMMENT '首重价格',
  `secondprice` decimal(10,2) NOT NULL COMMENT '续重价格',
  `provance` varchar(30) DEFAULT '',
  `city` varchar(30) DEFAULT '' COMMENT '城市',
  `area` varchar(30) DEFAULT '' COMMENT '区',
  `firstweight` int(10) NOT NULL COMMENT '首重',
  `secondweight` int(10) NOT NULL COMMENT '续重',
  `express` varchar(50) NOT NULL COMMENT '快递',
  `deleted` int(10) NOT NULL DEFAULT '0' COMMENT '是否删除',
  `displayorder` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `indx_displayorder` (`displayorder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_dispatch
-- ----------------------------

-- ----------------------------
-- Table structure for `shop_diymenu`
-- ----------------------------
DROP TABLE IF EXISTS `shop_diymenu`;
CREATE TABLE `shop_diymenu` (
  `menu_type` varchar(10) NOT NULL COMMENT '选择类型',
  `torder` int(2) NOT NULL COMMENT '订单主表',
  `icon` varchar(30) NOT NULL COMMENT '图标',
  `url` varchar(350) NOT NULL COMMENT '链接',
  `tname` varchar(100) NOT NULL COMMENT '姓名',
  `id序号` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id序号`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_diymenu
-- ----------------------------

-- ----------------------------
-- Table structure for `shop_goods`
-- ----------------------------
DROP TABLE IF EXISTS `shop_goods`;
CREATE TABLE `shop_goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `pcate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '一级分类',
  `ccate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '请选择二级分类',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0为实体，1为虚拟',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否上架销售 1上架  2下架',
  `displayorder` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '显示上架顺序',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '标题',
  `thumb` varchar(255) DEFAULT '' COMMENT '移除图片',
  `description` varchar(1000) NOT NULL DEFAULT '' COMMENT '商品简单描述',
  `content` text NOT NULL COMMENT '商品详细描述',
  `goodssn` varchar(50) NOT NULL DEFAULT '' COMMENT '端口货号',
  `weight` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '重量',
  `productsn` varchar(50) NOT NULL DEFAULT '' COMMENT '商品条码',
  `marketprice` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '本店售价',
  `productprice` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '市场售价',
  `total` int(10) NOT NULL DEFAULT '0' COMMENT '库存',
  `totalcnf` int(11) DEFAULT '0' COMMENT '0 拍下减库存 1 付款减库存 2 永久不减',
  `sales` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '销售额',
  `createtime` int(10) unsigned NOT NULL COMMENT '创建时间',
  `credit` int(11) DEFAULT '0' COMMENT '信用积分',
  `hasoption` int(11) DEFAULT '0' COMMENT '选择',
  `isnew` int(11) DEFAULT '0' COMMENT '新品',
  `issendfree` int(11) DEFAULT NULL COMMENT '免运费商品,打勾表示此商品不会产生运费花销，否则按照正常运费计算。',
  `ishot` int(11) DEFAULT '0' COMMENT '热卖',
  `isdiscount` int(11) DEFAULT '0' COMMENT '打折',
  `isrecommand` int(11) DEFAULT '0' COMMENT '首页推荐',
  `istime` int(11) DEFAULT '0' COMMENT '限时促销,1开启限时促销',
  `timestart` int(11) DEFAULT '0' COMMENT '开启限时促销',
  `timeend` int(11) DEFAULT '0' COMMENT '关闭限时促销',
  `viewcount` int(11) DEFAULT '0' COMMENT '浏览次数',
  `remark` text COMMENT '奖励积分,会员购买商品赠送的积分, 如果不填写，则默认为不奖励积分',
  `deleted` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '已删除',
  `isfirst` int(1) DEFAULT '0' COMMENT '首发',
  `isjingping` int(1) DEFAULT '0' COMMENT '精品',
  `isverify` int(1) DEFAULT '0' COMMENT '是否是核销产品0否1是',
  PRIMARY KEY (`id`,`goodssn`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_goods
-- ----------------------------
INSERT INTO `shop_goods` VALUES ('1', '1', '1', '0', '1', '1', '绿鲜知 圣女果 小番茄 樱桃番茄约500g 新鲜蔬菜', 'https://m.360buyimg.com/mobilecms/s750x750_jfs/t18214/360/2386198411/293049/11e5e4b1/5af25da3N8e3ececc.jpg', '此商品将于2019-07-13,00点结束闪购特卖，京觅生鲜专场', '牛肉制造啊', '1', '12.00', '12', '20.00', '24.00', '12', '1', '1', '20190702', '10', '1', '1', '0', '1', '0', '0', '0', '20180701', '20190731', '10', '10', '2', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('2', '1', '2', '1', '2', '0', '猪肉', 'https://m.360buyimg.com/mobilecms/s750x750_jfs/t18214/360/2386198411/293049/11e5e4b1/5af25da3N8e3ececc.jpg', '脆', '猪肉制造', '2', '13.00', '11', '12.00', '25.00', '13', '2', '1', '20190703', '11', '1', '0', '1', '0', '1', '1', '1', '20180702', '20190731', '11', '11', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('3', '1', '1', '1', '2', '1', '香蕉22222', 'https://m.360buyimg.com/mobilecms/s750x750_jfs/t18214/360/2386198411/293049/11e5e4b1/5af25da3N8e3ececc.jpg', '好吃', '助消化', '33879', '4.50', '963852', '3.00', '4.00', '5', '2', '5555', '1562642282', '123', '1', '1', '1', '1', '1', '1', '0', '123456', '123456789', '555', '没得', '2', '0', '2', '0');
INSERT INTO `shop_goods` VALUES ('9', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562919677', '0', '0', '1', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('10', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562919701', '0', '0', '1', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('11', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562919820', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('12', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562920462', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('13', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562920467', '0', '0', '0', null, '1', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('14', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562920612', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('15', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562920621', '0', '0', '0', null, '1', '1', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('16', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562920817', '0', '0', '0', null, '1', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('17', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562920826', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('18', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562920843', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('19', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562920851', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('20', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562920852', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('21', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562920852', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('22', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562920979', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('23', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562920984', '0', '0', '0', null, '1', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('24', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562922203', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('25', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562922226', '0', '0', '0', null, '1', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('26', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562922720', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('27', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562922723', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('28', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562922735', '0', '0', '0', null, '1', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('29', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562922743', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('30', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562922752', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('31', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562923197', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('32', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562923580', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('33', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562923853', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('34', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562923880', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('35', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562923921', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');
INSERT INTO `shop_goods` VALUES ('36', '0', '0', '1', '1', '0', '', '', '', '', '', '0.00', '', '0.00', '0.00', '0', '0', '0', '1562923971', '0', '0', '0', null, '0', '0', '0', '0', '0', '0', '0', '', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `shop_goods_comment`
-- ----------------------------
DROP TABLE IF EXISTS `shop_goods_comment`;
CREATE TABLE `shop_goods_comment` (
  `createtime` int(10) NOT NULL COMMENT '创建时间',
  `optionname` varchar(100) DEFAULT NULL COMMENT '选项名称',
  `orderid` int(10) DEFAULT NULL COMMENT '订单id',
  `ordersn` varchar(20) DEFAULT NULL COMMENT '订单编号',
  `openid` varchar(50) DEFAULT NULL COMMENT '查看id',
  `comment` text COMMENT '评价',
  `rate` int(1) DEFAULT '0' COMMENT '0差评 1中评 2好评',
  `goodsid` int(10) DEFAULT NULL COMMENT '商品编号',
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品评价id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_goods_comment
-- ----------------------------

-- ----------------------------
-- Table structure for `shop_goods_option`
-- ----------------------------
DROP TABLE IF EXISTS `shop_goods_option`;
CREATE TABLE `shop_goods_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品选项id',
  `goodsid` int(10) DEFAULT '0' COMMENT '商品编号',
  `title` varchar(50) DEFAULT '' COMMENT '添加规格',
  `thumb` varchar(60) DEFAULT '' COMMENT '移除',
  `productprice` decimal(10,2) DEFAULT '0.00' COMMENT '市场售价',
  `marketprice` decimal(10,2) DEFAULT '0.00' COMMENT '本店售价',
  `costprice` decimal(10,2) DEFAULT '0.00' COMMENT '成本价格',
  `stock` int(11) DEFAULT '0' COMMENT '库存',
  `weight` decimal(10,2) DEFAULT '0.00' COMMENT '重量',
  `displayorder` int(11) DEFAULT '0' COMMENT '显示上架顺序',
  `specs` text COMMENT '规格',
  PRIMARY KEY (`id`),
  KEY `indx_goodsid` (`goodsid`),
  KEY `indx_displayorder` (`displayorder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_goods_option
-- ----------------------------

-- ----------------------------
-- Table structure for `shop_goods_piclist`
-- ----------------------------
DROP TABLE IF EXISTS `shop_goods_piclist`;
CREATE TABLE `shop_goods_piclist` (
  `picurl` varchar(255) NOT NULL COMMENT '图片地址',
  `goodid` int(11) NOT NULL COMMENT '商品编号',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_goods_piclist
-- ----------------------------

-- ----------------------------
-- Table structure for `shop_goods_spec`
-- ----------------------------
DROP TABLE IF EXISTS `shop_goods_spec`;
CREATE TABLE `shop_goods_spec` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品规格id',
  `title` varchar(50) NOT NULL COMMENT '规格名',
  `description` varchar(1000) NOT NULL COMMENT '详情描述',
  `displaytype` tinyint(3) unsigned NOT NULL COMMENT '显示上架种类',
  `content` text NOT NULL COMMENT '目录',
  `goodsid` int(11) DEFAULT '0' COMMENT '商品编号',
  `displayorder` int(11) DEFAULT '0' COMMENT '显示上架顺序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_goods_spec
-- ----------------------------

-- ----------------------------
-- Table structure for `shop_goods_spec_item`
-- ----------------------------
DROP TABLE IF EXISTS `shop_goods_spec_item`;
CREATE TABLE `shop_goods_spec_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '商品规格项目id',
  `specid` int(11) DEFAULT '0' COMMENT '规格id',
  `title` varchar(255) DEFAULT '' COMMENT '商品规格项目标题',
  `thumb` varchar(255) DEFAULT '' COMMENT '移除图片',
  `show` int(11) DEFAULT '0' COMMENT '上架',
  `displayorder` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `indx_specid` (`specid`),
  KEY `indx_show` (`show`),
  KEY `indx_displayorder` (`displayorder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_goods_spec_item
-- ----------------------------

-- ----------------------------
-- Table structure for `shop_order`
-- ----------------------------
DROP TABLE IF EXISTS `shop_order`;
CREATE TABLE `shop_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `openid` varchar(50) NOT NULL,
  `ordersn` varchar(20) NOT NULL,
  `credit` int(10) NOT NULL DEFAULT '0',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '-6已退款 -5已退货 -4退货中， -3换货中， -2退款中，-1取消状态，0普通状态，1为已付款，2为已发货，3为成功',
  `sendtype` tinyint(1) unsigned NOT NULL COMMENT '0为快递，1为自提',
  `paytype` tinyint(1) NOT NULL COMMENT '1为余额，2为在线，3为到付',
  `paytypecode` varchar(30) NOT NULL COMMENT '0货到付款，1微支付，2支付宝付款，3余额支付，4积分支付',
  `paytypename` varchar(50) NOT NULL,
  `transid` varchar(50) NOT NULL DEFAULT '0' COMMENT '外部单号(微支付单号等)',
  `remark` varchar(1000) NOT NULL DEFAULT '',
  `expresscom` varchar(30) NOT NULL,
  `expresssn` varchar(50) NOT NULL,
  `express` varchar(30) NOT NULL,
  `addressid` int(10) unsigned NOT NULL,
  `goodsprice` decimal(10,2) DEFAULT '0.00',
  `dispatchprice` decimal(10,2) DEFAULT '0.00',
  `dispatchexpress` varchar(50) DEFAULT '',
  `dispatch` int(10) DEFAULT '0',
  `createtime` int(10) unsigned NOT NULL,
  `address_address` varchar(100) NOT NULL,
  `address_area` varchar(10) NOT NULL,
  `address_city` varchar(10) NOT NULL,
  `address_province` varchar(10) NOT NULL,
  `address_realname` varchar(10) NOT NULL,
  `address_mobile` varchar(20) NOT NULL,
  `rsreson` varchar(500) DEFAULT '' COMMENT '退货款退原因',
  `isrest` int(1) NOT NULL DEFAULT '0',
  `paytime` int(10) DEFAULT '0' COMMENT '订单支付时间',
  `updatetime` int(10) DEFAULT '0' COMMENT '订单更新时间',
  `hasbonus` int(1) DEFAULT '0' COMMENT '是否使用优惠券',
  `bonusprice` decimal(10,2) DEFAULT '0.00' COMMENT '优惠券抵消金额',
  `isverify` int(1) DEFAULT '0' COMMENT '是否是核销订单0否1是',
  `verify_shopvname` varchar(50) DEFAULT '' COMMENT '核销门店名称',
  `verify_shopvid` int(10) DEFAULT '0' COMMENT '核销门店id',
  `verify_openid` varchar(50) DEFAULT '' COMMENT '核销员openid',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_order
-- ----------------------------

-- ----------------------------
-- Table structure for `shop_order_goods`
-- ----------------------------
DROP TABLE IF EXISTS `shop_order_goods`;
CREATE TABLE `shop_order_goods` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `orderid` int(10) unsigned NOT NULL,
  `goodsid` int(10) unsigned NOT NULL,
  `status` tinyint(3) DEFAULT '0' COMMENT '申请状态，-2为标志删除，-1为审核无效，0为未申请，1为正在申请，2为审核通过',
  `content` text,
  `price` decimal(10,2) DEFAULT '0.00',
  `total` int(10) unsigned NOT NULL DEFAULT '1',
  `optionid` int(10) DEFAULT '0',
  `createtime` int(10) unsigned NOT NULL,
  `optionname` text,
  `iscomment` int(1) DEFAULT '0' COMMENT '是否已评论0否1是',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_order_goods
-- ----------------------------

-- ----------------------------
-- Table structure for `shop_order_paylog`
-- ----------------------------
DROP TABLE IF EXISTS `shop_order_paylog`;
CREATE TABLE `shop_order_paylog` (
  `createtime` int(10) NOT NULL COMMENT '订单创建时间',
  `orderid` int(10) NOT NULL COMMENT '订单编号',
  `fee` decimal(10,2) NOT NULL COMMENT '费用',
  `openid` varchar(40) NOT NULL COMMENT '身份授权',
  `pid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '支付方式id',
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_order_paylog
-- ----------------------------

-- ----------------------------
-- Table structure for `shop_pormotions`
-- ----------------------------
DROP TABLE IF EXISTS `shop_pormotions`;
CREATE TABLE `shop_pormotions` (
  `description` varchar(200) DEFAULT NULL COMMENT '描述(预留)',
  `endtime` int(10) NOT NULL COMMENT '结束时间',
  `starttime` int(10) NOT NULL COMMENT '开始时间',
  `condition` decimal(10,2) NOT NULL COMMENT '条件',
  `promoteType` int(11) NOT NULL COMMENT '0 按订单数包邮 1满额包邮',
  `pname` varchar(100) NOT NULL COMMENT '名称',
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '促销编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop_pormotions
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menuName` varchar(50) NOT NULL COMMENT '菜单名称',
  `menuLevel` int(11) NOT NULL COMMENT '1目录，2代表菜单，3代表按钮',
  `actionName` varchar(200) DEFAULT NULL COMMENT '后台url地址',
  `authority` varchar(50) DEFAULT NULL COMMENT '唯一权限标识',
  `sort` int(11) NOT NULL DEFAULT '0',
  `display` int(11) NOT NULL DEFAULT '1' COMMENT '1可见，0不可见',
  `parentId` int(11) NOT NULL DEFAULT '0',
  `parentLevel` varchar(50) NOT NULL COMMENT '记录上一级的等级,多个以 0|1|',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '系统管理', '1', null, null, '0', '1', '0', '0');
INSERT INTO `sys_menu` VALUES ('2', '数据库字典', '2', '/admin/manage/database/shop', 'admin:manage:database:shop', '0', '1', '1', '0|1');
INSERT INTO `sys_menu` VALUES ('5', '订单管理', '1', null, null, '0', '1', '0', '0');
INSERT INTO `sys_menu` VALUES ('6', '新增订单', '2', null, null, '0', '1', '5', '0|5');
INSERT INTO `sys_menu` VALUES ('7', '订单查询', '2', '/admin/manage/order', 'admin:manage:order', '0', '1', '5', '0|5');
INSERT INTO `sys_menu` VALUES ('12', '修改', '3', null, 'order:edit', '0', '0', '7', '0|7|12');
INSERT INTO `sys_menu` VALUES ('14', '会员管理', '1', null, null, '0', '1', '0', '0');
INSERT INTO `sys_menu` VALUES ('15', '会员列表', '2', '/admin/manage/member', 'admin:manage:member', '0', '1', '14', '0|14');
INSERT INTO `sys_menu` VALUES ('16', '新增', '3', null, 'member:add', '0', '0', '15', '0|14|15');
INSERT INTO `sys_menu` VALUES ('17', '修改', '3', null, 'member:edit', '0', '0', '15', '0|14|15');
INSERT INTO `sys_menu` VALUES ('18', '会员等级', '2', '/admin/mamage/rank', 'admin:mamage:rank', '0', '1', '14', '0|14');
INSERT INTO `sys_menu` VALUES ('19', '新增', '3', null, 'rank:add', '0', '0', '18', '0|14|18');
INSERT INTO `sys_menu` VALUES ('20', '修改', '3', null, 'rank:edit', '0', '0', '18', '0|14|18');
INSERT INTO `sys_menu` VALUES ('21', '商品管理', '1', null, null, '0', '1', '0', '0');
INSERT INTO `sys_menu` VALUES ('22', '商品列表', '2', '/admin/manage/shopgoods', 'admin:mamage:shopgoods', '0', '1', '21', '0|21');
INSERT INTO `sys_menu` VALUES ('23', '新增', '3', null, 'shopgoods:add', '0', '0', '22', '0|21|22');
INSERT INTO `sys_menu` VALUES ('24', '修改', '3', null, 'shopgoods:edit', '0', '0', '22', '0|21|22');
INSERT INTO `sys_menu` VALUES ('25', '商品分类', '2', '/admin/manage/category', 'admin:manage:category', '0', '1', '21', '0|21');
INSERT INTO `sys_menu` VALUES ('26', '新增', '3', null, 'category:add', '0', '0', '25', '0|21|25');
INSERT INTO `sys_menu` VALUES ('27', '修改', '3', null, 'category:edit', '0', '0', '25', '0|21|25');
INSERT INTO `sys_menu` VALUES ('28', '添加新商品', '2', '/admin/manage/goods/add', 'admin:goods:add', '0', '1', '21', '0|21');
INSERT INTO `sys_menu` VALUES ('29', '权限管理', '1', null, null, '0', '1', '0', '0');
INSERT INTO `sys_menu` VALUES ('30', '后台管理员', '2', '/admin/manage/user', 'admin:mamage:user', '0', '1', '29', '0|29');
INSERT INTO `sys_menu` VALUES ('31', '新增', '3', null, 'user:add', '0', '0', '30', '0|29|30');
INSERT INTO `sys_menu` VALUES ('32', '修改', '3', null, 'user:edit', '0', '0', '30', '0|29|30');
INSERT INTO `sys_menu` VALUES ('33', '角色列表', '2', '/admin/manage/sysRole', 'admin:mamage:role', '0', '1', '29', '0|29');
INSERT INTO `sys_menu` VALUES ('34', '新增', '3', null, 'role:add', '0', '0', '33', '0|29|33');
INSERT INTO `sys_menu` VALUES ('35', '修改', '3', null, 'role:edit', '0', '0', '33', '0|29|33');
INSERT INTO `sys_menu` VALUES ('36', '菜单列表', '2', '/admin/manage/menu', 'admin:manage:menu', '0', '1', '29', '0|29');
INSERT INTO `sys_menu` VALUES ('37', '新增', '3', null, 'menu:add', '0', '0', '36', '0|29|36');
INSERT INTO `sys_menu` VALUES ('38', '修改', '3', null, 'menu.edit', '0', '0', '36', '0|29|36');
INSERT INTO `sys_menu` VALUES ('39', '分配用户', '3', null, 'role:user', '0', '1', '33', '0|29|33');
INSERT INTO `sys_menu` VALUES ('40', '分配权限', '3', null, 'role:menu', '0', '1', '33', '0|29|33');
INSERT INTO `sys_menu` VALUES ('41', '商城配置', '2', '/admin/manage/config', 'admin:manage:config', '0', '1', '1', '0|1');
INSERT INTO `sys_menu` VALUES ('42', '商城配送方式', '2', '/admin/manage/delivery', 'admin:manage:delivery', '0', '1', '1', '0|1');
INSERT INTO `sys_menu` VALUES ('43', '修改', '3', null, 'delivery:edit', '0', '1', '42', '0|1|42');
INSERT INTO `sys_menu` VALUES ('44', '新增', '3', null, 'delivery:add', '0', '1', '42', '0|1|42');
INSERT INTO `sys_menu` VALUES ('45', '删除', '3', null, 'delivery:del', '0', '1', '42', '0|1|42');

-- ----------------------------
-- Table structure for `sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(20) NOT NULL COMMENT '角色名称',
  `authority` varchar(50) DEFAULT NULL COMMENT '唯一权限标识',
  `state` int(11) NOT NULL DEFAULT '1' COMMENT '1启用，0禁用',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '管理员11111', 'adminstrator11111', '1');
INSERT INTO `sys_role` VALUES ('2', '财务经理', 'FinanceManager', '1');
INSERT INTO `sys_role` VALUES ('3', '人事经理', 'HRManager', '1');
INSERT INTO `sys_role` VALUES ('4', '工程部经理', 'bbb', '1');
INSERT INTO `sys_role` VALUES ('9', '工程部经理111111', 'yhihmhoi44', '0');

-- ----------------------------
-- Table structure for `sys_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleId` int(11) NOT NULL COMMENT '角色编号',
  `menuId` int(11) NOT NULL COMMENT '菜单编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES ('2', '2', '2');
INSERT INTO `sys_role_menu` VALUES ('93', '1', '1');
INSERT INTO `sys_role_menu` VALUES ('94', '1', '2');
INSERT INTO `sys_role_menu` VALUES ('95', '1', '41');
INSERT INTO `sys_role_menu` VALUES ('96', '1', '5');
INSERT INTO `sys_role_menu` VALUES ('97', '1', '6');
INSERT INTO `sys_role_menu` VALUES ('98', '1', '7');
INSERT INTO `sys_role_menu` VALUES ('99', '1', '12');
INSERT INTO `sys_role_menu` VALUES ('100', '1', '14');
INSERT INTO `sys_role_menu` VALUES ('101', '1', '15');
INSERT INTO `sys_role_menu` VALUES ('102', '1', '16');
INSERT INTO `sys_role_menu` VALUES ('103', '1', '17');
INSERT INTO `sys_role_menu` VALUES ('104', '1', '18');
INSERT INTO `sys_role_menu` VALUES ('105', '1', '19');
INSERT INTO `sys_role_menu` VALUES ('106', '1', '20');
INSERT INTO `sys_role_menu` VALUES ('107', '1', '21');
INSERT INTO `sys_role_menu` VALUES ('108', '1', '22');
INSERT INTO `sys_role_menu` VALUES ('109', '1', '23');
INSERT INTO `sys_role_menu` VALUES ('110', '1', '24');
INSERT INTO `sys_role_menu` VALUES ('111', '1', '25');
INSERT INTO `sys_role_menu` VALUES ('112', '1', '26');
INSERT INTO `sys_role_menu` VALUES ('113', '1', '27');
INSERT INTO `sys_role_menu` VALUES ('114', '1', '28');
INSERT INTO `sys_role_menu` VALUES ('115', '1', '29');
INSERT INTO `sys_role_menu` VALUES ('116', '1', '30');
INSERT INTO `sys_role_menu` VALUES ('117', '1', '31');
INSERT INTO `sys_role_menu` VALUES ('118', '1', '32');
INSERT INTO `sys_role_menu` VALUES ('119', '1', '33');
INSERT INTO `sys_role_menu` VALUES ('120', '1', '34');
INSERT INTO `sys_role_menu` VALUES ('121', '1', '35');
INSERT INTO `sys_role_menu` VALUES ('122', '1', '39');
INSERT INTO `sys_role_menu` VALUES ('123', '1', '40');
INSERT INTO `sys_role_menu` VALUES ('124', '1', '36');
INSERT INTO `sys_role_menu` VALUES ('125', '1', '37');
INSERT INTO `sys_role_menu` VALUES ('126', '1', '38');
INSERT INTO `sys_role_menu` VALUES ('127', '1', '42');

-- ----------------------------
-- Table structure for `sys_role_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_user`;
CREATE TABLE `sys_role_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL COMMENT '用户编号',
  `roleId` int(11) NOT NULL COMMENT '角色编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_role_user
-- ----------------------------
INSERT INTO `sys_role_user` VALUES ('3', '2', '2');
INSERT INTO `sys_role_user` VALUES ('4', '1', '1');
INSERT INTO `sys_role_user` VALUES ('5', '2', '1');

-- ----------------------------
-- Table structure for `thirdlogin`
-- ----------------------------
DROP TABLE IF EXISTS `thirdlogin`;
CREATE TABLE `thirdlogin` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT COMMENT '第三方登录编号',
  `code` varchar(20) NOT NULL DEFAULT '' COMMENT '第三方授权临时票据',
  `name` varchar(120) NOT NULL DEFAULT '' COMMENT '第三方快捷登录名',
  `desc` text NOT NULL COMMENT '第三方浏览器访问快捷登录名',
  `configs` text NOT NULL COMMENT '配置信息',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0.未激活 1已激活',
  PRIMARY KEY (`id`),
  UNIQUE KEY `pay_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of thirdlogin
-- ----------------------------

-- ----------------------------
-- Table structure for `user`
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `salt` varchar(5) NOT NULL COMMENT 'MD5盐',
  `createtime` int(10) NOT NULL COMMENT '创建时间',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('XW996', '1561520761', '641499d19b373450d99f5a97b18ca605', 'boos', '1');
INSERT INTO `user` VALUES ('lAC4T', '1561520789', 'd390380106e2b73d601ad9da3ed7361f', 'admin', '2');
INSERT INTO `user` VALUES ('e6yb@', '1562045369', '80292f27356b1d3cba6ce256f802b0db', 'maoqi', '3');
INSERT INTO `user` VALUES ('6opph', '1562064320', '10b08b20ec2b54568152e0e660b6ac61', 'test1', '4');
INSERT INTO `user` VALUES ('8=Ors', '1562116408', 'd95548d94c7a0a5824ea8affbada6128', 'maoqi1', '5');
INSERT INTO `user` VALUES ('jK43z', '1562552474', 'abcf4b508c7199f3717c08c0122e3e04', 'test001', '6');
INSERT INTO `user` VALUES ('nG4Kv', '1562552692', '1baea61a30711d4945419d9794b299fe', 'tt11', '7');

-- ----------------------------
-- Table structure for `weixin_rule`
-- ----------------------------
DROP TABLE IF EXISTS `weixin_rule`;
CREATE TABLE `weixin_rule` (
  `url` varchar(500) NOT NULL COMMENT '链接地址',
  `thumb` varchar(60) NOT NULL COMMENT '图文',
  `keywords` varchar(50) NOT NULL COMMENT '关键字',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `ruletype` int(11) NOT NULL COMMENT '1文本回复 2图文回复',
  `addonsrule` int(1) NOT NULL DEFAULT '0' COMMENT '0常规，1模块规则',
  `addonsModule` varchar(50) DEFAULT '' COMMENT '所属模块',
  `content` text COMMENT '内容',
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weixin_rule
-- ----------------------------

-- ----------------------------
-- Table structure for `weixin_wxfans`
-- ----------------------------
DROP TABLE IF EXISTS `weixin_wxfans`;
CREATE TABLE `weixin_wxfans` (
  `createtime` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `openid` varchar(50) DEFAULT NULL COMMENT '身份认证',
  `weixin_openid` varchar(100) NOT NULL COMMENT '微信身份授权认证',
  `follow` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否订阅',
  `nickname` varchar(100) NOT NULL DEFAULT '' COMMENT '昵称',
  `avatar` varchar(200) NOT NULL DEFAULT '' COMMENT '头像',
  `gender` tinyint(1) NOT NULL DEFAULT '0' COMMENT '性别(0:保密 1:男 2:女)',
  `longitude` decimal(10,2) DEFAULT '0.00' COMMENT '地理位置经度',
  `latitude` decimal(10,2) DEFAULT '0.00' COMMENT '地理位置纬度',
  `precision` decimal(10,2) DEFAULT '0.00' COMMENT '地理位置精度',
  PRIMARY KEY (`weixin_openid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of weixin_wxfans
-- ----------------------------
