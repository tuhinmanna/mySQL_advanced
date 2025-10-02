use comp;
CREATE TABLE logins (
    user_id INT,
    login_date DATE
);

INSERT INTO logins VALUES
(101, '2025-01-01'),
(101, '2025-01-02'),
(101, '2025-01-03'),
(101, '2025-01-05'),
(101, '2025-01-06'),
(102, '2025-01-01'),
(102, '2025-01-04'),
(102, '2025-01-05'),
(102, '2025-01-06');

select * from logins;

select count(*) from logins group by user_id;

# main code

with rn as (
	select user_id, login_date, 
    row_number() over(partition by user_id order by login_date) as rnk
    from logins
    ),
 new_group as (
	select user_id, login_date,
    date_sub(login_date,interval rnk day) as grp
    from rn
    )
select user_id, count(*) as Streak, min(login_date) as first_login, max(login_date) as last_login
from new_group
group by 1,grp
order by user_id,Streak desc;

# now if only the highest stricks are to be taken into consideration

with rn as (
	select user_id, login_date, 
    row_number() over(partition by user_id order by login_date) as rnk
    from logins
    ),
 new_group as (
	select user_id, login_date,
    date_sub(login_date,interval rnk day) as grp
    from rn
    ),
final_grp as ( 
select user_id, count(*) as Streak, min(login_date) as first_login, max(login_date) as last_login,
row_number() over(partition by user_id order by count(*) desc) as rnk2
from new_group
group by user_id,grp
)
select user_id, Streak, first_login, last_login from final_grp
where rnk2 =1;