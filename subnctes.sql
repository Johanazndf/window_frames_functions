use db;
-- find the employees who's salary is more than average salary earned by all employee
-- 1. find the avg salary, 2. filter the employees based on the above result

select avg(salary) as Avg_Sal from employees;
select * from employees where salary > 4537.5000;
-- as this is inefficient if further data is added so subquery is used 
select * -- outer query / main query
from employees 
where salary > (select avg(salary) as Avg_Sal from employees); -- subquery / inner query

-- Types of subqueries
-- 1. Scalar subquery: it always returns 1 row and 1 column

select * 
from employees e
join (select avg(salary) sal from employees) as avg_sal
on e.salary > avg_sal.sal;

-- multiple subquery: returns multiple column and multiple row / returns only 1 column and multiple rows

-- fimd the employees who earn the highest salary in each department
select dept, max(salary)
from employees
group by dept;

-- write this in the subquery form 
select * 
from employees
where (dept, salary) in (select dept, max(salary)
from employees
group by dept);

