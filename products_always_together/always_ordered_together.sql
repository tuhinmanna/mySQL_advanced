use comp;

CREATE TABLE order_items (
    order_id INT,
    product_id INT
);

INSERT INTO order_items VALUES
(1, 101), (1, 102), (1, 103),   -- Products 101, 102, 103 always bought together
(2, 101), (2, 102), (2, 103),
(3, 101), (3, 102), (3, 103),
(4, 101), (4, 104),             -- Product 101 + 104 together (but not always with 102/103)
(5, 102), (5, 103),             -- 102+103 appear without 101
(6, 105), (6, 106);             -- Random other products

select * from order_items;

# main code
select least(a.product_id,b.product_id) as product1, greatest(a.product_id,b.product_id) as product2, 
count(distinct a.order_id) as total_times
from order_items a 
inner join order_items b 
on a.order_id = b.order_id and 
a.product_id <> b.product_id
group by product1,product2
having count(distinct a.order_id) = 
( select count(distinct oi.order_id) from order_items oi 
where oi.product_id = product1 );

# the answer contains 105, 106 pair because it's ordered just 1 time and 
# they are together,105 or 106 has not been order any other time as single or with other pair as well so they are always together

# how many times each pair has been ordered
select least(a.product_id,b.product_id) as product1, greatest(a.product_id,b.product_id) as product2, 
count(distinct a.order_id) as total_times
from order_items a inner join order_items b
where a.order_id = b.order_id and a.product_id <> b.product_id
group by 1,2 ;

# how many times each products were ordered
select product_id, count(distinct order_id) from order_items group by 1;
