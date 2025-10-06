# 🏃 Running Competition Leaderboard – Rank Progression

## 📌 Problem
Given a `races` table:

race_id | user_id | finish_time | race_date
--------+---------+-------------+------------
1       | 101     | 320         | 2025-01-01
1       | 102     | 300         | 2025-01-01
1       | 103     | 340         | 2025-01-01
2       | 101     | 310         | 2025-02-01
2       | 102     | 350         | 2025-02-01
2       | 103     | 290         | 2025-02-01
3       | 101     | 330         | 2025-03-01
3       | 102     | 305         | 2025-03-01
3       | 103     | 280         | 2025-03-01

Output:

user_id | race_id | race_date  | rnk | prev_rank | comments
--------+---------+------------+-----+-----------+------------
101     |   1     | 2025-01-01 |  2  |   NULL    | First race
101     |   2     | 2025-02-01 |  2  |    2      | Same pos retained
101     |   3     | 2025-03-01 |  3  |    2      | Dropped
102     |   1     | 2025-01-01 |  1  |   NULL    | First race
102     |   2     | 2025-02-01 |  3  |    1      | Dropped
102     |   3     | 2025-03-01 |  2  |    3      | Improved
103     |   1     | 2025-01-01 |  3  |   NULL    | First race
103     |   2     | 2025-02-01 |  1  |    3      | Improved
103     |   3     | 2025-03-01 |  1  |    1      | Same pos retained
