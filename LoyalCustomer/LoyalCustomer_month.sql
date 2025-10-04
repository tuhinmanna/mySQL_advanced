use comp;

create table product(
prod_id int,
category varchar(30)
);
create table sales(
sale_id int,
cust_id int,
prod_id int,
sale_date DATE
);

# product table have many other columns as well, 
# so prod_id is for products not category. ipun 17, semsong s25 both are electronic but will have different prod_id

insert into product values
(1, 'Electronics'),
(2, 'Electronics'),
(3, 'Cloth'),
(4, 'Cloth');

insert into sales values
(1, 101, 1, '2025-01-15'),
(2, 101, 1, '2025-02-10'),
(3, 101, 2, '2025-02-25'), -- same month, not counted twice
(4, 102, 1, '2025-01-20'),
(5, 102, 1, '2025-03-01'),
(6, 103, 3, '2025-01-05'),
(7, 103, 3, '2025-02-14'),
(8, 103, 4, '2025-03-22'),
(9, 104, 4, '2025-01-18'),
(10,104, 4, '2025-02-20');


with cte1 as (
	select s.*, p.category from sales s 
    inner join product p on p.prod_id = s.prod_id
),
cte2 as (
	select cust_id, category, count(date_format(sale_date, '%m-%Y')) as total_order
    from cte1 
    group by 1,2
),
 # select * from cte2;  >> this will show all the cust_id and their total diff month orders
 
 cte3 as (
	select *, row_number() over(partition by category order by total_order desc) as rn from cte2 
 )
select cust_id, category, total_order from cte3 where rn =1;