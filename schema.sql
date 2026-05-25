-- =============================================
-- CodeJudge Database Schema - Part 1
-- Includes Raw Staging + Clean Relational Schema
-- =============================================

DROP DATABASE IF EXISTS codejudge_db;
CREATE DATABASE codejudge_db;
USE codejudge_db;

-- ========================
-- RAW / STAGING TABLES
-- ========================
-- These will hold the original dirty data from CSVs

CREATE TABLE raw_students (
    student_id TEXT, roll_number TEXT, full_name TEXT, email TEXT, 
    batch_id TEXT, admission_date TEXT, enrollment_status TEXT, 
    graduation_year TEXT
);

CREATE TABLE raw_batches (
    batch_id TEXT, batch_code TEXT, program TEXT, start_date TEXT, 
    end_date TEXT
);

CREATE TABLE raw_submissions (
    submission_id TEXT, student_id TEXT, problem_id TEXT, contest_id TEXT,
    language TEXT, submission_time TEXT, verdict TEXT, score TEXT
);

CREATE TABLE raw_problems (
    problem_id TEXT, problem_code TEXT, title TEXT, difficulty TEXT, course_id TEXT
);

CREATE TABLE raw_courses (
    course_id TEXT, course_code TEXT, course_title TEXT, credit_hours TEXT
);

CREATE TABLE raw_contests (
    contest_id TEXT, contest_name TEXT, start_time TEXT, end_time TEXT
);

-- Add more raw tables as needed (enrollments, attendance, etc.)

-- ========================
-- CLEAN RELATIONAL SCHEMA
-- ========================

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
    difficulty ENUM('Easy', 'Medium', 'Hard'),
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
-- 8.Submissions
CREATE TABLE submissions (
    submission_id VARCHAR(20) PRIMARY KEY,
    student_id VARCHAR(10) NOT NULL,
    problem_id VARCHAR(10) NOT NULL,
    contest_id VARCHAR(10),
    language VARCHAR(20) NOT NULL,
    submission_time DATETIME NOT NULL,
    verdict VARCHAR(50) NOT NULL,
    score INT DEFAULT 0,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (problem_id) REFERENCES problems(problem_id)
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
