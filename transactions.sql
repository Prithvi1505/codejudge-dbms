-- =============================================
-- Task 3: Transaction Scenarios
-- =============================================

-- Transaction Scenario 1: Successful Student Submission (COMMIT)
START TRANSACTION;

-- Step 1: Insert a new submission
INSERT INTO raw_submissions (submission_id, student_id, problem_id, language, submission_time, verdict, score)
VALUES ('SUB99999', 'S0001', 'P0001', 'Python', NOW(), 'Accepted', 85);

-- Step 2: Insert corresponding test result
INSERT INTO raw_test_results (submission_id, test_case_id, passed, execution_time)
VALUES ('SUB99999', 'TC001', TRUE, 0.45);

COMMIT;

-- Verification
SELECT * FROM raw_submissions WHERE submission_id = 'SUB99999';


-- Transaction Scenario 2: Failed Operation with ROLLBACK
START TRANSACTION;

-- Try to enroll a student in a non-existing course
INSERT INTO raw_enrollments (student_id, course_id, enrolled_on)
VALUES ('S0001', 'INVALID_COURSE', NOW());

-- Oops! Invalid course → Rollback the entire operation
ROLLBACK;

-- Verification: No changes should be made
SELECT * FROM raw_enrollments WHERE student_id = 'S0001' AND course_id = 'INVALID_COURSE';


-- Transaction Scenario 3: Partial Update with SAVEPOINT
START TRANSACTION;

-- Step 1: Update student email
SAVEPOINT before_email_update;

UPDATE raw_students 
SET email = 'new.email@codejudge.edu' 
WHERE student_id = 'S0001';

-- Step 2: Try something risky
SAVEPOINT before_score_update;

UPDATE raw_submissions 
SET score = 9999 
WHERE student_id = 'S0001';

-- Oops! Invalid score → Rollback to previous savepoint
ROLLBACK TO SAVEPOINT before_score_update;

-- Only email update remains
COMMIT;

-- Final Verification
SELECT student_id, email FROM raw_students WHERE student_id = 'S0001';
