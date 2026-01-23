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

use db;
-- Employees with salary > 5000
select emp_id,salary
from employees
where salary > 5000;

-- Employees from HR or IT
select emp_id, dept
from employees
where dept='HR' or dept = 'IT';

-- Employees whose name contains ‘sh’
select emp_id, emp_name
from employees
where emp_name like '%sh%';

-- Employees ordered by salary (ascending)
select emp_id, emp_name, salary
from employees 
order by salary asc;

-- Employees ordered by salary (descending)
select emp_id, emp_name, salary
from employees 
order by salary desc;

-- Employees ordered by department, then salary
select emp_id, emp_name, dept, salary
from employees
order by dept asc, salary desc;

-- Top 3 highest-paid employees
select emp_id, emp_name, salary
from employees
order by salary desc limit 3;

-- Total salary paid per department
select dept,
sum(salary) as Total_salary
from employees
group by dept;

-- Number of employees per department
select dept,
count(*) as Total_Empl
from employees
group by dept;

-- Max salary in each department
select dept,
max(salary) as Maximum_salary
from employees
group by dept;

-- Department-wise employee count, ordered by count desc
select dept,
count(*) as Empl_Count
from employees
group by dept order by Empl_Count desc;

-- Departments with average salary > 2000
select dept,
avg(salary) as Avg_Sal
from employees
group by dept having Avg_Sal > 2000;

-- Departments where max salary > 4000
select dept,
max(salary) as Maximum_Salary
from employees
group by dept having Maximum_Salary > 4000;

-- Write a query to show emp_id, dept, salary, 
-- and average salary of the department using a window function
select emp_id, emp_name, dept, salary,
avg(salary) over (partition by dept) as Avg_Salary
from employees;

-- Show emp_id, dept, salary, and 
-- rank employees by salary within each department, highest salary = rank 1
select emp_id, dept, salary,
dense_rank() over (partition by dept order by salary desc) as
Ranking_Of_Salary from employees;

-- Show only the highest-paid employee per department
-- (If there are ties, return only one employee per department)
select emp_id, salary, dept
from (
select emp_id, salary, dept,
row_number() over (partition by dept order by salary desc) as rn
from employees
) e
where rn = 1;

-- For each employee, show: emp_id, dept, salary,previous employee’s salary in the 
-- same department and next employee’s salary in the same department
select emp_id, dept, salary,
lag(salary,1) over (partition by dept order by salary) as Previous_Salary,
lead(salary,1) over (partition by dept order by salary) as Next_Salary
from employees;

-- Show each employee’s salary and the difference from the previous employee’s salary in the same department
select emp_id, salary,
lag(salary) over (partition by dept) as Previou_Sal,
salary - lag(salary) over (partition by dept) as difference
from employees;



