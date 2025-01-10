--Логування змін статусу транспортного засобу
DELIMITER $$

CREATE TRIGGER LogVehicleStatusChange
AFTER UPDATE ON Vehicles
FOR EACH ROW
BEGIN
    IF OLD.status_id != NEW.status_id THEN
        INSERT INTO History_Log (entity, entity_id, operation, operation_date)
        VALUES ('Vehicle', NEW.vehicle_id, CONCAT('Status changed from ', OLD.status_id, ' to ', NEW.status_id), NOW());
    END IF;
END $$

DELIMITER ;

--Історія оновлень заявок
CREATE VIEW ApplicationHistory AS
SELECT 
    a.application_id,
    u.user_id,
    CONCAT(u.last_name, ' ', u.first_name) AS user_name,
    CONCAT('Status changed to ', as.status_name) AS change_description,
    ol.operation_date
FROM Operation_Log ol
JOIN Applications a ON ol.application_id = a.application_id
JOIN Users u ON a.user_id = u.user_id
JOIN Application_Statuses as ON a.status_id = as.status_id
WHERE ol.operation_type_id = 3; -- 3 = зміна статусу

--Історія операцій
CREATE VIEW Operation_History AS
SELECT 
    ol.log_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    ot.operation_name,
    ol.operation_date,
    a.application_id
FROM Operation_Log ol
LEFT JOIN Employees e ON ol.employee_id = e.employee_id
LEFT JOIN Operation_Types ot ON ol.operation_type_id = ot.operation_type_id
LEFT JOIN Applications a ON ol.application_id = a.application_id;
