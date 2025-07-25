SELECT 
	DATE_TRUNC('month', ca.orderdate)::date AS year_month,
	COUNT(DISTINCT customerkey) AS total_customers,
	SUM(total_net_revenue) AS total_revenue,
	(SUM(total_net_revenue) / COUNT(DISTINCT customerkey) ) AS customer_revenue
FROM cohort_analysis ca
WHERE orderdate = first_date_purchase
GROUP BY 
	year_month
