-- =============================================
-- Task 6: Staging Repair Scripts
-- =============================================

-- Repair 1: Fix Typo in enrollment_status ('actve' → 'active')
-- BEFORE
SELECT student_id, enrollment_status 
FROM raw_students 
WHERE enrollment_status = 'actve';

-- REPAIR
UPDATE raw_students 
SET enrollment_status = 'active' 
WHERE enrollment_status = 'actve';

-- AFTER
SELECT student_id, enrollment_status 
FROM raw_students 
WHERE student_id IN (SELECT student_id FROM raw_students WHERE enrollment_status = 'active' AND student_id LIKE 'S0089%');


-- Repair 2: Fix Invalid Email for S0018
-- BEFORE
SELECT student_id, full_name, email 
FROM raw_students 
WHERE student_id = 'S0018';

-- REPAIR
UPDATE raw_students 
SET email = 'ravi.patel018@codejudge.edu' 
WHERE student_id = 'S0018';

-- AFTER
SELECT student_id, full_name, email 
FROM raw_students 
WHERE student_id = 'S0018';


-- Repair 3: Fix Invalid Batch ID (B999)
-- BEFORE
SELECT student_id, batch_id 
FROM raw_students 
WHERE batch_id = 'B999';

-- REPAIR: Assign default batch (B001) or mark as NULL
UPDATE raw_students 
SET batch_id = 'B001' 
WHERE batch_id = 'B999';

-- AFTER
SELECT student_id, batch_id 
FROM raw_students 
WHERE student_id = 'S0059';


-- Repair 4: Set Negative/Invalid Scores to 0
-- BEFORE
SELECT submission_id, score 
FROM raw_submissions 
WHERE score < 0 OR score > 100;

-- REPAIR
UPDATE raw_submissions 
SET score = 0 
WHERE score < 0 OR score > 100;

-- AFTER
SELECT COUNT(*) AS invalid_scores_fixed 
FROM raw_submissions 
WHERE score = 0 AND submission_id IN (/* add some IDs you fixed */);


-- Repair 5: Remove obvious duplicate emails by making them unique
-- BEFORE
SELECT email, COUNT(*) 
FROM raw_students 
GROUP BY email 
HAVING COUNT(*) > 1;

-- REPAIR (Append student_id to make unique)
UPDATE raw_students 
SET email = CONCAT(SUBSTRING(email, 1, POSITION('@' IN email)-1), 
                   student_id, 
                   SUBSTRING(email, POSITION('@' IN email)))
WHERE email IN (SELECT email FROM raw_students GROUP BY email HAVING COUNT(*) > 1);
