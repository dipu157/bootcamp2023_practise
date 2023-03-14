CREATE TABLE `company` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL COMMENT '',
  `email` varchar(80) NOT NULL,
  `phone` varchar(14) NULL,
  `address` varchar(100) NULL,
  `city` varchar(60) NULL,
  `state` varchar(40) NULL,
  `zip` varchar(14) NULL,
  `country` varchar(40) NULL,
  `language` varchar(40) NULL DEFAULT 'en-US' COMMENT 'locale',
  `website` varchar(100) NULL,
  `remarks` varchar(100) NULL COMMENT 'note if any',
  `create_date` datetime NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
);

CREATE TABLE `access` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `cid` tinyint(3) NOT NULL COMMENT 'company_id',
  `name` varchar(60) NOT NULL COMMENT 'superadmin|admin|branch|teacher|student',
  `status` tinyint(1) unsigned DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_name` (`name`,`cid`),
  CONSTRAINT `fk_cid_access` FOREIGN KEY (`cid`) REFERENCES `company` (`id`)
);


CREATE TABLE `login` (
  `id` char(20) NOT NULL,
  `cid` tinyint(3) NOT NULL,
  `access_name` varchar(60) NOT NULL COMMENT 'superadmin|admin|branch|teacher|student',
  `username` varchar(80) NOT NULL,
  `passwd` char(60) NOT NULL,
  `email` varchar(80) NULL DEFAULT '' COMMENT 'forget password recovery purpose',
  `mobile` varchar(14) NULL DEFAULT '' COMMENT 'forget password and 2FA recovery purpose',
  `create_date` datetime NOT NULL,
  `update_date` datetime NULL COMMENT '0000-00-00 00:00:00',
  `status` tinyint(1) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`,`status`,`cid`),
  CONSTRAINT `fk_accessName_login` FOREIGN KEY (`access_name`) REFERENCES `access` (`name`),
  CONSTRAINT `fk_cid_login` FOREIGN KEY (`cid`) REFERENCES `company` (`id`)
) ;


CREATE TABLE `account` (
  `id` char(20) NOT NULL,
  `cid` tinyint(3) NOT NULL,
  `parent_id` char(20) NULL COMMENT 'if under another account',
  `account_type` varchar(20) NOT NULL COMMENT 'company|individual',
  `name` varchar(80) NOT NULL COMMENT 'supplier=company name, reseller,user=first+last_name',
  `ledger_code` varchar(20) NULL COMMENT 'linked with AccountHead table ledger_code',
  `login_id` char(20) NULL,
  `first_name` varchar(60) NULL,
  `last_name` varchar(100) NULL,
  `phone` varchar(14) NULL COMMENT 'phone/cell number',
  `email` varchar(80) NULL,
  `remarks` varchar(255) NULL COMMENT '',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 2=Suspended, 3=Suspicious, 9=Deleted',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_loginId_account` FOREIGN KEY (`login_id`) REFERENCES `login` (`id`),
  CONSTRAINT `fk_parentID_account` FOREIGN KEY (`parent_id`) REFERENCES `account` (`id`),
  CONSTRAINT `fk_cid_account` FOREIGN KEY (`cid`) REFERENCES `company` (`id`)
);


CREATE TABLE `address` (
  `id` char(20) NOT NULL,
  `cid` tinyint(3) NOT NULL,
  `account_id` char(20) NULL,
  `address_type` varchar(60) NOT NULL COMMENT 'account/billing',
  `city` varchar(85) NULL COMMENT 'district',
  `state` varchar(85) NULL,
  `address1` varchar(255) NULL COMMENT 'address line 1 street',
  `address2` varchar(255) NULL COMMENT 'address line 2 optional',
  `apartment` varchar(20) NULL,
  `zip` varchar(20) NULL,
  `country` varchar(60) NULL COMMENT 'country name',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 9=Deleted',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_accountID_address` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`),
  CONSTRAINT `fk_cid_address` FOREIGN KEY (`cid`) REFERENCES `company` (`id`)
) ;

CREATE TABLE `division`(
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `cid` tinyint(3) NOT NULL,
  `name` varchar(100) NOT NULL,
  `bn_name` varchar(100) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  CONSTRAINT `fk_cid_division` FOREIGN KEY (`cid`) REFERENCES `company` (`id`)
);

CREATE TABLE `district`(
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `cid` tinyint(3) NOT NULL,
  `division_id` int(3) NOT NULL,
  `name` varchar(100) NOT NULL,
  `bn_name` varchar(100) NOT NULL,
  `lat` double NOT NULL DEFAULT '0',
  `lon` double NOT NULL DEFAULT 0,
  `website` varchar(100) NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  CONSTRAINT `fk_divisionId_district` FOREIGN KEY (`division_id`) REFERENCES `division` (`id`),
  CONSTRAINT `fk_cid_district` FOREIGN KEY (`cid`) REFERENCES `company` (`id`)
);

