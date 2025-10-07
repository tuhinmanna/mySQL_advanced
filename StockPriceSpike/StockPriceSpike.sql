use comp;

CREATE TABLE stocks (
    stock_id INT,
    price DECIMAL(10,2),
    date DATE
);

INSERT INTO stocks VALUES
(1, 100.00, '2025-01-01'),
(1, 110.00, '2025-01-02'),
(1, 125.00, '2025-01-03'),
(1, 130.00, '2025-01-04'),
(2, 200.00, '2025-01-01'),
(2, 210.00, '2025-01-02'),
(2, 215.00, '2025-01-03'),
(2, 218.00, '2025-01-04'),
(3, 50.00, '2025-01-01'),
(3, 80.00, '2025-01-02'),
(3, 85.00, '2025-01-03');

select * from stocks;

with prices as (
	select * , 
    lag(price,2) over(partition by stock_id order by date) as prior_price
    from stocks
)
select stock_id , date, price, prior_price, round(((price - prior_price) * 100 )/ prior_price,2) as increase
from prices 
where ((price - prior_price) * 100 )/ prior_price >= 20
AND prior_price is not NULL;
