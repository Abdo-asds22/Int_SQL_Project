WITH customer_last_purchase AS (
	SELECT 
		customerkey,
		full_name,
		orderdate,
		first_purchase_date,
		ROW_NUMBER() OVER(PARTITION BY customerkey ORDER BY orderdate DESC) AS rn,
		cohort_year
	FROM cohort_analysis
), customer_activity_status AS (
	SELECT 
		customerkey,
		full_name,
		orderdate AS last_purchase_date,
		CASE 
			WHEN orderdate < (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months' THEN 'Churned'
			ELSE 'Active'
		END AS customer_status,
		cohort_year
	FROM customer_last_purchase
	WHERE rn = 1
		AND first_purchase_date < (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months'
)
SELECT 
	cohort_year,
	customer_status,
	COUNT(customerkey) AS customer_size,
	SUM(COUNT(customerkey)) OVER(PARTITION BY cohort_year) AS all_customers,
	ROUND(COUNT(customerkey) / SUM(COUNT(customerkey)) OVER(PARTITION BY cohort_year), 2) AS status_ratio
FROM customer_activity_status
GROUP BY cohort_year, customer_status
