--Отримання всіх заявок користувача
DELIMITER $$

CREATE PROCEDURE GetUserApplications(
    IN p_user_id INT
)
BEGIN
    SELECT 
        a.application_id,
        at.type_name AS application_type,
        as.status_name AS application_status,
        a.submission_date
    FROM Applications a
    JOIN Application_Types at ON a.application_type_id = at.application_type_id
    JOIN Application_Statuses as ON a.status_id = as.status_id
    WHERE a.user_id = p_user_id;
END $$

DELIMITER ;

--Отримання інформації про транспортний засіб
DELIMITER $$

CREATE PROCEDURE GetVehicleDetails(
    IN p_vehicle_id INT
)
BEGIN
    SELECT 
        v.vehicle_id,
        v.registration_number,
        v.make,
        v.model,
        v.color,
        v.last_maintenance_date,
        v.next_maintenance_date,
        vs.status_name AS vehicle_status
    FROM Vehicles v
    JOIN Vehicle_Statuses vs ON v.status_id = vs.status_id
    WHERE v.vehicle_id = p_vehicle_id;
END $$

DELIMITER ;

--Отримання даних про заявки
DELIMITER $$

CREATE PROCEDURE GetApplicationsByUser(
    IN p_user_id INT
)
BEGIN
    SELECT 
        a.application_id,
        at.type_name AS application_type,
        as.status_name AS application_status,
        a.submission_date,
        a.completion_date
    FROM Applications a
    LEFT JOIN Application_Types at ON a.application_type_id = at.application_type_id
    LEFT JOIN Application_Statuses as ON a.status_id = as.status_id
    WHERE a.user_id = p_user_id;
END $$

DELIMITER ;
