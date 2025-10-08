# 🛒 Shopping Cart Abandonment

## 📌 Problem
Find users who **added items but did not checkout within 7 days**.  
Carts can have multiple events: `add`, `remove`, `checkout`.  

---

## 🗂️ Input

| user_id | cart_id | event_type | event_time          |
|---------|---------|------------|---------------------|
| 1       | 1001    | add        | 2025-01-01 10:00:00 |
| 1       | 1001    | checkout   | 2025-01-03 14:00:00 |
| 2       | 1002    | add        | 2025-01-01 11:00:00 |
| 2       | 1002    | remove     | 2025-01-02 09:00:00 |
| 2       | 1002    | add        | 2025-01-05 12:00:00 |
| 3       | 1003    | add        | 2025-01-01 08:00:00 |
| 3       | 1003    | remove     | 2025-01-02 08:00:00 |
| 4       | 1004    | add        | 2025-01-01 15:00:00 |
| 5       | 1005    | add        | 2025-01-01 16:00:00 |
| 5       | 1005    | checkout   | 2025-01-20 09:00:00 |

---

## 💡 Output

| user_id | cart_id | first_add_time      | checkout_time       | cart_status |
|---------|---------|---------------------|---------------------|-------------|
| 1       | 1001    | 2025-01-01 10:00:00 | 2025-01-03 14:00:00 | Completed   |
| 2       | 1002    | 2025-01-01 11:00:00 | NULL                | Abandoned   |
| 3       | 1003    | 2025-01-01 08:00:00 | NULL                | Abandoned   |
| 4       | 1004    | 2025-01-01 15:00:00 | NULL                | Abandoned   |
| 5       | 1005    | 2025-01-01 16:00:00 | 2025-01-20 09:00:00 | Abandoned   |

---

## ✅ Key Concepts
- `MIN(event_time)` → earliest add & checkout.  
- `TIMESTAMPDIFF(DAY, add, checkout)` → check 7-day window.  
- If **no checkout** OR checkout happens **after 7 days** → `Abandoned`.  
