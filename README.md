
# DataAnalytics-Assessment

This repository contains the solution to a Data Analyst SQL assessment. The task evaluates understanding of SQL querying, data manipulation, and customer insights using sample banking/savings transactional data.

## Dataset Overview

The following tables are involved:
- `users_customuser`: Customer details
- `plans_plan`: Savings and investment plans
- `savings_savingsaccount`: Deposit transactions into plans
- `withdrawals_withdrawal`: Withdrawals from plans

---

## Solution Summary

### 🔹 Question 1: High-Value Customers with Multiple Products

**Objective**: Identify customers who have both a funded savings plan and a funded investment plan. Return their names, total deposits, and sort by deposit amount.

**Approach**:
- Used conditional aggregation to count savings and investment products per customer.
- Filtered for customers with at least one of each type.
- Summed total deposit amounts from the savings table (after adjusting for storage in Kobo, divided by 100).

### 🔹 Question 2: Transaction Frequency Analysis

**Objective**: Determine how frequently each customer transacts per month, categorize them into:
- Low Frequency: <3
- Medium Frequency: 3–9
- High Frequency: ≥10

**Approach**:
- Counted number of transactions and computed customer tenure in months.
- Divided total transactions by tenure to get average per month.
- Categorized into buckets using CASE logic.

### 🔹 Question 3: Account Inactivity Alert

**Objective**: Find active accounts with no deposit (inflow) activity in the last 365 days.

**Approach**:
- Left joined plans with deposits and found latest transaction date.
- Filtered accounts with no transactions or transactions older than 365 days.
- Returned plan ID, owner ID, last deposit date, and inactivity in days.

### 🔹 Question 4: Customer Lifetime Value (CLV) Estimation

**Objective**: Estimate CLV using:
- Total deposit value
- Customer tenure
- A simple profit assumption of 0.1% per transaction value

**Approach**:
- Summarized transaction values per customer.
- Calculated tenure using date_joined.
- Used formula: `(total_value × 0.001 / tenure_months) × 12` to estimate yearly CLV.

---

## File Structure

- `Assessment_Q1.sql` → High-Value Customers
- `Assessment_Q2.sql` → Transaction Frequency
- `Assessment_Q3.sql` → Inactive Accounts
- `Assessment_Q4.sql` → CLV Estimation

---

## Author
Ezekiel Ozimi  
Email: colynozimi@gmail.com  
Phone: +2347030188731

