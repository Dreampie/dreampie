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
  gender     INT DEFAULT 0  COMMENT '性别',
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
  created_at TIMESTAMP   NOT NULL,
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);

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
  created_at TIMESTAMP   NOT NULL,
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);

DROP TABLE IF EXISTS sec_role_permission;
DROP SEQUENCE IF EXISTS sec_role_permission_id_seq;
CREATE SEQUENCE sec_role_permission_id_seq START WITH 1;
CREATE TABLE sec_role_permission (
  id            BIGINT NOT NULL DEFAULT nextval('sec_role_permission_id_seq') PRIMARY KEY,
  role_id       BIGINT NOT NULL,
  permission_id BIGINT NOT NULL
);

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
  name varchar(50) DEFAULT '' COMMENT '地区名称',
  pinyin varchar(100) DEFAULT '' COMMENT '拼音',
  pid int(11) DEFAULT '0' COMMENT '父级编号',
  area_code varchar(6) DEFAULT NULL,
  zip_code varchar(6) DEFAULT NULL COMMENT '邮编',
  left_code bigint(20) DEFAULT '0' COMMENT '左编码',
  right_code bigint(20) DEFAULT '0' COMMENT '右编码',
  created_at TIMESTAMP   NOT NULL,
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
);

DROP TABLE IF EXISTS com_state;
DROP SEQUENCE IF EXISTS com_state_id_seq;
CREATE SEQUENCE com_state_id_seq START WITH 1;
CREATE TABLE com_state (
  id            BIGINT NOT NULL DEFAULT nextval('com_state_id_seq') PRIMARY KEY,
  name varchar(45) DEFAULT NULL COMMENT '状态名称',
  value int(11) DEFAULT '0' COMMENT '状态值',
  describe text COMMENT '描述',
  type varchar(45) DEFAULT NULL COMMENT '状态类型',
  created_at TIMESTAMP   NOT NULL,
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP
  );