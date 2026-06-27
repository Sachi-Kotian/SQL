USE USER;

DELIMITER $$
CREATE PROCEDURE view_users()
BEGIN
	SELECT * FROM USERS;
END$$
DELIMITER ;

CALL view_users;

-- procedure with input parameters
DELIMITER //
CREATE PROCEDURE ADD_USER(
IN u_name VARCHAR(100),
IN u_email VARCHAR(100),
IN u_gender ENUM('Male','Female','Other'),
IN u_dob DATE,
IN u_salary INT
)
BEGIN
	INSERT INTO USERS (name,email,gender,date_of_birth,salary)
    VALUES
    (u_name,u_email,u_gender,u_dob,u_salary);
    SELECT * FROM USERS;

END //

DELIMITER ;

CALL add_user('Sakhi','sakk@example.com','Female','2005-12-13',61000);

SHOW PROCEDURE STATUS WHERE DB='USER';

DROP PROCEDURE IF EXISTS add_user;
