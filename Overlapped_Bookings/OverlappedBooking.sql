use comp;

CREATE TABLE bookings (
    booking_id INT,
    room_id INT,
    start_time TIMESTAMP,
    end_time TIMESTAMP
);

INSERT INTO bookings VALUES
-- Room 100: 3 bookings, partial overlaps
(1, 100, '2025-01-01 10:00:00', '2025-01-01 12:00:00'),
(2, 100, '2025-01-01 11:30:00', '2025-01-01 13:00:00'),
(3, 100, '2025-01-01 12:30:00', '2025-01-01 14:00:00'),

-- Room 101: consecutive bookings (no overlap)
(4, 101, '2025-01-01 09:00:00', '2025-01-01 10:00:00'),
(5, 101, '2025-01-01 10:00:00', '2025-01-01 11:00:00'),
(6, 101, '2025-01-01 11:00:00', '2025-01-01 12:00:00'),

-- Room 102: one booking completely inside another
(7, 102, '2025-01-01 09:00:00', '2025-01-01 12:00:00'),
(8, 102, '2025-01-01 10:00:00', '2025-01-01 11:00:00'),

-- Room 103: multiple overlapping bookings
(9, 103, '2025-01-01 13:00:00', '2025-01-01 15:00:00'),
(10, 103, '2025-01-01 14:00:00', '2025-01-01 16:00:00'),
(11, 103, '2025-01-01 14:30:00', '2025-01-01 15:30:00'),

-- Room 104: single booking (no overlap)
(12, 104, '2025-01-01 09:00:00', '2025-01-01 11:00:00'),

-- Room 105: partial overlap + consecutive
(13, 105, '2025-01-01 12:00:00', '2025-01-01 14:00:00'),
(14, 105, '2025-01-01 13:30:00', '2025-01-01 15:30:00'),

-- Room 106: mixed (gaps + some overlap)
(15, 106, '2025-01-01 09:00:00', '2025-01-01 11:00:00'),
(16, 106, '2025-01-01 10:30:00', '2025-01-01 12:00:00'),
(17, 106, '2025-01-01 12:30:00', '2025-01-01 14:00:00');

select * from bookings;

select b1.booking_id, b2.booking_id, b1.room_id, b1.start_time as first_booking_start, b1.end_time as first_booking_end,
 b2.start_time as second_booking_start, b2.end_time as second_booking_end
from bookings b1 
inner join bookings b2
where b1.room_id = b2.room_id
and b1.booking_id < b2.booking_id
and b1.start_time < b2.end_time
and b2.start_time < b1.end_time;