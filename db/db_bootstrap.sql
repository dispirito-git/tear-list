-- This file is to bootstrap a database for the CS3200 project. 

-- Create a new database.  You can change the name later.  You'll
-- need this name in the FLASK API file(s),  the AppSmith 
-- data source creation.
create database cool_db;

-- Via the Docker Compose file, a special user called webapp will 
-- be created in MySQL. We are going to grant that user 
-- all privilages to the new database we just created. 
-- TODO: If you changed the name of the database above, you need 
-- to change it here too.
grant all privileges on cool_db.* to 'webapp'@'%';
flush privileges;

-- Move into the database we just created.
-- TODO: If you changed the name of the database above, you need to
-- change it here too. 
use cool_db;

-- Put your DDL 

CREATE TABLE `permission` (
  `perm_id` BIGINT,
  `perm_name` VARCHAR(20),
  PRIMARY KEY (`perm_id`)
);

CREATE TABLE `login` (
  `login_id` BIGINT,
  `login_user` VARCHAR(50),
  `login_pass` VARCHAR(100),
  PRIMARY KEY (`login_id`)
);

CREATE TABLE `admin` (
  `admin_id` BIGINT,
  `admin_per` BIGINT,
  `admin_user` BIGINT,
  `admin_login` BIGINT,
  `admin_dfa` BIGINT,
  `admin_lvl` INT(50),
  PRIMARY KEY (`admin_id`),
  FOREIGN KEY (`admin_per`) REFERENCES `permission`(`perm_id`),
  FOREIGN KEY (`admin_login`) REFERENCES `login`(`login_id`),
  FOREIGN KEY (`admin_user`) REFERENCES `user`(`user_id`)
);

CREATE TABLE `user` (
  `user_id` INT(20),
  `user_admin` BIGINT,
  `user_per` BIGINT,
  `user_login_id` BIGINT,
  `user_name` VARCHAR(20),
  `user_email` VARCHAR(50),
  `user_phone` INT(20),
  PRIMARY KEY (`user_id`),
  FOREIGN KEY (`user_per`) REFERENCES `permission`(`perm_id`),
  FOREIGN KEY (`user_admin`) REFERENCES `admin`(`admin_id`),
  FOREIGN KEY (`user_login_id`) REFERENCES `login`(`login_id`)
);

CREATE TABLE `follower` (
  `following_user_id` BIGINT,
  `followed_user_id` BIGINT,
  FOREIGN KEY (`followed_user_id`) REFERENCES `user`(`user_id`),
  FOREIGN KEY (`following_user_id`) REFERENCES `user`(`user_id`)
);

CREATE TABLE `community` (
  `community_id` BIGINT,
  `community_name` VARCHAR(20),
  `community_desc` VARCHAR(255),
  `community_leader` BIGINT,
  PRIMARY KEY (`community_id`)
);

CREATE TABLE `tier_list` (
  `tier_id` BIGINT,
  `tier_post` BIGINT,
  `tier_s` LONGTEXT,
  `tier_a` LONGTEXT,
  `tier_b` LONGTEXT,
  `tier_c` LONGTEXT,
  `tier_d` LONGTEXT,
  `tier_e` LONGTEXT,
  `tier_f` LONGTEXT,
  `tier_topic` VARCHAR(20),
  PRIMARY KEY (`tier_id`)
);

CREATE TABLE `post` (
  `post_id` BIGIINT,
  `post_user` BIGINT,
  `post_desc` LONGTEXT,
  `post_title` VARCHAR(20),
  `post_date` DATE,
  PRIMARY KEY (`post_id`),
  FOREIGN KEY (`post_id`) REFERENCES `tier_list`(`tier_post`),
  FOREIGN KEY (`post_user`) REFERENCES `user`(`user_id`)
);

CREATE TABLE `post_comment` (
  `comment_post` BIGINT,
  `comment_content` LONGTEXT,
  `comment_id` BIGINT,
  FOREIGN KEY (`comment_id`) REFERENCES `community`(`community_id`),
  FOREIGN KEY (`comment_post`) REFERENCES `post`(`post_id`)
);

CREATE TABLE `community_leader` (
  `leader_id` BIGINT,
  `leader_login` BIGINT,
  `leader_per` BIGINT,
  `leader_user` BIGINT,
  PRIMARY KEY (`leader_id`),
  FOREIGN KEY (`leader_login`) REFERENCES `login`(`login_id`),
  FOREIGN KEY (`leader_per`) REFERENCES `permission`(`perm_id`),
  FOREIGN KEY (`leader_user`) REFERENCES `user`(`user_id`),
  FOREIGN KEY (`leader_id`) REFERENCES `community`(`community_leader`)
);

CREATE TABLE `post_like` (
  `like_post` BIGINT,
  `like_date` DATE,
  FOREIGN KEY (`like_post`) REFERENCES `post`(`post_id`)
);

CREATE TABLE `post_share ` (
  `share_post` BIGINT,
  `share_desc` LONGTEXT,
  `share_date` DATE,
  `share_type` VARCHAR(20),
  FOREIGN KEY (`share_post`) REFERENCES `post`(`post_id`)
);

CREATE TABLE `community_post` (
  `com_post` BIGINT,
  `com_id` BIGINT,
  FOREIGN KEY (`com_post`) REFERENCES `post`(`post_id`),
  FOREIGN KEY (`com_id`) REFERENCES `community`(`community_id`)
);

CREATE TABLE `community_follower` (
  `following_community_id` BIGINT,
  `followed_user_id` BIGINT,
  FOREIGN KEY (`following_community_id`) REFERENCES `community`(`community_id`),
  FOREIGN KEY (`followed_user_id`) REFERENCES `user`(`user_id`)
);

-- Add sample data.

-- Insert data into the `permission` table.
INSERT INTO `permission` (`perm_id`, `perm_name`)
VALUES (1, 'admin'),
       (2, 'community_leader'),
       (3, 'user');


-- Insert data into the `login` table.
INSERT INTO `login` (`login_id`, `login_user`, `login_pass`)
VALUES (1, 'jane.doe', 'my_secure_password');

-- Insert data into the `admin` table.
INSERT INTO `admin` (`admin_id`, `admin_per`, `admin_user`, `admin_login`, `admin_dfa`, `admin_lvl`)
VALUES (1, 1, 1, 1, 1, 5);

-- Insert data into the `user` table.
INSERT INTO `user` (`user_id`, `user_admin`, `user_per`, `user_login_id`, `user_name`, `user_email`, `user_phone`)
VALUES (1, 1, 1, 1, 'Jane Doe', 'jane.doe@gmail.com', 5555555555);

-- Insert data into the `follower` table.
INSERT INTO `follower` (`following_user_id`, `followed_user_id`)
VALUES (1, 2);

-- Insert data into the `community` table.
INSERT INTO `community` (`community_id`, `community_name`, `community_desc`, `community_leader`)
VALUES (1, 'Cool Community', 'A community for cool people.', 1);

-- Insert data into the `tier_list` table.
INSERT INTO `tier_list` (`tier_id`, `tier_post`, `tier_s`, `tier_a`, `tier_b`, `tier_c`, `tier_d`, `tier_e`, `tier_f`, `tier_topic`)
VALUES (1, 1, 'item1', 'item2', 'item3', 'item4', 'item5', 'item6', 'item7', 'movies');

-- Insert data into the `post` table.
INSERT INTO `post` (`post_id`, `post_user`, `post_body`, `post_comment`, `post_date`, `post_comm`)
VALUES (1, 1, 'This is my first post!', '', '2022-12-13', 1);
