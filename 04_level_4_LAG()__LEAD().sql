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

-- 21. Find the Next Order for Each Customer
-- Scenario:
-- An e-commerce company wants to know when each customer placed their next order.
-- Task:
-- Show:
--     customer_id
--     order_date
--     next_order_date
-- Concept: LEAD() + PARTITION BY

USE WindowFunctionsPracticeDB;

SELECT
    customer_id,
    order_date,
    LEAD(order_date) OVER (
        PARTITION BY
            customer_id
        ORDER BY order_date ASC
    ) AS next_order_date
FROM orders
ORDER BY customer_id ASC, order_date ASC;

-- 22. Calculate Days Until Next Order
-- Scenario:
-- Marketing wants to understand how frequently customers return.
-- Task:
-- Show:
--     customer_id
--     order_date
--     next_order_date
--     days_until_next_order
-- Concept: LEAD()

USE WindowFunctionsPracticeDB;

SELECT
    customer_id,
    order_date,
    LEAD(order_date) OVER (
        PARTITION BY
            customer_id
        ORDER BY order_date ASC
    ) AS next_order_date,
    DATEDIFF(
        DAY,
        order_date,
        LEAD(order_date) OVER (
            PARTITION BY
                customer_id
            ORDER BY order_date ASC
        )
    ) AS days_until_next_order
FROM orders
ORDER BY customer_id ASC, order_date ASC;

-- 23. Compare Monthly Revenue With Previous Month
-- Scenario:
-- A business has monthly revenue data.
-- Task:
-- Show:
--     month
--     revenue
--     previous_month_revenue
-- Concept: LAG()

USE WindowFunctionsPracticeDB;

SELECT
    revenue_month AS [month],
    revenue,
    LAG(revenue) OVER (
        ORDER BY revenue_month ASC
    ) AS previous_month_revenue
FROM monthly_revenue
ORDER BY revenue_month ASC;