-- =============================================
-- Task 4: Domain and Rule Validation
-- =============================================

-- 1. Invalid Scores (negative or too high)
SELECT submission_id, score 
FROM raw_submissions 
WHERE score < 0 OR score > 100;

-- 2. Invalid Enrollment Status
SELECT student_id, enrollment_status 
FROM raw_students 
WHERE enrollment_status NOT IN ('active', 'inactive', 'graduated', 'dropped');

-- 3. Invalid Email Format
SELECT student_id, full_name, email 
FROM raw_students 
WHERE email NOT LIKE '%@%' 
   OR email LIKE '%@%@%';

-- 4. Invalid Difficulty Levels
SELECT problem_id, difficulty 
FROM raw_problems 
WHERE difficulty NOT IN ('Easy', 'Medium', 'Hard');

-- 5. Date Issues - End time before Start time in contests
SELECT contest_id, start_time, end_time 
FROM raw_contests 
WHERE end_time < start_time;

-- 6. Submission before Admission Date
SELECT sub.submission_id, s.student_id, s.admission_date, sub.submission_time
FROM raw_submissions sub
JOIN raw_students s ON sub.student_id = s.student_id
WHERE sub.submission_time < s.admission_date;

-- 7. Invalid Verdict Values
SELECT DISTINCT verdict 
FROM raw_submissions;

-- 8. NULL in Mandatory Columns
SELECT 
    COUNT(CASE WHEN full_name IS NULL OR full_name = '' THEN 1 END) AS null_full_name,
    COUNT(CASE WHEN admission_date IS NULL THEN 1 END) AS null_admission_date,
    COUNT(CASE WHEN submission_time IS NULL THEN 1 END) AS null_submission_time
FROM raw_students, raw_submissions;

-- =============================================
-- SUMMARY OBSERVATIONS (Task 4)
-- =============================================

/*
Major Issues Found:
1. Invalid emails (missing @) → High impact on communication
2. Students with invalid batch_id (B999) → Data quality issue
3. Some negative or unrealistic scores
4. Typos in status (e.g., 'actve' instead of 'active')
5. Date inconsistencies (submission before admission)

These violate domain rules and must be cleaned.
*/
