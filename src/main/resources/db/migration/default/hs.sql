
CREATE TABLE IF NOT EXISTS `th_ad_list` (
  `adid` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '广告名称',
  `auid` int(11) NOT NULL COMMENT '广告位ID',
  `type` tinyint(1) NOT NULL COMMENT '1图片|2html|3右下角弹出|4全屏',
  `url` varchar(255) NOT NULL COMMENT '跳转地址',
  `body` text NOT NULL COMMENT '广告具体内容',
  `ga` text COMMENT '谷歌ga统计代码',
  `time_date_limit` char(21) DEFAULT NULL COMMENT '广告投放日期：例如2012-04-05-2012-04-20，用char存放起始和结束日期用“|”分隔',
  `time_area_limit` varchar(600) DEFAULT NULL COMMENT '广告投放时间段如，8:00-12：00用json存放多个时间段',
  `is_show` tinyint(1) NOT NULL DEFAULT '0',
  `weight` int(10) NOT NULL DEFAULT '10',
  PRIMARY KEY (`adid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `th_ad_unit`
--

CREATE TABLE IF NOT EXISTS `th_ad_unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '广告位置',
  `adesc` varchar(255) NOT NULL COMMENT '位置描述',
  `img` varchar(255) NOT NULL COMMENT '广告位置截图',
  `orders` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  `system` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为系统投放位',
  `is_show` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `th_attachments`
--

CREATE TABLE IF NOT EXISTS `th_attachments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bid` int(10) unsigned NOT NULL,
  `path` varchar(255) NOT NULL,
  `blogdesc` varchar(50) NOT NULL COMMENT '描述',
  `filesize` int(10) unsigned NOT NULL,
  `mime` varchar(20) NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `time` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bid` (`bid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='附件表';

-- --------------------------------------------------------

--
-- 表的结构 `th_blog`
--

CREATE TABLE IF NOT EXISTS `th_blog` (
  `bid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
  `top` tinyint(1) NOT NULL DEFAULT '0' COMMENT '置顶',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1文字2音乐3照片4视频5链接 ',
  `tag` char(30) NOT NULL COMMENT '分类',
  `title` char(50) DEFAULT NULL,
  `body` text NOT NULL,
  `open` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0草稿 1通过 -1临时ID',
  `hitcount` int(10) DEFAULT '0' COMMENT '点击量',
  `feedcount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '动作统计',
  `replaycount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论回复数',
  `noreply` tinyint(1) NOT NULL DEFAULT '0' COMMENT '不允许评论',
  `time` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`bid`),
  KEY `tag` (`tag`),
  KEY `uid` (`uid`),
  KEY `top` (`top`),
  KEY `open` (`open`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;




-- --------------------------------------------------------

--
-- 表的结构 `th_cache`
--

CREATE TABLE IF NOT EXISTS `th_cache` (
  `cachename` varchar(100) NOT NULL,
  `cachevalue` text,
  PRIMARY KEY (`cachename`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `th_catetags`
--

CREATE TABLE IF NOT EXISTS `th_catetags` (
  `cid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `catename` varchar(20) NOT NULL,
  `sort` tinyint(10) unsigned NOT NULL COMMENT '排序',
  `used` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '有多少人用了这个标签',
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `th_cpage_body`
--

CREATE TABLE IF NOT EXISTS `th_cpage_body` (
  `cid` int(10) unsigned NOT NULL,
  `body` text,
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='自定义页面,内容';

-- --------------------------------------------------------

--
-- 表的结构 `th_cpage_cate`
--

CREATE TABLE IF NOT EXISTS `th_cpage_cate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tags` varchar(30) NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  `keyword` varchar(100) DEFAULT NULL,
  `description` varchar(50) DEFAULT NULL,
  `orders` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tags` (`tags`),
  KEY `order` (`orders`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='自定义页面,标题';

-- --------------------------------------------------------

--
-- 表的结构 `th_feeds`
--

CREATE TABLE IF NOT EXISTS `th_feeds` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `parentkey` int(10) NOT NULL DEFAULT '0',
  `bid` int(10) unsigned NOT NULL,
  `type` varchar(20) NOT NULL,
  `uid` int(10) NOT NULL,
  `title` varchar(50) NOT NULL COMMENT '动态标题',
  `info` varchar(255) DEFAULT '' COMMENT '动态内容',
  `time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `th_findpwd`
--

CREATE TABLE IF NOT EXISTS `th_findpwd` (
  `uid` int(10) NOT NULL,
  `token` char(32) NOT NULL,
  `time` int(10) NOT NULL,
  `mailsend` int(10) NOT NULL COMMENT '上次发送邮件时间',
  PRIMARY KEY (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='找回密码';

-- --------------------------------------------------------

--
-- 表的结构 `th_follow`
--

CREATE TABLE IF NOT EXISTS `th_follow` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL COMMENT '谁',
  `touid` int(10) unsigned NOT NULL COMMENT '关注他',
  `linker` tinyint(1) NOT NULL COMMENT '互相关注',
  `time` int(10) NOT NULL COMMENT '关注时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uid` (`uid`,`touid`),
  KEY `touid` (`touid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `th_invite`
--

CREATE TABLE IF NOT EXISTS `th_invite` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) NOT NULL COMMENT '用户ID',
  `inviteCode` char(32) NOT NULL COMMENT '邀请码',
  `exptime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '邀请码过期时间',
  PRIMARY KEY (`id`),
  KEY `inviteCode` (`inviteCode`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='邀请表';

-- --------------------------------------------------------

--
-- 表的结构 `th_invite_friend`
--

CREATE TABLE IF NOT EXISTS `th_invite_friend` (
  `uid` int(10) NOT NULL,
  `touid` int(10) NOT NULL,
  PRIMARY KEY (`touid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='邀请过的好友';

-- --------------------------------------------------------

--
-- 表的结构 `th_likes`
--

CREATE TABLE IF NOT EXISTS `th_likes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `bid` int(10) unsigned NOT NULL,
  `time` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bid` (`bid`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `th_member`
--

CREATE TABLE IF NOT EXISTS `th_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `open` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否开放',
  `email` varchar(50) NOT NULL,
  `password` char(32) NOT NULL,
  `salt` char(6) NOT NULL,
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '昵称',
  `domain` varchar(20) NOT NULL DEFAULT '',
  `local` varchar(20) DEFAULT NULL COMMENT '我所在',
  `blogtag` varchar(100) DEFAULT NULL,
  `sign` varchar(140) DEFAULT NULL,
  `num` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '发布数量',
  `flow` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '关注我的',
  `likenum` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '我喜欢的',
  `qq` char(12) NOT NULL DEFAULT '',
  `regtime` int(10) NOT NULL,
  `logtime` int(10) NOT NULL DEFAULT '0',
  `regip` char(16) NOT NULL DEFAULT '0',
  `logip` char(16) NOT NULL DEFAULT '0',
  `m_rep` tinyint(1) NOT NULL DEFAULT '1',
  `m_fow` tinyint(1) NOT NULL DEFAULT '1',
  `m_pm` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`uid`),
  KEY `username` (`username`),
  KEY `domain` (`domain`),
  KEY `blogtag` (`blogtag`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;



--
-- 触发器 `th_member`
--




-- --------------------------------------------------------

--
-- 表的结构 `th_memberex`
--

CREATE TABLE IF NOT EXISTS `th_memberex` (
  `openid` char(32) NOT NULL COMMENT '登陆唯一id',
  `token` char(32) NOT NULL COMMENT '验证凭据',
  `secret` char(32) NOT NULL,
  `types` char(4) NOT NULL COMMENT '类型 QQ SINA W163',
  `uid` int(10) NOT NULL COMMENT '是否关联账户',
  `expires` int(10) NOT NULL COMMENT '是否过期',
  PRIMARY KEY (`openid`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='开放登陆';

-- --------------------------------------------------------

--
-- 表的结构 `th_models`
--

CREATE TABLE IF NOT EXISTS `th_models` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `icon` varchar(50) NOT NULL COMMENT '图标或样式标示符',
  `name` varchar(50) NOT NULL,
  `modelfile` char(20) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `mdesc` varchar(255) NOT NULL,
  `version` varchar(10) NOT NULL,
  `author` varchar(20) DEFAULT 'SYSTEM',
  `feedtpl` text NOT NULL,
  `cfg` text NOT NULL COMMENT 'conf',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `th_mytags`
--

CREATE TABLE IF NOT EXISTS `th_mytags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `tagid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tagid` (`tagid`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='我收藏的Tag';

-- --------------------------------------------------------

--
-- 表的结构 `th_notice`
--

CREATE TABLE IF NOT EXISTS `th_notice` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL COMMENT '我',
  `sys` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1为回复 0为私信 2为通知',
  `foruid` int(10) unsigned NOT NULL COMMENT '谁搞我',
  `title` varchar(50) NOT NULL,
  `info` varchar(500) DEFAULT NULL,
  `isread` tinyint(1) NOT NULL DEFAULT '0',
  `location` varchar(255) NOT NULL COMMENT '跳转位置',
  `time` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `foruid` (`foruid`,`isread`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='我的通知';

-- --------------------------------------------------------

--
-- 表的结构 `th_pm`
--

CREATE TABLE IF NOT EXISTS `th_pm` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
  `touid` int(10) NOT NULL,
  `isnew` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `num` int(10) unsigned NOT NULL DEFAULT '0',
  `info` varchar(255) NOT NULL,
  `status` int(10) DEFAULT '0' COMMENT '删除标记',
  `time` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `isnew` (`isnew`,`uid`),
  KEY `pminfo` (`uid`,`touid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------
--
-- 表的结构 `th_replay`
--

CREATE TABLE IF NOT EXISTS `th_replay` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `repuid` int(10) unsigned DEFAULT '0' COMMENT '回复某人',
  `msg` varchar(255) NOT NULL,
  `time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `th_setting`
--

CREATE TABLE IF NOT EXISTS `th_setting` (
  `name` varchar(25) NOT NULL,
  `val` text,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系统设置';

-- --------------------------------------------------------

--
-- 表的结构 `th_skins`
--

CREATE TABLE IF NOT EXISTS `th_skins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `skindir` varchar(255) NOT NULL COMMENT '主题位置',
  `name` varchar(50) NOT NULL COMMENT '主题名称',
  `author` varchar(50) NOT NULL COMMENT '主题作者',
  `uri` varchar(50) NOT NULL COMMENT '主题主页',
  `version` char(10) NOT NULL COMMENT '主题版本',
  `exclusive` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为专属主题',
  `usenumber` int(10) DEFAULT '0' COMMENT '多少人用',
  `setup` text COMMENT '主题钩子',
  `open` tinyint(1) NOT NULL DEFAULT '0' COMMENT '允许使用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='系统主题表';

-- --------------------------------------------------------

--
-- 表的结构 `th_tags`
--

CREATE TABLE IF NOT EXISTS `th_tags` (
  `tid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `title` varchar(20) NOT NULL,
  `bid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`tid`),
  KEY `title` (`title`),
  KEY `bid` (`bid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;



CREATE TABLE IF NOT EXISTS `th_tags_blog` (
  `tagid` int(10) NOT NULL COMMENT 'tagid',
  `uid` int(10) NOT NULL COMMENT 'uid',
  KEY `tagid` (`tagid`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='根据某人设置的blogid 获得tagid';

-- --------------------------------------------------------

--
-- 表的结构 `th_theme`
--

CREATE TABLE IF NOT EXISTS `th_theme` (
  `uid` int(10) NOT NULL,
  `config` text,
  `setup` text,
  `css` text,
  `img1` varchar(255) DEFAULT NULL,
  `img2` varchar(255) DEFAULT NULL,
  `img3` varchar(255) DEFAULT NULL,
  `img4` varchar(255) DEFAULT NULL,
  `theme` varchar(255) DEFAULT NULL,
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='个人主题表';


CREATE TABLE IF NOT EXISTS `th_tags_system` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '标签',
  `num` int(10) unsigned DEFAULT '0' COMMENT '标签使用率',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='系统整理标签表';

