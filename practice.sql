create database db;
CREATE TABLE db.employees (
    emp_id INT,
    emp_name VARCHAR(20),
    dept VARCHAR(10),
    hire_date DATE,
    salary INT
);
INSERT INTO db.employees VALUES
(1, 'Asha',  'HR', '2020-01-01', 3000),
(2, 'Ravi',  'HR', '2020-03-01', 3500),
(3, 'Neha',  'HR', '2021-01-01', 4000),
(4, 'Arjun', 'IT', '2019-02-01', 5000),
(5, 'Kiran', 'IT', '2020-06-01', 6000),
(6, 'Meena', 'IT', '2021-09-01', 5500),
(7, 'Dev',   'FIN','2020-05-01', 4500),
(8, 'Riya',  'FIN','2021-04-01', 4800);

select * from db.employees;

-- Assign a row number to employees within each department ordered by salary descending
select emp_id, emp_name,salary, dept, row_number() 
over (partition by dept order by salary desc) as RowNo_Empl from db.employees; 

-- Assign a rank to employees within each department by salary (handle ties correctly) 
select emp_id, emp_name, dept, salary, dense_rank() 
over (partition by dept order by salary desc) as Rank_Empl from db.employees;

-- Show employees who earn more than the average salary of their department 
select emp_id, emp_name, dept, salary 
from ( select emp_id, emp_name, dept, salary, 
avg(salary) over (partition by dept ) as avgdept_salary 
from db.employees)e where salary > avgdept_salary;

-- Find employees whose salary is higher than the previous employee’s 
-- salary within the same department (ordered by hire_date)
select emp_id, emp_name, dept, salary from
(select emp_id, emp_name, dept, salary, 
lag(salary) over (partition by dept order by hire_date)
as High_Prev_sal from db.employees)e
where salary > High_Prev_sal;

-- For each department, show the employee’s salary and
 -- the running total of salary ordered by hire_date
 select emp_id, emp_name, dept, salary,
 sum(salary) over (partition by dept order by hire_date
 rows between unbounded preceding and current row)
 as dept_running_totalsal from db.employees;
 
 -- Show each employee’s salary and the cumulative salary in their -- department up to the current row (ordered by hire_date) 
 select emp_id, emp_name, salary, 
 sum(salary) over (partition by dept order by hire_date 
 rows between unbounded preceding and current row) as Cumulative_Salary from db.employees;
 
 -- Show each employee’s salary and the sum of their salary plus the previous 
 -- 2 employees in the same department, ordered by hire_date 
 select emp_id, emp_name, dept, salary, 
 sum(salary) over (partition by dept order by hire_date 
 rows between 2 preceding and current row) as rolling_sum_salary from db.employees;
 
 -- Show each employee’s salary and the sum of their salary and the next 
 -- 2 employees in the same department, ordered by hire_date
 select emp_id, emp_name, dept, salary, 
 sum(salary) over (partition by dept order by hire_date 
 rows between current row and 2 following) as forward_sum_salary from db.employees;
 
 -- -- Show each employee’s salary, along with the average salary of the previous employee, 
 -- current employee, and next employee in their department, ordered by hire_date 
 select emp_id, emp_name, dept, salary, 
 avg(salary) over (partition by dept order by hire_date 
 rows between 1 preceding and 1 following) as rolling_avg_salary from db. employees;
 


 
