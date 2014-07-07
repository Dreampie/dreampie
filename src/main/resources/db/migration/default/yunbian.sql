
--
-- 表的结构 `th_access_cache`
--

DROP TABLE IF EXISTS `th_access_cache`;
CREATE TABLE IF NOT EXISTS `th_access_cache` (
  `cachename` varchar(100) NOT NULL,
  `cachevalue` text,
  PRIMARY KEY (`cachename`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `th_attachments`
--

DROP TABLE IF EXISTS `th_attachments`;
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='附件表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `th_blog`
--

DROP TABLE IF EXISTS `th_blog`;
CREATE TABLE IF NOT EXISTS `th_blog` (
  `bid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL DEFAULT '0',
  `top` tinyint(1) NOT NULL DEFAULT '0' COMMENT '置顶',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1文字2音乐3照片4视频5链接 ',
  `tag` char(30) NOT NULL COMMENT '分类',
  `title` char(50) NOT NULL,
  `body` text NOT NULL,
  `open` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0草稿 1通过 -1临时ID',
  `hitcount` int(10) DEFAULT '0' COMMENT '点击量',
  `feedcount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '动作统计',
  `replaycount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论回复数',
  `noreply` tinyint(1) NOT NULL DEFAULT '0' COMMENT '不允许评论',
  `time` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`bid`),
  KEY `tag` (`tag`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `th_catetags`
--

DROP TABLE IF EXISTS `th_catetags`;
CREATE TABLE IF NOT EXISTS `th_catetags` (
  `cid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `catename` varchar(20) NOT NULL,
  `sort` tinyint(10) NOT NULL COMMENT '排序',
  `used` int(10) NOT NULL DEFAULT '0' COMMENT '有多少人用了这个标签',
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `th_feeds`
--

DROP TABLE IF EXISTS `th_feeds`;
CREATE TABLE IF NOT EXISTS `th_feeds` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `bid` int(10) unsigned NOT NULL,
  `type` varchar(20) NOT NULL,
  `uid` int(10) NOT NULL,
  `title` varchar(50) NOT NULL COMMENT '动态标题',
  `info` varchar(255) DEFAULT '' COMMENT '动态内容',
  `time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `th_follow`
--

DROP TABLE IF EXISTS `th_follow`;
CREATE TABLE IF NOT EXISTS `th_follow` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL COMMENT '谁',
  `touid` int(10) unsigned NOT NULL COMMENT '关注他',
  `linker` tinyint(1) NOT NULL COMMENT '互相关注',
  `time` int(10) NOT NULL COMMENT '关注时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `th_likes`
--

DROP TABLE IF EXISTS `th_likes`;
CREATE TABLE IF NOT EXISTS `th_likes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `bid` int(10) unsigned NOT NULL,
  `time` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bid` (`bid`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `th_member`
--

DROP TABLE IF EXISTS `th_member`;
CREATE TABLE IF NOT EXISTS `th_member` (
  `uid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `open` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否开放',
  `email` varchar(50) NOT NULL,
  `password` char(32) NOT NULL,
  `salt` char(6) NOT NULL,
  `username` varchar(10) NOT NULL DEFAULT '' COMMENT '昵称',
  `domain` varchar(20) NOT NULL DEFAULT '',
  `local` varchar(20) DEFAULT NULL COMMENT '我所在',
  `blogtag` varchar(20) DEFAULT NULL,
  `sign` varchar(255) NOT NULL DEFAULT '',
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `th_memberex`
--

DROP TABLE IF EXISTS `th_memberex`;
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
-- 表的结构 `th_mytags`
--

DROP TABLE IF EXISTS `th_mytags`;
CREATE TABLE IF NOT EXISTS `th_mytags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `tagid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='我收藏的Tag' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `th_notice`
--

DROP TABLE IF EXISTS `th_notice`;
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
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='我的通知' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `th_replay`
--

DROP TABLE IF EXISTS `th_replay`;
CREATE TABLE IF NOT EXISTS `th_replay` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bid` int(10) unsigned NOT NULL,
  `uid` int(10) unsigned NOT NULL,
  `repuid` int(10) unsigned DEFAULT '0' COMMENT '回复某人',
  `msg` varchar(255) NOT NULL,
  `time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `th_setting`
--

DROP TABLE IF EXISTS `th_setting`;
CREATE TABLE IF NOT EXISTS `th_setting` (
  `name` varchar(25) NOT NULL,
  `val` text NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='系统设置';

-- --------------------------------------------------------

--
-- 表的结构 `th_skins`
--

DROP TABLE IF EXISTS `th_skins`;
CREATE TABLE IF NOT EXISTS `th_skins` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `skindir` varchar(255) NOT NULL COMMENT '主题位置',
  `name` varchar(50) NOT NULL COMMENT '主题名称',
  `author` varchar(50) NOT NULL COMMENT '主题作者',
  `version` char(10) NOT NULL COMMENT '主题版本',
  `exclusive` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为专属主题',
  `usenumber` int(10) NOT NULL COMMENT '多少人用',
  `open` tinyint(1) NOT NULL DEFAULT '0' COMMENT '允许使用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='系统主题表' AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- 表的结构 `th_tags`
--

DROP TABLE IF EXISTS `th_tags`;
CREATE TABLE IF NOT EXISTS `th_tags` (
  `tid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` int(10) unsigned NOT NULL,
  `title` varchar(20) NOT NULL,
  `num` int(10) unsigned NOT NULL DEFAULT '0',
  `time` int(10) NOT NULL,
  `updates` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`tid`),
  KEY `title` (`title`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `th_theme`
--

DROP TABLE IF EXISTS `th_theme`;
CREATE TABLE IF NOT EXISTS `th_theme` (
  `uid` int(10) NOT NULL,
  `setup` text NOT NULL,
  `css` text,
  `img1` varchar(255) DEFAULT NULL,
  `img2` varchar(255) DEFAULT NULL,
  `img3` varchar(255) DEFAULT NULL,
  `img4` varchar(255) DEFAULT NULL,
  `theme` varchar(255) DEFAULT NULL,
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='个人主题表';



INSERT INTO `th_skins` (`id`, `skindir`, `name`, `author`, `version`, `exclusive`, `usenumber`, `open`) VALUES
(1, 'anythink', '诗琴画意', 'anythink', '1.0', 1, 1, 1),
(2, 'qsqy', '轻声琴语', 'anythink', '1.0', 0, 0, 1),
(3, 'girldream', '少女之梦', 'anythink', '1.0', 0, 1, 1),
(4, 'xzmuma', '旋转木马', 'anythink', '1.0', 0, 0, 1),
(5, 'jitashaonv', '吉他少女', 'anythink', '1.0', 0, 2, 1);



