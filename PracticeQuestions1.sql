USE LIBRARY;

-- 1. SELECT / WHERE / Filtering(5) 
-- Get all books in the 'Fiction' genre with price under ₹500.
SELECT * FROM books WHERE genre='Fiction' AND price<500;
-- Get all members who are 'Premium' or 'Student', ordered by join_date descending.
SELECT * FROM members WHERE membership_type='Premium' OR membership_type='Student'
ORDER BY join_date DESC;
-- Get all books whose title contains the word 'War'.
SELECT * FROM books WHERE title LIKE '%War%';
-- Get all loans where return_date is NULL (i.e. the book hasn't been returned yet).
SELECT * FROM loans WHERE return_date IS NULL;
-- Get the 3 most recently published books, skipping the most recent one.
SELECT * FROM books ORDER BY published_date DESC LIMIT 3 OFFSET 1;

-- 2. INSERT / UPDATE / DELETE (4)
-- Insert a new book: 'Deep Work', author 'Cal Newport', genre 'Self-Help', price 420.00, stock 8 — published date not known yet.
INSERT INTO books(title,author,genre,price,stock)
VALUES('Deep Work','Cal Newport','Self-Help',420.00,8);
-- A member returns a book today. Update loan id = 4's return_date to today's date.
UPDATE loans
SET return_date=CURDATE() WHERE id=4;
-- Every book in the 'Fiction' genre gets a 10% price cut. Write the update.
SET SQL_SAFE_UPDATES=0;
UPDATE books
SET price=price-0.1*price
WHERE genre='Fiction';
-- Delete all loan records where fine = 0 AND return_date is not NULL (cleanup of fully settled, no-fine loans).
DELETE FROM loans WHERE fine=0 AND return_date IS NOT NULL;


-- 3. ALTER TABLE / Constraints (4)
-- Add a column phone VARCHAR(15) to members.
ALTER TABLE members ADD COLUMN phone VARCHAR(15);
-- Add a CHECK constraint so books.stock can never go below 0.
ALTER TABLE books ADD CONSTRAINT CHECK(stock<0);
-- Make books.price NOT NULL.
ALTER TABLE books MODIFY COLUMN price DECIMAL(8,2) NOT NULL;
-- Rename staff.role to designation and change its type to VARCHAR(80).
ALTER TABLE staff CHANGE COLUMN role designation VARCHAR(80);

-- 4. Aggregate & String/Date Functions (5)
-- Find the total number of books per genre.
SELECT genre, COUNT(*) AS count FROM books GROUP BY genre;
-- Find the most expensive book's price using an aggregate function (not ORDER BY).
SELECT MAX(price) FROM books;
-- Display every staff member's name in lowercase along with their role, concatenated as "name (role)".
SELECT CONCAT(LOWER(name),'(',designation,')') as id_name FROM staff;
-- For every loan that's been returned, calculate how many days the book was kept (return_date - loan_date).
SELECT id,DATEDIFF(return_date,loan_date) FROM loans WHERE return_date IS NOT NULL;
-- Find the average price of books, rounded to 2 decimal places.
SELECT ROUND(AVG(price),2) as avg_price FROM books;

-- 5. PRIMARY KEY / UNIQUE / FOREIGN KEY (3)
-- Write the ALTER TABLE to add a foreign key (named fk_referrer) on members.referred_by_id referencing members.id.
ALTER TABLE members
ADD CONSTRAINT fk_referrer FOREIGN KEY (referred_by_id) REFERENCES members(id) ON DELETE CASCADE;
ALTER TABLE members DROP FOREIGN KEY fk_referrer;


-- 6. JOINs (6)
-- Get the name of every member along with the title of books they've borrowed — only members who've actually borrowed something.
SELECT m.name,b.title
FROM 
members m
INNER JOIN
loans l ON m.id=l.member_id
INNER JOIN 
books b ON l.book_id=b.id; 
-- Get the name of every member along with borrowed book titles — including members who've never borrowed anything (members 9 and 10 should show up with NULL).
SELECT m.name,b.title
FROM 
members m
LEFT JOIN
loans l ON m.id=l.member_id
LEFT  JOIN 
books b ON l.book_id=b.id; 
-- Using a Self JOIN on members, get each member's name next to the name of the person who referred them.
SELECT a.name,b.name
FROM 
members a
INNER  JOIN
members b ON a.id=b.referred_by_id;
-- Find all books that have never been borrowed (hint: start from books, LEFT JOIN to loans, then filter). Expect exactly one result: 'Silent Spring'.
SELECT b.title
FROM books B
LEFT JOIN 
loans l ON b.id=l.book_id 
WHERE l.book_id IS NULL;
