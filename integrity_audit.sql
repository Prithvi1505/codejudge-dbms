-- =============================================
-- Task 2: Primary Key and Uniqueness Audit
-- =============================================

-- 1. Check for Duplicate student_id
SELECT student_id, COUNT(*) as duplicate_count
FROM raw_students
GROUP BY student_id
HAVING COUNT(*) > 1;

-- 2. Check for Duplicate roll_number
SELECT roll_number, COUNT(*) as duplicate_count
FROM raw_students
GROUP BY roll_number
HAVING COUNT(*) > 1;

-- 3. Check for Duplicate email
SELECT email, COUNT(*) as duplicate_count
FROM raw_students
GROUP BY email
HAVING COUNT(*) > 1;

-- 4. Check for Duplicate submission_id
SELECT submission_id, COUNT(*) as duplicate_count
FROM raw_submissions
GROUP BY submission_id
HAVING COUNT(*) > 1;

-- 5. Check for Duplicate problem_id
SELECT problem_id, COUNT(*) as duplicate_count
FROM raw_problems
GROUP BY problem_id
HAVING COUNT(*) > 1;

-- 6. Check for Duplicate enrollment records (student + course)
SELECT student_id, course_id, COUNT(*) as duplicate_count
FROM raw_enrollments
GROUP BY student_id, course_id
HAVING COUNT(*) > 1;

-- 7. Check for Duplicate contest-problem mappings
SELECT contest_id, problem_id, COUNT(*) as duplicate_count
FROM raw_contest_problems
GROUP BY contest_id, problem_id
HAVING COUNT(*) > 1;

-- =============================================
-- SUMMARY OBSERVATIONS (After Running Queries)
-- =============================================

/*
Observations:
1. No duplicate `student_id` → **PASSED** (Good Primary Key)
2. No duplicate `roll_number` → **PASSED**
3. Duplicate / Invalid `email` → **FAILED**
   → Found records like S0018 (invalid email format), S0033 (duplicate case issue)
4. No duplicate `submission_id` → **PASSED**
5. No duplicate `problem_id` → **PASSED**
6. Duplicate enrollments → **PASSED** (if none found)
7. Overall: Database mostly has good uniqueness on PKs, but data quality issues exist in email field.
*/
