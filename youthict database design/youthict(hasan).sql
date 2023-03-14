<<<<<<< HEAD
<<<<<<< HEAD
-- Table structure for table `company`

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

-- Table structure for table `access`

CREATE TABLE `access` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `cid` tinyint(3) NOT NULL COMMENT 'company_id',
  `name` varchar(60) NOT NULL COMMENT 'superadmin|admin|branch|student',
  `status` tinyint(1) unsigned DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY access_name (name, cid),
  CONSTRAINT fk_cid_access FOREIGN KEY (cid) REFERENCES company (id)
);

-- Table structure for table `account`

CREATE TABLE `login` (
  `id` char(20) NOT NULL,
  `cid` tinyint(3) NOT NULL,
  `access_name` varchar(60) NOT NULL COMMENT 'superadmin|admin|branch|student',
  `username` varchar(80) NOT NULL,
  `passwd` char(60) NOT NULL,
  `email` varchar(80) NULL DEFAULT '' COMMENT 'forget password recovery purpose',
  `mobile` varchar(14) NULL DEFAULT '' COMMENT 'forget password and 2FA recovery purpose',
  `create_date` datetime NOT NULL,
  `update_date` datetime NULL COMMENT '0000-00-00 00:00:00',
  `status` tinyint(1) unsigned DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY username (username, status, cid),
  CONSTRAINT fk_accessName_login FOREIGN KEY (access_name) REFERENCES access(name),
  CONSTRAINT fk_cid_login FOREIGN KEY (cid) REFERENCES company(id)
);

-- Table structure for table `account`

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
  CONSTRAINT fk_loginId_account FOREIGN KEY (login_id) REFERENCES login(id),
  CONSTRAINT fk_parentID_account FOREIGN KEY (parent_id) REFERENCES account(id),
  CONSTRAINT fk_cid_account FOREIGN KEY (cid) REFERENCES company(id)
);

-- Table structure for table `address`

CREATE TABLE `address` (
  `id` char(20) NOT NULL,
  `cid` tinyint(3) NOT NULL,
  `account_id` char(20) NULL,
  `address_type` varchar(60) NOT NULL COMMENT 'account/billing',
  `city` varchar(85) NULL,
  `state` varchar(85) NULL,
  `address1` varchar(255) NULL COMMENT 'address line 1 street',
  `address2` varchar(255) NULL COMMENT 'address line 2 optional',
  `apartment` varchar(20) NULL,
  `zip` varchar(20) NULL,
  `country` varchar(60) NULL COMMENT 'country name',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 9=Deleted',
  PRIMARY KEY (`id`),
  CONSTRAINT fk_accountID_address FOREIGN KEY (account_id) REFERENCES account(id),
  CONSTRAINT fk_cid_address FOREIGN KEY (cid) REFERENCES company (id)
) ;


-- Table structure for table `branch`

CREATE TABLE `branch` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  -- COMMENT branch id start with 300 becoz 101 to ... distributed
  `name_bn` varchar(80) NOT NULL,
  `name_en` varchar(80) NOT NULL,
  `br_age` int(3) NOT NULL,
  `br_computer` int(2) NOT NULL,
  `proprietor_name_bn` varchar(80) NOT NULL,
  `proprietor_name_en` varchar(80) NOT NULL,
  `pro_f_name` varchar(80) NOT NULL,
  `pro_m_name` varchar(80) NOT NULL,
  `br_email` varchar(20) NOT NULL,
  `br_mobile` varchar(14) NOT NULL,
  `div_id` tinyint(1) NOT NULL COMMENT 'division name',
  `dis_id` tinyint(1) NOT NULL COMMENT 'district name',
  `ps_id` tinyint(3) NOT NULL COMMENT 'police station',
  `br_address_en` varchar(100) NOT NULL,
  `br_addreess_bn` varchar(100) NOT NULL,
  `br_exprience` tinyint(1) NOT NULL,
  `pro_photo` blob NOT NULL,
  `pro_nid` blob NOT NULL,
  `br_trade_license` blob NOT NULL,
  `br_other_per_name_en` varchar(80) NULL,
  `br_other_per_mobile` varchar(14) NULL,
  `br_other_per_designation` varchar(16) NULL,
  `br_other_per_address` varchar(150) NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 2=Suspended, 3=Suspicious, 9=Deleted',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT fk_divId_branch FOREIGN KEY (div_id) REFERENCES division(id),
  CONSTRAINT fk_disId_branch FOREIGN KEY (dis_id) REFERENCES district(id),
  CONSTRAINT fk_psId_branch FOREIGN KEY (ps_id) REFERENCES police_station(id)
);

