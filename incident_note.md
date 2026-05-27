# Task 5: Reliability Incident Note

## Incident: Accidental Mass Update Without WHERE Clause

**What Happened:**
A developer was trying to fix email typos and accidentally ran the following command:
```sql
UPDATE raw_students SET email = 'fixed@codejudge.edu';

without any WHERE clause.
Impact:

All student emails in the database would have been overwritten with the same email.
This would break login systems, communication, uniqueness constraints, and cause massive data corruption.
Over 100+ student records would be affected.

How It Could Be Detected:

Sudden spike in duplicate email errors.
Students complaining they are not receiving emails.
Row count of distinct emails dropping to 1.

How Transactions / Rollback Could Help:

If the operation was wrapped in a START TRANSACTION, the developer could immediately run ROLLBACK; to undo the damage.
Using SAVEPOINT before risky operations would allow partial recovery.

Preventive Measures:

Always test UPDATE/DELETE on a small subset first (LIMIT 5 or specific student_id).
Always include a WHERE clause.
Use transactions (START TRANSACTION + COMMIT / ROLLBACK).
Work only on staging/raw tables, never on production/clean tables.
Create regular backups before running DML statements.
Use safe patterns like:SQLSTART TRANSACTION;
UPDATE ... WHERE student_id = 'Sxxxx';
-- Verify with SELECT
COMMIT;

Lesson Learned:
In a real system like CodeJudge, such a mistake could disrupt hundreds of students’ academic records. Proper transaction handling and caution with DML commands are critical for database reliability.
