DROP TABLE IF EXISTS contacts;
DROP SEQUENCE IF EXISTS contacts_id_seq;
CREATE SEQUENCE contacts_id_seq START WITH 1;
CREATE TABLE contacts (
  id   BIGINT  NOT NULL DEFAULT NEXTVAL('contacts_id_seq') PRIMARY KEY,
  user_id BIGINT    NOT NULL  COMMENT '用户id',
  link_id BIGINT    NOT NULL  COMMENT '联系人id',
  intro TEXT COMMENT '简介',
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP
);

INSERT INTO contacts(id,user_id,link_id,intro,created_at)
VALUES(1,1,2,'测试猪头',current_timestamp);