-- Table structure for table `course`

CREATE TABLE `course` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `discription_en` varchar(255) NOT NULL,
  `discription_bn` varchar(255) NULL,
  `tid` tinyint(1) NOT NULL COMMENT 'type_id',
  `cid` tinyint(1) NOT NULL COMMENT 'category_id',
  `fee` decimal(8,2) NOT NULL,
  `thamnil` blob NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 2=Suspended, 3=Suspicious, 9=Deleted',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT fk_tid_course FOREIGN KEY (tid) REFERENCES course_type(id),
  CONSTRAINT fk_cid_course FOREIGN KEY (cid) REFERENCES course_category(id)
);

-- Table structure for table `course_category`

CREATE TABLE `course_category` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL COMMENT 'online/offline',
  `create_at` timestamp NULL DEFAULT NULL,
  `update_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 2=Suspended, 3=Suspicious, 9=Deleted',
  PRIMARY KEY (`id`)
);

-- Table structure for table `course_type`

CREATE TABLE `course_type` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `name_en` varchar(30) NOT NULL COMMENT 'basic/diploma/ICT/Govt.',
  `name_bn` varchar(30) NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 2=Suspended, 3=Suspicious, 9=Deleted',
  PRIMARY KEY (`id`)
);

-- Table structure for table `division`

CREATE TABLE `division` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `en_name` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bn_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `district`

CREATE TABLE `district` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `en_name` varchar(12) NOT NULL,
  `bn_name` varchar(12) NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `police_station`

CREATE TABLE `police_station` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `ps_name_bn` varchar(20) NOT NULL,
  `ps_name_en` varchar(20) NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `update_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `event`

CREATE TABLE `event` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `date` date NOT NULL,
  `description_en` varchar(255) NOT NULL,
 `description_bn` varchar(255) NULL,
  `photo` blob NOT NULL,
  `create_at` timestamp NULL DEFAULT NULL,
  `update_at` timestamp NULL DEFAULT NULL
  PRIMARY KEY (`id`)
);

-- Table structure for table `exam`

CREATE TABLE `exam` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `exam_name` varchar(40) NOT NULL,
  `cid` tinyint(3) NOT NULL,
  `sid` int(3) NOT NULL,
  `exam_duration` tinyint(1) NOT NULL,
  `total_marks` tinyint(1) NOT NULL,
  `result_id` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT fk_cid_exam FOREIGN KEY (cid) REFERENCES course_category(id),
  CONSTRAINT fk_sid_exam FOREIGN KEY (sid) REFERENCES session(id),
  CONSTRAINT fk_result_id_exam FOREIGN KEY (result_id) REFERENCES result(id)
);

-- Table structure for table `job_type`

CREATE TABLE `job_type` (
  `id` int(1) NOT NULL AUTO_INCREMENT,
  `name` varchar(14) NOT NULL COMMENT 'Govt/Private/Organization',
  PRIMARY KEY (`id`)
);

-- Table structure for table `notice`

CREATE TABLE `notice` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `notice_en` varchar(255) NOT NULL,
  `notice_bn` varchar(255) NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
  PRIMARY KEY (`id`)
);

-- Table structure for table `partner`

CREATE TABLE `partner` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `url` varchar(150) NOT NULL,
  `logo` blob NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
  PRIMARY KEY (`id`)
);

-- Table structure for table `password_reset`

CREATE TABLE `password_reset` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `email` varchar(30) NOT NULL,
  `token` varchar(30) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `placement_info`

CREATE TABLE `placement_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mid` tinyint(2) NOT NULL COMMENT 'ministry_id',
  `position_name` varchar(40) NOT NULL,
  `join_date` date NOT NULL,
  `jt_id` int(1) NOT NULL COMMENT 'join type govt/private/organization',
  PRIMARY KEY (`id`),
  CONSTRAINT fk_jtId_placement_info FOREIGN KEY (jt_id) REFERENCES job_type(id)
);
-- Table structure for table `ministry/divisio`

CREATE TABLE `ministry` (
  `id` tinyint(2) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL COMMENT "Ministry/Division/Depertment name",
  `address_name` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
);


