--Встановлення нового статусу транспортного засобу
DELIMITER $$

CREATE PROCEDURE SetVehicleStatus(
    IN p_vehicle_id INT,
    IN p_status_id INT
)
BEGIN
    UPDATE Vehicles
    SET status_id = p_status_id
    WHERE vehicle_id = p_vehicle_id;
END $$

DELIMITER ;

--Додавання нового типу заявки
DELIMITER $$

CREATE PROCEDURE SetApplicationType(
    IN p_type_name VARCHAR(100)
)
BEGIN
    INSERT INTO Application_Types (type_name)
    VALUES (p_type_name);
END $$

DELIMITER ;

--Додавання нового користувача
DELIMITER $$

CREATE PROCEDURE AddUser(
    IN p_first_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_middle_name VARCHAR(50),
    IN p_date_of_birth DATE
)
BEGIN
    INSERT INTO Users (first_name, last_name, middle_name, date_of_birth)
    VALUES (p_first_name, p_last_name, p_middle_name, p_date_of_birth);
END $$

DELIMITER ;

--Оновлення статусу заявки
DELIMITER $$

CREATE PROCEDURE UpdateApplicationStatus(
    IN p_application_id INT,
    IN p_status_id INT
)
BEGIN
    UPDATE Applications
    SET status_id = p_status_id
    WHERE application_id = p_application_id;
END $$

DELIMITER ;
