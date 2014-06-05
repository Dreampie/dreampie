
--create  admin--
INSERT INTO sec_user(id, username, providername, email, mobile, password, hasher, salt, avatar_url, first_name, last_name, full_name, created_at)
VALUES (1,'admin','dreampie','wangrnehui1990@gmail.com','18611434552','$shiro1$SHA-256$500000$fAHLl8oQK5dWgnBErtXCyQ==$RhQ+bPwO84Lav75bVGVb+XJNx64YxMJnH3zR+2yM40M=','default_hasher','','','仁辉','王','王 仁辉',current_timestamp);

--create user_info--
INSERT INTO sec_user_info(id, user_id, creator_id, gender, created_at)
VALUES (1,1,0,0,current_timestamp);

--create role--
INSERT INTO sec_user_role(id, user_id, role_id)
VALUES (1,1,1);