-- Table structure for table `result`

CREATE TABLE `result` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `grade` varchar(2) NOT NULL COMMENT 'A+/A/A-',
  PRIMARY KEY (`id`)
);

-- Table structure for table `session`

CREATE TABLE `session` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `start_month` varchar(10) NOT NULL,
  `start_year` int(4) NOT NULL,
  `end_month` varchar(10) NOT NULL,
  `end_year` int(4) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 9=Deleted',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `student`

CREATE TABLE `student` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `bid` tinyint(3) NOT NULL COMMENT 'branch_id',
  `cid` int(3) NOT NULL COMMENT 'course_id',
  `sid` int(3) NOT NULL COMMENT 'session_id',
  `reg_no` varchar(8) NOT NULL COMMENT 'start from 20000',
  `stu_name_en` varchar(60) NOT NULL,
  `stu_name_bn` varchar(60) NULL,
  `f_name_en` varchar(60) NOT NULL,
  `f_name_bn` varchar(60) NULL,
  `m_name_en` varchar(60) NOT NULL,
  `m_name_bn` varchar(60) NULL,
  `d_o_b` date NOT NULL,
  `mobile` varchar(14) NOT NULL,
  `email` varchar(40) NOT NULL,
  `gender` varchar(7) NOT NULL,
  `pre_address` varchar(80) NOT NULL,
  `div_id` tinyint(1) NOT NULL,
  `dis_id` tinyint(1) NOT NULL,
  `ps_id` tinyint(3) NOT NULL,
  `per_address` varchar(80) NOT NULL,
  `per_div_id` tinyint(1) NOT NULL,
  `per_dis_id` tinyint(1) NOT NULL,
  `per_ps_id` tinyint(3) NOT NULL,
  `edu_qualification` varchar(10) NOT NULL,
  `photo` blob NOT NULL,
  `signature` blob NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 9=Deleted',
  `created_by` int(11) NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT fk_bid_student FOREIGN KEY (bid) REFERENCES branch(id),
  CONSTRAINT fk_cid_student FOREIGN KEY (cid) REFERENCES course(id),
  CONSTRAINT fk_sid_student FOREIGN KEY (sid) REFERENCES session(id),
  CONSTRAINT fk_divId_student FOREIGN KEY (div_id) REFERENCES division(id),
  CONSTRAINT fk_disId_student FOREIGN KEY (dis_id) REFERENCES district(id),
  CONSTRAINT fk_psId_student FOREIGN KEY (ps_id) REFERENCES police_station(id),
  CONSTRAINT fk_perDivId_student FOREIGN KEY (per_div_id) REFERENCES division(id),
  CONSTRAINT fk_perDisId_student FOREIGN KEY (per_dis_id) REFERENCES district(id),
  CONSTRAINT fk_perDsId_student FOREIGN KEY (per_ps_id) REFERENCES police_station(id)
);

-- Table structure for table `teacher`

CREATE TABLE `teacher` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `mobile` varchar(14) NOT NULL,
  `email` varchar(30) NOT NULL,
  `address` varchar(80) NOT NULL,
  `cid` int(3) NOT NULL COMMENT 'course_id',
  `create_at` timestamp NULL DEFAULT NULL,
  `update_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT fk_cid_teacher FOREIGN KEY (cid) REFERENCES course(id)
);
=======
-- Table structure for table `branch`

CREATE TABLE `branch` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  -- COMMENT branch id start with 300 becoz 101 to ... distributed
  `name_bn` varchar(80) NOT NULL,
  `name_en` varchar(80) NOT NULL,
  `br_age` int(3) NOT NULL,
  `br_computer` int(2) NOT NULL,
  `proprietor_name_bn` varchar(80) NOT NULL,
  `proprietor_name_en` varchar(80) NOT NULL,
  `pro_f_name` varchar(80) NOT NULL,
  `pro_m_name` varchar(80) NOT NULL,
  `br_email` varchar(20) NOT NULL,
  `br_mobile` varchar(14) NOT NULL,
  `div_id` varchar(14) NOT NULL COMMENT 'division name',
  `dis_id` varchar(14) NOT NULL COMMENT 'district name',
  `ps_id` varchar(14) NOT NULL COMMENT 'police station',
  `br_address_en` varchar(100) NOT NULL,
  `br_addreess_bn` varchar(100) NOT NULL,
  `br_exprience` tinyint(1) NOT NULL,
  `pro_photo` blob NOT NULL,
  `pro_nid` blob NOT NULL,
  `br_trade_license` blob NOT NULL,
  `br_other_per_name_en` varchar(80) NULL,
  `br_other_per_mobile` varchar(14) NULL,
  `br_other_per_designation` varchar(16) NULL,
  `br_other_per_address` varchar(150) NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 2=Suspended, 3=Suspicious, 9=Deleted',
  `created_at` timestamp NULL DEFAULT,
  `updated_at` timestamp NULL DEFAULT,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_divid_division` FOREIGN KEY (`div_id`) REFERENCES `division` (`id`),
  CONSTRAINT `fk_disid_district` FOREIGN KEY (`dis_id`) REFERENCES `district` (`id`),
  CONSTRAINT `fk_psid_district` FOREIGN KEY (`ps_id`) REFERENCES `police_station` (`id`)
);

