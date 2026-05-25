# Task 3: Keys and Constraints

## Primary Keys, Candidate Keys, and Constraints

### 1. Batches Table
- **Primary Key**: `batch_id` (e.g., B001, B002)
- **Candidate Keys**: `batch_code`
- **Constraints**:
  - `batch_id` → NOT NULL, UNIQUE
  - `batch_code` → NOT NULL, UNIQUE
  - `program` → NOT NULL

### 2. Students Table
- **Primary Key**: `student_id` (e.g., S0001)
- **Candidate Keys**: `roll_number`, `email`
- **Alternate Key**: `roll_number`
- **Foreign Key**: `batch_id` REFERENCES batches(batch_id)
- **Constraints**:
  - `student_id`, `roll_number`, `full_name`, `email`, `admission_date`, `enrollment_status` → NOT NULL
  - `email` → UNIQUE
  - `enrollment_status` → CHECK (value IN ('active', 'inactive', 'graduated', 'dropped'))

### 3. Courses Table
- **Primary Key**: `course_id`
- **Candidate Keys**: `course_code`
- **Constraints**:
  - `course_id`, `course_code`, `course_title` → NOT NULL
  - `credit_hours` → CHECK (credit_hours BETWEEN 1 AND 6)

### 4. Enrollments Table
- **Primary Key**: `enrollment_id` (Auto-increment)
- **Composite Candidate Key**: (`student_id`, `course_id`)
- **Foreign Keys**:
  - `student_id` REFERENCES students(student_id)
  - `course_id` REFERENCES courses(course_id)
- **Constraints**:
  - UNIQUE(`student_id`, `course_id`)  -- Prevents duplicate enrollment
  - `enrolled_on` → NOT NULL

### 5. Problems Table
- **Primary Key**: `problem_id`
- **Foreign Key**: `course_id` (if applicable)
- **Constraints**: `problem_id`, `title` → NOT NULL

### 6. Submissions Table
- **Primary Key**: `submission_id`
- **Foreign Keys**:
  - `student_id` REFERENCES students(student_id)
  - `problem_id` REFERENCES problems(problem_id)
  - `contest_id` REFERENCES contests(contest_id)  (optional)
- **Constraints**:
  - `submission_id`, `student_id`, `problem_id`, `submission_time` → NOT NULL
  - `verdict` → CHECK (value IN ('Accepted', 'Wrong Answer', 'Runtime Error', etc.))

### 7. Contest_Problems Table (Mapping)
- **Composite Primary Key**: (`contest_id`, `problem_id`)
- **Foreign Keys**: `contest_id`, `problem_id`

### Justification (Why these keys/constraints?)
- **Primary Keys** ensure every record can be uniquely identified.
- **Foreign Keys** maintain referential integrity (no orphan submissions).
- **UNIQUE constraints** prevent duplicate emails, roll numbers, enrollments.
- **CHECK constraints** ensure data quality (valid status values, reasonable credit hours).
- **NOT NULL** on critical fields prevents incomplete records.
