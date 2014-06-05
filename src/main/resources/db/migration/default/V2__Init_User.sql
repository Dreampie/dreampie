
--create  admin--
INSERT INTO sec_user(id, username, providername, email, mobile, password, hasher, salt, avatar_url, first_name, last_name, full_name, created_at)
VALUES (sec_user_id_seq.nextval,'admin','dreampie','wangrnehui1990@gmail.com','18611434552','$shiro1$SHA-256$500000$ZMhNGAcL3HbpTbNXzxxT1Q==$wRi5AF6BK/1FsQdvISIY1lJ9Rm/aekBoChjunVsqkUU=','default_hasher','','','仁辉','王','仁辉·王',current_timestamp);

--create user_info--
INSERT INTO sec_user_info(id, user_id, creator_id, gender, created_at)
VALUES (sec_user_info_id_seq.nextval,1,0,0,current_timestamp);

--create role--
INSERT INTO sec_user_role(id, user_id, role_id)
VALUES (sec_user_role_id_seq.nextval,1,1);