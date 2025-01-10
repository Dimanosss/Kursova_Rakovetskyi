-- Перегляд користувачів та їх транспортних засобів
CREATE VIEW UserVehicles AS
SELECT 
    u.user_id,
    CONCAT(u.last_name, ' ', u.first_name, ' ', COALESCE(u.middle_name, '')) AS full_name,
    v.registration_number,
    v.make,
    v.model,
    v.year
FROM Users u
LEFT JOIN Vehicles v ON u.user_id = v.user_id;

--Перегляд активних заявок користувачів
CREATE VIEW ActiveApplications AS
SELECT 
    a.application_id,
    CONCAT(u.last_name, ' ', u.first_name, ' ', COALESCE(u.middle_name, '')) AS full_name,
    at.type_name AS application_type,
    as.status_name AS application_status,
    a.submission_date
FROM Applications a
JOIN Users u ON a.user_id = u.user_id
JOIN Application_Types at ON a.application_type_id = at.application_type_id
JOIN Application_Statuses as ON a.status_id = as.status_id
WHERE a.status_id IN (1, 2); 

--Перегляд транспортних засобів, яким необхідно ТО
CREATE VIEW VehiclesForMaintenance AS
SELECT 
    v.vehicle_id,
    v.registration_number,
    CONCAT(u.last_name, ' ', u.first_name) AS owner_name,
    v.make,
    v.model,
    v.last_maintenance_date,
    v.next_maintenance_date
FROM Vehicles v
JOIN Users u ON v.user_id = u.user_id
WHERE v.next_maintenance_date <= CURDATE();