-- Table structure for table `course`

CREATE TABLE `course` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `discription_en` varchar(255) NOT NULL,
  `discription_bn` varchar(255) NULL,
  `tid` tinyint(1) NOT NULL COMMENT 'type_id',
  `cid` tinyint(1) NOT NULL COMMENT 'category_id',
  `fee` decimal(8,2) NOT NULL,
  `thamnil` blob NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 2=Suspended, 3=Suspicious, 9=Deleted',
  `created_at` timestamp DEFAULT NULL,
  `updated_at` timestamp DEFAULT NULL
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tid` FOREIGN KEY (`tid`) REFERENCES `course_type` (`id`),
  CONSTRAINT `fk_cid` FOREIGN KEY (`cid`) REFERENCES `course_category` (`id`)
);

-- Table structure for table `course_category`

CREATE TABLE `course_category` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL COMMENT 'online/offline',
  `create_at` timestamp DEFAULT NULL,
  `update_at` timestamp DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 2=Suspended, 3=Suspicious, 9=Deleted',
  PRIMARY KEY (`id`)
);

-- Table structure for table `course_type`

CREATE TABLE `course_type` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `name_en` varchar(30) NOT NULL COMMENT 'basic/diploma/ICT/Govt.',
  `name_bn` varchar(30) NULL,
  `created_at` timestamp DEFAULT NULL,
  `updated_at` timestamp DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 2=Suspended, 3=Suspicious, 9=Deleted',
  PRIMARY KEY (`id`)
);

-- Table structure for table `division`

CREATE TABLE `division` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `en_name` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bn_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp DEFAULT NULL,
  `updated_at` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `districts`

CREATE TABLE `districts` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `en_name` varchar(12) NOT NULL,
  `bn_name` varchar(12) NULL,
  `created_at` timestamp DEFAULT NULL,
  `updated_at` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `police_station`

CREATE TABLE `police_station` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `ps_name_bn` varchar(20) NOT NULL,
  `ps_name_en` varchar(20) NULL,
  `created_at` timestamp DEFAULT NULL,
  `update_at` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `event`

CREATE TABLE `event` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `date` date NOT NULL,
  `description_en` varchar(255) NOT NULL,
 `description_bn` varchar(255) NULL,
  `photo` blob NOT NULL,
  `create_at` timestamp NULL DEFAULT NULL,
  `update_at` timestamp NULL DEFAULT NULL
  PRIMARY KEY (`id`)
);

-- Table structure for table `exam`

CREATE TABLE `exam` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `exam_name` varchar(40) NOT NULL,
  `cid` int(3) NOT NULL,
  `sid` int(3) NOT NULL,
  `exam_duration` tinyint(1) NOT NULL,
  `total_marks` tinyint(1) NOT NULL,
  `result_id` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cid_category` FOREIGN KEY (`cid`) REFERENCES `course_category` (`id`),
  CONSTRAINT `fk_sid_session` FOREIGN KEY (`sid`) REFERENCES `session` (`id`),
  CONSTRAINT `fk_result_id` FOREIGN KEY (`result_id`) REFERENCES `result` (`id`)
);

-- Table structure for table `job_type`

CREATE TABLE `job_type` (
  `id` int(1) NOT NULL AUTO_INCREMENT,
  `name` varchar(14) NOT NULL COMMENT 'Govt/Private/Organization',
  PRIMARY KEY (`id`)
);

-- Table structure for table `notice`

