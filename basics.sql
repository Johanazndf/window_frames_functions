use db;
CREATE TABLE db.orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10,2),
    discount DECIMAL(5,2)
);

INSERT INTO db.orders (order_id, customer_id, order_date, order_amount, discount) VALUES
(2001, 101, '2025-01-05', 2500.00, 0.00),
(2002, 102, '2025-01-08', 5200.50, 50.00),
(2003, 103, '2025-01-10', 3100.00, NULL),
(2004, 101, '2025-01-15', 4500.75, 100.00),
(2005, 104, '2025-02-01', 6000.00, NULL),
(2006, 105, '2025-02-05', 700.00, 0.00),
(2007, 102, '2025-02-10', 8200.00, 200.00),
(2008, 103, '2025-02-15', 1500.50, NULL),
(2009, 104, '2025-03-01', 3000.00, 0.00),
(2010, 105, '2025-03-05', 4200.00, NULL),
(2011, 101, '2025-03-10', 5000.00, 150.00),
(2012, 102, '2025-03-15', 2600.00, NULL);

select * from db.employees;
select * from db.orders;

-- Find all employees working in the IT department
select * from employees
where dept = 'IT';

-- List employees who were hired after 2020-01-01
select * from employees
where hire_date > '2020-01-01';

-- Find employees whose salary is between 4000 and 5500
select * from employees
where salary between 4000 and 5500;

-- Find the average salary per department
select dept,
avg(salary) as Avg_sal 
from employees
group by dept;

-- Find departments that have more than 2 employees
select dept, 
count(emp_id) as Two_Empl
from employees
group by dept
having Two_Empl > 2;

-- Rank employees by salary within each department
select salary, emp_id
from employees
order by salary desc;

-- Identify employees who earn more than the average salary of their department
select emp_id, emp_name, dept, salary
from employees 
where salary > (select avg(salary) as Avg_Sal
from employees);

-- Count the number of employees in each department
select dept , count(*) as NoOfEmpl
from employees
group by dept;

-- Find departments where the average salary is greater than 4500
select dept
from employees
group by dept
having avg(salary) > 4500;






