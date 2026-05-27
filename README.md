# codejudge-dbms
SQL &amp; DBMS Assignment - CodeJudge Platform
# CodeJudge Database System - Part 1
**Relational Design, Keys & Normalization**

## Assignment Overview
This repository contains the solution for **Part 1** of the SQL & DBMS Assignment.

## Repository Structure
- `schema.sql` → Complete SQL DDL with raw staging + clean schema
- `schema_explanation.md` → Understanding of raw dataset
- `keys_and_relationships.md` → Entities and Relationships
- `keys_and_constraints.md` → Keys and Constraints
- `normalization_notes.md` → Normalization Analysis
- `assumptions.md` → Design Assumptions & Approach
- `erd.md` → Entity Relationship Diagram

## Key Features of My Design
- Proper **Primary Keys**, **Foreign Keys**, and **Constraints**
- **Raw/Staging tables** to handle messy CSV data safely
- Clean relational schema in **3NF**
- Clear documentation for all tasks
---

## Part 2: SQL Query Implementation & Verification [20 Marks]
- `queries.sql` → All 20 SQL queries
- `query_outputs.md` → Sample outputs and validation notes
- `sql_reasoning.md` → Explanations for JOINs, HAVING, Subqueries, etc.

---

## How to Use
1. Run `schema.sql` to create the database.
2. Import data from raw CSVs into staging tables.
3. Run queries from `queries.sql`.


## Part 3: Data Integrity Audit, Debugging & Repair [25 Marks]
- `import_validation.sql`
- `integrity_audit.sql`
- `domain_rule_checks.sql`
- `repair_plan.md`
- `staging_repair_scripts.sql`
- `before_after_evidence.md`

**Key Highlights of Part 3:**
- Performed full data audit (row counts, PK uniqueness, FK integrity, domain rules)
- Identified real issues (invalid emails, wrong batch_id, status typos, etc.)
- Created safe repair scripts on staging tables only
- Provided before/after evidence

---
