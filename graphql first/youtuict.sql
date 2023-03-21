CREATE TABLE `company` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL COMMENT '',
  `create_date` datetime NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
);


CREATE TABLE `access` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `cid` tinyint(3) NOT NULL COMMENT 'company_id',
  CONSTRAINT `fk_cid_access` FOREIGN KEY (`cid`) REFERENCES `company` (`id`)
  `name` varchar(60) NOT NULL,
  `status` tinyint(1) unsigned DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_name` (`name`,`cid`),
);
