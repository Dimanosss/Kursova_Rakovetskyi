-- Таблиця: Користувачі
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    date_of_birth DATE NOT NULL,
    passport_series VARCHAR(5) NOT NULL,
    passport_number VARCHAR(10) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(15),
    email VARCHAR(100)
);

-- Таблиця: Типи транспортних засобів
CREATE TABLE Vehicle_Types (
    vehicle_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
);

-- Таблиця: Транспортні засоби
CREATE TABLE Vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    registration_number VARCHAR(15) UNIQUE NOT NULL,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    year YEAR NOT NULL,
    vehicle_type_id INT NOT NULL,
    registration_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (vehicle_type_id) REFERENCES Vehicle_Types(vehicle_type_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Таблиця: Категорії водійських посвідчень
CREATE TABLE License_Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(5) NOT NULL
);

-- Таблиця: Водійські посвідчення
CREATE TABLE Driver_Licenses (
    license_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    license_number VARCHAR(20) UNIQUE NOT NULL,
    issue_date DATE NOT NULL,
    expiry_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Таблиця: Категорії, присвоєні посвідченням
CREATE TABLE License_Assigned_Categories (
    license_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (license_id, category_id),
    FOREIGN KEY (license_id) REFERENCES Driver_Licenses(license_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (category_id) REFERENCES License_Categories(category_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Таблиця: Типи заявок
CREATE TABLE Application_Types (
    application_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(100) NOT NULL
);

-- Таблиця: Статуси заявок
CREATE TABLE Application_Statuses (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL
);

-- Таблиця: Заявки
CREATE TABLE Applications (
    application_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    application_type_id INT NOT NULL,
    status_id INT NOT NULL,
    submission_date DATE NOT NULL,
    completion_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (application_type_id) REFERENCES Application_Types(application_type_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (status_id) REFERENCES Application_Statuses(status_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Таблиця: Посади
CREATE TABLE Positions (
    position_id INT AUTO_INCREMENT PRIMARY KEY,
    position_name VARCHAR(100) NOT NULL
);

-- Таблиця: Співробітники
CREATE TABLE Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    position_id INT NOT NULL,
    hire_date DATE NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100),
    FOREIGN KEY (position_id) REFERENCES Positions(position_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- Таблиця: Типи операцій
CREATE TABLE Operation_Types (
    operation_type_id INT AUTO_INCREMENT PRIMARY KEY,
    operation_name VARCHAR(100) NOT NULL
);

-- Таблиця: Лог виконаних операцій
CREATE TABLE Operation_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    operation_type_id INT NOT NULL,
    operation_date DATETIME NOT NULL,
    application_id INT,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (operation_type_id) REFERENCES Operation_Types(operation_type_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    FOREIGN KEY (application_id) REFERENCES Applications(application_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);
