# Task 2: Entities and Relationships

## Main Entities Identified

### 1. **Batches**
- **Why separate table?** Batches represent academic cohorts. Multiple students belong to one batch.
- **Primary Key**: `batch_id`
- **Candidate Keys**: `batch_code`
- **Foreign Keys**: None
- **Important Constraints**: `batch_id` NOT NULL, UNIQUE
- **Relationship**: One-to-Many with Students (1 Batch → Many Students)

### 2. **Students**
- **Why separate table?** Central entity of the system. Contains personal and academic details.
- **Primary Key**: `student_id`
- **Candidate Keys**: `roll_number`, `email`
- **Foreign Keys**: `batch_id` (references Batches)
- **Constraints**: `student_id`, `roll_number`, `full_name`, `email`, `enrollment_status` → NOT NULL
- **Relationship**: Many-to-One with Batches, One-to-Many with Enrollments and Submissions

### 3. **Courses**
- **Why separate table?** Courses are independent academic offerings.
- **Primary Key**: `course_id`
- **Candidate Keys**: `course_code`
- **Foreign Keys**: None
- **Constraints**: `course_id`, `course_code`, `course_title` → NOT NULL

### 4. **Enrollments**
- **Why separate table?** Junction table to handle Many-to-Many relationship between Students and Courses.
- **Primary Key**: `enrollment_id` (or composite: student_id + course_id)
- **Foreign Keys**: `student_id`, `course_id`
- **Constraints**: UNIQUE(student_id, course_id)

### 5. **Problems**
- **Why separate table?** Programming problems are reusable across contests and practice.
- **Primary Key**: `problem_id`
- **Foreign Keys**: `course_id` (if problem belongs to a course)

### 6. **Contests**
- **Why separate table?** Contests are time-bound events.
- **Primary Key**: `contest_id`

### 7. **Contest_Problems** (Mapping Table)
- **Why separate?** Many-to-Many relationship between Contests and Problems.
- **Composite Primary Key**: (`contest_id`, `problem_id`)

### 8. **Submissions**
- **Why separate?** Records every code submission attempt.
- **Primary Key**: `submission_id`
- **Foreign Keys**: `student_id`, `problem_id`, `contest_id` (optional)
- **Constraints**: `submission_id`, `student_id`, `problem_id`, `submission_time` → NOT NULL

### 9. **Test_Results**
- **Why separate?** Detailed outcome for each test case per submission.
- **Foreign Keys**: `submission_id`, `test_case_id`

### Other Entities:
- **Attendance**: Links students to sessions
- **Regrade_Requests**: Links to submissions
- **Plagiarism_Flags**: Links to submissions
- **Operation_Requests**: Administrative table

## Relationship Summary

| Relationship | Type | Example |
|--------------|------|--------|
| Batch - Student | 1:N | One batch has many students |
| Student - Course | M:N | Through Enrollments table |
| Contest - Problem | M:N | Through contest_problems |
| Student - Submission | 1:N | One student makes many submissions |
| Submission - Problem | N:1 | Many submissions for one problem |
| Submission - Test_Result | 1:N | One submission has many test results |
