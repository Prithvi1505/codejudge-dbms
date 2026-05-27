# Task 5: Repair Plan

## Overall Repair Strategy
We will **not modify original raw CSVs**. Instead, we will:
1. Work on staging/raw tables.
2. Create clean tables.
3. Apply corrections using UPDATE, INSERT, and DELETE on staging tables.
4. Move cleaned data into final relational schema.

## Specific Repair Actions with Examples

### 1. Invalid Emails (High Priority)
- **Issue**: Students like S0018 have invalid email (`ravi.no-at-symbol.codejudge.edu`)
- **Action**: Correct obvious typos or mark as `NULL` for manual review.
- **Example**: Update S0018 email to proper format or set to NULL.

### 2. Invalid Batch IDs (e.g., B999)
- **Issue**: Student S0059 has `batch_id = 'B999'` which doesn't exist.
- **Action**: Move such students to a `rejected_students` table or assign default batch.
- **Decision**: Set to a valid batch or mark as `suspended`.

### 3. Typos in Status Fields
- **Issue**: `enrollment_status = 'actve'` (should be 'active')
- **Action**: UPDATE using string replacement or mapping.
- **Example**: S0089 has typo 'actve'.

### 4. Duplicate / Invalid Emails
- **Issue**: Multiple students sharing similar emails.
- **Action**: Append student_id to email to make unique (e.g., vivaan.gupta001@...).

### 5. Orphan Submissions (missing student_id or problem_id)
- **Action**: Move to `rejected_submissions` table for manual review.

### 6. Negative or Unrealistic Scores
- **Action**: Set score = 0 where score < 0 or score > 100.

### 7. Date Inconsistencies
- **Action**: For submissions before admission date → correct timestamp or reject.

### 8. Missing Mandatory Fields
- **Action**: Fill with default values (e.g., 'Unknown') or reject record.

## Repair Priority
- High: Emails, Primary Key issues, Foreign Key orphans
- Medium: Status typos, invalid values
- Low: Minor formatting

**Final Decision Rule**: If correction is obvious and safe → UPDATE. If uncertain → move to rejected table.
