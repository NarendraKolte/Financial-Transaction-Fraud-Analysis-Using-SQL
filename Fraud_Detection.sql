CREATE DATABASE fraud_analysis;

USE fraud_analysis;

CREATE TABLE transactions (
    step INT,
    type VARCHAR(20),
    amount DECIMAL(15,2),
    nameOrig VARCHAR(50),
    oldbalanceOrg DECIMAL(15,2),
    newbalanceOrig DECIMAL(15,2),
    nameDest VARCHAR(50),
    oldbalanceDest DECIMAL(15,2),
    newbalanceDest DECIMAL(15,2),
    isFraud INT,
    isFlaggedFraud INT
);


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/paysim_500k.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT count(*) FROM transactions;

CREATE TABLE transactions_sample AS
SELECT *
FROM transactions
LIMIT 500000;

#Basic Analysis

#1. Total Transactions by Type

SELECT
    type,
    COUNT(*) AS total_transactions
FROM transactions_sample
GROUP BY type
ORDER BY total_transactions DESC;

#2. Total Transaction Amount by Type

SELECT
    type,
    ROUND(SUM(amount),2) AS total_amount
FROM transactions_sample
GROUP BY type
ORDER BY total_amount DESC;

#3. Fraud Rate by Transaction Type

SELECT
    type,
    COUNT(*) AS total_transactions,
    SUM(isFraud) AS fraud_transactions,
    ROUND(100*SUM(isFraud)/COUNT(*),4) AS fraud_rate
FROM transactions_sample
GROUP BY type;

#4. Top 10 Largest Transactions

SELECT
    nameOrig,
    nameDest,
    type,
    amount
FROM transactions_sample
ORDER BY amount DESC
LIMIT 10;

#Intermediate Analysis

#5. Transaction Type with Highest Fraud %

SELECT
    type,
    ROUND(100*SUM(isFraud)/COUNT(*),4) AS fraud_percentage
FROM transactions_sample
GROUP BY type
ORDER BY fraud_percentage DESC;

#6. Fraud Transactions by Hour

SELECT
    step,
    COUNT(*) AS fraud_transactions
FROM transactions_sample
WHERE isFraud = 1
GROUP BY step
ORDER BY step;

#7. Average Transaction Amount: Fraud vs Non-Fraud

SELECT
    isFraud,
    ROUND(AVG(amount),2) AS avg_transaction_amount
FROM transactions_sample
GROUP BY isFraud;

#8. Top Accounts Involved in Fraud

SELECT
    nameOrig,
    COUNT(*) AS fraud_count
FROM transactions_sample
WHERE isFraud = 1
GROUP BY nameOrig
ORDER BY fraud_count DESC
LIMIT 10;

#Advanced SQL 

#9. Rank Customers by Transaction Volume

SELECT
    nameOrig,
    SUM(amount) AS total_amount,
    RANK() OVER(
        ORDER BY SUM(amount) DESC
    ) AS customer_rank
FROM transactions_sample
GROUP BY nameOrig
LIMIT 20;


#10. Suspicious Accounts with Multiple High-Value Transfers

SELECT
    nameOrig,
    COUNT(*) AS transfer_count,
    SUM(amount) AS total_transferred
FROM transactions_sample
WHERE type='TRANSFER'
AND amount > 50000
GROUP BY nameOrig
ORDER BY total_transferred DESC
LIMIT 20;

#11. Cumulative Transaction Amount (Window Function)


SELECT
    step,
    amount,
    SUM(amount) OVER(
        ORDER BY step
    ) AS cumulative_amount
FROM transactions_sample
LIMIT 100;

#12. Detect Unusual Balance Changes

SELECT
    nameOrig,
    amount,
    oldbalanceOrg,
    newbalanceOrig
FROM transactions_sample
WHERE ABS(
    oldbalanceOrg - amount - newbalanceOrig
) > 1000;