-- ============================================
-- Customer Churn Analysis — Cell2Cell Telecom
-- Author: Saad Ahmed
-- Tool: MySQL Workbench
-- Dataset: Cell2Cell (51,047 US telecom customers)
-- ============================================


-- -----------------------------------------------
-- QUERY 1: Overall Churn Summary
-- How many customers churned and what is the average revenue?
-- -----------------------------------------------
SELECT
    COUNT(*)                                        AS total_customers,
    SUM(Churn)                                      AS total_churned,
    ROUND(SUM(Churn) * 100.0 / COUNT(*), 2)        AS churn_rate_pct,
    ROUND(AVG(MonthlyRevenue), 2)                   AS avg_monthly_revenue
FROM customer_churn;
-- Result: 49,752 customers | 14,245 churned | 28.63% churn rate | $58.72 avg revenue


-- -----------------------------------------------
-- QUERY 2: Churn Rate by Credit Rating
-- Do customers with better credit churn more or less?
-- -----------------------------------------------
SELECT
    CreditRating,
    COUNT(*)                                        AS total_customers,
    SUM(Churn)                                      AS churned,
    ROUND(SUM(Churn) * 100.0 / COUNT(*), 2)        AS churn_rate_pct
FROM customer_churn
GROUP BY CreditRating
ORDER BY churn_rate_pct DESC;
-- Finding: High-credit customers (Good/Highest) churn at 30.7% vs 21.7% for Low credit
-- Suggests churn is driven by service quality, not financial risk


-- -----------------------------------------------
-- QUERY 3: Monthly Revenue Lost to Churn
-- What is the financial impact of customer churn?
-- -----------------------------------------------
SELECT
    ROUND(SUM(MonthlyRevenue), 2)                   AS total_monthly_revenue,
    ROUND(SUM(CASE WHEN Churn = 1 
              THEN MonthlyRevenue ELSE 0 END), 2)   AS revenue_lost_to_churn,
    ROUND(SUM(CASE WHEN Churn = 1 
              THEN MonthlyRevenue ELSE 0 END) * 100.0
          / SUM(MonthlyRevenue), 2)                 AS pct_revenue_at_risk
FROM customer_churn;
-- Finding: $824,404/month lost to churn — 28.22% of total monthly revenue at risk


-- -----------------------------------------------
-- QUERY 4: Churn Rate by Customer Tenure Group
-- At what stage of the customer lifecycle does churn peak?
-- -----------------------------------------------
SELECT
    CASE
        WHEN MonthsInService <= 12 THEN '0-12 Months (New)'
        WHEN MonthsInService <= 24 THEN '13-24 Months (Early)'
        WHEN MonthsInService <= 36 THEN '25-36 Months (Mid)'
        ELSE '36+ Months (Loyal)'
    END                                             AS tenure_group,
    COUNT(*)                                        AS total_customers,
    SUM(Churn)                                      AS churned,
    ROUND(SUM(Churn) * 100.0 / COUNT(*), 2)        AS churn_rate_pct
FROM customer_churn
GROUP BY tenure_group
ORDER BY churn_rate_pct DESC;
-- Finding: 13-24 month customers churn most at 30.52% — critical retention window


-- -----------------------------------------------
-- QUERY 5: Top 10 Service Areas by Churn Rate
-- Which US markets have the highest churn concentration?
-- (Filtered to areas with 100+ customers for statistical reliability)
-- -----------------------------------------------
SELECT
    ServiceArea,
    COUNT(*)                                        AS total_customers,
    SUM(Churn)                                      AS churned,
    ROUND(SUM(Churn) * 100.0 / COUNT(*), 2)        AS churn_rate_pct
FROM customer_churn
GROUP BY ServiceArea
HAVING COUNT(*) > 100
ORDER BY churn_rate_pct DESC
LIMIT 10;
-- Finding: Tallahassee FL (39.3%), Seattle WA (38.9%), Portland OR (37.7%)
--          are highest churn markets — geo-targeted retention strategies needed