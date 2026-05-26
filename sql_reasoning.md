# Part 2: SQL Reasoning & Explanations

## Explanation Questions

### 1. Explain one query where LEFT JOIN is more appropriate than INNER JOIN.
**Query 7**: "Display all students and their enrollments, including students who are not enrolled in any course."
- I used `LEFT JOIN` because we want to see **all students**, even those who have not enrolled in any course.
- If I used INNER JOIN, students with no enrollments would be completely excluded, which would give incomplete information.

### 2. Explain one query where HAVING is required instead of WHERE.
**Query 13**: "Find students with more than 50 submissions."
- We used `HAVING COUNT(*) > 50` because we need to filter **after grouping** (after calculating the count per student).
- `WHERE` clause cannot be used here because it filters individual rows **before** grouping. HAVING is applied after `GROUP BY`.

### 3. Explain one query where a subquery helped solve the problem.
**Query 16**: "Find students whose average score is greater than the overall average score."
- I used a **subquery** `(SELECT AVG(score) FROM submissions)` to calculate the overall average first.
- This value is then compared with each student's average. A subquery made this comparison clean and efficient.

### 4. Explain one situation where your query output could be misleading if duplicate records exist.
In **Query 6** (Detailed Submissions), if there were duplicate submission records due to dirty data, the same submission might appear multiple times. This could mislead someone into thinking more submissions were made than actually occurred. That's why proper primary keys and data cleaning (in Part 3) are important.

### 5. Explain one edge case you considered while writing any query.
In **Query 2** (Invalid Emails), I considered edge cases like:
- Completely empty email (`email = ''`)
- Email without `@` symbol
- Email with wrong domain
This helps identify real data quality issues present in the raw dataset (e.g., S0018 has invalid email).

---

**Overall Note**: 
All queries are written considering the actual structure and data quality of the provided dataset. I have used appropriate JOIN types, aggregations, and subqueries as per requirement.
