# Fraudulent Transactions (Impossible Travel) 🚨

This SQL example detects **fraudulent transactions** (also known as *impossible travel*).  
A user makes two transactions from **different locations** within a **time gap too small to be possible**.

---

## 📝 Problem
Find cases where:
- The **same user** has multiple transactions,
- From **different locations**,
- Within **less than 2 hours**.

---

## 📂 Solution (MySQL with Window Functions)
```sql
WITH txn_cte AS (
    SELECT txn_id, user_id, txn_time, location,
           LAG(txn_time) OVER (PARTITION BY user_id ORDER BY txn_time) AS prev_time,
           LAG(location) OVER (PARTITION BY user_id ORDER BY txn_time) AS prev_location
    FROM transactions
)
SELECT *
FROM txn_cte
WHERE prev_time IS NOT NULL
  AND TIMESTAMPDIFF(MINUTE, prev_time, txn_time) < 120
  AND location <> prev_location;
