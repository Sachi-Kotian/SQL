USE LIBRARY;
-- Final Round — Mixed, Unlabeled
-- A. Find the member who has paid the most total fines — only one row, no tie handling needed.
SELECT member_id, SUM(fine) AS total_fine
FROM loans
GROUP BY member_id
ORDER BY total_fine DESC
LIMIT 1;
-- B. Find all genres where no book has ever been borrowed.
SELECT DISTINCT genre
FROM books
WHERE id NOT IN (
    SELECT book_id
    FROM loans
);
-- C. You add a CHECK constraint requiring price > 0 to books, but some existing rows might have price = 0. (None currently do, but explain:) what would happen if one did, when you ran the ALTER TABLE?
ALTER TABLE BOOKS ADD CONSTRAINT chk_price CHECK(PRICE>0);
-- D. Get a list of every distinct author who has written more than one book.
SELECT DISTINCT author,COUNT(*) as total_books FROM books GROUP BY author HAVING total_books>1;
-- E. Find members who exist in members but never appear in staff (by matching on name) — without using a JOIN.
SELECT name FROM MEMBERS WHERE name NOT IN(SELECT name from staff);
-- G. Find the second-most-expensive book (no LIMI T-only trick — use a subquery).
SELECT title, price
FROM books
ORDER BY price DESC;
-- H. Return one merged, duplicate-free list of every genre from books combined with every designation/role from staff — treating both as a single column called category.
SELECT genre AS category
FROM books

UNION

SELECT role AS category
FROM staff;