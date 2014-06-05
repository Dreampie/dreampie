DROP TABLE IF EXISTS sec_user;
DROP SEQUENCE IF EXISTS sec_user_id_seq;
CREATE SEQUENCE sec_user_id_seq START WITH 1;
CREATE TABLE sec_user (
  id           BIGINT       NOT NULL DEFAULT nextval('sec_user_id_seq') PRIMARY KEY,
  username     VARCHAR(50)  NOT NULL  COMMENT '登录名',
  providername VARCHAR(50)  NOT NULL  COMMENT '提供者',
  email        VARCHAR(200)  COMMENT '邮箱',
  mobile       VARCHAR(50)  COMMENT '手机',
  password     VARCHAR(200) NOT NULL  COMMENT '密码',
  hasher       VARCHAR(200) NOT NULL  COMMENT '加密类型',
  salt         VARCHAR(200) NOT NULL  COMMENT '加密盐',
  avatar_url   VARCHAR(255)  COMMENT '头像',
  first_name   VARCHAR(10)  COMMENT '名字',
  last_name    VARCHAR(10)  COMMENT '姓氏',
  full_name    VARCHAR(20)  COMMENT '全名',
  created_at   TIMESTAMP    NOT NULL,
  updated_at   TIMESTAMP,
  deleted_at   TIMESTAMP
);

DROP TABLE IF EXISTS sec_user_info;
DROP SEQUENCE IF EXISTS sec_user_info_id_seq;
CREATE SEQUENCE sec_user_info_id_seq START WITH 1;
CREATE TABLE sec_user_info (
  id         BIGINT    NOT NULL DEFAULT nextval('sec_user_info_id_seq') PRIMARY KEY,
  user_id    BIGINT    NOT NULL  COMMENT '用户id',
  creator_id BIGINT  COMMENT '创建者id',
  gender     INT DEFAULT 0  COMMENT '性别0男，1女',
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);

DROP TABLE IF EXISTS sec_role;
DROP SEQUENCE IF EXISTS sec_role_id_seq;
CREATE SEQUENCE sec_role_id_seq START WITH 1;
CREATE TABLE sec_role (
  id         BIGINT      NOT NULL DEFAULT nextval('sec_role_id_seq') PRIMARY KEY,
  name       VARCHAR(50) NOT NULL  COMMENT '名称',
  value      VARCHAR(50) NOT NULL  COMMENT '值',
  intro      VARCHAR(255)  COMMENT '简介',
  pid        BIGINT DEFAULT 0  COMMENT '父级id',
  left_code       BIGINT DEFAULT 0  COMMENT '数据左边码',
  right_code       BIGINT DEFAULT 0  COMMENT '数据右边码',
  created_at TIMESTAMP   NOT NULL,
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);

INSERT INTO sec_role(id,name, value, intro, pid,left_code,right_code,created_at)
VALUES (1,'超级管理员','R_ADMIN','',0,1,8, current_timestamp),
        (2,'系统管理员','R_MANAGER','',1,2,7,current_timestamp),
        (3,'会员','R_MEMBER','',2,3,4,current_timestamp),
        (4,'普通用户','R_USER','',2,5,6,current_timestamp);

DROP TABLE IF EXISTS sec_user_role;
DROP SEQUENCE IF EXISTS sec_user_role_id_seq;
CREATE SEQUENCE sec_user_role_id_seq START WITH 1;
CREATE TABLE sec_user_role (
  id      BIGINT NOT NULL DEFAULT nextval('sec_user_role_id_seq') PRIMARY KEY,
  user_id BIGINT NOT NULL,
  role_id BIGINT NOT NULL
);

