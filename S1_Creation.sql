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

-- for viewing 
SELECT * FROM student;		

DROP DATABASE students;


