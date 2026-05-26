-- =============================================
-- Part 2: SQL Queries - CodeJudge Platform
-- =============================================

-- Query 1: List all active students
SELECT 
    s.student_id,
    s.full_name,
    s.email,
    b.batch_code AS batch,
    s.admission_date
FROM students s
LEFT JOIN batches b ON s.batch_id = b.batch_id
WHERE s.enrollment_status = 'active'
ORDER BY s.admission_date DESC;

-- Query 2: Find students with missing or invalid email
SELECT student_id, full_name, email, enrollment_status
FROM students
WHERE email IS NULL 
   OR email = '' 
   OR email NOT LIKE '%@%'
   OR email NOT LIKE '%codejudge.edu';

-- Query 3: List all problems with Easy or Medium difficulty
SELECT problem_id, title, difficulty
FROM problems
WHERE difficulty IN ('Easy', 'Medium')
ORDER BY difficulty, title;

-- Query 4: Latest 20 submissions
SELECT submission_id, student_id, problem_id, submission_time, verdict, score
FROM submissions
ORDER BY submission_time DESC
LIMIT 20;

-- Query 5: Submissions where status is not successful
SELECT submission_id, student_id, verdict, score
FROM submissions
WHERE verdict != 'Accepted';

-- Query 6: Submission with student name and problem title
SELECT 
    sub.submission_id,
    s.full_name AS student_name,
    p.title AS problem_title,
    sub.language,
    sub.verdict,
    sub.score,
    sub.submission_time
FROM submissions sub
JOIN students s ON sub.student_id = s.student_id
JOIN problems p ON sub.problem_id = p.problem_id
ORDER BY sub.submission_time DESC;

-- Query 7: All students and their enrollments (including no enrollment)
SELECT 
    s.student_id, s.full_name,
    e.course_id,
    c.course_title,
    e.enrolled_on
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id;

-- Query 8: Courses with number of enrolled students
SELECT 
    c.course_id,
    c.course_title,
    COUNT(e.student_id) AS enrolled_students
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_title
ORDER BY enrolled_students DESC;

-- Query 9: Test case results with student and problem
SELECT 
    tr.submission_id,
    s.full_name,
    p.title AS problem_title,
    tr.passed,
    tr.execution_time
FROM test_results tr
JOIN submissions sub ON tr.submission_id = sub.submission_id
JOIN students s ON sub.student_id = s.student_id
JOIN problems p ON sub.problem_id = p.problem_id;

-- Query 10: Students enrolled but no submissions in that course
SELECT DISTINCT 
    s.student_id, s.full_name, c.course_title
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE NOT EXISTS (
    SELECT 1 FROM submissions sub 
    WHERE sub.student_id = s.student_id 
);

-- Query 11: Count submissions by status
SELECT verdict, COUNT(*) AS submission_count
FROM submissions
GROUP BY verdict
ORDER BY submission_count DESC;

-- Query 12: Average score per problem
SELECT 
    p.title,
    AVG(sub.score) AS average_score,
    COUNT(sub.submission_id) AS total_attempts
FROM submissions sub
JOIN problems p ON sub.problem_id = p.problem_id
GROUP BY p.problem_id, p.title
ORDER BY average_score DESC;

-- Query 13: Students with more than 50 submissions
SELECT 
    s.student_id, s.full_name, COUNT(*) AS total_submissions
FROM submissions sub
JOIN students s ON sub.student_id = s.student_id
GROUP BY s.student_id, s.full_name
HAVING COUNT(*) > 50
ORDER BY total_submissions DESC;

-- Query 14: Problems with success rate below 40%
SELECT 
    p.title,
    COUNT(CASE WHEN sub.verdict = 'Accepted' THEN 1 END) * 100.0 / COUNT(*) AS success_rate
FROM submissions sub
JOIN problems p ON sub.problem_id = p.problem_id
GROUP BY p.problem_id, p.title
HAVING success_rate < 40;

-- Query 15: Top 10 most attempted problems
SELECT 
    p.title,
    COUNT(*) AS attempts
FROM submissions sub
JOIN problems p ON sub.problem_id = p.problem_id
GROUP BY p.problem_id, p.title
ORDER BY attempts DESC
LIMIT 10;

-- Query 16: Students with above average score
SELECT 
    s.full_name,
    AVG(sub.score) AS student_avg
FROM submissions sub
JOIN students s ON sub.student_id = s.student_id
GROUP BY s.student_id, s.full_name
HAVING AVG(sub.score) > (SELECT AVG(score) FROM submissions);

-- Query 17: Problems never attempted
SELECT problem_id, title
FROM problems p
WHERE NOT EXISTS (SELECT 1 FROM submissions WHERE problem_id = p.problem_id);

-- Query 18: Students enrolled but never submitted
SELECT s.student_id, s.full_name
FROM students s
WHERE EXISTS (SELECT 1 FROM enrollments WHERE student_id = s.student_id)
  AND NOT EXISTS (SELECT 1 FROM submissions WHERE student_id = s.student_id);

-- Query 19: Students who submitted in both Python and Java
SELECT s.student_id, s.full_name
FROM students s
WHERE EXISTS (SELECT 1 FROM submissions WHERE student_id = s.student_id AND language = 'Python')
  AND EXISTS (SELECT 1 FROM submissions WHERE student_id = s.student_id AND language = 'Java');

-- Query 20: Second highest score for a problem (Example: Problem P0001)
SELECT MAX(score) AS second_highest_score
FROM submissions
WHERE problem_id = 'P0001'
  AND score < (SELECT MAX(score) FROM submissions WHERE problem_id = 'P0001');
