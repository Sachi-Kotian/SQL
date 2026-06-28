
CREATE DATABASE LIBRARY;
USE LIBRARY;

CREATE TABLE members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    membership_type ENUM('Basic', 'Premium', 'Student'),
    join_date DATE,
    referred_by_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
SELECT * FROM MEMBERS;

CREATE TABLE books (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    author VARCHAR(100),
    genre VARCHAR(50),
    price DECIMAL(8,2),
    stock INT DEFAULT 0,
    published_date DATE
);
SELECT * FROM BOOKS;

CREATE TABLE loans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    book_id INT,
    loan_date DATE,
    return_date DATE,
    fine DECIMAL(6,2) DEFAULT 0,
    FOREIGN KEY (member_id) REFERENCES members(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);
SELECT * FROM LOANS;

CREATE TABLE staff (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    role VARCHAR(50),
    salary DECIMAL(10,2)
);
SELECT * FROM STAFF;

-- ============================
-- DATA: members
-- ============================
INSERT INTO members (id, name, email, membership_type, join_date, referred_by_id) VALUES
(1, 'Aarav Mehta',     'aarav@example.com',   'Premium', '2022-03-10', NULL),
(2, 'Sneha Iyer',      'sneha@example.com',   'Basic',   '2022-06-15', 1),
(3, 'Raj Malhotra',    'raj@example.com',     'Student', '2023-01-20', 1),
(4, 'Fatima Sheikh',   'fatima@example.com',  'Premium', '2023-02-05', 2),
(5, 'Priya Nair',      'priya@example.com',   'Basic',   '2023-04-18', NULL),
(6, 'Kabir Singh',     'kabir@example.com',   'Student', '2023-07-22', 5),
(7, 'Ananya Rao',      'ananya@example.com',  'Premium', '2023-09-30', NULL),
(8, 'Vikram Joshi',    'vikram@example.com',  'Basic',   '2024-01-12', 7),
(9, 'Meera Kulkarni',  'meera@example.com',   'Student', '2024-03-25', NULL),
(10,'Rohan Desai',     'rohan@example.com',   'Basic',   '2024-05-01', NULL);


-- ============================
-- DATA: books
-- ============================
INSERT INTO books (id, title, author, genre, price, stock, published_date) VALUES
(1, '1984',                     'George Orwell',        'Fiction',    350.00, 5, '1949-06-08'),
(2, 'Animal Farm',               'George Orwell',        'Fiction',    250.00, 3, '1945-08-17'),
(3, 'Sapiens',                   'Yuval Noah Harari',    'Non-Fiction',550.00, 4, '2011-01-01'),
(4, 'Homo Deus',                 'Yuval Noah Harari',    'Non-Fiction',600.00, 2, '2015-02-10'),
(5, 'Atomic Habits',             'James Clear',          'Self-Help',  450.00, 10,'2018-10-16'),
(6, 'The War of Art',            'Steven Pressfield',    'Self-Help',  300.00, 6, '2002-03-01'),
(7, 'War and Peace',             'Leo Tolstoy',          'Fiction',    700.00, 2, '1869-01-01'),
(8, 'The Lean Startup',          'Eric Ries',            'Business',   500.00, 3, '2011-09-13'),
(9, 'Zero to One',               'Peter Thiel',          'Business',   480.00, 5, '2014-09-16'),
(10,'Silent Spring',             'Rachel Carson',        'Non-Fiction',400.00, 7, '1962-09-27');


-- ============================
-- DATA: loans
-- ============================
-- Members 9 and 10 have NO loans (never borrowed)
-- Book 10 never appears here (never borrowed)
-- Some return_date = NULL (currently out / not returned yet)

INSERT INTO loans (id, member_id, book_id, loan_date, return_date, fine) VALUES
(1,  1, 1, '2024-01-05', '2024-01-15', 0),
(2,  1, 3, '2024-02-01', '2024-02-20', 50.00),
(3,  2, 5, '2024-01-10', '2024-01-25', 0),
(4,  2, 7, '2024-03-01', NULL,        0),
(5,  3, 1, '2024-02-10', '2024-02-12', 0),
(6,  3, 2, '2024-03-15', '2024-03-18', 0),
(7,  4, 6, '2024-01-20', NULL,        0),
(8,  5, 9, '2024-02-05', '2024-02-25', 100.00),
(9,  5, 1, '2024-04-01', '2024-04-10', 0),
(10, 6, 3, '2024-01-15', '2024-01-16', 0),
(11, 6, 5, '2024-04-05', NULL,        0),
(12, 7, 4, '2024-02-15', '2024-03-01', 75.00),
(13, 8, 2, '2024-04-10', '2024-04-20', 0),
(14, 1, 8, '2024-05-01', NULL,        0);


-- ============================
-- DATA: staff
-- ============================
INSERT INTO staff (id, name, email, role, salary) VALUES
(1, 'Devika Rao',     'devika.staff@example.com', 'Librarian',     45000.00),
(2, 'Arjun Bhatt',    'arjun.staff@example.com',  'Assistant',     30000.00),
(3, 'Neha Kapoor',    'neha.staff@example.com',   'Manager',       65000.00),
(4, 'Sameer Khan',    'sameer.staff@example.com', 'Librarian',     47000.00),
(5, 'Aarav Mehta',    'aarav.staff@example.com',  'Assistant',     31000.00);

DROP DATABASE LIBRARY;