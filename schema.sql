-- =============================================
-- CodeJudge Database Schema - Part 1
-- Relational Design, Keys & Normalization
-- =============================================

DROP DATABASE IF EXISTS codejudge_db;
CREATE DATABASE codejudge_db;
USE codejudge_db;

-- 1. Batches
CREATE TABLE batches (
    batch_id VARCHAR(10) PRIMARY KEY,
    batch_code VARCHAR(20) UNIQUE NOT NULL,
    program VARCHAR(50) NOT NULL,
    start_date DATE,
    end_date DATE,
    batch_status ENUM('active', 'completed', 'upcoming') DEFAULT 'active'
);

-- 2. Students
CREATE TABLE students (
    student_id VARCHAR(10) PRIMARY KEY,
    roll_number VARCHAR(20) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    batch_id VARCHAR(10),
    admission_date DATE NOT NULL,
    enrollment_status ENUM('active', 'inactive', 'graduated', 'dropped') NOT NULL,
    graduation_year YEAR,
    FOREIGN KEY (batch_id) REFERENCES batches(batch_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- 3. Courses
CREATE TABLE courses (
    course_id VARCHAR(10) PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_title VARCHAR(100) NOT NULL,
    credit_hours INT CHECK (credit_hours BETWEEN 1 AND 6),
    course_status ENUM('active', 'archived') DEFAULT 'active'
);

-- 4. Enrollments (Junction Table)
CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id VARCHAR(10) NOT NULL,
    course_id VARCHAR(10) NOT NULL,
    enrolled_on DATE NOT NULL,
    enrollment_status ENUM('enrolled', 'completed', 'dropped') DEFAULT 'enrolled',
    final_grade DECIMAL(5,2) CHECK (final_grade BETWEEN 0 AND 100),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE RESTRICT,
    UNIQUE KEY unique_enrollment (student_id, course_id)
);

-- 5. Problems
CREATE TABLE problems (
    problem_id VARCHAR(10) PRIMARY KEY,
    problem_code VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(200) NOT NULL,
    difficulty ENUM('Easy', 'Medium', 'Hard') NOT NULL,
    course_id VARCHAR(10),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- 6. Contests
CREATE TABLE contests (
    contest_id VARCHAR(10) PRIMARY KEY,
    contest_name VARCHAR(100) NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    contest_status ENUM('upcoming', 'ongoing', 'completed') DEFAULT 'upcoming'
);

-- 7. Contest Problems (Mapping)
CREATE TABLE contest_problems (
    contest_id VARCHAR(10) NOT NULL,
    problem_id VARCHAR(10) NOT NULL,
    PRIMARY KEY (contest_id, problem_id),
    FOREIGN KEY (contest_id) REFERENCES contests(contest_id),
    FOREIGN KEY (problem_id) REFERENCES problems(problem_id)
);

-- 8. Submissions
CREATE TABLE submissions (
    submission_id VARCHAR(20) PRIMARY KEY,
    student_id VARCHAR(10) NOT NULL,
    problem_id VARCHAR(10) NOT NULL,
    contest_id VARCHAR(10),
    language VARCHAR(20) NOT NULL,
    submission_time DATETIME NOT NULL,
    verdict ENUM('Accepted', 'Wrong Answer', 'Runtime Error', 'Time Limit Exceeded', 
                'Compilation Error', 'Memory Limit Exceeded') NOT NULL,
    score INT DEFAULT 0,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (problem_id) REFERENCES problems(problem_id),
    FOREIGN KEY (contest_id) REFERENCES contests(contest_id)
);

-- 9. Test Cases
CREATE TABLE test_cases (
    test_case_id VARCHAR(15) PRIMARY KEY,
    problem_id VARCHAR(10) NOT NULL,
    input TEXT,
    expected_output TEXT,
    is_hidden BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (problem_id) REFERENCES problems(problem_id)
);

-- 10. Test Results
CREATE TABLE test_results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    submission_id VARCHAR(20) NOT NULL,
    test_case_id VARCHAR(15) NOT NULL,
    passed BOOLEAN NOT NULL,
    execution_time DECIMAL(8,3),
    FOREIGN KEY (submission_id) REFERENCES submissions(submission_id),
    FOREIGN KEY (test_case_id) REFERENCES test_cases(test_case_id)
);

-- Additional tables (Attendance, Regrade, etc.) can be added similarly
