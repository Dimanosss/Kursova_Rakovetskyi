--Список активних заявок за останній місяць
SELECT 
    a.application_id,
    CONCAT(u.last_name, ' ', u.first_name) AS user_name,
    at.type_name AS application_type,
    as.status_name AS application_status,
    a.submission_date
FROM Applications a
JOIN Users u ON a.user_id = u.user_id
JOIN Application_Types at ON a.application_type_id = at.application_type_id
JOIN Application_Statuses as ON a.status_id = as.status_id
WHERE a.submission_date >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

--Транспортні засоби, яким потрібне обслуговування найближчим часом
SELECT 
    v.vehicle_id,
    v.registration_number,
    CONCAT(u.last_name, ' ', u.first_name) AS owner_name,
    v.make,
    v.model,
    v.next_maintenance_date
FROM Vehicles v
JOIN Users u ON v.user_id = u.user_id
WHERE v.next_maintenance_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 1 MONTH);

--Користувачі без активних заявок
SELECT 
    u.user_id,
    CONCAT(u.last_name, ' ', u.first_name) AS full_name,
    u.date_of_birth
FROM Users u
LEFT JOIN Applications a ON u.user_id = a.user_id AND a.status_id IN (1, 2) -- 1 = Новий, 2 = У процесі
WHERE a.application_id IS NULL;

--Заявки, які не оновлювали більше 30 днів
SELECT 
    a.application_id,
    CONCAT(u.last_name, ' ', u.first_name) AS user_name,
    at.type_name AS application_type,
    as.status_name AS application_status,
    MAX(ol.operation_date) AS last_update
FROM Applications a
JOIN Users u ON a.user_id = u.user_id
JOIN Application_Types at ON a.application_type_id = at.application_type_id
JOIN Application_Statuses as ON a.status_id = as.status_id
LEFT JOIN Operation_Log ol ON a.application_id = ol.application_id
GROUP BY a.application_id
HAVING last_update < DATE_SUB(CURDATE(), INTERVAL 30 DAY);

--Кількість заявок за статусами та типами
SELECT 
    at.type_name AS application_type,
    as.status_name AS application_status,
    COUNT(a.application_id) AS total_count
FROM Applications a
JOIN Application_Types at ON a.application_type_id = at.application_type_id
JOIN Application_Statuses as ON a.status_id = as.status_id
GROUP BY at.type_name, as.status_name
ORDER BY at.type_name, as.status_name;
