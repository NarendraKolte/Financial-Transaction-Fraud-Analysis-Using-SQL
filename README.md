# Financial Transaction Fraud Analysis Using SQL

## Project Overview

This project analyzes financial transaction data to identify fraud patterns, suspicious account behavior, and transaction trends using SQL. The analysis was performed on a sample of 500,000+ transaction records from the PaySim dataset, a financial mobile money simulator designed for fraud detection research.

The objective was to apply SQL analytical techniques to investigate fraudulent activities, evaluate transaction behavior, and generate actionable business insights.

---

## Dataset Information

Dataset: PaySim Financial Transaction Dataset

### Features

| Column         | Description                                                    |
| -------------- | -------------------------------------------------------------- |
| step           | Time step representing one hour                                |
| type           | Transaction type (CASH-IN, CASH-OUT, DEBIT, PAYMENT, TRANSFER) |
| amount         | Transaction amount                                             |
| nameOrig       | Sender account                                                 |
| oldbalanceOrg  | Sender balance before transaction                              |
| newbalanceOrig | Sender balance after transaction                               |
| nameDest       | Receiver account                                               |
| oldbalanceDest | Receiver balance before transaction                            |
| newbalanceDest | Receiver balance after transaction                             |
| isFraud        | Fraud indicator (1 = Fraud, 0 = Non-Fraud)                     |
| isFlaggedFraud | Flagged suspicious transaction indicator                       |

---

## Project Objectives

* Analyze transaction patterns across different transaction types.
* Identify fraudulent transaction behavior.
* Calculate fraud rates and fraud-related KPIs.
* Detect suspicious accounts and transaction anomalies.
* Apply advanced SQL concepts for business analysis.

---

## SQL Concepts Used

### Data Analysis

* Aggregate Functions
* GROUP BY
* ORDER BY
* HAVING
* CASE WHEN
* Subqueries

### Advanced SQL

* Common Table Expressions (CTEs)
* Window Functions
* RANK()
* DENSE_RANK()
* ROW_NUMBER()
* Running Totals

---

## Key Analysis Performed

### Basic Analysis

* Total Transactions by Type
* Total Transaction Amount by Type
* Fraud Rate by Transaction Type
* Top 10 Largest Transactions

### Intermediate Analysis

* Transaction Type with Highest Fraud Percentage
* Fraud Transactions by Hour
* Average Fraud vs Non-Fraud Transaction Amount
* Top Accounts Involved in Fraud

### Advanced Analysis

* Customer Transaction Ranking
* Suspicious High-Value Transfer Detection
* Running Total Calculations
* Balance Change Analysis
* Fraud Detection KPI Analysis
* Transaction Share Analysis

---

## Key Findings

* TRANSFER and CASH_OUT transactions showed the highest fraud occurrence.
* Fraudulent transactions generally involved significantly larger amounts compared to normal transactions.
* Multiple accounts exhibited suspicious transfer behavior through repeated high-value transactions.
* Fraud activity was concentrated within specific transaction categories.
* Transaction monitoring rules can be strengthened by focusing on high-risk transaction types.

---

## Business Recommendations

* Implement additional verification for high-value TRANSFER transactions.
* Increase monitoring of accounts involved in repeated suspicious transfers.
* Strengthen fraud detection rules for high-risk transaction categories.
* Utilize real-time transaction monitoring to identify unusual balance changes.
* Improve fraud prevention systems using transaction pattern analysis.

---

## Tools Used

* MySQL 8.0
* MySQL Workbench
* SQL

---

## Project Structure

Financial-Transaction-Fraud-Analysis-SQL

├── Dataset

├── SQL Queries.sql

├── README.md





---

## Sample SQL Query

```sql
SELECT
    type,
    COUNT(*) AS total_transactions,
    SUM(isFraud) AS fraud_transactions,
    ROUND(
        100 * SUM(isFraud) / COUNT(*),
        4
    ) AS fraud_rate
FROM transactions_sample
GROUP BY type;
```

---

## Project Outcome

Successfully analyzed 500,000+ financial transaction records and developed 19+ analytical SQL queries to identify fraud patterns, customer behavior, transaction trends, and business risks using advanced SQL techniques.