CREATE TABLE `upazila` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `cid` tinyint(3) NOT NULL,
  `district_id` int(3) NOT NULL,
  `name` varchar(100) NOT NULL,
  `bn_name` varchar(100) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  CONSTRAINT `fk_districtId_upazila` FOREIGN KEY (`district_id`) REFERENCES `district` (`id`),
  CONSTRAINT `fk_cid_upazila` FOREIGN KEY (`cid`) REFERENCES `company` (`id`)
);


CREATE TABLE `gallery` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `cid` tinyint(3) NOT NULL,
  `event_name` varchar(100) NOT NULL,
  `event_type` varchar(100) NOT NULL,
  `image` varchar(100) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cid_gallery` FOREIGN KEY (`cid`) REFERENCES `company` (`id`)
);

/*session*/
CREATE TABLE `session` (
  `id` char(20) NOT NULL,
  `cid` tinyint(3) NOT NULL,
  `name` varchar(100) NOT NULL COMMENT 'session name',
  `start_month` varchar(20) NOT NULL,
  `end_month` varchar(20) NOT NULL,
  `year` int(4) NOT NULL DEFAULT '2023',
  `login_id` char(20) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_loginId_courseSession` FOREIGN KEY (`login_id`) REFERENCES `login` (`id`),
  CONSTRAINT `fk_cid_courseSession` FOREIGN KEY (`cid`) REFERENCES `company` (`id`)
);

CREATE TABLE `course_category` (
  `id` char(20) NOT NULL,
  `cid` tinyint(3) NOT NULL,
  `name` varchar(100) NOT NULL COMMENT 'session name',
  `bn_name` varchar(100) NULL,
  `slug` varchar(100) NULL COMMENT 'cateory url',
  `login_id` char(20) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_loginId_courseCategory` FOREIGN KEY (`login_id`) REFERENCES `login` (`id`),
  CONSTRAINT `fk_cid_courseCategory` FOREIGN KEY (`cid`) REFERENCES `company` (`id`)
);

CREATE TABLE `course` (
  `id` char(20) NOT NULL,
  `cid` tinyint(3) NOT NULL,
  `category_id` char(20) NULL COMMENT 'course category',
  `slug` varchar(100) NULL COMMENT 'cateory url',
  `thumbnail` varchar(100) NULL,
  `promo_video` varchar(100) NULL COMMENT 'video url',
  `name` varchar(100) NOT NULL COMMENT 'title name',
  `code` varchar(20) NOT NULL COMMENT 'course code',
  `description` varchar(200) NULL,
  `instructors` varchar(104) NULL COMMENT 'max 5 instructor',
  `curriculum_url` varchar(100) NULL COMMENT 'download_link',
  `medium` varchar(100) NULL DEFAULT 'offline' COMMENT 'online,offline',
  `duration` double NULL DEFAULT '0' COMMENT 'hours',
  `taken` int(6) NULL DEFAULT '0' COMMENT 'total enroll',
  `price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT 'course fee',
  --`publish_status` varchar(20) NOT NULL DEFAULT 'draft' COMMENT 'draft,published,unpublished',
  `login_id` char(20) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '1=published,0=unpublished',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_categoryId_course` FOREIGN KEY (`category_id`) REFERENCES `course_category` (`id`),
  CONSTRAINT `fk_loginId_course` FOREIGN KEY (`login_id`) REFERENCES `login` (`id`),
  CONSTRAINT `fk_cid_course` FOREIGN KEY (`cid`) REFERENCES `company` (`id`)
);

CREATE TABLE `content` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `cid` tinyint(3) NOT NULL,
  `type` varchar(30) NOT NULL COMMENT 'text,image,video,text,slide_show',
  `course_id` char(20) NULL COMMENT 'if course',
  `slug` varchar(100) NULL COMMENT 'content url',
  `name` varchar(100) NOT NULL COMMENT 'notice|filename',
  `desc` text NULL,
  `title` varchar(100) NOT NULL,
  `sub_title` varchar(100) NULL,
  `filepath` varchar(200) NULL COMMENT 'file path',
  `size` double NOT NULL DEFAULT 0,
  `layout` varchar(100) NULL COMMENT 'grid',
  `publish_date` datetime NULL, 
  `tags` varchar(100) NULL,
  `login_id` char(20) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_loginId_content` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `fk_courseId_content` FOREIGN KEY (`login_id`) REFERENCES `login` (`id`),
  CONSTRAINT `fk_cid_content` FOREIGN KEY (`cid`) REFERENCES `company` (`id`)
);

