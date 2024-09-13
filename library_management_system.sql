-- User Login Table
DROP TABLE IF EXISTS user_login;
CREATE TABLE user_login (
	user_id VARCHAR(255) PRIMARY KEY,
	user_password VARCHAR(255),
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	sign_up_on DATE,
	email_id VARCHAR(255)
);

-- Publisher Table
DROP TABLE IF EXISTS publisher;
CREATE TABLE publisher (
	publisher_id VARCHAR(255) PRIMARY KEY,
	publisher VARCHAR(255),
	distributor VARCHAR(255),
	releases_count INT,
	last_release DATE
);

-- Author Table
DROP TABLE IF EXISTS author;
CREATE TABLE author (
	author_id VARCHAR(255) PRIMARY KEY,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	publications_count INT
);

-- Books Table
DROP TABLE IF EXISTS books;
CREATE TABLE books (
	book_id VARCHAR(255) PRIMARY KEY,
	book_code VARCHAR(255),
	book_name VARCHAR(255),
	author_id VARCHAR(255),
	publisher_id VARCHAR(255),
	book_version VARCHAR(255),
	release_date DATE,
	available_from DATE,
	is_available BOOLEAN,
	FOREIGN KEY (author_id) REFERENCES author(author_id),
	FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);

-- Staff Table
DROP TABLE IF EXISTS staff;
CREATE TABLE staff (
	staff_id VARCHAR(255) PRIMARY KEY,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	staff_role VARCHAR(255),
	start_date DATE,
	last_date DATE,
	is_active BOOLEAN,
	work_shift_start TIME,
	work_shift_end TIME
);

-- Readers Table
DROP TABLE IF EXISTS readers;
CREATE TABLE readers (
	reader_id VARCHAR(255) PRIMARY KEY,
	first_name VARCHAR(255),
	last_name VARCHAR(255),
	registered_on DATE,
	books_issued_total INT,
	books_issued_current INT,
	is_issued BOOLEAN,
	last_issue_date DATE,
	total_fine DECIMAL(10, 2),
	current_fine DECIMAL(10, 2)
);

-- Books Issue Table
DROP TABLE IF EXISTS books_issue;
CREATE TABLE books_issue (
	issue_id INT AUTO_INCREMENT PRIMARY KEY,
	book_id VARCHAR(255),
	issued_to VARCHAR(255),
	issued_on DATE,
	return_on DATE,
	current_fine DECIMAL(10, 2),
	fine_paid BOOLEAN,
	payment_transaction_id VARCHAR(255),
	FOREIGN KEY (book_id) REFERENCES books(book_id),
	FOREIGN KEY (issued_to) REFERENCES readers(reader_id)
);

-- Settings Table
DROP TABLE IF EXISTS settings;
CREATE TABLE settings (
	book_issue_count_per_reader INT,
	fine_per_day DECIMAL(10, 2),
	book_return_in_days INT
);


-- Some queries
-- 1. Managing Book Issues:
-- Issue a book to a reader and update the books_issued_current field for the reader:

INSERT INTO books_issue (book_id, issued_to, issued_on, return_on)
VALUES ('book1', 'reader1', CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY));

UPDATE readers
SET books_issued_current = books_issued_current + 1
WHERE reader_id = 'reader1';

-- 2. Tracking Book Returns and Fines:
-- When a book is returned, calculate fines based on the number of overdue days and update the current_fine:

UPDATE books_issue
SET current_fine = DATEDIFF(CURDATE(), return_on) * (SELECT fine_per_day FROM settings)
WHERE issue_id = 1
AND CURDATE() > return_on;

-- If fine is paid
UPDATE books_issue
SET fine_paid = TRUE, payment_transaction_id = 'TXN123'
WHERE issue_id = 1;

-- 3. Calculating Total Fines for a Reader:
-- Get the total outstanding fines for a reader across all books they have not returned yet:

SELECT SUM(current_fine) AS total_fines
FROM books_issue
WHERE issued_to = 'reader1' AND fine_paid = FALSE;

-- 4. System-Wide Settings Query:
-- Retrieve the current library system settings for book return periods and fine amounts:

SELECT book_issue_count_per_reader, fine_per_day, book_return_in_days
FROM settings;

-- 5. Update System Settings (e.g., Fine Per Day):

UPDATE settings
SET fine_per_day = 2.50;  -- Changing fine per day to $2.50
