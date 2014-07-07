-- MySQL dump 10.13  Distrib 5.1.41, for Win32 (ia32)
--
-- Host: localhost    Database: paipang
-- ------------------------------------------------------
-- Server version	5.1.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `sp_adminuser`
--

DROP TABLE IF EXISTS `sp_adminuser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_adminuser` (
  `aid` bigint(20) NOT NULL AUTO_INCREMENT,
  `adminuser` varchar(40) DEFAULT NULL,
  `adminpassword` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_adminuser`
--

LOCK TABLES `sp_adminuser` WRITE;
/*!40000 ALTER TABLE `sp_adminuser` DISABLE KEYS */;
/*!40000 ALTER TABLE `sp_adminuser` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_comments`
--

DROP TABLE IF EXISTS `sp_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_comments` (
  `cid` bigint(20) NOT NULL AUTO_INCREMENT,
  `did` bigint(20) DEFAULT NULL,
  `cdata` varchar(200) DEFAULT NULL,
  `uid` bigint(20) DEFAULT NULL,
  `cdate` datetime DEFAULT NULL,
  `uname` varchar(40) DEFAULT NULL,
  `reuid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_comments`
--

LOCK TABLES `sp_comments` WRITE;
/*!40000 ALTER TABLE `sp_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `sp_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_content`
--

DROP TABLE IF EXISTS `sp_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_content` (
  `did` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(180) DEFAULT NULL,
  `data` text,
  `img` varchar(120) DEFAULT NULL,
  `thedate` datetime DEFAULT NULL,
  `uid` bigint(20) DEFAULT NULL,
  `types` int(8) DEFAULT NULL,
  `sercet` int(2) NOT NULL DEFAULT '0',
  `cnum` int(8) DEFAULT '0',
  `likenum` int(8) NOT NULL DEFAULT '0',
  `video` text,
  `mp3` text,
  `source` varchar(40) DEFAULT '身旁官方网站',
  `forid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`did`)
) ENGINE=InnoDB AUTO_INCREMENT=418 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_content`
--

LOCK TABLES `sp_content` WRITE;
/*!40000 ALTER TABLE `sp_content` DISABLE KEYS */;
INSERT INTO `sp_content` VALUES (415,'我的开场白:身旁网(shenpang.cc)','欢迎来到身旁网。\r\n\r\n拍旁科技：paipang.com。 此系统版权为身旁网所有，个人使用免费，商业请购买授权。',NULL,'2011-12-03 20:18:09',353,1,0,0,0,NULL,NULL,'身旁官方网站',NULL),(416,'<a target=_blank href=http://www.shenpang.cc >http://www.shenpang.cc</a>(身旁网|轻社区 -专注兴趣与爱好，致力分享与成长)','<p><br /></p>',NULL,'2011-12-03 20:18:35',353,4,0,0,0,NULL,NULL,'身旁官方网站',NULL),(417,'<a target=_blank href=http://www.paipang.com >http://www.paipang.com</a>()','<p><br /></p>',NULL,'2011-12-03 20:19:00',353,4,0,0,0,NULL,NULL,'身旁官方网站',NULL);
/*!40000 ALTER TABLE `sp_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_disable`
--

DROP TABLE IF EXISTS `sp_disable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_disable` (
  `kw_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '唯一、自增ID',
  `item` varchar(45) NOT NULL COMMENT '屏蔽或禁止的ID或内容',
  `comment` varchar(60) NOT NULL COMMENT '相关显示内容',
  `admin_name` varchar(24) NOT NULL COMMENT '管理员操作时的昵称',
  `admin_id` int(10) unsigned NOT NULL COMMENT '管理员ID',
  `add_time` int(10) unsigned NOT NULL COMMENT '加入时间',
  PRIMARY KEY (`kw_id`),
  UNIQUE KEY `Index_type_item` (`item`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='屏蔽或禁止的内容列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_disable`
--

LOCK TABLES `sp_disable` WRITE;
/*!40000 ALTER TABLE `sp_disable` DISABLE KEYS */;
/*!40000 ALTER TABLE `sp_disable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_feedback`
--

DROP TABLE IF EXISTS `sp_feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_feedback` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` char(50) NOT NULL,
  `content` text NOT NULL,
  `uid` bigint(20) NOT NULL,
  `classID` int(1) NOT NULL,
  `reslove` int(1) NOT NULL DEFAULT '1',
  `answer` text,
  `support` int(5) NOT NULL DEFAULT '0',
  `thedate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_feedback`
--

LOCK TABLES `sp_feedback` WRITE;
/*!40000 ALTER TABLE `sp_feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `sp_feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_follows`
--

DROP TABLE IF EXISTS `sp_follows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_follows` (
  `fid` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) DEFAULT NULL,
  `name` varchar(40) DEFAULT NULL,
  `guid` bigint(20) DEFAULT NULL,
  `gname` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`fid`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_follows`
--

LOCK TABLES `sp_follows` WRITE;
/*!40000 ALTER TABLE `sp_follows` DISABLE KEYS */;
INSERT INTO `sp_follows` VALUES (110,355,'hoho',353,'身旁网');
/*!40000 ALTER TABLE `sp_follows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_friendlink`
--

DROP TABLE IF EXISTS `sp_friendlink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_friendlink` (
  `fid` int(8) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `url` varchar(80) DEFAULT NULL,
  `logo` varchar(80) DEFAULT NULL,
  `types` varchar(40) DEFAULT NULL,
  `sortid` int(8) DEFAULT NULL,
  PRIMARY KEY (`fid`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_friendlink`
--

LOCK TABLES `sp_friendlink` WRITE;
/*!40000 ALTER TABLE `sp_friendlink` DISABLE KEYS */;
/*!40000 ALTER TABLE `sp_friendlink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_group_config`
--

DROP TABLE IF EXISTS `sp_group_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_group_config` (
  `gid` bigint(20) NOT NULL AUTO_INCREMENT,
  `gname` varchar(60) DEFAULT NULL,
  `descs` varchar(200) DEFAULT NULL,
  `uid` bigint(20) DEFAULT NULL,
  `nownum` int(10) DEFAULT NULL,
  `maxnum` int(10) DEFAULT NULL,
  `img` varchar(140) DEFAULT NULL,
  `open` int(2) DEFAULT NULL,
  `face` varchar(40) DEFAULT NULL,
  `types` varchar(60) DEFAULT NULL,
  `tuinum` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`gid`)
) ENGINE=InnoDB AUTO_INCREMENT=297 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_group_config`
--

LOCK TABLES `sp_group_config` WRITE;
/*!40000 ALTER TABLE `sp_group_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `sp_group_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_group_content`
--

DROP TABLE IF EXISTS `sp_group_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_group_content` (
  `gcid` bigint(20) NOT NULL AUTO_INCREMENT,
  `did` bigint(20) DEFAULT NULL,
  `gid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`gcid`)
) ENGINE=InnoDB AUTO_INCREMENT=146 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_group_content`
--

LOCK TABLES `sp_group_content` WRITE;
/*!40000 ALTER TABLE `sp_group_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `sp_group_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_group_users`
--

DROP TABLE IF EXISTS `sp_group_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_group_users` (
  `gnid` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) DEFAULT NULL,
  `gid` bigint(20) DEFAULT NULL,
  `admin` int(2) DEFAULT NULL,
  PRIMARY KEY (`gnid`)
) ENGINE=InnoDB AUTO_INCREMENT=299 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_group_users`
--

LOCK TABLES `sp_group_users` WRITE;
/*!40000 ALTER TABLE `sp_group_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `sp_group_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_like`
--

DROP TABLE IF EXISTS `sp_like`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_like` (
  `lid` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) DEFAULT NULL,
  `did` bigint(20) DEFAULT NULL,
  `ry` int(2) DEFAULT NULL,
  PRIMARY KEY (`lid`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_like`
--

LOCK TABLES `sp_like` WRITE;
/*!40000 ALTER TABLE `sp_like` DISABLE KEYS */;
/*!40000 ALTER TABLE `sp_like` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_message`
--

DROP TABLE IF EXISTS `sp_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_message` (
  `mid` bigint(20) NOT NULL AUTO_INCREMENT,
  `uname` varchar(40) DEFAULT NULL,
  `msg` varchar(200) DEFAULT NULL,
  `mdate` datetime DEFAULT NULL,
  `uid` bigint(20) DEFAULT NULL,
  `touid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_message`
--

LOCK TABLES `sp_message` WRITE;
/*!40000 ALTER TABLE `sp_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `sp_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_recommend`
--

DROP TABLE IF EXISTS `sp_recommend`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_recommend` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) NOT NULL DEFAULT '0',
  `tuid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_recommend`
--

LOCK TABLES `sp_recommend` WRITE;
/*!40000 ALTER TABLE `sp_recommend` DISABLE KEYS */;
/*!40000 ALTER TABLE `sp_recommend` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_school`
--

DROP TABLE IF EXISTS `sp_school`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_school` (
  `uid` bigint(20) NOT NULL DEFAULT '0',
  `realname` varchar(40) DEFAULT NULL,
  `school` varchar(40) DEFAULT NULL,
  `grade` varchar(40) DEFAULT NULL,
  `profession` varchar(40) DEFAULT NULL,
  `sex` varchar(10) DEFAULT NULL,
  `desc_school` varchar(200) DEFAULT NULL,
  `tmp` text,
  `xueli` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_school`
--

LOCK TABLES `sp_school` WRITE;
/*!40000 ALTER TABLE `sp_school` DISABLE KEYS */;
/*!40000 ALTER TABLE `sp_school` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_setting`
--

DROP TABLE IF EXISTS `sp_setting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_setting` (
  `sid` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `value` text,
  PRIMARY KEY (`sid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_setting`
--

LOCK TABLES `sp_setting` WRITE;
/*!40000 ALTER TABLE `sp_setting` DISABLE KEYS */;
INSERT INTO `sp_setting` VALUES (1,'title','身旁网(shenpang.cc) | 简单实用的轻博客社区'),(2,'Keywords','身旁,身旁网,轻博客,轻博客社区,博客,社区'),(3,'Description','身旁网是具有影响力的轻博客网站，具有完善的轻微博功能，是最早推出轻博客社区的网站之一。身旁网具备了轻微博方便、易用的特点，同时秉承“生命要用心涂鸦，每个人都是艺术家”的信念而打造的个性轻博客社区，在身旁社区中您将尽情享受分享带来的乐趣。'),(4,'statistics',''),(5,'mailhost',''),(6,'mailpost',''),(7,'mailusername',''),(8,'mailpassword',''),(9,'mailname','身旁网'),(10,'mailnametip','身旁网最新动态提示'),(11,'bei','粤ICP备08128591号-2');
/*!40000 ALTER TABLE `sp_setting` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_sharebook`
--

DROP TABLE IF EXISTS `sp_sharebook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_sharebook` (
  `bid` bigint(20) NOT NULL DEFAULT '0',
  `uid` bigint(20) DEFAULT NULL,
  `bookid` bigint(20) DEFAULT NULL,
  `num` int(8) DEFAULT NULL,
  PRIMARY KEY (`bid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_sharebook`
--

LOCK TABLES `sp_sharebook` WRITE;
/*!40000 ALTER TABLE `sp_sharebook` DISABLE KEYS */;
/*!40000 ALTER TABLE `sp_sharebook` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_spsorce`
--

DROP TABLE IF EXISTS `sp_spsorce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_spsorce` (
  `artid` int(11) NOT NULL AUTO_INCREMENT,
  `ratecount` mediumint(7) DEFAULT '0',
  `totalrate` mediumint(7) DEFAULT '0',
  `title` varchar(50) DEFAULT NULL,
  `tid` int(11) DEFAULT NULL,
  `ttype` int(5) DEFAULT NULL,
  PRIMARY KEY (`artid`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_spsorce`
--

LOCK TABLES `sp_spsorce` WRITE;
/*!40000 ALTER TABLE `sp_spsorce` DISABLE KEYS */;
/*!40000 ALTER TABLE `sp_spsorce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_tags`
--

DROP TABLE IF EXISTS `sp_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_tags` (
  `tarid` bigint(20) NOT NULL AUTO_INCREMENT,
  `tarname` varchar(40) DEFAULT NULL,
  `num` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`tarid`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_tags`
--

LOCK TABLES `sp_tags` WRITE;
/*!40000 ALTER TABLE `sp_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `sp_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_tags_content`
--

DROP TABLE IF EXISTS `sp_tags_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_tags_content` (
  `did` bigint(20) NOT NULL DEFAULT '0',
  `tarid` bigint(20) NOT NULL DEFAULT '0',
  `uid` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`did`,`tarid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_tags_content`
--

LOCK TABLES `sp_tags_content` WRITE;
/*!40000 ALTER TABLE `sp_tags_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `sp_tags_content` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_tme`
--

DROP TABLE IF EXISTS `sp_tme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_tme` (
  `tid` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) DEFAULT NULL,
  `did` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_tme`
--

LOCK TABLES `sp_tme` WRITE;
/*!40000 ALTER TABLE `sp_tme` DISABLE KEYS */;
/*!40000 ALTER TABLE `sp_tme` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_unread`
--

DROP TABLE IF EXISTS `sp_unread`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_unread` (
  `uid` bigint(20) NOT NULL DEFAULT '0',
  `uncomment` int(4) DEFAULT '0',
  `unfans` int(4) DEFAULT '0',
  `unmsg` int(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_unread`
--

LOCK TABLES `sp_unread` WRITE;
/*!40000 ALTER TABLE `sp_unread` DISABLE KEYS */;
/*!40000 ALTER TABLE `sp_unread` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_user_config`
--

DROP TABLE IF EXISTS `sp_user_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_user_config` (
  `uid` bigint(20) NOT NULL DEFAULT '0',
  `name` varchar(40) DEFAULT NULL,
  `face` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_user_config`
--

LOCK TABLES `sp_user_config` WRITE;
/*!40000 ALTER TABLE `sp_user_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `sp_user_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sp_users`
--

DROP TABLE IF EXISTS `sp_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sp_users` (
  `uid` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `mail` varchar(40) DEFAULT NULL,
  `pic` varchar(80) DEFAULT NULL,
  `descs` text,
  `password` varchar(80) DEFAULT NULL,
  `member` int(2) DEFAULT '0',
  `domname` varchar(40) DEFAULT NULL,
  `fenlei` varchar(40) DEFAULT NULL,
  `tui` int(8) DEFAULT '0',
  `foltip` int(2) NOT NULL DEFAULT '0',
  `comtip` int(2) NOT NULL DEFAULT '0',
  `msgtip` int(2) NOT NULL DEFAULT '0',
  `ortui` int(4) NOT NULL DEFAULT '0',
  `orban` int(4) NOT NULL DEFAULT '0',
  `sign` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=356 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sp_users`
--

LOCK TABLES `sp_users` WRITE;
/*!40000 ALTER TABLE `sp_users` DISABLE KEYS */;
INSERT INTO `sp_users` VALUES (353,'身旁网','sp@shenpang.cc',NULL,'欢迎来到拍旁轻博客系统。','e10adc3949ba59abbe56e057f20f883e',0,NULL,'历史',0,0,0,0,0,0,'欢迎来到拍旁轻博客系统。'),(354,'轻轻一点','oo@shenpang.cc',NULL,NULL,'e10adc3949ba59abbe56e057f20f883e',0,NULL,NULL,0,0,0,0,0,0,NULL),(355,'hoho','hoho@shenpang.cc',NULL,NULL,'e10adc3949ba59abbe56e057f20f883e',0,NULL,NULL,0,0,0,0,0,0,NULL);
/*!40000 ALTER TABLE `sp_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2011-12-03 21:04:03