CREATE TABLE `notice` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `notice_en` varchar(255) NOT NULL,
  `notice_bn` varchar(255) NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `partner`

CREATE TABLE `partner` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `url` varchar(150) COLLATE NOT NULL,
  `logo` blob NOT NULL,
  `created_at` timestamp DEFAULT NULL,
  `updated_at` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `password_reset`

CREATE TABLE `password_reset` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `email` varchar(30) NOT NULL,
  `token` varchar(30) NOT NULL,
  `created_at` timestamp DEFAULT NULL,
  `updated_at` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `placement_info`

CREATE TABLE `placement_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(40) NOT NULL,
  `position_name` varchar(40) NOT NULL,
  `join_date` date NOT NULL,
  `jt_id` int(1) NOT NULL COMMENT 'join type govt/private/organization'
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_jt_id` FOREIGN KEY (`jt_id`) REFERENCES `company` (`id`)
);

-- Table structure for table `result`

CREATE TABLE `result` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `grade` varchar(2) NOT NULL COMMENT 'A+/A/A-',
  PRIMARY KEY (`id`)
);

-- Table structure for table `session`

CREATE TABLE `session` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `start_month` varchar(10) NOT NULL,
  `start_year` int(4) NOT NULL,
  `end_month` varchar(10) NOT NULL,
  `end_year` int(4) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 9=Deleted',
  `created_at` timestamp DEFAULT NULL,
  `updated_at` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `student`

CREATE TABLE `student` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `bid` int(8) NOT NULL COMMENT 'branch_id',
  `cid` int(3) NOT NULL COMMENT 'course_id',
  `sid` int(4) NOT NULL COMMENT 'session_id',
  `reg_no` varchar(8) NOT NULL AUTO_INCREMENT COMMENT 'start from 20000',
  `stu_name_en` varchar(60) NOT NULL,
  `stu_name_bn` varchar(60) NULL,
  `f_name_en` varchar(60) NOT NULL,
  `f_name_bn` varchar(60) NULL,
  `m_name_en` varchar(60) NOT NULL,
  `m_name_bn` varchar(60) NULL,
  `d_o_b` date NOT NULL,
  `mobile` varchar(14) NOT NULL,
  `email` varchar(40) NOT NULL,
  `gender` varchar(7) NOT NULL,
  `pre_address` varchar(80) NOT NULL,
  `div_id` varchar(12) NOT NULL,
  `dis-id` varchar(12) NOT NULL,
  `ps_id` varchar(12) NOT NULL,
  `per_address` varchar(80) NOT NULL,
  `per_div_id` varchar(12) NOT NULL,
  `per_dis_id` varchar(12) NOT NULL,
  `per_ps_id` varchar(12) NOT NULL,
  `edu_qualification` varchar(10) NOT NULL,
  `photo` blob NOT NULL,
  `signature` blob NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 9=Deleted',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp DEFAULT NULL,
  `updated_at` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_bid_branch` FOREIGN KEY (`branch_id`) REFERENCES `branch`(`id`),
  CONSTRAINT `fk_cid_course` FOREIGN KEY (`course_id`) REFERENCES `course`(`id`),
  CONSTRAINT `fk_sid_session` FOREIGN KEY (`session_id`) REFERENCES `session`(`id`)
);

-- Table structure for table `teacher`

CREATE TABLE `teacher` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `mobile` varchar(14) NOT NULL,
  `email` varchar(30) NOT NULL,
  `address` varchar(80) NOT NULL,
  `cid` int(3) NOT NULL COMMENT 'course_id',
  `create_at` timestamp NULL DEFAULT NULL,
  `update_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cid_course` FOREIGN KEY (`course_id`) REFERENCES `course`(`id`)
);
>>>>>>> 078fe9f3935552f47b1f666299cf77b6814b94c1
=======
-- Table structure for table `branch`

CREATE TABLE `branch` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  -- COMMENT branch id start with 300 becoz 101 to ... distributed
  `name_bn` varchar(80) NOT NULL,
  `name_en` varchar(80) NOT NULL,
  `br_age` int(3) NOT NULL,
  `br_computer` int(2) NOT NULL,
  `proprietor_name_bn` varchar(80) NOT NULL,
  `proprietor_name_en` varchar(80) NOT NULL,
  `pro_f_name` varchar(80) NOT NULL,
  `pro_m_name` varchar(80) NOT NULL,
  `br_email` varchar(20) NOT NULL,
  `br_mobile` varchar(14) NOT NULL,
  `div_id` varchar(14) NOT NULL COMMENT 'division name',
  `dis_id` varchar(14) NOT NULL COMMENT 'district name',
  `ps_id` varchar(14) NOT NULL COMMENT 'police station',
  `br_address_en` varchar(100) NOT NULL,
  `br_addreess_bn` varchar(100) NOT NULL,
  `br_exprience` tinyint(1) NOT NULL,
  `pro_photo` blob NOT NULL,
  `pro_nid` blob NOT NULL,
  `br_trade_license` blob NOT NULL,
  `br_other_per_name_en` varchar(80) NULL,
  `br_other_per_mobile` varchar(14) NULL,
  `br_other_per_designation` varchar(16) NULL,
  `br_other_per_address` varchar(150) NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 2=Suspended, 3=Suspicious, 9=Deleted',
  `created_at` timestamp NULL DEFAULT,
  `updated_at` timestamp NULL DEFAULT,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_divid_division` FOREIGN KEY (`div_id`) REFERENCES `division` (`id`),
  CONSTRAINT `fk_disid_district` FOREIGN KEY (`dis_id`) REFERENCES `district` (`id`),
  CONSTRAINT `fk_psid_district` FOREIGN KEY (`ps_id`) REFERENCES `police_station` (`id`)
);

