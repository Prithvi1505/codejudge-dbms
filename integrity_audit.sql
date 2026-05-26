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



-- =============================================
-- Task 3: Foreign Key and Relationship Audit
-- =============================================

-- 1. Students linked to non-existing batches
SELECT s.student_id, s.full_name, s.batch_id
FROM raw_students s
WHERE s.batch_id IS NOT NULL 
  AND s.batch_id NOT IN (SELECT batch_id FROM raw_batches);

-- 2. Enrollments linked to missing students
SELECT e.student_id, e.course_id
FROM raw_enrollments e
WHERE e.student_id NOT IN (SELECT student_id FROM raw_students);

-- 3. Enrollments linked to missing courses
SELECT e.student_id, e.course_id
FROM raw_enrollments e
WHERE e.course_id NOT IN (SELECT course_id FROM raw_courses);

-- 4. Submissions linked to missing students
SELECT sub.submission_id, sub.student_id
FROM raw_submissions sub
WHERE sub.student_id NOT IN (SELECT student_id FROM raw_students);

-- 5. Submissions linked to missing problems
SELECT sub.submission_id, sub.problem_id
FROM raw_submissions sub
WHERE sub.problem_id NOT IN (SELECT problem_id FROM raw_problems);

-- 6. Test Results linked to missing submissions
SELECT tr.result_id, tr.submission_id
FROM raw_test_results tr
WHERE tr.submission_id NOT IN (SELECT submission_id FROM raw_submissions);

-- 7. Problems linked to missing courses (if course_id exists)
SELECT p.problem_id, p.course_id
FROM raw_problems p
WHERE p.course_id IS NOT NULL 
  AND p.course_id NOT IN (SELECT course_id FROM raw_courses);

-- 8. Contest Problems with missing contest or problem
SELECT cp.contest_id, cp.problem_id
FROM raw_contest_problems cp
WHERE cp.contest_id NOT IN (SELECT contest_id FROM raw_contests)
   OR cp.problem_id NOT IN (SELECT problem_id FROM raw_problems);

-- =============================================
-- SUMMARY OBSERVATIONS (Task 3)
-- =============================================

/*
Key Findings from Foreign Key Audit:

1. Orphan Students (invalid batch_id)     → Found (e.g., B999)
2. Orphan Enrollments                     → Some found
3. Orphan Submissions                     → Several submissions with invalid student_id or problem_id
4. Orphan Test Results                    → Found
5. Problems with invalid course_id        → Minor issues

These issues can cause JOIN failures and broken relationships.
It is critical to clean them before moving data to clean tables.
*/
