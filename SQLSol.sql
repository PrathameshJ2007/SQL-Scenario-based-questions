-- Scenario 1: Sales Performance by Country
SELECT
	C.country ,
	SUM(F.quantity_sold) AS Total_Orders,
	SUM(F.total_amount) AS Total_Revenue,
	ROUND(AVG(F.total_amount),2) AS Average_Order_Value
FROM 
	(fact_sales F
		LEFT JOIN  dim_customer C 
			ON F.customer_key = C.customer_key
		LEFT JOIN dim_date D 
			ON  F.date_key = D.date_key )
WHERE D.year = '2025'
GROUP BY C.country 
	HAVING Total_Revenue > 10000
ORDER BY Total_Revenue DESC;

-- Scenario 2: Best Selling Products
SELECT 
	P.product_name , 
    P.category,
    SUM(F.quantity_sold) AS Total_sold,
    SUM(F.total_amount) AS Total_revenue
FROM
	fact_sales F
LEFT JOIN dim_product P ON F.product_key = P.product_key
GROUP BY 
	P.product_name,
    P.category
ORDER BY Total_sold desc
LIMIT 10;

-- Scenario 3: Weekend vs Weekday Analysis
SELECT
    SQ.Weekend_Sales,
    SQ.Weekday_Sales,
    Weekend_Sales - Weekday_Sales AS Difference,
    (Weekend_Sales - Weekday_Sales) / Weekday_Sales * 100 AS Percentage_Change
FROM 
(SELECT
        SUM(CASE WHEN D.is_weekend = 1 THEN F.total_amount ELSE 0 END) AS Weekend_Sales,
        SUM(CASE WHEN D.is_weekend = 0 THEN F.total_amount ELSE 0 END) AS Weekday_Sales
    FROM fact_sales F
    JOIN dim_date D 
        ON F.date_key = D.date_key
) SQ ; 

-- Scenario 4: Customer Lifetime Value
SELECT
	concat_WS(' ' , C.first_name , C.last_name) as Name ,
    sum(quantity_sold) AS Total_Orders,
    sum(total_amount) AS Total_Amount_Spent,
    avg(total_amount) AS Average_Order_Value,
    dense_rank() OVER ( ORDER BY sum(total_amount) DESC)
FROM
	fact_sales F
LEFT JOIN dim_customer C ON F.customer_key = C.customer_key
group by Name;

-- Scenario 5: Monthly Sales Trend
SELECT
	D.month_name ,
    SUM(total_amount) as Month ,
    LAG(sum(total_amount)) OVER (order by d.month_name) as prev_month ,
    ROUND(
        (
            (SUM(total_amount) - LAG(SUM(total_amount)) OVER (ORDER BY d.month_name))
            * 100.0
        ) / LAG(SUM(total_amount)) OVER (ORDER BY d.month_name),
        2
    ) AS revenue_growth_pct,
    SUM(SUM(total_amount)) OVER (
        ORDER BY d.month_name
    ) AS running_total_revenue
    
FROM 	
	fact_sales F
LEFT JOIN dim_date D ON F.date_key = D.date_key
GROUP BY D.month_name;

-- Scenario 6: Product Category Contribution
SELECT
	P.category,
    SUM(S.total_amount) as Revenue , 
    ROUND(
        SUM(S.total_amount) * 100.0 /
        SUM(SUM(S.total_amount)) OVER (),
        2
    ) AS Percentage_Contri,
    (dense_rank() over (order by SUM(S.total_amount) DESC )) AS RANKING
FROM fact_sales S
JOIN dim_product P  ON S.product_key = P.product_key
group by P.category;

-- Scenario 7: First Purchase
SELECT
    CONCAT(C.first_name, ' ', C.last_name) AS Customer_Name,
    C.join_date,
    MIN(D.date) AS First_Purchase_Date,
    MIN(D.date) - C.join_date AS Days_Taken
FROM fact_sales F
JOIN dim_customer C ON F.customer_key = C.customer_key
JOIN dim_date D ON F.date_key = D.date_key
GROUP BY
    C.customer_key,
    C.first_name,
    C.last_name,
    C.join_date
HAVING MIN(D.date) - C.join_date <= 30;

-- Scenario 8: Detect High Discounts
SELECT
    CONCAT(C.first_name, ' ', C.last_name) AS Customer_Name,
    p.product_name,
    s.store_name ,
    D.date
FROM fact_sales F
JOIN dim_customer C ON F.customer_key = C.customer_key
JOIN dim_product P ON F.product_key = P.product_key
JOIN dim_store S on F.store_key = S.store_key
JOIN dim_date D on F.date_key = D.date_key
where F.discount > 25;

-- Scenario 9: Repeat Customers
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS Customer,
    p.product_name AS Product,
    COUNT(*) AS Number_of_Purchases
FROM fact_sales F
JOIN dim_customer C ON F.customer_key = C.customer_key
JOIN dim_product P ON F.product_key = P.product_key
JOIN dim_store S on F.store_key = S.store_key
GROUP BY
    c.first_name,
    c.last_name,
    p.product_name
HAVING COUNT(*) > 1
ORDER BY
    Customer,
    Product;
    
-- Scenario 10: Top Product in Every Category
select 
	 SQ.product_name, 
    SQ.category, 
    SQ.total_sold
FROM (
SELECT 
    P.product_name, 
    P.category, 
    SUM(F.quantity_sold) AS total_sold, 
    DENSE_RANK() OVER (
        PARTITION BY P.category 
        ORDER BY SUM(F.quantity_sold) DESC
    ) AS ranking
FROM fact_sales F 
LEFT JOIN dim_product P 
    ON F.product_key = P.product_key 
GROUP BY 
    P.product_name, 
    P.category
) AS SQ
WHERE ranking= 1 ;

-- Scenario 11: Revenue Leaderboard
SELECT
	CONCAT(C.first_name , ' ' , C.last_name) AS Name,
    SUM(F.total_amount) as Revenue,
    dense_rank() over (order by (SUM(F.total_amount) )desc)  AS RANKING,
	lag(SUM(F.total_amount)) over (Order by (SUM(F.total_amount) )desc) AS PREV_REVENUE
FROM
	fact_sales F
LEFT JOIN dim_customer C on F.customer_key = C.customer_key
group by C.first_name , C.last_name;