-- Table structure for table `course`

CREATE TABLE `course` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `discription_en` varchar(255) NOT NULL,
  `discription_bn` varchar(255) NULL,
  `tid` tinyint(1) NOT NULL COMMENT 'type_id',
  `cid` tinyint(1) NOT NULL COMMENT 'category_id',
  `fee` decimal(8,2) NOT NULL,
  `thamnil` blob NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 2=Suspended, 3=Suspicious, 9=Deleted',
  `created_at` timestamp DEFAULT NULL,
  `updated_at` timestamp DEFAULT NULL
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_tid` FOREIGN KEY (`tid`) REFERENCES `course_type` (`id`),
  CONSTRAINT `fk_cid` FOREIGN KEY (`cid`) REFERENCES `course_category` (`id`)
);

-- Table structure for table `course_category`

CREATE TABLE `course_category` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL COMMENT 'online/offline',
  `create_at` timestamp DEFAULT NULL,
  `update_at` timestamp DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 2=Suspended, 3=Suspicious, 9=Deleted',
  PRIMARY KEY (`id`)
);

-- Table structure for table `course_type`

CREATE TABLE `course_type` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `name_en` varchar(30) NOT NULL COMMENT 'basic/diploma/ICT/Govt.',
  `name_bn` varchar(30) NULL,
  `created_at` timestamp DEFAULT NULL,
  `updated_at` timestamp DEFAULT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 2=Suspended, 3=Suspicious, 9=Deleted',
  PRIMARY KEY (`id`)
);

-- Table structure for table `division`

CREATE TABLE `division` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `en_name` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bn_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp DEFAULT NULL,
  `updated_at` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `districts`

CREATE TABLE `districts` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `en_name` varchar(12) NOT NULL,
  `bn_name` varchar(12) NULL,
  `created_at` timestamp DEFAULT NULL,
  `updated_at` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `police_station`

CREATE TABLE `police_station` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `ps_name_bn` varchar(20) NOT NULL,
  `ps_name_en` varchar(20) NULL,
  `created_at` timestamp DEFAULT NULL,
  `update_at` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `event`

CREATE TABLE `event` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `date` date NOT NULL,
  `description_en` varchar(255) NOT NULL,
 `description_bn` varchar(255) NULL,
  `photo` blob NOT NULL,
  `create_at` timestamp NULL DEFAULT NULL,
  `update_at` timestamp NULL DEFAULT NULL
  PRIMARY KEY (`id`)
);

-- Table structure for table `exam`

CREATE TABLE `exam` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `exam_name` varchar(40) NOT NULL,
  `cid` int(3) NOT NULL,
  `sid` int(3) NOT NULL,
  `exam_duration` tinyint(1) NOT NULL,
  `total_marks` tinyint(1) NOT NULL,
  `result_id` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cid_category` FOREIGN KEY (`cid`) REFERENCES `course_category` (`id`),
  CONSTRAINT `fk_sid_session` FOREIGN KEY (`sid`) REFERENCES `session` (`id`),
  CONSTRAINT `fk_result_id` FOREIGN KEY (`result_id`) REFERENCES `result` (`id`)
);

