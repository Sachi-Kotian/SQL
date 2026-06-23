CREATE DATABASE students;
USE students;

CREATE TABLE student (
roll INT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
email VARCHAR(50) UNIQUE NOT NULL,
gender ENUM('Male','Female','Other'),
dob DATE,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- viewing specific columns 
SELECT roll,name FROM student;

RENAME TABLE student TO candidates; 
SELECT * FROM candidates;

-- ALTER OPERATIONS
ALTER TABLE candidates ADD COLUMN marks INT ; 

ALTER TABLE candidates DROP COLUMN marks; 

-- MODIFY COL TYPE 
ALTER TABLE candidates MODIFY COLUMN  name VARCHAR(150);

ALTER TABLE candidates MODIFY COLUMN name VARCHAR(150) FIRST;

ALTER TABLE candidates MODIFY COLUMN email VARCHAR(50)  AFTER dob;

-- INSERTING DATA 
INSERT INTO candidates VALUES ('Priya',1,'Female','2006-08-15','abc@eg.com',DEFAULT,20); 
INSERT INTO candidates (name,roll,gender,email,marks) VALUES ('RAJEEV',2,'Male','rajiv@eg.com',15);

INSERT INTO candidates VALUES 
('Riya',3,'Female','2006-12-10','riya@eg.com',DEFAULT,18),
('Sonu',4,'Male','2006-01-26','sonu@eg.com',DEFAULT,10); 
