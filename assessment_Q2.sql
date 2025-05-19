USE ADASHI_STAGING;
-- Assessment_Q2.sql

WITH txn_counts AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_txns,
        TIMESTAMPDIFF(MONTH, MIN(created_on), MAX(created_on)) + 1 AS active_months
    FROM savings_savingsaccount
    GROUP BY owner_id
),
txn_rates AS (
    SELECT 
        owner_id,
        total_txns,
        active_months,
        total_txns / active_months AS txn_per_month
    FROM txn_counts
),
categorized AS (
    SELECT 
        CASE 
            WHEN txn_per_month >= 10 THEN 'High Frequency'
            WHEN txn_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        txn_per_month
    FROM txn_rates
)
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(txn_per_month), 1) AS avg_transactions_per_month
FROM categorized
GROUP BY frequency_category;
