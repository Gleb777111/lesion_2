-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema cryptohelper
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `cryptohelper` ;

-- -----------------------------------------------------
-- Schema cryptohelper
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cryptohelper` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `cryptohelper` ;

-- -----------------------------------------------------
-- Table `cryptohelper`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`users` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(260) CHARACTER SET 'utf8mb3' NOT NULL,
  `name` VARCHAR(100) CHARACTER SET 'utf8mb3' NOT NULL,
  `user_id` INT NOT NULL,
  `registered` DATETIME NOT NULL,
  `added_by` VARCHAR(100) CHARACTER SET 'utf8mb3' NOT NULL,
  `comment` VARCHAR(1000) CHARACTER SET 'utf8mb3' NOT NULL,
  `session` VARCHAR(5000) CHARACTER SET 'utf8mb3' NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cryptohelper`.`vips`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`vips` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`vips` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) CHARACTER SET 'utf8mb3' NOT NULL,
  `price_list` VARCHAR(1000) CHARACTER SET 'utf8mb3' NOT NULL,
  `channels` VARCHAR(1000) CHARACTER SET 'utf8mb3' NOT NULL,
  `visible` TINYINT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cryptohelper`.`bannes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`bannes` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`bannes` (
  `user_id_fk` INT NOT NULL,
  `vip_id` INT NOT NULL,
  `ban_date` DATETIME NOT NULL,
  INDEX `user_id_fk` (`user_id_fk` ASC) VISIBLE,
  INDEX `vip_id` (`vip_id` ASC) VISIBLE,
  CONSTRAINT `bannes_ibfk_1`
    FOREIGN KEY (`user_id_fk`)
    REFERENCES `cryptohelper`.`users` (`id`),
  CONSTRAINT `bannes_ibfk_2`
    FOREIGN KEY (`vip_id`)
    REFERENCES `cryptohelper`.`vips` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cryptohelper`.`bot`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`bot` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`bot` (
  `token` VARCHAR(100) NULL DEFAULT NULL,
  `owner_id` VARCHAR(45) NULL,
  `id` INT NOT NULL,
  INDEX `fk_bot_users1_idx` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_bot_users1`
    FOREIGN KEY (`id`)
    REFERENCES `cryptohelper`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cryptohelper`.`coins`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`coins` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`coins` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `coin` VARCHAR(15) CHARACTER SET 'utf8mb3' NOT NULL,
  `address` VARCHAR(260) CHARACTER SET 'utf8mb3' NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cryptohelper`.`config`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`config` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`config` (
  `admin_id` INT NULL DEFAULT NULL,
  `error_channel` INT NULL DEFAULT NULL,
  `event_channel` INT NULL DEFAULT NULL,
  `id` INT NOT NULL,
  INDEX `fk_config_users1_idx` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_config_users1`
    FOREIGN KEY (`id`)
    REFERENCES `cryptohelper`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `cryptohelper`.`pools`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`pools` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`pools` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) CHARACTER SET 'utf8mb3' NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cryptohelper`.`pool_requests`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`pool_requests` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`pool_requests` (
  `pool_id_fk` INT NOT NULL,
  `user_id_fk` INT NOT NULL,
  `username` VARCHAR(260) CHARACTER SET 'utf8mb3' NOT NULL,
  `name` VARCHAR(100) CHARACTER SET 'utf8mb3' NOT NULL,
  `mail` VARCHAR(260) CHARACTER SET 'utf8mb3' NOT NULL,
  `coin_id_fk` INT NOT NULL,
  `coin_address` VARCHAR(260) CHARACTER SET 'utf8mb3' NOT NULL,
  `amount` INT NOT NULL,
  `txn_id` VARCHAR(260) CHARACTER SET 'utf8mb3' NOT NULL,
  INDEX `coin_id_fk` (`coin_id_fk` ASC) VISIBLE,
  INDEX `user_id_fk` (`user_id_fk` ASC) VISIBLE,
  INDEX `pool_id_fk` (`pool_id_fk` ASC) VISIBLE,
  CONSTRAINT `pool_requests_ibfk_1`
    FOREIGN KEY (`coin_id_fk`)
    REFERENCES `cryptohelper`.`coins` (`id`),
  CONSTRAINT `pool_requests_ibfk_2`
    FOREIGN KEY (`user_id_fk`)
    REFERENCES `cryptohelper`.`users` (`id`),
  CONSTRAINT `pool_requests_ibfk_3`
    FOREIGN KEY (`pool_id_fk`)
    REFERENCES `cryptohelper`.`pools` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cryptohelper`.`transactions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`transactions` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`transactions` (
  `user_id_fk` INT NOT NULL,
  `txn_id` VARCHAR(260) CHARACTER SET 'utf8mb3' NOT NULL,
  `txn_status` VARCHAR(1000) CHARACTER SET 'utf8mb3' NOT NULL,
  INDEX `user_id_fk` (`user_id_fk` ASC) VISIBLE,
  CONSTRAINT `transactions_ibfk_1`
    FOREIGN KEY (`user_id_fk`)
    REFERENCES `cryptohelper`.`users` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cryptohelper`.`vips_library`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`vips_library` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`vips_library` (
  `user_id_fk` INT NOT NULL,
  `vip_id_fk` INT NOT NULL,
  `sub_start` DATETIME NOT NULL,
  `sub_finish` DATETIME NOT NULL,
  `coin_id_fk` INT NOT NULL,
  `txn_id` VARCHAR(260) CHARACTER SET 'utf8mb3' NOT NULL,
  INDEX `user_id_fk` (`user_id_fk` ASC) VISIBLE,
  INDEX `vip_id_fk` (`vip_id_fk` ASC) VISIBLE,
  CONSTRAINT `vips_library_ibfk_1`
    FOREIGN KEY (`user_id_fk`)
    REFERENCES `cryptohelper`.`users` (`id`),
  CONSTRAINT `vips_library_ibfk_2`
    FOREIGN KEY (`vip_id_fk`)
    REFERENCES `cryptohelper`.`vips` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `cryptohelper`.`profile`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`profile` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`profile` (
  `id` INT NOT NULL,
  `fio` VARCHAR(45) NULL,
  `city` VARCHAR(45) NULL,
  `status` VARCHAR(45) NULL,
  `birthday` DATE NULL,
  `subscribers` INT NULL,
  `userid` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cryptohelper`.`group_chat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`group_chat` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`group_chat` (
  `id` INT NOT NULL,
  `namegroups` VARCHAR(45) NULL,
  `user_id` INT NULL,
  `admin_id` INT NULL,
  `messages` VARCHAR(45) NULL,
  `profile_id` INT NOT NULL,
  `media_id` INT NULL,
  PRIMARY KEY (`id`, `profile_id`),
  INDEX `fk_group_chat_profile1_idx` (`profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_group_chat_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `cryptohelper`.`profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cryptohelper`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`user` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`user` (
  `id` INT NOT NULL,
  `login` INT NULL,
  `password` CHAR(25) NULL,
  `profile_id` INT NOT NULL,
  `group_chat_id` INT NOT NULL,
  `group_chat_profile_id` INT NOT NULL,
  PRIMARY KEY (`id`, `profile_id`, `group_chat_id`, `group_chat_profile_id`),
  INDEX `fk_user_profile1_idx` (`profile_id` ASC) VISIBLE,
  INDEX `fk_user_group_chat1_idx` (`group_chat_id` ASC, `group_chat_profile_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `cryptohelper`.`profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_group_chat1`
    FOREIGN KEY (`group_chat_id` , `group_chat_profile_id`)
    REFERENCES `cryptohelper`.`group_chat` (`id` , `profile_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cryptohelper`.`post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`post` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`post` (
  `id` INT NOT NULL,
  `profile_id` INT NULL,
  `seive_id` INT NULL,
  `messages` VARCHAR(45) NULL,
  `profile_id1` INT NOT NULL,
  PRIMARY KEY (`id`, `profile_id1`),
  INDEX `fk_post_profile1_idx` (`profile_id1` ASC) VISIBLE,
  CONSTRAINT `fk_post_profile1`
    FOREIGN KEY (`profile_id1`)
    REFERENCES `cryptohelper`.`profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cryptohelper`.`seive`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`seive` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`seive` (
  `id` INT NOT NULL,
  `seive_media_id` INT NULL,
  `profile_id` INT NULL,
  `profile_id1` INT NOT NULL,
  `post_id` INT NOT NULL,
  PRIMARY KEY (`id`, `profile_id1`, `post_id`),
  INDEX `fk_seive_profile1_idx` (`profile_id1` ASC) VISIBLE,
  INDEX `fk_seive_post1_idx` (`post_id` ASC) VISIBLE,
  CONSTRAINT `fk_seive_profile1`
    FOREIGN KEY (`profile_id1`)
    REFERENCES `cryptohelper`.`profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_seive_post1`
    FOREIGN KEY (`post_id`)
    REFERENCES `cryptohelper`.`post` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cryptohelper`.`comens`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`comens` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`comens` (
  `id` INT NOT NULL,
  `comens` VARCHAR(45) NULL,
  `media_id` VARCHAR(45) NULL,
  `post_id` INT NOT NULL,
  `post_profile_id1` INT NOT NULL,
  PRIMARY KEY (`id`, `post_id`, `post_profile_id1`),
  INDEX `fk_comens_post1_idx` (`post_id` ASC, `post_profile_id1` ASC) VISIBLE,
  CONSTRAINT `fk_comens_post1`
    FOREIGN KEY (`post_id` , `post_profile_id1`)
    REFERENCES `cryptohelper`.`post` (`id` , `profile_id1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cryptohelper`.`media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`media` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`media` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `user_id` INT NULL,
  `chatmed_id` INT NULL,
  `user_id1` INT NOT NULL,
  `user_profile_id` INT NOT NULL,
  `user_group_chat_id` INT NOT NULL,
  `user_group_chat_profile_id` INT NOT NULL,
  `group_chat_id` INT NOT NULL,
  `group_chat_profile_id` INT NOT NULL,
  `seive_id` INT NOT NULL,
  `seive_profile_id1` INT NOT NULL,
  `comens_id` INT NOT NULL,
  `comens_post_id` INT NOT NULL,
  `comens_post_profile_id1` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id1`, `user_profile_id`, `user_group_chat_id`, `user_group_chat_profile_id`, `group_chat_id`, `group_chat_profile_id`, `seive_id`, `seive_profile_id1`, `comens_id`, `comens_post_id`, `comens_post_profile_id1`),
  INDEX `fk_media_user1_idx` (`user_id1` ASC, `user_profile_id` ASC, `user_group_chat_id` ASC, `user_group_chat_profile_id` ASC) VISIBLE,
  INDEX `fk_media_group_chat1_idx` (`group_chat_id` ASC, `group_chat_profile_id` ASC) VISIBLE,
  INDEX `fk_media_seive1_idx` (`seive_id` ASC, `seive_profile_id1` ASC) VISIBLE,
  INDEX `fk_media_comens1_idx` (`comens_id` ASC, `comens_post_id` ASC, `comens_post_profile_id1` ASC) VISIBLE,
  CONSTRAINT `fk_media_user1`
    FOREIGN KEY (`user_id1` , `user_profile_id` , `user_group_chat_id` , `user_group_chat_profile_id`)
    REFERENCES `cryptohelper`.`user` (`id` , `profile_id` , `group_chat_id` , `group_chat_profile_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_media_group_chat1`
    FOREIGN KEY (`group_chat_id` , `group_chat_profile_id`)
    REFERENCES `cryptohelper`.`group_chat` (`id` , `profile_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_media_seive1`
    FOREIGN KEY (`seive_id` , `seive_profile_id1`)
    REFERENCES `cryptohelper`.`seive` (`id` , `profile_id1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_media_comens1`
    FOREIGN KEY (`comens_id` , `comens_post_id` , `comens_post_profile_id1`)
    REFERENCES `cryptohelper`.`comens` (`id` , `post_id` , `post_profile_id1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cryptohelper`.`friends`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`friends` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`friends` (
  `id` INT NOT NULL,
  `recipient_id` INT NULL,
  `sender_id` INT NULL,
  `money` VARCHAR(45) NULL,
  `messages` VARCHAR(45) NULL,
  `user_id` INT NOT NULL,
  `user_profile_id` INT NOT NULL,
  `user_group_chat_id` INT NOT NULL,
  `user_group_chat_profile_id` INT NOT NULL,
  `user_id1` INT NOT NULL,
  `user_profile_id1` INT NOT NULL,
  `user_group_chat_id1` INT NOT NULL,
  `user_group_chat_profile_id1` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`, `user_profile_id`, `user_group_chat_id`, `user_group_chat_profile_id`, `user_id1`, `user_profile_id1`, `user_group_chat_id1`, `user_group_chat_profile_id1`),
  INDEX `fk_friends_user1_idx` (`user_id` ASC, `user_profile_id` ASC, `user_group_chat_id` ASC, `user_group_chat_profile_id` ASC) VISIBLE,
  INDEX `fk_friends_user2_idx` (`user_id1` ASC, `user_profile_id1` ASC, `user_group_chat_id1` ASC, `user_group_chat_profile_id1` ASC) VISIBLE,
  CONSTRAINT `fk_friends_user1`
    FOREIGN KEY (`user_id` , `user_profile_id` , `user_group_chat_id` , `user_group_chat_profile_id`)
    REFERENCES `cryptohelper`.`user` (`id` , `profile_id` , `group_chat_id` , `group_chat_profile_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_friends_user2`
    FOREIGN KEY (`user_id1` , `user_profile_id1` , `user_group_chat_id1` , `user_group_chat_profile_id1`)
    REFERENCES `cryptohelper`.`user` (`id` , `profile_id` , `group_chat_id` , `group_chat_profile_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cryptohelper`.`photo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`photo` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`photo` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `photocol` VARCHAR(45) NULL,
  `coments` VARCHAR(45) NULL,
  `media_id` INT NULL,
  `media_id1` INT NOT NULL,
  `media_user_id1` INT NOT NULL,
  `media_user_profile_id` INT NOT NULL,
  `media_user_group_chat_id` INT NOT NULL,
  `media_user_group_chat_profile_id` INT NOT NULL,
  `media_group_chat_id` INT NOT NULL,
  `media_group_chat_profile_id` INT NOT NULL,
  `media_seive_id` INT NOT NULL,
  `media_seive_profile_id1` INT NOT NULL,
  `media_comens_id` INT NOT NULL,
  `media_comens_post_id` INT NOT NULL,
  `media_comens_post_profile_id1` INT NOT NULL,
  PRIMARY KEY (`id`, `media_id1`, `media_user_id1`, `media_user_profile_id`, `media_user_group_chat_id`, `media_user_group_chat_profile_id`, `media_group_chat_id`, `media_group_chat_profile_id`, `media_seive_id`, `media_seive_profile_id1`, `media_comens_id`, `media_comens_post_id`, `media_comens_post_profile_id1`),
  INDEX `fk_photo_media1_idx` (`media_id1` ASC, `media_user_id1` ASC, `media_user_profile_id` ASC, `media_user_group_chat_id` ASC, `media_user_group_chat_profile_id` ASC, `media_group_chat_id` ASC, `media_group_chat_profile_id` ASC, `media_seive_id` ASC, `media_seive_profile_id1` ASC, `media_comens_id` ASC, `media_comens_post_id` ASC, `media_comens_post_profile_id1` ASC) VISIBLE,
  CONSTRAINT `fk_photo_media1`
    FOREIGN KEY (`media_id1` , `media_user_id1` , `media_user_profile_id` , `media_user_group_chat_id` , `media_user_group_chat_profile_id` , `media_group_chat_id` , `media_group_chat_profile_id` , `media_seive_id` , `media_seive_profile_id1` , `media_comens_id` , `media_comens_post_id` , `media_comens_post_profile_id1`)
    REFERENCES `cryptohelper`.`media` (`id` , `user_id1` , `user_profile_id` , `user_group_chat_id` , `user_group_chat_profile_id` , `group_chat_id` , `group_chat_profile_id` , `seive_id` , `seive_profile_id1` , `comens_id` , `comens_post_id` , `comens_post_profile_id1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `cryptohelper`.`video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `cryptohelper`.`video` ;

CREATE TABLE IF NOT EXISTS `cryptohelper`.`video` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `coments` VARCHAR(45) NULL,
  `media_id` INT NULL,
  `media_id1` INT NOT NULL,
  `media_user_id1` INT NOT NULL,
  `media_user_profile_id` INT NOT NULL,
  `media_user_group_chat_id` INT NOT NULL,
  `media_user_group_chat_profile_id` INT NOT NULL,
  `media_group_chat_id` INT NOT NULL,
  `media_group_chat_profile_id` INT NOT NULL,
  `media_seive_id` INT NOT NULL,
  `media_seive_profile_id1` INT NOT NULL,
  `media_comens_id` INT NOT NULL,
  `media_comens_post_id` INT NOT NULL,
  `media_comens_post_profile_id1` INT NOT NULL,
  PRIMARY KEY (`id`, `media_id1`, `media_user_id1`, `media_user_profile_id`, `media_user_group_chat_id`, `media_user_group_chat_profile_id`, `media_group_chat_id`, `media_group_chat_profile_id`, `media_seive_id`, `media_seive_profile_id1`, `media_comens_id`, `media_comens_post_id`, `media_comens_post_profile_id1`),
  INDEX `fk_video_media1_idx` (`media_id1` ASC, `media_user_id1` ASC, `media_user_profile_id` ASC, `media_user_group_chat_id` ASC, `media_user_group_chat_profile_id` ASC, `media_group_chat_id` ASC, `media_group_chat_profile_id` ASC, `media_seive_id` ASC, `media_seive_profile_id1` ASC, `media_comens_id` ASC, `media_comens_post_id` ASC, `media_comens_post_profile_id1` ASC) VISIBLE,
  CONSTRAINT `fk_video_media1`
    FOREIGN KEY (`media_id1` , `media_user_id1` , `media_user_profile_id` , `media_user_group_chat_id` , `media_user_group_chat_profile_id` , `media_group_chat_id` , `media_group_chat_profile_id` , `media_seive_id` , `media_seive_profile_id1` , `media_comens_id` , `media_comens_post_id` , `media_comens_post_profile_id1`)
    REFERENCES `cryptohelper`.`media` (`id` , `user_id1` , `user_profile_id` , `user_group_chat_id` , `user_group_chat_profile_id` , `group_chat_id` , `group_chat_profile_id` , `seive_id` , `seive_profile_id1` , `comens_id` , `comens_post_id` , `comens_post_profile_id1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
