## Table: User

- id (INT PRIMARY KEY)
- name (VARCHAR(60))
- email (VARCHAR(64) UNIQUE)
- phone_number (VARCHAR(14))
- password (VARCHAR(20))
- avatar_url (VARCHAR(255))
- created_at (DATETIME)
- updated_at (DATETIME)
- access_id (INT, FOREIGN KEY (access_id) REFERENCES Access(id))

## Table Access

- id (INT PRIMARY KEY)
- role (ENUM('superadmin', 'admin', 'branch_owner', 'student'))

## Table: Company

- company_id (INT PRIMARY KEY)
- name (VARCHAR(60))
- address (VARCHAR(255))
- phone_number (VARCHAR(14))
- email (VARCHAR(64))
- website (VARCHAR(255))
- created_at (DATETIME)
- updated_at (DATETIME)

## Table: Division

- division_id (INT PRIMARY KEY)
- name (VARCHAR(60))
- Table: District
- district_id (INT PRIMARY KEY)
- division_id (INT)

## Table: District

- district_id (INT PRIMARY KEY)
- division_id (INT)
- name (VARCHAR(60))
- FOREIGN KEY (division_id) REFERENCES Division(division_id)

## Table: Gallery

- gallery_id (INT PRIMARY KEY)
- name (VARCHAR(60))
- description (TEXT)
- image_url (VARCHAR(255))
- created_at (DATETIME)
- updated_at (DATETIME)

## Table: CMS_Section

- cms_section_id (INT PRIMARY KEY)
- title (VARCHAR(255))
- description (TEXT)
- content_type (ENUM('image', 'video', 'text', 'slide_show'))
- content (TEXT)
- grid (INT)
- created_at (DATETIME)
- updated_at (DATETIME)

## Table: Event

- event_id (INT PRIMARY KEY)
- title (VARCHAR(255))
- description (TEXT)
- date (DATE)
- image_url (VARCHAR(255))
- created_at (DATETIME)
- updated_at (DATETIME)

## Table: NoticeBoard

- notice_id (INT PRIMARY KEY)
- title (VARCHAR(255))
- description (TEXT)
- created_at (DATETIME)
- updated_at (DATETIME)

## Table: Partner

- partner_id (INT PRIMARY KEY)
- name (VARCHAR(255))
- description (TEXT)
- logo_url (VARCHAR(255))
- website_url (VARCHAR(255))
- created_at (DATETIME)
- updated_at (DATETIME)

## Table: PlacementInfo

- placement_info_id (INT PRIMARY KEY)
- student_id (INT)
- company_name (VARCHAR(255))
- position_name (VARCHAR(255))
- join_date (DATE)
- job_title (VARCHAR(255))
- job_type (ENUM('govt', 'others', 'private'))
- location (VARCHAR(255))
- description (TEXT)
- start_date (DATE)
- end_date (DATE)
- created_at (DATETIME)
- updated_at (DATETIME)
- FOREIGN KEY (student_id) REFERENCES User(user_id)

## Table: Branch

- branch_id (INT PRIMARY KEY)
- company_id (INT)
- name (VARCHAR(255))
- address (VARCHAR(255))
- phone_number (VARCHAR(14))
- email (VARCHAR(64))
- website (VARCHAR(255))
- created_at (DATETIME)
- updated_at (DATETIME)
- FOREIGN KEY (company_id) REFERENCES Company(company_id)

## Table: Category

- category_id (INT PRIMARY KEY)
- name (VARCHAR(255))
- description (TEXT)
- created_at (DATETIME)
- updated_at (DATETIME)

## Table: Course

- course_id (INT PRIMARY KEY)
- category_id (INT)
- course_code (VARCHAR(50))
- title (VARCHAR(255))
- slug (VARCHAR(255) UNIQUE)
- description (TEXT)
- thumbnail_url (VARCHAR(255))
- language (VARCHAR(50))
- level (INT)
- duration (INT)
- course_status (ENUM('online', 'offline'))
- visibility (ENUM('public', 'draft'))
- status (ENUM('active', 'inactive'))
- created_at (DATETIME)
- updated_at (DATETIME)
- FOREIGN KEY (category_id) REFERENCES CourseCategory(category_id)

## Table: CoursePrice

- course_price_id (INT PRIMARY KEY)
- course_id (INT)
- price_type (ENUM('regular', 'special'))
- price (DECIMAL(10, 2))
- discount (DECIMAL(10, 2))
- discount_expiry_date (DATE)
- currency (VARCHAR(50))
- start_date (DATE)
- end_date (DATE)
- created_at (DATETIME)
- updated_at (DATETIME)
- FOREIGN KEY (course_id) REFERENCES Course(id)

## Table: Payment

- payment_id (INT PRIMARY KEY)
- student_id (INT)
- course_id (INT)
- amount_paid (DECIMAL(10, 2))
- payment_date (DATETIME)
- payment_method (VARCHAR(50)) -- cash, credit card, etc.
- transaction_number (VARCHAR(255))
- phone_number (VARCHAR(255))
- email (VARCHAR(64))
- due_amount (DECIMAL(10, 2))
- created_at (DATETIME)
- updated_at (DATETIME)
- FOREIGN KEY (student_id) REFERENCES Student(student_id)
- FOREIGN KEY (course_id) REFERENCES Course(course_id)

## Table: CourseSyllabus

