# Question2 : See fradulant transaction. difference between 120 minute between 2 location

CREATE TABLE transactions (
    txn_id INT,
    user_id INT,
    txn_time DATETIME,
    location VARCHAR(50),
    amount DECIMAL(10,2)
);

INSERT INTO transactions VALUES
(1, 101, '2025-01-01 10:00:00', 'New York', 200.00),
(2, 101, '2025-01-01 10:45:00', 'London', 150.00),
(3, 101, '2025-01-02 09:00:00', 'New York', 300.00),
(4, 102, '2025-01-01 11:00:00', 'Paris', 100.00),
(5, 102, '2025-01-01 11:30:00', 'Paris', 250.00);

with ftd as (
	select *, lag(txn_time) over(partition by user_id order by txn_time) as prev_time,
    lag(location) over(partition by user_id order by txn_time) as prev_loc
    from transactions
)
select user_id, txn_time, location, prev_time, prev_loc from ftd
where prev_time is not null and timestampdiff(minute,prev_time,txn_time)<120 and location <> prev_loc;

select timestampdiff(minute,'2025-1-1 10:40:00','2025-1-1 10:30:00');  #t2-t1
SELECT TIMEDIFF('10:00:00', '08:30:00'); # t1-t2