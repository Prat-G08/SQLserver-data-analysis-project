/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/

--Segment products into cost ranges and count how many products fall into each segment
WITH category_sales AS (
SELECT 
	p.category,
	SUM(f.sales_amount) AS sales_per_category
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
GROUP BY p.category
)

SELECT 
	category,
	sales_per_category,
	SUM(sales_per_category) OVER() AS total_sales,
	CONCAT(ROUND((sales_per_category * 100.0/SUM(sales_per_category) OVER()), 2), '%') AS percentage
FROM category_sales
