# Library Management System (SQL Schema)

## Project Overview
This project implements a SQL-based Library Management System that manages the following key entities:
- Users (Library staff, readers)
- Books (including authors and publishers)
- Book issue/return tracking
- Fines and system-wide settings

The system is designed to handle the basic functionality of a library, such as user registration, book management, book issuing, returns, and fine calculation.

## Database Schema

The following tables are implemented in this system:
1. **user_login**: Stores user login information, including their personal details.
2. **publisher**: Holds information about publishers and their releases.
3. **author**: Stores author details and publication count.
4. **books**: Contains book information, including author, publisher, availability, and version details.
5. **staff**: Records information about library staff and their work shifts.
6. **readers**: Tracks library readers, books issued to them, and their fines.
7. **books_issue**: Manages the issuing and returning of books, along with fine details.
8. **settings**: Holds system-wide settings for book issue limits, fine rates, and return periods.

## Basic Features

### 1. User Management
- Users (staff, readers) can be added with personal and login details.
  
### 2. Book Management
- Information about books, their authors, publishers, and versions are stored in the system.
- Books can be made available or unavailable for issue.

### 3. Book Issue and Return
- Books can be issued to readers and their return date is tracked.
- Automated fine calculation based on the delay in return is implemented.

### 4. Fine Calculation
- Fines are calculated based on the number of overdue days and system settings.
- Readers can be charged for overdue books, and the fines can be paid and recorded.

### 5. System Settings
- System administrators can manage global settings such as:
  - Maximum number of books a reader can issue.
  - Fine per day for overdue books.
  - Standard book return period (in days).

## Database Queries Implemented

### 1. Issue a Book
```sql
INSERT INTO books_issue (book_id, issued_to, issued_on, return_on)
VALUES ('book1', 'reader1', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY));

UPDATE readers
SET books_issued_current = books_issued_current + 1
WHERE reader_id = 'reader1';
```
### 2. Return a Book and Calculate Fine
```sql
UPDATE books_issue
SET current_fine = DATEDIFF(CURDATE(), return_on) * (SELECT fine_per_day FROM settings)
WHERE issue_id = 1 AND CURDATE() > return_on;

UPDATE books_issue
SET fine_paid = TRUE, payment_transaction_id = 'TXN123'
WHERE issue_id = 1;
```
### 2. Return a Book and Calculate Fine
```sql
UPDATE books_issue
SET current_fine = DATEDIFF(CURDATE(), return_on) * (SELECT fine_per_day FROM settings)
WHERE issue_id = 1 AND CURDATE() > return_on;

UPDATE books_issue
SET fine_paid = TRUE, payment_transaction_id = 'TXN123'
WHERE issue_id = 1;
```
### 3. Retrieve Total Outstanding Fines for a Reader
```sql
SELECT book_issue_count_per_reader, fine_per_day, book_return_in_days
FROM settings;

```

### 5. Update System Settings
```sql
UPDATE settings
SET fine_per_day = 2.50;  -- Change fine per day to $2.50

```
