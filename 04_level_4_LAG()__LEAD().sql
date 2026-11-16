-- 18. Compare Today's Sales With Yesterday's Sales
-- Scenario:
-- A company records daily sales.
-- Task:
-- Show:
--     date
--     sales
--     previous_day_sales
-- Use LAG() .
-- Concept: LAG()

USE WindowFunctionsPracticeDB;
GO

SELECT
    sales_date AS [date],
    sales_amount AS sales,
    LAG(sales_amount, 1) OVER (
        ORDER BY sales_date ASC
    ) AS previous_day_sales
FROM daily_sales;

-- 19. Calculate Daily Sales Change
-- Scenario:
-- Management wants to know how much sales changed compared with the previous day.
-- Task:
-- Return:
--     date
--     sales
--     previous_day_sales
--     sales_difference
-- Concept: LAG()

USE WindowFunctionsPracticeDB;
GO

SELECT
	sales_date AS [date],
    sales_amount AS sales,
	LAG(sales_amount, 1) OVER(
		ORDER BY sales_date ASC
	) AS previous_day_sales,
	sales_amount - LAG(sales_amount, 1) OVER(
		ORDER BY sales_date ASC
	) AS sales_difference
FROM daily_sales;

--20. Compare Employee Salary With Previous Employee
--Scenario:
--	HR wants to see how salaries change when employees are ordered from lowest to highest.
--Task:
--Show:
--	employee
--	salary
--	previous_salary
--Concept: LAG()

USE WindowFunctionsPracticeDB;
GO

SELECT
    CONCAT(
        employee_id,
        ' -> ',
        employee_name
    ) AS employee,
    salary,
    LAG(salary) OVER (
        ORDER BY salary ASC, employee_id ASC
    ) AS previous_salary
FROM employees
ORDER BY salary ASC, employee_id ASC;