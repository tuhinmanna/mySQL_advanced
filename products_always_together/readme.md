
# 🛒 Products Always Sold Together

## 📌 Problem
Identify **pairs of products** that are **always purchased together** .  
For example, if product **101** and **102** occur in every order together (and never alone), then they are considered "always sold together".

---

## 🗂️ Input (order_items)

| order_id | product_id |
|----------|------------|
| 1        | 101        |
| 1        | 102        |
| 1        | 103        |
| 2        | 101        |
| 2        | 102        |
| 2        | 103        |
| 3        | 101        |
| 3        | 102        |
| 3        | 103        |
| 4        | 101        |
| 4        | 104        |
| 5        | 102        |
| 5        | 103        |
| 6        | 105        |
| 6        | 106        |

---

## 💡 Output

| product1 | product2 | times_together |
|----------|----------|----------------|
| 102      | 103      | 4              |
| 105      | 106      | 1              |

✅ Products **102, 103** are always bought together across 4 orders.
Product **101, 102** are together however **101** is also ordered with **104**
**105,106** are bought only 1 times no presense anywhere else, so per the current table they are eligible for being together always

---

## ✅ Key Concepts
- **Self-join** on `order_id` to find product pairs in the same order.  
- **LEAST() / GREATEST()** to normalize product pairs (avoid duplicates).  
- **Mutual check**: ensure both products appear **exclusively together**.  

