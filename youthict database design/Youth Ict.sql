CREATE TABLE `countries` (
  `id` uuid PRIMARY KEY,
  `title` string,
  `code` string,
  `alpha_2` string,
  `alpha_3` string,
  `status` boolean
);

CREATE TABLE `satets` (
  `id` uuid PRIMARY KEY,
  `country_id` uuid,
  `title` string,
  `abbreviation` string,
  `status` boolean
);

CREATE TABLE `city` (
  `id` uuid PRIMARY KEY,
  `country_id` uuid,
  `state_id` uuid,
  `title` string,
  `status` boolean
);

CREATE TABLE `media` (
  `id` uuid PRIMARY KEY,
  `file_name` string,
  `path` string,
  `mime_type` string,
  `disk` string,
  `blur_hash` string,
  `height` string,
  `width` string,
  `size` string,
  `mediable_type` string,
  `mediable_id` string
);

CREATE TABLE `general_informations` (
  `id` uuid PRIMARY KEY,
  `company_nname` string,
  `email` string,
  `phone` string,
  `fax` string,
  `country_id` uuid,
  `state_id` uuid,
  `city_id` uuid,
  `address_line_1` string,
  `address_line_2` string,
  `tin_id` string,
  `bin_id` string,
  `registration_no` string
);

CREATE TABLE `roles` (
  `id` uuid PRIMARY KEY,
  `title` string,
  `status` boolean
);

CREATE TABLE `users` (
  `id` uuid PRIMARY KEY,
  `first_name` string,
  `middle_name` string,
  `last_name` string,
  `role_id` uuid,
  `email` string,
  `phone` string,
  `password` string,
  `otp_code` string
);

CREATE TABLE `user_details` (
  `id` uuid PRIMARY KEY,
  `user_id` uuid,
  `dob` datetime,
  `birth_certificate_no` string,
  `nid` string,
  `fathers_name` string,
  `mothers_name` string,
  `country_id` uuid,
  `state_id` uuid,
  `city_id` uuid,
  `address_line_1` string,
  `address_line_2` string
);

CREATE TABLE `login_details` (
  `id` uuid PRIMARY KEY,
  `user_id` uuid,
  `session_token` string,
  `login_time` string,
  `status` string,
  `logout_time` string
);

CREATE TABLE `placements` (
  `id` uuid PRIMARY KEY,
  `user_id` uuid,
  `institute_title` string,
  `position` string,
  `joining_date` datetime,
  `job_type` ENUM ('government', 'private', 'others')
);

CREATE TABLE `cms_sections` (
  `id` uuid PRIMARY KEY,
  `title` string,
  `keywords` string,
  `description` string,
  `content_type` ENUM ('image', 'video', 'text', 'slid_show'),
  `grid_count` int,
  `grid_side` ENUM ('left', 'middle', 'right'),
  `status` boolean
);

CREATE TABLE `events` (
  `id` uuid PRIMARY KEY,
  `title` string,
  `description` string,
  `event_date` datetime
);

CREATE TABLE `notice_boards` (
  `id` uuid PRIMARY KEY,
  `title` string,
  `description` text,
  `start_date` datetime,
  `end_date` datetime,
  `durations` string,
  `status` boolean
);

CREATE TABLE `course_categories` (
  `id` uuid PRIMARY KEY,
  `title` string,
  `description` string,
  `status` boolean
);

CREATE TABLE `courses` (
  `id` uuid PRIMARY KEY,
  `course_category_id` uuid,
  `title` string,
  `description` longtext,
  `base_price` string,
  `offer_price` string,
  `durations` int,
  `course_type` ENUM ('online', 'offline'),
  `status` boolean
);

CREATE TABLE `course_sessions` (
  `id` uuid PRIMARY KEY,
  `course_id` uuid,
  `title` string,
  `start_date` datetime COMMENT 'Y-M',
  `end_date` datetime COMMENT 'Y-M',
  `status` boolean
);

CREATE TABLE `course_assignments` (
  `id` uuid PRIMARY KEY,
  `course_id` uuid,
  `title` string,
  `description` text,
  `status` boolean,
  `due_date` datetime
);

CREATE TABLE `submitted_assignments` (
  `id` uuid PRIMARY KEY,
  `course_id` uuid,
  `user_id` uuid,
  `submitted_date` datetime
);

ALTER TABLE `countries` ADD FOREIGN KEY (`id`) REFERENCES `satets` (`country_id`);

ALTER TABLE `countries` ADD FOREIGN KEY (`id`) REFERENCES `city` (`country_id`);

ALTER TABLE `satets` ADD FOREIGN KEY (`id`) REFERENCES `city` (`state_id`);

ALTER TABLE `media` ADD FOREIGN KEY (`mediable_id`) REFERENCES `general_informations` (`id`);

ALTER TABLE `users` ADD FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

ALTER TABLE `media` ADD FOREIGN KEY (`mediable_id`) REFERENCES `users` (`id`);

ALTER TABLE `user_details` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `countries` ADD FOREIGN KEY (`id`) REFERENCES `user_details` (`country_id`);

ALTER TABLE `satets` ADD FOREIGN KEY (`id`) REFERENCES `user_details` (`state_id`);

ALTER TABLE `city` ADD FOREIGN KEY (`id`) REFERENCES `user_details` (`city_id`);

ALTER TABLE `login_details` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `placements` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `media` ADD FOREIGN KEY (`mediable_id`) REFERENCES `cms_sections` (`id`);

ALTER TABLE `media` ADD FOREIGN KEY (`mediable_id`) REFERENCES `events` (`id`);

ALTER TABLE `course_categories` ADD FOREIGN KEY (`id`) REFERENCES `courses` (`course_category_id`);

ALTER TABLE `course_sessions` ADD FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`);

ALTER TABLE `course_assignments` ADD FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`);

ALTER TABLE `media` ADD FOREIGN KEY (`mediable_id`) REFERENCES `course_assignments` (`id`);

ALTER TABLE `media` ADD FOREIGN KEY (`mediable_id`) REFERENCES `submitted_assignments` (`id`);
