USE USER;

CREATE TABLE user_log(
id INT PRIMARY KEY AUTO_INCREMENT,
user_id INT ,
name VARCHAR(100),
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$
CREATE TRIGGER update_log
AFTER INSERT ON USERS
FOR EACH ROW
BEGIN
	INSERT INTO user_log (user_id,name)
    VALUES(NEW.id,NEW.name);
END$$

DELIMITER ;

INSERT INTO USERS (name,email,gender,date_of_birth,salary)
VALUES
('Shanti','shanti@eg.com','Other','2000-04-30',20000),
('Pranay','pran@eg.com','Male','2002-07-23',33000);

SELECT * FROM user_log;
SELECT * FROM users;

DROP TRIGGER IF EXISTS update_log;