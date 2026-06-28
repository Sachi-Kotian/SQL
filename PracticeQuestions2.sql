USE LIBRARY;
SET SQL_SAFE_UPDATES=1;

-- 7. UNION / UNION ALL (3)
-- Get a single unique list of all names from members and staff.
SELECT name FROM members 
UNION
SELECT name FROM staff;
-- Get a list of all names from members and staff, keeping duplicates. (Note: 'Aarav Mehta' appears in both tables with different emails — so this should return him twice.)
SELECT name FROM members 
UNION ALL
SELECT name FROM staff;
-- Get name and an extra label column ('Member' or 'Staff') for everyone in the system, in one result set.
SELECT name, 'Member' AS ROLE FROM members
UNION ALL
SELECT name,'Staff' AS ROLE FROM staff;

-- 8. Subqueries (5)
-- Find all books priced higher than the average price of all books.
SELECT * FROM books WHERE price > (SELECT AVG(price) FROM books);
-- Find all members who were referred by someone who joined before 2023-01-01.
SELECT b.id,b.name FROM 
members a
RIGHT JOIN
members b ON a.id=b.referred_by_id
WHERE a.join_date<'2023-01-01';
-- Show every book's title and price, plus a column showing the overall average book price next to each row.
SELECT title,price,(SELECT AVG(price)FROM books) AS avg_price FROM books; 
-- Find the member(s) who currently have the highest total fine, using a subquery (not ORDER BY ... LIMIT 1). (You'll need to GROUP BY member_id first, then compare.)
SELECT MAX(total_fine)
FROM (
    SELECT member_id, SUM(fine) AS total_fine
    FROM loans
    GROUP BY member_id
) AS t;

-- Find all books that currently have zero active loans (i.e. no row in loans with return_date IS NULL), using NOT IN.
SELECT title FROM books WHERE id NOT IN
(SELECT book_id FROM loans WHERE return_date IS NULL  );

-- 9. GROUP BY / HAVING (5)

-- Find the total fine collected, grouped by member_id.
SELECT member_id, SUM(fine) FROM loans GROUP BY member_id;
-- Find genres where the average book price exceeds ₹500.
SELECT genre,AVG(price) as avg_price FROM books GROUP BY genre HAVING avg_price>500;
-- Find members who have taken more than 1 loan total.
SELECT member_id,COUNT(*) as total_loans FROM loans GROUP BY member_id HAVING total_loans>1;
-- Find books that have been borrowed more than once — GROUP BY book_id on loans, use HAVING.
SELECT book_id,COUNT(*) AS tot_bor FROM loans GROUP BY book_id HAVING tot_bor>1;
-- Get the count of loans per genre (you'll need to JOIN loans to books first), plus a grand total using ROLLUP.
SELECT genre,COUNT(*) as total_loans
FROM books
INNER JOIN
loans ON books.id=loans.book_id
GROUP BY Genre WITH ROLLUP;

-- 10. Views / Indexes / Transactions (4)

-- Create a view overdue_loans showing all loans where return_date IS NULL and loan_date is more than 60 days before '2024-06-01' (use this as your reference "today" since the data is from early 2024).
CREATE VIEW overdue_loans
AS
SELECT * FROM loans WHERE return_date IS NULL AND DATEDIFF('2024-06-01',loan_date)>60;
SELECT * FROM overdue_loans;
-- You frequently search loans by member_id. What should you create, and write the statement.
CREATE INDEX idx_member_id ON members(id);


-- 11. Stored Procedures & Triggers (4)

-- Write a stored procedure GetLoansByMember(p_member_id) that returns all loans for a given member.
DELIMITER $$
CREATE PROCEDURE GetLoansByMember( IN p_member_id INT )
BEGIN
	SELECT * FROM loans WHERE member_id=p_member_id;
END$$

DELIMITER ;
CALL GetLoansByMember(1);
drop procedure GetLoansByMember;
-- Write a stored procedure AddBook(...) that inserts a new book, taking title, author, genre, price, and stock as input parameters.
DELIMITER $$
CREATE PROCEDURE AddBook(
IN bk_title VARCHAR(200),
IN bk_author VARCHAR(100),
IN bk_genre VARCHAR(50),
IN bk_price DECIMAL(8,2),
IN bk_stock INT
)
BEGIN
	INSERT INTO books (title,author,genre,price,stock)
    VALUES (bk_title,bk_author,bk_genre,bk_price,bk_stock);
END $$
DELIMITER ;
CALL AddBook('Harry Potter','J.K. Rowling','Fiction',720,55);
-- Write a trigger that automatically reduces books.stock by 1 every time a new row is inserted into loans.
DELIMITER $$
CREATE TRIGGER update_stock
AFTER INSERT ON loans
FOR EACH ROW
BEGIN
	UPDATE  books SET stock=stock-1 where id=NEW.book_id;
END$$
DELIMITER ;