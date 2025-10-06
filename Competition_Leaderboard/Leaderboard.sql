use comp;

create table races (
	race_id INT,
    user_id INT,
    finish_time INT,
    race_date DATE 
);

insert into races values
(1,101,320,'2025-01-01'),
(1,102,300,'2025-01-01'),
(1,103,340,'2025-01-01'),
(2,101,310,'2025-02-01'),
(2,102,350,'2025-02-01'),
(2,103,290,'2025-02-01'),
(3,101,330,'2025-03-01'),
(3,102,305,'2025-03-01'),
(3,103,280,'2025-03-01');

select * from races;

with ranks as (
	select *, dense_rank() over(partition by race_id order by finish_time) as rnk
    from races
),
progress as (
	select * , lag(rnk) over(partition by user_id order by race_id) as previous_rank
    from ranks
)
select *, case 
when previous_rank is null then 'First race'
when rnk > previous_rank then 'Dropped'
when rnk < previous_rank then 'Improved'
when rnk = previous_rank then 'Same pos retained'
end as Comments
from progress;
