CREATE DATABASE Revenue_Tracking;
USE Revenue_Tracking;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    join_date DATE,
    course_id INT,
    counselor_id VARCHAR(10)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    price INT
);

CREATE TABLE Payments (
    payment_id VARCHAR(10) PRIMARY KEY,
    student_id INT,
    payment_date DATE,
    amount INT,
    payment_mode VARCHAR(20),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);


INSERT INTO Courses (course_id, course_name, price) VALUES
(101, 'Data Analytics', 150000),
(102, 'Full stack', 200000);

INSERT INTO Students (student_id, name, email, join_date, course_id, counselor_id) VALUES
(1, 'Rahul', 'rahul@gmail.com', '2025-01-15', 101, 'Prerna C01'),
(2, 'Sneha', 'sneha@gmail.com', '2025-01-20', 102, 'Rahul C02'),
(3, 'Aman', 'aman@gmail.com', '2025-01-25', 102, 'Aakash C03'),
(4, 'Priya', 'priya4@gmail.com', '2025-02-01', 101, 'Rahul C02'),
(5, 'Karan', 'karan@gmail.com', '2025-02-05', 102, 'Prerna C01'),
(6, 'Isha', 'isha@gmail.com', '2025-02-08', 101, 'Aakash C03');

-- ============================
-- Insert Data: Payments
-- ============================

INSERT INTO Payments (payment_id, student_id, payment_date, amount, payment_mode) VALUES
('P001', 1, '2025-01-15', 150000, 'UPI'),
('P002', 2, '2025-01-22', 125000, 'Card'),
('P003', 3, '2025-01-26', 125000, 'NetBanking'),
('P004', 3, '2025-02-05', 120000, 'UPI'),
('P005', 4, '2025-02-02', 150000, 'Card'),
('P006', 5, '2025-02-07', 150000, 'UPI'),
('P007', 6, '2025-02-10', 200000, 'Card'),
('P008', 6, '2025-02-20', 150000, 'UPI');

-- ============================
-- Queries for Dashboard
-- ============================

-- Total Revenue
SELECT SUM(amount) AS total_revenue FROM Payments;

-- Revenue by Course
SELECT c.course_name, SUM(p.amount) AS revenue
FROM Payments p
JOIN Students s ON p.student_id = s.student_id
JOIN Courses c ON s.course_id = c.course_id
GROUP BY c.course_name
ORDER BY revenue DESC;

-- Monthly Revenue Trend
SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month, SUM(amount) AS revenue
FROM Payments
GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
ORDER BY month;

-- Top Paying Students
SELECT s.name, SUM(p.amount) AS total_paid
FROM Payments p
JOIN Students s ON p.student_id = s.student_id
GROUP BY s.name
ORDER BY total_paid DESC
LIMIT 5;

-- Revenue by Counselor
SELECT s.counselor_id, SUM(p.amount) AS revenue_generated
FROM Payments p
JOIN Students s ON p.student_id = s.student_id
GROUP BY s.counselor_id
ORDER BY revenue_generated DESC;

