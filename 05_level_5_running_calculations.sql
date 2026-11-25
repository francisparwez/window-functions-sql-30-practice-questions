-- 25. Calculate Running Total of Sales
-- Scenario:
-- A company wants to track cumulative sales throughout the year.
-- Example:
--     Date Sales Running Total
--     Jan 1 1000 1000
--     Jan 2 1500 2500
--     Jan 3 2000 4500
-- Task:
-- Calculate the running sales total.
-- Concept: SUM() OVER(ORDER BY ...)

USE WindowFunctionsPracticeDB;
GO

SELECT
	sales_date AS [Date],
	sales_amount AS Sales,
	SUM(sales_amount) OVER (ORDER BY sales_date ASC) AS [Running Total]
FROM daily_sales
ORDER BY sales_date ASC;

-- 26. Calculate Running Total for Each Customer
-- Scenario:
-- An e-commerce company wants to see how each customer's spending accumulated over
-- time.
-- Task:
-- Return:
-- 	customer_id
-- 	order_date
-- 	order_amount
-- 	running_customer_spending
-- Concept: SUM() + PARTITION BY + ORDER BY

USE WindowFunctionsPracticeDB;
GO

SELECT
    c.customer_id,
    o.order_date,
    o.amount AS order_amount,
    SUM(o.amount) OVER (
        PARTITION BY
            c.customer_id
        ORDER BY o.order_date ASC, o.order_id ASC
    ) AS running_customer_spending
FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_id ASC, o.order_date ASC;

-- 27. Calculate Running Average of Sales
-- Scenario:
--     Management wants to see the average sales value accumulated up to each day.
-- Task:
-- Return:
--     date
--     sales
--     running_average_sales
-- Concept:
--     AVG() OVER(ORDER BY ...)

USE WindowFunctionsPracticeDB;
GO

SELECT
	sales_date AS [date],
	sales_amount AS [sales],
	CAST(AVG(sales_amount) OVER (
		ORDER BY sales_date ASC
	) AS DECIMAL(10, 2)) AS running_average_sales
FROM daily_sales
ORDER BY sales_date ASC;