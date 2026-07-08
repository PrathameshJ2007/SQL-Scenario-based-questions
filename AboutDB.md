# Database Name

`Tables_in_ecom`

---

# Schema Architecture

```
                     +----------------+
                     |   dim_date     |
                     +----------------+
                            |
                            |
+----------------+    +----------------+    +----------------+
| dim_customer   |----|   fact_sales   |----|  dim_product   |
+----------------+    +----------------+    +----------------+
                            |
                            |
                     +----------------+
                     |   dim_store    |
                     +----------------+
```

`fact_sales` stores transactional sales data and references all dimension tables using surrogate keys.

---

# Tables

## 1. dim_customer

Stores customer-related information.

| Column | Data Type | Description |
|---------|----------|-------------|
| customer_key | INT (PK) | Surrogate key |
| customer_id | VARCHAR(20) | Business customer ID |
| first_name | VARCHAR(50) | Customer first name |
| last_name | VARCHAR(50) | Customer last name |
| gender | CHAR(1) | Gender |
| email | VARCHAR(100) | Email address |
| phone | VARCHAR(20) | Contact number |
| country | VARCHAR(50) | Country |
| state | VARCHAR(50) | State |
| city | VARCHAR(50) | City |
| join_date | DATE | Customer registration date |

---

## 2. dim_date

Stores calendar information used for time-based analysis.

| Column | Data Type | Description |
|---------|----------|-------------|
| date_key | INT (PK) | Surrogate key |
| date | DATE | Full date |
| day | INT | Day of month |
| month | INT | Month number |
| month_name | VARCHAR(20) | Month name |
| quarter | INT | Quarter |
| year | INT | Year |
| is_weekend | TINYINT(1) | Weekend indicator |

---

## 3. dim_product

Stores product details.

| Column | Data Type | Description |
|---------|----------|-------------|
| product_key | INT (PK) | Surrogate key |
| product_id | VARCHAR(20) | Business product ID |
| product_name | VARCHAR(100) | Product name |
| category | VARCHAR(50) | Product category |
| brand | VARCHAR(50) | Brand |
| unit_price | DECIMAL(10,2) | Standard selling price |
| launch_date | DATE | Product launch date |

---

## 4. dim_store

Stores store information.

> **Note:** The provided schema appears to duplicate the product columns. Normally, `dim_store` should contain store-related attributes.

### Expected Structure

| Column | Data Type | Description |
|---------|----------|-------------|
| store_key | INT (PK) | Surrogate key |
| store_id | VARCHAR(20) | Store identifier |
| store_name | VARCHAR(100) | Store name |
| city | VARCHAR(50) | Store city |
| state | VARCHAR(50) | Store state |
| country | VARCHAR(50) | Store country |
| manager | VARCHAR(100) | Store manager |
| opening_date | DATE | Opening date |

---

## 5. fact_sales

Stores all sales transactions.

| Column | Data Type | Description |
|---------|----------|-------------|
| sales_id | INT (PK) | Sales transaction ID |
| date_key | INT (FK) | References dim_date |
| customer_key | INT (FK) | References dim_customer |
| product_key | INT (FK) | References dim_product |
| store_key | INT (FK) | References dim_store |
| quantity_sold | INT | Quantity sold |
| unit_price | DECIMAL(10,2) | Selling price per unit |
| discount | DECIMAL(10,2) | Discount applied |
| total_amount | DECIMAL(10,2) | Final sale amount |

---
