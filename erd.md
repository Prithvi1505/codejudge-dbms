# Task 6: Entity Relationship Diagram (ERD)

## Text-based ERD (Markdown)

```mermaid
erDiagram
    BATCHES ||--o{ STUDENTS : "has"
    STUDENTS ||--o{ ENROLLMENTS : "enrolls_in"
    COURSES ||--o{ ENROLLMENTS : "has"
    COURSES ||--o{ PROBLEMS : "contains"
    PROBLEMS ||--o{ SUBMISSIONS : "has"
    STUDENTS ||--o{ SUBMISSIONS : "makes"
    CONTESTS ||--o{ CONTEST_PROBLEMS : "includes"
    PROBLEMS ||--o{ CONTEST_PROBLEMS : "belongs_to"
    SUBMISSIONS ||--o{ TEST_RESULTS : "produces"

    BATCHES {
        string batch_id PK
        string batch_code UK
        string program
    }

    STUDENTS {
        string student_id PK
        string roll_number UK
        string full_name
        string email UK
        string batch_id FK
        string enrollment_status
    }

    COURSES {
        string course_id PK
        string course_code UK
        string course_title
    }

    PROBLEMS {
        string problem_id PK
        string problem_code UK
        string title
        string difficulty
        string course_id FK
    }

    SUBMISSIONS {
        string submission_id PK
        string student_id FK
        string problem_id FK
        string contest_id FK
        datetime submission_time
        string verdict
    }
