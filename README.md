# Library Management System - SQL Schema

This repository contains the SQL code to create the schema and tables required for a Library Management System. The system manages user login details, books, authors, publishers, library staff, readers, book issues, and system settings.

## Schema Overview

- **Schema Name**: `library_management`
  
The schema includes tables to handle user authentication, library book management, book issues, and staff and reader details, along with the system settings for managing fines and book returns.

## Tables

### 1. `user_login`
Stores information related to users who can log into the system.

| Column Name      | Data Type | Description                 |
|------------------|-----------|-----------------------------|
| `user_id`        | `TEXT`    | Primary key (User's unique ID) |
| `user_password`  | `TEXT`    | User's login password         |
| `first_name`     | `TEXT`    | User's first name             |
| `last_name`      | `TEXT`    | User's last name              |
| `sign_up_on`     | `DATE`    | Date of account creation      |
| `email_id`       | `TEXT`    | User's email address          |

---

### 2. `publisher`
Stores information about book publishers and their distributors.

| Column Name       | Data Type | Description                   |
|-------------------|-----------|-------------------------------|
| `publisher_id`     | `TEXT`    | Primary key (Unique publisher ID) |
| `publisher`        | `TEXT`    | Name of the publisher           |
| `distributor`      | `TEXT`    | Distributor for the publisher   |
| `releases_count`   | `INT`     | Total number of book releases   |
| `last_release`     | `DATE`    | Date of the last book release   |

---

### 3. `author`
Stores details about authors of books.

| Column Name         | Data Type | Description                   |
|---------------------|-----------|-------------------------------|
| `author_id`         | `TEXT`    | Primary key (Unique author ID) |
| `first_name`        | `TEXT`    | Author's first name            |
| `last_name`         | `TEXT`    | Author's last name             |
| `publications_count`| `INT`     | Total number of publications   |

---

### 4. `books`
Stores information about the books available in the library.

| Column Name       | Data Type | Description                          |
|-------------------|-----------|--------------------------------------|
| `book_id`         | `TEXT`    | Primary key (Unique book ID)         |
| `book_code`       | `TEXT`    | Unique code for the book             |
| `book_name`       | `TEXT`    | Title of the book                    |
| `author_id`       | `TEXT`    | Foreign key referencing `author_id`  |
| `publisher_id`    | `TEXT`    | Foreign key referencing `publisher_id` |
| `book_version`    | `TEXT`    | Version or edition of the book       |
| `release_date`    | `DATE`    | Date the book was released           |
| `available_from`  | `DATE`    | Date from which the book is available|
| `is_available`    | `BOOLEAN` | Whether the book is available for issue |

---

### 5. `staff`
Stores details about the library's staff members.

| Column Name         | Data Type | Description                     |
|---------------------|-----------|---------------------------------|
| `staff_id`          | `TEXT`    | Primary key (Unique staff ID)    |
| `first_name`        | `TEXT`    | Staff member's first name       |
| `last_name`         | `TEXT`    | Staff member's last name        |
| `staff_role`        | `TEXT`    | Staff role (e.g., librarian)    |
| `start_date`        | `DATE`    | Date the staff member started   |
| `last_date`         | `DATE`    | Date the staff member left      |
| `is_active`         | `BOOLEAN` | Whether the staff member is active |
| `work_shift_start`  | `TIME`    | Shift start time                |
| `work_shift_end`    | `TIME`    | Shift end time                  |

---

### 6. `readers`
Stores information about registered readers in the library.

| Column Name         | Data Type | Description                       |
|---------------------|-----------|-----------------------------------|
| `reader_id`         | `TEXT`    | Primary key (Unique reader ID)    |
| `first_name`        | `TEXT`    | Reader's first name               |
| `last_name`         | `TEXT`    | Reader's last name                |
| `registered_on`     | `DATE`    | Date the reader registered        |
| `books_issued_total`| `INT`     | Total number of books issued      |
| `books_issued_current`| `INT`   | Number of books currently issued  |
| `is_issued`         | `BOOLEAN` | Whether the reader currently has books issued |
| `last_issue_date`   | `DATE`    | Last book issue date              |
| `total_fine`        | `FLOAT`   | Total fine owed by the reader     |
| `current_fine`      | `FLOAT`   | Current outstanding fine          |

---

### 7. `books_issue`
Tracks the issue of books to readers.

| Column Name             | Data Type | Description                         |
|-------------------------|-----------|-------------------------------------|
| `issue_id`              | `SERIAL`  | Primary key (Auto-incremented)      |
| `book_id`               | `TEXT`    | Foreign key referencing `books`     |
| `issued_to`             | `TEXT`    | Foreign key referencing `readers`   |
| `issued_on`             | `DATE`    | Date the book was issued            |
| `return_on`             | `DATE`    | Due date for returning the book     |
| `current_fine`          | `FLOAT`   | Current fine owed on this book      |
| `fine_paid`             | `BOOLEAN` | Whether the fine has been paid      |
| `payment_transaction_id`| `TEXT`    | Transaction ID for the fine payment |

---

### 8. `settings`
Stores system-wide settings like book issue limits and fine rates.

| Column Name                   | Data Type | Description                         |
|-------------------------------|-----------|-------------------------------------|
| `book_issue_count_per_reader`  | `INT`     | Maximum books a reader can issue    |
| `fine_per_day`                 | `FLOAT`   | Fine charged per day of late return |
| `book_return_in_days`          | `INT`     | Number of days before a book must be returned |

---
