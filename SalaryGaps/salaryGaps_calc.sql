use comp;

# select (2 and 3);
# select abs(3-2);
#  Task: find departments where 2nd highest salary > 2x median salary

-- First, create the table structure
CREATE TABLE emp2 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept VARCHAR(50),
    salary INT
);

-- Now, insert the sample data
INSERT INTO emp2 (emp_id, emp_name, dept, salary) VALUES
-- ===================================================================
-- Sales Department: Designed to MEET the condition
-- A large cluster of low salaries keeps the median low.
-- Two very high salaries ensure the 2nd highest is large.
-- ===================================================================
(101, 'Nina', 'Sales', 30000),
(102, 'David', 'Sales', 32000),
(103, 'Peter', 'Sales', 28000),
(104, 'Grace', 'Sales', 30000),
(105, 'Helen', 'Sales', 31000),          -- The median will be around here
(106, 'Michael', 'Sales', 150000),       -- This is the 2nd highest salary
(107, 'Laura', 'Sales', 180000),        -- This is the highest salary

-- ===================================================================
-- Engineering Department: Designed to NOT meet the condition
-- Salaries are more evenly distributed.
-- The 2nd highest salary is high, but so is the median.
-- ===================================================================
(201, 'Frank', 'Engineering', 90000),
(202, 'Ivy', 'Engineering', 105000),
(203, 'Jack', 'Engineering', 110000),     -- The median is the average of these two
(204, 'Karen', 'Engineering', 120000),    --
(205, 'Leo', 'Engineering', 140000),      -- This is the 2nd highest salary
(206, 'Megan', 'Engineering', 155000);    -- This is the highest salary


select * from emp2;

with salary_ranks as (
	select dept, salary , dense_rank() over(partition by dept order by salary desc) as sal_rank
    from emp2
    ),
second_high as (
	select dept, salary from salary_ranks
    where sal_rank = 2
    ),
median_rank as (
	select dept, salary, 
    row_number() over(partition by dept order by salary) as sl_asc,
    row_number() over(partition by dept order by salary desc) as sl_desc
    from emp2
    ),
median_sal as (
	select dept, avg(salary) as medianSalary
    from median_rank
    where abs(cast(sl_asc as SIGNED) - cast(sl_desc as SIGNED)) <=1
    group by dept
    )
select s.dept, s.salary from second_high s 
inner join median_sal h 
on s.dept = h.dept
where s.salary >2* h.medianSalary;







