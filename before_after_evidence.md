# Task 6: Before & After Evidence

## Repair 1: Fixed 'actve' typo
- Before: S0089 had `actve`
- After: Changed to `active`

## Repair 2: Fixed Invalid Email
- Before: S0018 had `ravi.no-at-symbol.codejudge.edu`
- After: Corrected to proper email

## Repair 3: Fixed Invalid Batch ID
- Before: S0059 had `B999`
- After: Assigned to `B001`

## Repair 4: Fixed Invalid Scores
- Before: Negative / >100 scores existed
- After: Set to 0

## Repair 5: Made duplicate emails unique
- Before: Duplicate emails present
- After: Emails made unique by appending student_id

**All repairs were done on staging tables only.**
