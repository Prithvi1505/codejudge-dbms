# Task 1: Schema Understanding - CodeJudge Database

# Introduction
CodeJudge is an online coding practice and evaluation platform. The raw dataset contains multiple CSV files exported from the system. These files represent different aspects of the platform like students, courses, submissions, contests, etc. The data is in raw form and contains some inconsistencies.

# List of All Tables/Files and Their Purpose

# 1. batches.csv
- Represents: Academic batches or cohorts (e.g., 2025 Spring Batch).
- Key Columns:
  - `batch_id`: Unique identifier for batch (e.g., B001)
  - `batch_code', `program`, `start_date`, `end_date`
- Purpose: Groups students who joined together.

# 2. students.csv
- Represents: All students registered on the platform.
- Key Columns:
  - `student_id` (Primary candidate)
  - `roll_number`, `full_name`, `email`, `batch_id`, `admission_date`
  - `enrollment_status` (active, inactive, graduated, dropped)
- Purpose: Core user entity.

# 3. courses.csv
- Represents: Academic courses offered by the department.
- Key Columns: `course_id`, `course_code`, `course_title`, `credit_hours`

# 4. enrollments.csv
- Represents: Students enrolled in specific courses.
- Key Columns: `enrollment_id`, `student_id`, `course_id`, `enrolled_on`, `final_grade`

# 5. problems.csv
- Represents: Programming problems available for practice/contests.
- Key Columns: `problem_id`, `problem_code`, `title`, `difficulty`, `course_id` (probably)

# 6. test_cases.csv
- Represents: Test cases for each programming problem.
- Purpose: Used to evaluate student submissions.

# 7. contests.csv
- Represents: Coding contests organized on the platform.

# 8. contest_problems.csv
- Represents: Many-to-many relationship between contests and problems.

# 9. submissions.csv
- Represents: Code submissions made by students.
- Key Columns: `submission_id`, `student_id`, `problem_id`, `contest_id`, `language`, `submission_time`, `verdict` (Accepted, Wrong Answer, etc.), `score`

# 10. test_results.csv
- Represents: Detailed results of each test case for a submission.

# 11. sessions.csv
- Represents: Student login/practice sessions.

# 12. attendance.csv
- Represents: Attendance records for classes/sessions.

# 13. regrade_requests.csv
- Represents: Requests by students to re-evaluate their submissions.

# 14. plagiarism_flags.csv
- Represents: Cases where plagiarism was detected in submissions.

# 15. operation_requests.csv
- Represents: Administrative operation requests.

### 16. raw_student_import.csv
- Temporary/raw import data.

## Relationships Between Tables (How they connect)

- `students.batch_id` → `batches.batch_id` (One batch has many students)
- `enrollments.student_id` → `students.student_id`
- `enrollments.course_id` → `courses.course_id`
- `submissions.student_id` → `students.student_id`
- `submissions.problem_id` → `problems.problem_id`
- `contest_problems.contest_id` → `contests.contest_id`
- `contest_problems.problem_id` → `problems.problem_id`

# Observations from Raw Data
- Data is **denormalized** (repeating student names in submissions, etc.)
- Some data quality issues exist (invalid emails, typos like "actve", missing values)
- Same student might appear with slight variations.
