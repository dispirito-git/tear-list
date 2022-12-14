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

CREATE TABLE permission(
  `perm_id` BIGINT,
  `perm_name` VARCHAR(20),
  PRIMARY KEY (`perm_id`)
);

CREATE TABLE logins(
  `login_id` BIGINT,
  `login_user` VARCHAR(50),
  `login_pass` VARCHAR(100),
  PRIMARY KEY (`login_id`)
);

CREATE TABLE user(
  `user_id` INT(20) AUTO_INCREMENT,
  `user_per` BIGINT,
  `user_login_id` BIGINT,
  `user_name` VARCHAR(20),
  `user_email` VARCHAR(50),
  `user_phone` INT(20),
  PRIMARY KEY (`user_id`),
  FOREIGN KEY (`user_per`) REFERENCES permission(`perm_id`),
  FOREIGN KEY (`user_login_id`) REFERENCES logins(`login_id`)
);

CREATE TABLE admins (
  `admin_id` BIGINT,
  `admin_per` BIGINT,
  `admin_user` INT(20) AUTO_INCREMENT,
  `admin_login` BIGINT,
  `admin_lvl` INT(50),
  PRIMARY KEY (`admin_id`),
  FOREIGN KEY (`admin_per`) REFERENCES permission(`perm_id`),
  FOREIGN KEY (`admin_login`) REFERENCES logins(`login_id`),
  FOREIGN KEY (`admin_user`) REFERENCES user(`user_id`)
);

CREATE TABLE follower (
  `following_user_id` INT(20) AUTO_INCREMENT,
  `followed_user_id` INT(20) AUTO_INCREMENT,
  FOREIGN KEY (`followed_user_id`) REFERENCES user(`user_id`),
  FOREIGN KEY (`following_user_id`) REFERENCES user(`user_id`)
);

CREATE TABLE community (
  `community_id` BIGINT,
  `community_name` VARCHAR(20),
  `community_desc` VARCHAR(255),
  `community_leader` BIGINT,
  PRIMARY KEY (`community_id`)
);

