use comp;

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10,2)
);

INSERT INTO orders VALUES
(1, 101, '2025-01-10', 100.00),
(2, 101, '2025-02-15', 120.00),
(3, 101, '2025-03-05', 90.00),
(4, 101, '2025-04-01', 600.00),   -- anomaly (>> avg of last 6 months)
(5, 102, '2025-01-12', 200.00),
(6, 102, '2025-03-01', 250.00),
(7, 102, '2025-04-05', 300.00);   -- normal


# Using selfJoin

with cte1 as (
SELECT o.order_id, o.customer_id, o.order_date, o.order_amount,
         AVG(o2.order_amount) AS avg_6m
  FROM orders o
  JOIN orders o2
       ON o.customer_id = o2.customer_id
      AND o2.order_id <> o.order_id
      AND o2.order_date BETWEEN DATE_SUB(o.order_date, INTERVAL 6 MONTH) AND o.order_date
  GROUP BY o.order_id, o.customer_id, o.order_date, o.order_amount order by o.customer_id,o.order_date
)
select * from cte1 where order_amount > 3 * avg_6m;



# using window function
with cte2 as (
SELECT order_id,
         customer_id,
         order_date,
         order_amount,
         AVG(order_amount) OVER (
             PARTITION BY customer_id
             ORDER BY order_date
             RANGE BETWEEN INTERVAL 6 MONTH PRECEDING AND INTERVAL 1 DAY PRECEDING) as rnk
from orders)
select * from cte2 
where rnk is not null and
order_amount > 3* rnk;
             