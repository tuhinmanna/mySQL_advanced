use comp;

CREATE TABLE cart_events (
    user_id INT,
    cart_id INT,
    event_type VARCHAR(20),
    event_time TIMESTAMP
);

INSERT INTO cart_events VALUES
(1, 1001, 'add',     '2025-01-01 10:00:00'),
(1, 1001, 'checkout','2025-01-03 14:00:00'),
(2, 1002, 'add',     '2025-01-01 11:00:00'),
(2, 1002, 'remove',  '2025-01-02 09:00:00'),
(2, 1002, 'add',     '2025-01-05 12:00:00'),
(3, 1003, 'add',     '2025-01-01 08:00:00'),
(3, 1003, 'remove',  '2025-01-02 08:00:00'),
(4, 1004, 'add',     '2025-01-01 15:00:00'),
(5, 1005, 'add',     '2025-01-01 16:00:00'),
(5, 1005, 'checkout','2025-01-20 09:00:00');

select * from cart_events;

with cart_add as (
	select user_id, cart_id, min(event_time) as addtime
    from cart_events
    where event_type = 'add'
    group by 1,2
),
checkout as (
	select user_id, cart_id, min(event_time) as checkouttime
    from cart_events
    where event_type = 'checkout'
    group by 1,2
)
select a.user_id, a.cart_id, a.addtime as first_add_time, c.checkouttime as checkout_time,
case
when c.checkouttime is null then 'Abandoned'
when timestampdiff(DAY,addtime,checkouttime) > 7 then 'Abandoned'
else 'Completed'
end as Cart_Status
from cart_add a
left join checkout c
on a.user_id = c.user_id and a.cart_id = c.cart_id;