- syllabus_id (INT PRIMARY KEY)
- course_id (INT)
- title (VARCHAR(255))
- description (TEXT)
- order (INT)
- created_at (DATETIME)
- updated_at (DATETIME)
- FOREIGN KEY (course_id) REFERENCES Course(id)

## Table: CourseTeacher

- course_teacher_id (INT PRIMARY KEY)
- course_id (INT)
- teacher_id (INT)
- created_at (DATETIME)
- updated_at (DATETIME)
- FOREIGN KEY (course_id) REFERENCES Course(id)
- FOREIGN KEY (teacher_id) REFERENCES Teacher(id)
- CONSTRAINT UC_CourseTeacher UNIQUE (course_id, teacher_id)

## Table: Teacher

- teacher_id (INT PRIMARY KEY)
- name (VARCHAR(60))
- email (VARCHAR(64))
- bio (TEXT)
- avatar_url (VARCHAR(255))
- created_at (DATETIME)
- updated_at (DATETIME)

## Table: CourseReview

- review_id (INT PRIMARY KEY)
- course_id (INT)
- user_id (INT)
- rating (INT)
- comment (TEXT)
- created_at (DATETIME)
- updated_at (DATETIME)
- FOREIGN KEY (course_id) REFERENCES Course(id)
- FOREIGN KEY (user_id) REFERENCES User(id)

## Table: UserEnrollment

- enrollment_id (INT PRIMARY KEY)
- user_id (INT)
- course_id (INT)
- enrollment_date (DATE)
- status (INT)
- created_at (DATETIME)
- updated_at (DATETIME)
- FOREIGN KEY (user_id) REFERENCES User(user_id)
- FOREIGN KEY (course_id) REFERENCES Course(course_id)

## Table: Assignment

- assignment_id (INT PRIMARY KEY)
- title (VARCHAR(255))
- description (TEXT)
- course_id (INT)
- teacher_id (INT)
- student_id (INT)
- created_at (DATETIME)
- updated_at (DATETIME)
- FOREIGN KEY (course_id) REFERENCES Course(course_id)
- FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
- FOREIGN KEY (student_id) REFERENCES Student(student_id)

## Table: Exam

- exam_id (INT PRIMARY KEY)
- title (VARCHAR(255))
- description (TEXT)
- course_id (INT)
- created_at (DATETIME)
- updated_at (DATETIME)
- FOREIGN KEY (course_id) REFERENCES Course(course_id)
- exam_name (VARCHAR(255))
- total_marks (INT)
- passing_marks (INT)
- exam_duration (INT)

## Table: AdmitCard

- admit_card_id (INT PRIMARY KEY)
- student_id (INT)
- course_id (INT)
- fees (DECIMAL(10, 2))
- session (VARCHAR(255))
- created_at (DATETIME)
- updated_at (DATETIME)
- FOREIGN KEY (course_id) REFERENCES Course(course_id)
- FOREIGN KEY (student_id) REFERENCES Student(student_id)
- FOREIGN KEY (session_id) REFERENCES CourseSession(session_id)

## Table: CourseSession

- session_id (INT PRIMARY KEY)
- name (VARCHAR(255))
- start_month (VARCHAR(255))
- end_month (VARCHAR(255))
- year (INT)
- login_id (VARCHAR(255))
- status (ENUM('open', 'closed', 'upcoming'))
- created_at (DATETIME)
- updated_at (DATETIME)
- FOREIGN KEY (course_id) REFERENCES Course(course_id)

## Table: CourseCategory

- category_id (INT PRIMARY KEY)
- category_name (VARCHAR(255))
- created_at (DATETIME)
- updated_at (DATETIME)

## Table: Result

- result_id (INT PRIMARY KEY)
- exam_id (INT)
- student_id (INT)
- marks_obtained (INT)
- created_at (DATETIME)
- updated_at (DATETIME)
- FOREIGN KEY (exam_id) REFERENCES Exam(exam_id)
- FOREIGN KEY (student_id) REFERENCES Student(student_id)

## Table: StudentEnrollmentForm

- enrollment_form_id (INT PRIMARY KEY)
- student_id (INT)
- course_id (INT)
- course_offer_id (INT)
- ledger_id (INT)
- created_at (DATETIME)
- updated_at (DATETIME)
- FOREIGN KEY (student_id) REFERENCES Student(student_id)
- FOREIGN KEY (course_id) REFERENCES Course(course_id)
- FOREIGN KEY (course_offer_id) REFERENCES CourseOffer(course_offer_id)
- FOREIGN KEY (ledger_id) REFERENCES Ledger(ledger_id)

## Table: CourseOffer

- course_offer_id (INT PRIMARY KEY)
- course_id (INT)
- session_id (INT)
- start_date (DATE)
- end_date (DATE)
- price_type (ENUM('regular', 'special'))
- price (DECIMAL(10, 2))
- currency (VARCHAR(50))
- created_at (DATETIME)
- updated_at (DATETIME)
- FOREIGN KEY (course_id) REFERENCES Course(course_id)
- FOREIGN KEY (session_id) REFERENCES CourseSession(session_id)

## Table: Certificate

- certificate_id (INT PRIMARY KEY)
- course_id (INT)
- student_id (INT)
- generation_date (DATE)
- verified (BOOLEAN)
- verification_process (TEXT)
- created_at (DATETIME)
- updated_at (DATETIME)
- FOREIGN KEY (course_id) REFERENCES Course(course_id)
- FOREIGN KEY (student_id) REFERENCES Student(student_id)