CREATE TABLE `course_curriculum` (
  `id` char(20) NOT NULL,
  `cid` tinyint(3) NOT NULL,
  `course_id` char(20) NOT NULL,
  `name` varchar(100) NOT NULL COMMENT 'title',
  `topics` varchar(200) NULL COMMENT 'bullet point',
  `handson` varchar(200) NULL COMMENT 'max 5 instructor',
  `skills` varchar(100) NULL COMMENT 'skills you will learn',
  `login_id` char(20) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_loginId_courseCurriculum` FOREIGN KEY (`login_id`) REFERENCES `login` (`id`),
  CONSTRAINT `fk_courseId_courseCurriculum` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `fk_cid_courseCurriculum` FOREIGN KEY (`cid`) REFERENCES `company` (`id`)
);

CREATE TABLE `testimonial` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `cid` tinyint(3) NOT NULL,
  `course_id` char(20) NOT NULL,
  `student_id` char(20) NOT NULL COMMENT 'account_id',
  `remarks` varchar(200) NOT NULL COMMENT 'comments',
  `create_date` datetime NULL COMMENT 'comment date',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_courseId_testimonial` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `fk_studentId_testimonial` FOREIGN KEY (`student_id`) REFERENCES `account` (`id`),
  CONSTRAINT `fk_cid_testimonial` FOREIGN KEY (`cid`) REFERENCES `company` (`id`)
);

CREATE TABLE `exam` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `cid` tinyint(3) NOT NULL,
  `branch_code` char(20) NOT NULL COMMENT 'branch id',
  `name` varchar(100) NOT NULL COMMENT 'exam name',
  `exam_code` varchar(40) NOT NULL COMMENT 'exam code',
  `exam_mark` varchar(40) NOT NULL COMMENT 'exam code',
  `course_id` char(20) NOT NULL,
  `student_id` char(20) NOT NULL,
  `session_id` char(20) NOT NULL COMMENT 'session',
  `exam_date` date NULL,
  `center` varchar(100) NULL COMMENT 'location name',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY (`exam_code`),
  CONSTRAINT `fk_courseId_exam` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `fk_studentId_exam` FOREIGN KEY (`student_id`) REFERENCES `account` (`id`),
  CONSTRAINT `fk_cid_exam` FOREIGN KEY (`cid`) REFERENCES `company` (`id`)
);

CREATE TABLE `admitcard` (
  `id` char(20) NOT NULL,
  `cid` tinyint(3) NOT NULL,
  `branch_code` char(20) NOT NULL COMMENT 'branch id',
  `exam_code` varchar(40) NOT NULL COMMENT 'unique exam',
  `student_id` char(20) NOT NULL COMMENT 'account_id',
  `reg_no` varchar(40) NOT NULL COMMENT 'student id',
  `print_status` tinyint(1) NULL DEFAULT '0' COMMENT '0=No, 1=Yes',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_examCode_admitcard` FOREIGN KEY (`exam_code`) REFERENCES `exam` (`exam_code`),
  CONSTRAINT `fk_studentId_admitcard` FOREIGN KEY (`student_id`) REFERENCES `account` (`id`),
  CONSTRAINT `fk_cid_admitcard` FOREIGN KEY (`cid`) REFERENCES `company` (`id`)
);

CREATE TABLE `certificate` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `cid` tinyint(3) NOT NULL,
  `course_id` char(20) NOT NULL,
  `student_id` char(20) NOT NULL COMMENT 'account_id',
  `session_id` char(20) NOT NULL COMMENT 'session',
  `branch_code` char(20) NOT NULL COMMENT 'branch id',
  `remarks` varchar(200) NOT NULL COMMENT 'comments',
  `issue_date` date NULL,
  `print_status` tinyint(1) NULL DEFAULT '0' COMMENT '0=No, 1=Yes',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_courseId_certificate` FOREIGN KEY (`course_id`) REFERENCES `course` (`id`),
  CONSTRAINT `fk_studentId_certificate` FOREIGN KEY (`student_id`) REFERENCES `account` (`id`),
  CONSTRAINT `fk_cid_certificate` FOREIGN KEY (`cid`) REFERENCES `company` (`id`)
);

CREATE TABLE `placement_info` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `cid` tinyint(3) NOT NULL,
  `student_id` char(20) NOT NULL COMMENT 'account_id',
  `job_type` varchar(20) NOT NULL COMMENT 'govt,others,private',
  `company_name` varchar(80) NOT NULL,
  `position_name` varchar(80) NOT NULL,
  `join_date` date NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cid_placementInfo` FOREIGN KEY (`cid`) REFERENCES `company` (`id`)
);