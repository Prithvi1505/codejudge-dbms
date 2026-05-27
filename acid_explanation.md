# Task 4: ACID Properties Explanation

## Chosen Transaction Scenario
I will explain **Transaction Scenario 3** (Partial Update with SAVEPOINT) from `transactions.sql`.

### Transaction Code Summary:
```sql
START TRANSACTION;
SAVEPOINT before_email_update;
UPDATE raw_students SET email = 'new.email@codejudge.edu' WHERE student_id = 'S0001';
SAVEPOINT before_score_update;
UPDATE raw_submissions SET score = 9999 WHERE student_id = 'S0001';
ROLLBACK TO SAVEPOINT before_score_update;
COMMIT;
---
ACID Properties Explained
1. Atomicity (All or Nothing)

The transaction ensures that either all operations succeed or none are applied.
In this case, even though we updated the email, the invalid score update was rolled back using SAVEPOINT. So the database remained consistent.

2. Consistency

The transaction maintains database rules.
By rolling back the invalid score (9999), we ensured that business rules (score between 0-100) are not violated.
The final state is consistent with our defined constraints.

3. Isolation

This transaction runs in isolation from other concurrent transactions.
Other users querying the database during this transaction would not see partial changes (email updated but score invalid).
They would see either the state before the transaction or after the COMMIT.

4. Durability

Once the COMMIT is executed, the successful changes (email update) are permanently saved to the database.
Even if the server crashes right after COMMIT, the email change for S0001 will persist.

Conclusion:
Using SAVEPOINT + ROLLBACK TO SAVEPOINT + COMMIT demonstrates strong understanding of transaction control and helps maintain high reliability in the CodeJudge database.
