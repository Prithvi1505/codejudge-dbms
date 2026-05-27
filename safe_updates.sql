-- =============================================
-- Task 1: Safe UPDATE Operations
-- =============================================

-- Update 1: Fix Typo in enrollment_status
-- BEFORE
SELECT student_id, full_name, enrollment_status 
FROM raw_students 
WHERE enrollment_status = 'actve';

-- SAFE UPDATE
UPDATE raw_students 
SET enrollment_status = 'active' 
WHERE enrollment_status = 'actve' 
  AND student_id = 'S0089';   -- Specific student_id for safety

-- AFTER
SELECT student_id, full_name, enrollment_status 
FROM raw_students 
WHERE student_id = 'S0089';


-- Update 2: Fix Invalid Email
-- BEFORE
SELECT student_id, full_name, email 
FROM raw_students 
WHERE student_id = 'S0018';

-- SAFE UPDATE
UPDATE raw_students 
SET email = 'ravi.patel018@codejudge.edu' 
WHERE student_id = 'S0018';

-- AFTER
SELECT student_id, full_name, email 
FROM raw_students 
WHERE student_id = 'S0018';


-- Update 3: Fix Invalid Batch ID
-- BEFORE
SELECT student_id, batch_id 
FROM raw_students 
WHERE batch_id = 'B999';

-- SAFE UPDATE
UPDATE raw_students 
SET batch_id = 'B001' 
WHERE batch_id = 'B999' 
  AND student_id = 'S0059';

-- AFTER
SELECT student_id, batch_id 
FROM raw_students 
WHERE student_id = 'S0059';


-- Update 4: Reset Invalid Scores
-- BEFORE
SELECT submission_id, score 
FROM raw_submissions 
WHERE score < 0 OR score > 100 
LIMIT 5;

-- SAFE UPDATE
UPDATE raw_submissions 
SET score = 0 
WHERE (score < 0 OR score > 100) 
  AND submission_id LIKE 'SUB00%';   -- Safe condition

-- AFTER
SELECT COUNT(*) AS fixed_scores 
FROM raw_submissions 
WHERE score = 0;
