-- Task 1: Import Validation & Row Count Check

-- Row counts of all raw tables
SELECT 'raw_students' AS table_name, COUNT(*) AS row_count FROM raw_students
UNION ALL
SELECT 'raw_batches', COUNT(*) FROM raw_batches
UNION ALL
SELECT 'raw_courses', COUNT(*) FROM raw_courses
UNION ALL
SELECT 'raw_problems', COUNT(*) FROM raw_problems
UNION ALL
SELECT 'raw_submissions', COUNT(*) FROM raw_submissions
UNION ALL
SELECT 'raw_contests', COUNT(*) FROM raw_contests
UNION ALL
SELECT 'raw_enrollments', COUNT(*) FROM raw_enrollments
UNION ALL
SELECT 'raw_test_cases', COUNT(*) FROM raw_test_cases
UNION ALL
SELECT 'raw_test_results', COUNT(*) FROM raw_test_results;

-- Check for NULLs in important columns
SELECT 
    COUNT(CASE WHEN email IS NULL OR email = '' THEN 1 END) AS null_or_empty_emails,
    COUNT(CASE WHEN batch_id IS NULL OR batch_id = '' THEN 1 END) AS null_batch_ids,
    COUNT(CASE WHEN full_name IS NULL OR full_name = '' THEN 1 END) AS null_names
FROM raw_students;

-- Distinct PK check
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT student_id) AS unique_student_ids
FROM raw_students;
