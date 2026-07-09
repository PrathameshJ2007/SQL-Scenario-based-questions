# SQL Practice Scenarios (E-Commerce Star Schema)

These scenarios are designed like real interview or company tasks rather than textbook exercises. They use only the **E-Commerce Star Schema** and cover nearly every concept from the SQL Bootcamp.

---

# Scenario 1: Sales Performance by Country

### Objective
The CEO wants to know which countries generated the highest revenue '2025'.

### Task

- Display:
  - Country
  - Total Revenue
  - Total Orders
  - Average Order Value
- Sort by **Revenue** in descending order.
- Show only countries with **Revenue > ₹10,000**.

---

# Scenario 2: Best Selling Products

### Objective
Management wants to identify products that consistently sell well.

### Task

- Display:
  - Product Name
  - Category
  - Total Quantity Sold
  - Total Revenue
- Show only the **Top 10** products based on **Quantity Sold**.
- If quantities tie, use **Revenue** as the tiebreaker.(Use 2 statement in orderby )

---

# Scenario 3: Weekend vs Weekday Analysis

### Objective
Marketing believes customers spend more on weekends.

### Task

Using **dim_date**, compare:

- Weekend Sales
- Weekday Sales
- Difference
- Percentage Increase

---

# Scenario 4: Customer Lifetime Value

### Objective
The CRM team wants to reward loyal customers.

### Task

For every customer display:

- Customer Name
- Total Orders
- Total Amount Spent
- Average Order Value
- Customer Rank (based on Total Spending)

---

# Scenario 5: Monthly Sales Trend

### Objective
Create a monthly sales report.

### Display

- Month
- Revenue
- Previous Month Revenue
- Revenue Growth %
- Running Total Revenue

---

# Scenario 6: Product Category Contribution

### Objective
Management wants to know which categories contribute the most to business.

### Display

- Category
- Revenue
- Percentage Contribution
- Rank

---

# Scenario 7: First Purchase

### Objective
Find customers who made their **first purchase within 30 days of joining**.

### Display

- Customer Name
- Join Date
- First Purchase Date
- Days Taken

---

# Scenario 8: Detect High Discounts

### Objective
Finance wants to detect suspicious discounts.

### Task

Display all sales where:

- Discount > **25% of Unit Price**

Include:

- Customer
- Product
- Store
- Date

---

# Scenario 9: Repeat Customers

### Objective
Identify customers who purchased the **same product more than once**.

### Display

- Customer
- Product
- Number of Purchases

---

# Scenario 10: Top Product in Every Category

### Objective
Without using `LIMIT`, display only the **highest-selling product** from each category.

**Hint:** Ranking Functions

---

# Scenario 11: Revenue Leaderboard

### Display

- Customer
- Revenue
- Dense Rank
- Previous Customer Revenue
- Revenue Difference

---

# Scenario 12: Products Never Sold

### Objective
Business wants to discontinue products that never sold.

### Display

- Product ID
- Product Name
- Category

---

# Scenario 13: Customers Without Purchases

### Objective
Find customers who registered but never placed any order.

---

# Scenario 14: Consecutive Growth

### Objective
Find months where revenue increased compared to the previous month.

### Display

- Month
- Revenue
- Previous Revenue
- Growth %

---

# Scenario 15: Highest Revenue Day

### Objective
Find the date having the maximum revenue.

### Display

- Date
- Revenue
- Number of Orders
- Average Order Value

---

# Scenario 16: Customer Spending Classification

### Objective
Classify customers into spending tiers based on **Total Spending**.

### Rules

| Total Spending | Classification |
|---------------|----------------|
| > 100000 | VIP |
| 50000 – 100000 | Premium |
| 10000 – 50000 | Regular |
| Below 10000 | New |

---

# Scenario 17: Revenue Above Category Average

### Objective
Find products whose revenue is higher than the **average revenue of their own category**.

**Hint:** Correlated Subquery or CTE

---

# Scenario 18: Sales Dashboard View

### Objective
Create a SQL View named:

```sql
vw_sales_dashboard
```

### Columns

- Date
- Customer
- Product
- Category
- Store
- Quantity
- Discount
- Revenue

The view should be ready for **Power BI** or **Tableau**.

---

# Scenario 19: Stored Procedure

### Objective
Create a Stored Procedure:

```sql
GetCustomerSales(IN customerID VARCHAR(20))
```

### Output

- Customer Name
- Orders
- Quantity Purchased
- Revenue
- Average Order Value

---

# Scenario 20: User Defined Function

### Objective
Create a function:

```sql
CalculateDiscountPercent()
```

### Input

- Unit Price
- Discount

### Output

- Discount Percentage

Use it inside a query that displays:

- Product
- Unit Price
- Discount
- Discount %

---


# Recommended Difficulty Progression

| Level | Scenarios | Concepts Covered |
|--------|-----------|------------------|
| ⭐ Basic–Intermediate | 1–5 | JOINs, GROUP BY, HAVING, ORDER BY |
| ⭐⭐ Intermediate | 6–10 | Window Functions, Ranking, CASE, Date Functions |
| ⭐⭐⭐ Advanced | 11–15 | LAG, LEAD, CTEs, Correlated Subqueries |
| ⭐⭐⭐⭐ Expert | 16–20 | Views, Stored Procedures, User-Defined Functions |

---

# Coverage

These scenarios collectively test nearly every important SQL concept:

- Joins
- Aggregations
- GROUP BY & HAVING
- CASE Expressions
- Date Functions
- Subqueries
- Correlated Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- Ranking Functions
- Views
- Stored Procedures
- User-Defined Functions
- Analytical SQL
- Business Reporting Queries