DROP TABLE IF EXISTS sec_permission;
DROP SEQUENCE IF EXISTS sec_permission_id_seq;
CREATE SEQUENCE sec_permission_id_seq START WITH 1;
CREATE TABLE sec_permission (
  id         BIGINT      NOT NULL DEFAULT nextval('sec_permission_id_seq') PRIMARY KEY,
  name       VARCHAR(50) NOT NULL  COMMENT '名称',
  value      VARCHAR(50) NOT NULL  COMMENT '值',
  url        VARCHAR(255)  COMMENT 'url地址',
  intro      VARCHAR(255)  COMMENT '简介',
  pid        BIGINT DEFAULT 0  COMMENT '父级id',
  left_code       BIGINT DEFAULT 0  COMMENT '数据左边码',
  right_code       BIGINT DEFAULT 0  COMMENT '数据右边码',
  created_at TIMESTAMP   NOT NULL,
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);

INSERT INTO sec_permission(id, name, value, url, intro,pid,left_code,right_code, created_at)
VALUES (1,'超级管理员目录','P_D_ADMIN','/admin/**','',0,1,4,current_timestamp),
        (2,'角色权限管理','P_ROLE','/admin/role/**','',1,2,3,current_timestamp),
        (3,'管理员目录','P_D_MANAGER','/manager/**','',0,5,6,current_timestamp),
        (4,'会员目录','P_D_MEMBER','/member/**','',0,7,8,current_timestamp),
        (5,'普通用户目录','P_D_USER','/user/**','',0,9,10,current_timestamp);

DROP TABLE IF EXISTS sec_role_permission;
DROP SEQUENCE IF EXISTS sec_role_permission_id_seq;
CREATE SEQUENCE sec_role_permission_id_seq START WITH 1;
CREATE TABLE sec_role_permission (
  id            BIGINT NOT NULL DEFAULT nextval('sec_role_permission_id_seq') PRIMARY KEY,
  role_id       BIGINT NOT NULL,
  permission_id BIGINT NOT NULL
);

INSERT INTO sec_role_permission(id,role_id, permission_id)
VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),
        (6,2,3),(7,2,4),(8,2,5),
        (9,3,4),
        (10,4,5);

DROP TABLE IF EXISTS sec_token;
CREATE TABLE sec_token (
  uuid          VARCHAR(255) NOT NULL  COMMENT '用户编码',
  username      VARCHAR(50)  NOT NULL  COMMENT '用户名',
  created_at    TIMESTAMP    NOT NULL ,
  expiration_at TIMESTAMP    NOT NULL  COMMENT '结束时间',
  is_sign_up    BOOLEAN DEFAULT TRUE  COMMENT '是否是注册'
);

DROP TABLE IF EXISTS com_area;
DROP SEQUENCE IF EXISTS com_area_id_seq;
CREATE SEQUENCE com_area_id_seq START WITH 1;
CREATE TABLE com_area (
  id            BIGINT NOT NULL DEFAULT nextval('com_area_id_seq') PRIMARY KEY,
  name VARCHAR(50) DEFAULT '' COMMENT '地区名称',
  pinyin VARCHAR(100) DEFAULT '' COMMENT '拼音',
  pid INT(11) DEFAULT '0' COMMENT '父级编号',
  area_code VARCHAR(6) DEFAULT NULL,
  zip_code VARCHAR(6) DEFAULT NULL COMMENT '邮编',
  left_code BIGINT DEFAULT '0' COMMENT '左编码',
  right_code BIGINT DEFAULT '0' COMMENT '右编码',
  created_at TIMESTAMP   NOT NULL,
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);

DROP TABLE IF EXISTS com_state;
DROP SEQUENCE IF EXISTS com_state_id_seq;
CREATE SEQUENCE com_state_id_seq START WITH 1;
CREATE TABLE com_state (
  id            BIGINT NOT NULL DEFAULT nextval('com_state_id_seq') PRIMARY KEY,
  name VARCHAR(45) DEFAULT NULL COMMENT '状态名称',
  value INT(11) DEFAULT '0' COMMENT '状态值',
  describe TEXT COMMENT '描述',
  type VARCHAR(45) DEFAULT NULL COMMENT '状态类型',
  created_at TIMESTAMP   NOT NULL,
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
  );