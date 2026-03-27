/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

--Calculate total sales in each month
--Calculate running total of sales over time 
SELECT 
	t.order_date,
	t.total_sales_amount,
	SUM(t.total_sales_amount) OVER (ORDER BY t.order_date) AS running_total_sales,
	AVG(t.avg_price) OVER (ORDER BY t.order_date) AS running_average_price
FROM(
SELECT 
	DATETRUNC(MONTH, order_date) AS order_date, 
	SUM(sales_amount) AS total_sales_amount,
	AVG(price) AS avg_price
FROM gold.fact_sales
WHERE DATETRUNC(MONTH, order_date) IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
) AS t

--Calculate total sales in each month
--Calculate running total of sales over time for every year  
SELECT 
	t2.order_date,
	t2.total_sales_amount,
	SUM(t2.total_sales_amount) OVER (PARTITION BY YEAR(t2.order_date) ORDER BY t2.order_date) AS running_total_sales,
	AVG(t2.avg_price) OVER (PARTITION BY YEAR(t2.order_date) ORDER BY t2.order_date) AS running_average_price
FROM(
SELECT 
	DATETRUNC(MONTH, order_date) AS order_date, 
	SUM(sales_amount) AS total_sales_amount,
	AVG(price) AS avg_price
FROM gold.fact_sales
WHERE DATETRUNC(MONTH, order_date) IS NOT NULL
GROUP BY DATETRUNC(MONTH, order_date)
) AS t2
