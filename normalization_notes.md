# Task 4: Normalization Reasoning

## Analysis of Raw Data Issues

### 1. Examples of Redundancy / Repeated Data in Raw CSVs
- Student names (`full_name`), roll numbers, and emails are repeated in `submissions.csv`, `attendance.csv`, `regrade_requests.csv`, etc.
- Batch information (program, start_date) is likely repeated if stored directly in students table.
- Problem titles and difficulty levels are repeated across multiple submissions.

### 2. Examples Where Separating Tables Improves Design
- **Students vs Submissions**: Instead of repeating student details in every submission, we link via `student_id`. This reduces redundancy and update anomalies (e.g., if a student changes name, only one place needs update).
- **Courses vs Enrollments**: Separating enrollment data prevents repeating course_title and credit_hours for every student enrolled in the same course.

### 3. Functional Dependencies Observed
- `student_id` → `full_name`, `email`, `batch_id`, `enrollment_status` (Full functional dependency)
- `problem_id` → `title`, `difficulty`, `course_id`
- Partial dependency example in raw data: In submissions, `student_id` + `problem_id` might determine some fields, but separating into proper tables removes this.

### 4. Normalization Level of My Design
- **1NF**: Achieved — All attributes are atomic (no multi-valued fields).
- **2NF**: Achieved — No partial dependency (All non-key attributes fully depend on the entire primary key).
- **3NF**: Mostly Achieved — No transitive dependencies (e.g., student details are not dependent on batch through another attribute). Minor trade-offs kept for performance.

### Trade-offs in My Design
- I have not gone to BCNF/4NF as it would make the database too complex for this platform.
- Some CHECK constraints and ENUMs are used for data integrity.
- Denormalization may be done later for reporting queries (e.g., storing computed scores), but currently we prioritize normalization.

This design removes most redundancy while keeping the system practical and performant.
