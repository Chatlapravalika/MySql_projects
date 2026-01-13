
-- HR / Employee Management System Project

CREATE DATABASE IF NOT EXISTS hr_db;
USE hr_db;

-- Drop tables if exist
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- Departments Table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Employees Table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    gender VARCHAR(10),
    dept_id INT,
    salary INT,
    join_date DATE,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Attendance Table
CREATE TABLE attendance (
    att_id INT PRIMARY KEY,
    emp_id INT,
    att_date DATE,
    status VARCHAR(10), -- Present / Absent
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- Insert Departments
INSERT INTO departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Sales');

-- Insert Employees
INSERT INTO employees VALUES
(101, 'Amit', 'Male', 1, 60000, '2022-01-10'),
(102, 'Neha', 'Female', 2, 40000, '2023-03-15'),
(103, 'Ravi', 'Male', 1, 55000, '2021-06-20'),
(104, 'Pooja', 'Female', 3, 45000, '2022-11-01'),
(105, 'Kiran', 'Male', 4, 50000, '2023-02-05');

-- Insert Attendance
INSERT INTO attendance VALUES
(1, 101, '2025-01-01', 'Present'),
(2, 102, '2025-01-01', 'Absent'),
(3, 103, '2025-01-01', 'Present'),
(4, 104, '2025-01-01', 'Present'),
(5, 105, '2025-01-01', 'Present'),
(6, 101, '2025-01-02', 'Present'),
(7, 102, '2025-01-02', 'Present'),
(8, 103, '2025-01-02', 'Absent'),
(9, 104, '2025-01-02', 'Present'),
(10, 105, '2025-01-02', 'Present');

-- ================== Useful Queries ==================

-- Total Employees
SELECT COUNT(*) AS total_employees FROM employees;

-- Department-wise Employee Count
SELECT d.dept_name, COUNT(e.emp_id) AS total_employees
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- Average Salary by Department
SELECT d.dept_name, AVG(e.salary) AS avg_salary
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- Highest Paid Employee
SELECT emp_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 1;

-- Employees Joined After 2022
SELECT * FROM employees
WHERE join_date > '2022-01-01';

-- Absent Employees
SELECT e.emp_name, a.att_date
FROM employees e
JOIN attendance a ON e.emp_id = a.emp_id
WHERE a.status = 'Absent';

-- Attendance Percentage Per Employee
SELECT e.emp_name,
SUM(CASE WHEN a.status='Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS attendance_percentage
FROM employees e
JOIN attendance a ON e.emp_id = a.emp_id
GROUP BY e.emp_name;
