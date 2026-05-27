-- =============================================
-- Task 2: Safe DELETE Operations
-- =============================================

-- Delete 1: Remove obvious invalid / test records 
-- BEFORE
SELECT submission_id, student_id, verdict 
FROM raw_submissions 
WHERE student_id = 'S9999' OR verdict = 'Test';

-- SAFE DELETE
DELETE FROM raw_submissions 
WHERE student_id = 'S9999' 
   OR (verdict = 'Test' AND submission_time < '2025-01-01');

-- AFTER
SELECT COUNT(*) AS remaining_invalid 
FROM raw_submissions 
WHERE student_id = 'S9999';


-- Delete 2: Remove duplicate enrollment records (if any)
-- BEFORE
SELECT student_id, course_id, COUNT(*) as dup_count
FROM raw_enrollments
GROUP BY student_id, course_id
HAVING COUNT(*) > 1;

-- SAFE DELETE (keep only the earliest enrollment)
DELETE FROM raw_enrollments 
WHERE enrollment_id IN (
    SELECT enrollment_id FROM (
        SELECT enrollment_id,
               ROW_NUMBER() OVER (PARTITION BY student_id, course_id ORDER BY enrolled_on) as rn
        FROM raw_enrollments
    ) t
    WHERE rn > 1
);

-- AFTER
SELECT student_id, course_id, COUNT(*) 
FROM raw_enrollments
GROUP BY student_id, course_id
HAVING COUNT(*) > 1;


-- Explanation:
-- All DELETEs use very specific WHERE conditions or subqueries.
-- We never run DELETE without WHERE clause.
-- Deletions are done only on staging/raw tables.
