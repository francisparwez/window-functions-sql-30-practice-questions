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