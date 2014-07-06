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