CREATE TABLE tier_list (
  `tier_id` BIGINT,
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

CREATE TABLE post (
  `post_id` BIGINT,
  `post_tier` BIGINT,
  `post_user` INT(20) AUTO_INCREMENT,
  `post_desc` LONGTEXT,
  `post_title` VARCHAR(20),
  `post_date` DATE,
  PRIMARY KEY (`post_id`),
  FOREIGN KEY(`post_tier`) REFERENCES  tier_list(`tier_id`),
  FOREIGN KEY (`post_user`) REFERENCES user(`user_id`)
);

CREATE TABLE post_comment (
  `comment_post` BIGINT,
  `comment_content` LONGTEXT,
  `commenter_id` INT(20) AUTO_INCREMENT,
  `comment_date` DATE,
  FOREIGN KEY (`comment_post`) REFERENCES post(`post_id`),
  FOREIGN KEY (`commenter_id`) REFERENCES user(`user_id`)
);

CREATE TABLE community_leader (
  `leader_id` BIGINT,
  `leader_login` BIGINT,
  `leader_per` BIGINT,
  `leader_user` INT(20) AUTO_INCREMENT,
  PRIMARY KEY (`leader_id`),
  FOREIGN KEY (`leader_login`) REFERENCES logins(`login_id`),
  FOREIGN KEY (`leader_per`) REFERENCES permission(`perm_id`),
  FOREIGN KEY (`leader_user`) REFERENCES user(`user_id`)
);

CREATE TABLE post_like (
  `like_post` BIGINT,
  `like_date` DATE,
  `liker_user` INT(20) AUTO_INCREMENT,
  FOREIGN KEY (`like_post`) REFERENCES post(`post_id`),
  FOREIGN KEY (`liker_user`) REFERENCES user(`user_id`)
);

CREATE TABLE post_share (
  `share_post` BIGINT,
  `share_desc` LONGTEXT,
  `share_date` DATE,
  `share_type` VARCHAR(20),
  `share_user` INT(20) AUTO_INCREMENT,
  FOREIGN KEY (`share_post`) REFERENCES post(`post_id`),
  FOREIGN KEY (`share_user`) REFERENCES user(`user_id`)
);

CREATE TABLE community_post (
  `com_post` BIGINT,
  `com_id` BIGINT,
  FOREIGN KEY (`com_post`) REFERENCES post(`post_id`),
  FOREIGN KEY (`com_id`) REFERENCES community(`community_id`)
);

CREATE TABLE community_follower (
  `following_community_id` BIGINT,
  `followed_user_id` INT(20) AUTO_INCREMENT,
  FOREIGN KEY (`following_community_id`) REFERENCES community(`community_id`),
  FOREIGN KEY (`followed_user_id`) REFERENCES user(`user_id`)
);

-- Add sample data.

-- Insert data into the `permission` table.
INSERT INTO permission(`perm_id`, `perm_name`)
VALUES (1, 'admin'),
       (2, 'community_leader'),
       (3, 'user');


-- Insert data into the `login` table.
INSERT INTO logins(`login_id`, `login_user`, `login_pass`)
VALUES (1, 'jane.doe', 'my_secure_password'),
       (2, 'john.doe', 'my_secure_password2'),
       (3, 'joe.doe', 'my_secure_password4');

-- Insert data into the user table.
INSERT INTO user(`user_id`, `user_per`, `user_login_id`, `user_name`, `user_email`, `user_phone`)
VALUES (1, 3, 1, 'Jane Doe', 'jane.doe@gmail.com', 5555555555),
       (2, 2, 2, 'John Doe', 'john.doe@gmail.com', 0987654321),
       (3, 1, 3, 'Joe Doe', 'jane.doe@gmail.com', 1212121212);

-- Insert data into the `admin` table.
INSERT INTO admins(`admin_id`, `admin_per`, `admin_user`, `admin_login`, `admin_lvl`)
VALUES (1, 1, 1, 1, 5);

-- Insert data into the `follower` table.
INSERT INTO follower(`following_user_id`, `followed_user_id`)
VALUES (1,2),
       (2,1),
       (1,3);

-- Insert data into the `community` table.
INSERT INTO community(`community_id`, `community_name`, `community_desc`, `community_leader`)
VALUES (1, 'Cool Community 1', 'A community for cool people.', 1),
       (2, 'Cool Community 2', 'A community for cool people.', 2),
       (3, 'Cool Community 3', 'A community for cool people.', 3);

-- Insert data into the `tier_list` table.
INSERT INTO tier_list(`tier_id`, `tier_s`, `tier_a`, `tier_b`, `tier_c`, `tier_d`, `tier_e`, `tier_f`, `tier_topic`)
VALUES (1, 'item1', 'item2', 'item3', 'item4', 'item5', 'item6', 'item7', 'movies'),
       (2, 'item1', 'item2', 'item3', 'item4', 'item5', 'item6', 'item7', 'dragons'),
       (3, 'item1', 'item2', 'item3', 'item4', 'item5', 'item6', 'item7', 'tv'),
       (4, 'item1', 'item2', 'item3', 'item4', 'item5', 'item6', 'item7', 'art');

-- Insert data into the `post` table.
INSERT INTO post(`post_id`, `post_tier`, `post_user`, `post_desc`, `post_title`, `post_date`)
VALUES (1, 1, 1, 'This is my first post!', 'No Title', '2022-12-13'),
       (2, 2, 2, 'This is the second post!', 'Title', '2022-12-15'),
       (3, 3, 3, 'This is the third post!', 'Title 4', '2022-12-25');
INSERT INTO post_comment(`comment_post`, `comment_content` , `commenter_id`, `comment_date`)
VALUES (1, 'This is the first comment', 1, '2021-01-01'),
       (2, 'This is the second comment', 2, '2021-01-02'),
       (3, 'This is the third comment', 3, '2021-01-03');

INSERT INTO community_leader(`leader_id`, `leader_login`, `leader_per`, `leader_user`)
VALUES (1,1,1,1),
       (2,2,2,2),
       (3,2,2,3);

INSERT INTO post_like(`like_post`, `like_date`, `liker_user`)
VALUES (1, '2022-12-13', 1),
       (2, '2022-12-17', 2),
       (3, '2022-12-5', 3);

INSERT INTO post_share(`share_post`, `share_desc`, `share_date`, `share_type`, `share_user`)
VALUES (1, 'Lol', '2022-12-13', 'snapchat', 1),
       (2, 'haha', '2022-12-13', 'text', 2),
       (3, 'lmao', '2022-12-13', 'direct message', 3);
INSERT INTO community_post(`com_post`, `com_id`)
VALUES (1,1),
       (2,2),
       (3,3);
INSERT INTO community_follower(`following_community_id`, `followed_user_id`)
VALUES (1,1),
       (2,3),
       (3,2);
