WITH customer_ltv AS (	
	SELECT 
		customerkey,
		full_name,
		SUM(total_net_revenue) AS total_revenue
	FROM cohort_analysis 
	GROUP BY 
		customerkey,
		full_name
), ltv_percentile AS (
	SELECT 
		PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY c.total_revenue) AS ltv_25th_percentile,
		PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY c.total_revenue) AS ltv_75th_percentile
	FROM customer_ltv c
), customer_segments AS (
	SELECT 
		c.*,
		CASE 
			WHEN c.total_revenue < l.ltv_25th_percentile THEN '1- Low Value'
			WHEN c.total_revenue > l.ltv_75th_percentile THEN '3- High Value'
			ELSE '2- Mid Value'
		END AS customer_segment
	FROM customer_ltv c , ltv_percentile l
)
SELECT 
	customer_segment,
	SUM(total_revenue) AS segment_revenue,
	COUNT(customer_segment) AS segment_size,
	SUM(total_revenue) / COUNT(customer_segment) AS avg_customer_revenue
FROM customer_segments 
GROUP BY 
	customer_segment
	
	
	
	