-- Table structure for table `job_type`

CREATE TABLE `job_type` (
  `id` int(1) NOT NULL AUTO_INCREMENT,
  `name` varchar(14) NOT NULL COMMENT 'Govt/Private/Organization',
  PRIMARY KEY (`id`)
);

-- Table structure for table `notice`

CREATE TABLE `notice` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `notice_en` varchar(255) NOT NULL,
  `notice_bn` varchar(255) NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `partner`

CREATE TABLE `partner` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `url` varchar(150) COLLATE NOT NULL,
  `logo` blob NOT NULL,
  `created_at` timestamp DEFAULT NULL,
  `updated_at` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `password_reset`

CREATE TABLE `password_reset` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `email` varchar(30) NOT NULL,
  `token` varchar(30) NOT NULL,
  `created_at` timestamp DEFAULT NULL,
  `updated_at` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `placement_info`

CREATE TABLE `placement_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(40) NOT NULL,
  `position_name` varchar(40) NOT NULL,
  `join_date` date NOT NULL,
  `jt_id` int(1) NOT NULL COMMENT 'join type govt/private/organization'
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_jt_id` FOREIGN KEY (`jt_id`) REFERENCES `company` (`id`)
);

-- Table structure for table `result`

CREATE TABLE `result` (
  `id` tinyint(1) NOT NULL AUTO_INCREMENT,
  `grade` varchar(2) NOT NULL COMMENT 'A+/A/A-',
  PRIMARY KEY (`id`)
);

-- Table structure for table `session`

CREATE TABLE `session` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `start_month` varchar(10) NOT NULL,
  `start_year` int(4) NOT NULL,
  `end_month` varchar(10) NOT NULL,
  `end_year` int(4) NOT NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 9=Deleted',
  `created_at` timestamp DEFAULT NULL,
  `updated_at` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `student`

CREATE TABLE `student` (
  `id` int(8) NOT NULL AUTO_INCREMENT,
  `bid` int(8) NOT NULL COMMENT 'branch_id',
  `cid` int(3) NOT NULL COMMENT 'course_id',
  `sid` int(4) NOT NULL COMMENT 'session_id',
  `reg_no` varchar(8) NOT NULL AUTO_INCREMENT COMMENT 'start from 20000',
  `stu_name_en` varchar(60) NOT NULL,
  `stu_name_bn` varchar(60) NULL,
  `f_name_en` varchar(60) NOT NULL,
  `f_name_bn` varchar(60) NULL,
  `m_name_en` varchar(60) NOT NULL,
  `m_name_bn` varchar(60) NULL,
  `d_o_b` date NOT NULL,
  `mobile` varchar(14) NOT NULL,
  `email` varchar(40) NOT NULL,
  `gender` varchar(7) NOT NULL,
  `pre_address` varchar(80) NOT NULL,
  `div_id` varchar(12) NOT NULL,
  `dis-id` varchar(12) NOT NULL,
  `ps_id` varchar(12) NOT NULL,
  `per_address` varchar(80) NOT NULL,
  `per_div_id` varchar(12) NOT NULL,
  `per_dis_id` varchar(12) NOT NULL,
  `per_ps_id` varchar(12) NOT NULL,
  `edu_qualification` varchar(10) NOT NULL,
  `photo` blob NOT NULL,
  `signature` blob NULL,
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active, 9=Deleted',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp DEFAULT NULL,
  `updated_at` timestamp DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_bid_branch` FOREIGN KEY (`branch_id`) REFERENCES `branch`(`id`),
  CONSTRAINT `fk_cid_course` FOREIGN KEY (`course_id`) REFERENCES `course`(`id`),
  CONSTRAINT `fk_sid_session` FOREIGN KEY (`session_id`) REFERENCES `session`(`id`)
);

-- Table structure for table `teacher`

CREATE TABLE `teacher` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `mobile` varchar(14) NOT NULL,
  `email` varchar(30) NOT NULL,
  `address` varchar(80) NOT NULL,
  `cid` int(3) NOT NULL COMMENT 'course_id',
  `create_at` timestamp NULL DEFAULT NULL,
  `update_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_cid_course` FOREIGN KEY (`course_id`) REFERENCES `course`(`id`)
);
>>>>>>> 078fe9f3935552f47b1f666299cf77b6814b94c1
