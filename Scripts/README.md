# Intermediate SQL - Sales Analysis

## Overview
Analysis of customer behavior, life-time value, and retention for an e-commerce company to improve customer retention and maximize revenue.

## Business Questions 
1. **Customer Segmentation:** What value do each customer segment by LTV contripute to the total revenue?

2. **Cohort Analysis:** How do different customer groups generate revenue?

3. **Churn Analysis:** Who hasn't purchased recently?

## Analysis Approach 
### 1. Customer Segmentation
- Categorize customers based on total lifetime value(LTV).
- Assigned customers to high, mid, low segments.
- Calculate key metrics: total revenue.

🖥️Query: [1_customer_segmentation.sql](1_customer_segmentation.sql)

**📈Visualization**

![Customer Segmentation](/Scripts/images/1_customer_segmentation.png)

📊**Key Findings:**
- High-value customers: (25% of total customers) generate 66% of revenue ($135.4M).
- Mid-value customers: (50% of total customers) generate 32% of revenue ($66.6M).
- Low-value customers: (25% of total customers) generate 2% of revenue ($4.34M).

💡**Business Insights:**
- Focus retention, loyalty programs, and personalized services on high-value segment to protect and grow this core revenue base.
- Develop cross-selling/up-selling strategies to move Mid-Value customers toward higher spending tiers.
- Consider automating service, reducing acquisition costs, or even re-evaluating whether low-value segment is strategically worth targeting heavily.


### 2. Cohort Analysis
- Tracked revenue and customer count per cohort.
- Cohorts where grouped by year of first purchase.
- Analyzed customer retention at a cohort level.

🖥️Query: [2_cohort_analysis.sql](/Scripts/images/2_cohort_analysis.png)
```sql
SELECT 
	cohort_year,
	COUNT(DISTINCT customerkey) AS total_customers,
	SUM(total_net_revenue) AS total_revenue,
	(SUM(total_net_revenue) / COUNT(DISTINCT customerkey) ) AS customer_revenue
FROM cohort_analysis 
WHERE orderdate = first_date_purchase
GROUP BY 
	cohort_year
```
**📊Visualization:**

![Cohort Analysis](/Scripts/images/2_cohort_analysis.png)

**🔎Key Findings:**
- Revenue per customer shows an alarming decreasing trend
  over  time.
    - 2022-2024 cohorts are consistenly performing worse than earlier cohorts.
    - NOTE: Although net revenue is increasing, this is likely due to a larger customer base, which is not reflective of customer value.

💡**Business Insights**
- Value extracted from customers is decreasing over time and need futher investigation.
- In 2023 we see a drop in number of customers acquired, which is concerning.
- With both lowering LTV and decreasing customer aquisition, the company is facing a potential revenue decline.

### 3. Churn Analysis
- Identify customers at risk of churning.
- Analyze last purchase pattern.
- Calculate customer specific metrics.

🖥️ Query: [3_churn_analysis.sql](/Scripts\3_churn_analysis.sql)  

**📊Visualization**
![churn_analysis](/Scripts/images/3_churn_analysis.png)

**🔎Key Findings**
- **Consistently High Churn:** Across all cohorts (2015–2023), churn rates hover around 90–92%, indicating that the vast majority of users do not remain active beyond their first year.

- **Gradual Uptick in Retention:** Active ratios rose from 8% in 2015 to 10% in 2022–2023, signaling modest improvements in customer retention over time.

- **Plateau Effect Since 2016:** Aside from the initial jump from 8% to 9% (2015→2016), retention has largely plateaued at 9–10%, suggesting that past initiatives had limited incremental impact.

**💡Business Insights:**
- **Target Early Cohorts with Enhanced Onboarding:** Since the biggest lift came between 2015 and 2016, focus on replicating and scaling the successful tactics from that period—e.g. personalized welcome flows, early-engagement incentives—to boost retention in newer cohorts.

- **Invest in Continuous Engagement Programs:** With retention stalling around 9–10%, introduce periodic value-driving touchpoints (loyalty rewards, feature webinars, in-app nudges) to move the needle beyond the current plateau.

- **Leverage Cohort-Specific Feedback Loops:** Conduct qualitative surveys or usage analytics per cohort to pinpoint drop-off drivers, then tailor product and marketing adjustments cohort by cohort rather than one-size-fits-all.

## Technical details:
- **Database:** PostgreSQL
- **Analysis Tools:** PostgreSQL, DBeaver, PGAdmin
- **Visualizations:** Excel
