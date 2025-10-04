use comp;
select * from employees;

# select the direct reports only

select e.emp_id as mngr_id, e.emp_name, count(e1.emp_id) as emp_count
from employees e 
left join employees e1
on e1.manager_id = e.emp_id
group by e.emp_id,e.emp_name;

# direct + indirect

with recursive cte1 as (
	select e.emp_id as top_manager_id, e.emp_id, e.salary from employees e
    union all
    select h.top_manager_id, e.emp_id, e.salary from employees e 
    inner join cte1 h on e.manager_id = h.emp_id
    )
select e.emp_id, e.emp_name, count(*) - 1 as total_reports
from employees e inner join cte1 h on h.top_manager_id = e.emp_id
group by 1,2
having total_reports > 0 ;
