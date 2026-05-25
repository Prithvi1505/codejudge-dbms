# Task 5: Assumptions and Design Decisions

## Important Note on Raw Data
As mentioned in the assignment, the raw CSV files contain inconsistent and dirty data (e.g., invalid emails, typos like "actve", missing values, wrong batch_id like B999, duplicate-like records, etc.).

## Approach Used
- First, data is loaded into **raw/staging tables** (using the provided `codejudge_raw.db` or by creating raw tables).
- Then, data is cleaned and inserted into the **clean relational schema** (the one in `schema.sql`).

## Key Assumptions Made

1. **Data Types & Lengths**:
   - `student_id`, `problem_id`, `contest_id` etc. are treated as VARCHAR(10) ~ VARCHAR(20) based on sample data.

2. **Primary Keys**:
   - `student_id`, `submission_id`, `problem_id` etc. are assumed to be unique and stable identifiers.

3. **Email**:
   - Assumed to be unique. Even though raw data has some invalid emails (e.g., missing @ symbol), we enforce UNIQUE constraint in clean schema.

4. **Status Fields**:
   - Used ENUM types with common values seen in data (`active`, `inactive`, `graduated`, `dropped`, etc.).

5. **Referential Integrity**:
   - Some submissions may have invalid `student_id` or `problem_id` in raw data. In production, we would clean them first before inserting.

6. **Staging Tables Strategy**:
   - We will create raw tables with all columns as TEXT to import dirty data safely.
   - Then use INSERT...SELECT with cleaning logic to move data into clean tables.

