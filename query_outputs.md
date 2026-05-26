# Part 2: Query Outputs & Validation Notes

## Query 1: Active Students
**Purpose**: List all currently active students.  
**Sample Result**: Returns ~70-80 students with status 'active'.  
**Validation**: Correct because many students have `enrollment_status = 'active'`. LEFT JOIN ensures we don't lose students with missing batch info.

## Query 2: Invalid/Missing Emails
**Purpose**: Find data quality issues.  
**Sample Result**: Returns students like S0018 (email without @ symbol).  
**Validation**: Matches real issues in the raw dataset.

## Query 3: Easy/Medium Problems
**Purpose**: Filter problems by difficulty.  
**Validation**: Works as expected based on `difficulty` column.

## Query 4: Latest 20 Submissions
**Purpose**: Show recent activity.  
**Validation**: Ordered correctly by `submission_time DESC`.

## Query 5: Non-Successful Submissions
**Purpose**: Identify failed attempts.  
**Validation**: Returns high number of 'Wrong Answer', 'Runtime Error', etc.

## Query 6: Detailed Submissions with Names
**Purpose**: Join student and problem info.  
**Validation**: INNER JOIN is suitable here as we only want submissions with valid student and problem.

## Query 7: Students with Enrollments (LEFT JOIN)
**Purpose**: Show all students including those not enrolled.  
**Validation**: LEFT JOIN is used correctly to include students with no enrollments.

## Query 8: Course Enrollment Count
**Purpose**: Aggregation with GROUP BY.  
**Validation**: Shows popular courses.

## Query 9: Test Results with Details
**Purpose**: Multi-table join.  
**Validation**: Good for debugging test case failures.

## Query 10: Enrolled but No Submissions
**Purpose**: Uses NOT EXISTS subquery.  
**Validation**: Identifies inactive students.

## Query 11-20: (Summary)
- Aggregation queries (11-15) use GROUP BY + HAVING correctly.
- Subqueries (16-20) are used for complex conditions.
- All queries run on the actual dataset without errors.

**Overall Validation**: All queries were tested on the `codejudge_raw.db` and produce logical results matching the dataset.
