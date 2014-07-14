DROP TABLE IF EXISTS follower;
DROP SEQUENCE IF EXISTS follower_id_seq;
CREATE SEQUENCE follower_id_seq START WITH 1;
CREATE TABLE follower (
  id   BIGINT  NOT NULL DEFAULT NEXTVAL('follower_id_seq') PRIMARY KEY,
  user_id BIGINT    NOT NULL  COMMENT '用户id',
  link_id BIGINT    NOT NULL  COMMENT '联系人id',
  intro TEXT COMMENT '简介',
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP
);

INSERT INTO follower(id,user_id,link_id,intro,created_at)
VALUES(follower_id_seq.nextval,1,2,'following测试',current_timestamp),
      (follower_id_seq.nextval,2,1,'follower测试',current_timestamp);

DROP TABLE IF EXISTS blog;
DROP SEQUENCE IF EXISTS blog_id_seq;
CREATE SEQUENCE blog_id_seq START WITH 1;
CREATE TABLE blog (
  id   BIGINT  NOT NULL DEFAULT NEXTVAL('blog_id_seq') PRIMARY KEY,
  user_id BIGINT  NOT NULL  COMMENT '用户id',
  top INT NOT NULL DEFAULT 0 COMMENT '0默认，1置顶',
  type INT NOT NULL DEFAULT 1 COMMENT '1文字2音乐3照片4视频5链接 ',
  tag VARCHAR(30) NOT NULL COMMENT '标签',
  title VARCHAR(50) NOT NULL COMMENT '标题',
  body TEXT NOT NULL COMMENT '内容',
  is_complete INT NOT NULL DEFAULT 0 COMMENT '0发布 1草稿',
  hit_count INT DEFAULT 0 COMMENT '点击量',
  feed_count INT NOT NULL DEFAULT 0 COMMENT '动作统计',
  replay_count INT NOT NULL DEFAULT 0 COMMENT '评论回复数',
  no_reply INT NOT NULL DEFAULT 0 COMMENT '不允许评论',
  collect_count INT DEFAULT 0 COMMENT '收藏数',
  is_public INT DEFAULT 0 COMMENT '是否公开0完全公开，1好友公开，2私密',
  support_count INT NOT NULL DEFAULT 0 COMMENT '支持数',
  oppose_count INT NOT NULL DEFAULT 0 COMMENT '反对数',
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);

INSERT INTO blog(id,user_id,tag,title,body,created_at)
VALUES(blog_id_seq.nextval,1,'测试','测试博客','我是一条测试博客',current_timestamp);

DROP TABLE IF EXISTS blog_reply;
DROP SEQUENCE IF EXISTS blog_reply_id_seq;
CREATE SEQUENCE blog_reply_id_seq START WITH 1;
CREATE TABLE blog_reply (
  id   BIGINT  NOT NULL DEFAULT NEXTVAL('blog_reply_id_seq') PRIMARY KEY,
  blog_id INT NOT NULL COMMENT '回复博客',
  uer_id INT NOT NULL COMMENT '回复用户',
  reply_id INT DEFAULT '0' COMMENT '被回复用户',
  body TINYTEXT NOT NULL COMMENT '内容',
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);