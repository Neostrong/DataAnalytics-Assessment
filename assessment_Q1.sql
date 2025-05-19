USE ADASHI_STAGING;
-- Assessment_Q1.sql

SELECT 
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count,
    SUM(CASE WHEN p.is_regular_savings = 1 THEN s.confirmed_amount ELSE 0 END) / 100.0 AS total_deposits
FROM users_customuser u
JOIN plans_plan p ON u.id = p.owner_id
LEFT JOIN savings_savingsaccount s ON s.plan_id = p.id
WHERE p.status_id = 1 -- Assuming status_id 1 = funded
GROUP BY u.id, name
HAVING savings_count > 0 AND investment_count > 0
ORDER BY total_deposits DESC;
