USE ADASHI_STAGING;
-- Assessment_Q4.sql

WITH txn_summary AS (
    SELECT 
        owner_id,
        COUNT(*) AS total_transactions,
        SUM(confirmed_amount) / 100.0 AS total_value
    FROM savings_savingsaccount
    GROUP BY owner_id
),
tenure_calc AS (
    SELECT 
        id AS customer_id,
        CONCAT(first_name, ' ', last_name) AS name,
        TIMESTAMPDIFF(MONTH, date_joined, CURDATE()) AS tenure_months
    FROM users_customuser
),
combined AS (
    SELECT 
        t.customer_id,
        t.name,
        t.tenure_months,
        s.total_transactions,
        s.total_value,
        (s.total_value * 0.001) AS total_profit,
        ROUND((s.total_value * 0.001 / t.tenure_months) * 12, 2) AS estimated_clv
    FROM tenure_calc t
    JOIN txn_summary s ON t.customer_id = s.owner_id
    WHERE t.tenure_months > 0
)
SELECT customer_id, name, tenure_months, total_transactions, estimated_clv
FROM combined
ORDER BY estimated_clv DESC;
