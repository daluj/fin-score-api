-- Retrieve all businesses
SELECT * FROM businesses;

-- Retrieve total assets and liabilities for a business in a given period
SELECT business_id, period, 
       SUM(CASE WHEN type = 'Asset' THEN amount ELSE 0 END) AS total_assets,
       SUM(CASE WHEN type = 'Liability' THEN amount ELSE 0 END) AS total_liabilities
FROM assets_liabilities
WHERE business_id = 1 AND period = '2024-01-01'
GROUP BY business_id, period;

-- Calculate the Altman Z-Score for a business
SELECT 
    business_id, 
    period, 
    (6.56 * (working_capital / total_assets)) +
    (3.26 * (retained_earnings / total_assets)) +
    (6.72 * (ebit / total_assets)) +
    (1.05 * (book_value_equity / total_liabilities)) AS z_score
FROM financial_statements
WHERE business_id = 1
ORDER BY period DESC;

-- Retrieve all completed orders
SELECT * FROM orders WHERE order_status = 'Completed';

-- Retrieve all suppliers for a business
SELECT * FROM suppliers WHERE business_id = 1;

-- Retrieve total sales revenue and expenses for a business
SELECT transaction_type, SUM(amount) AS total_amount
FROM transactions
WHERE business_id = 1
GROUP BY transaction_type;

-- Retrieve top-selling products
SELECT p.name, SUM(o.total_price) AS total_revenue
FROM orders o
JOIN products p ON o.business_id = p.business_id
WHERE o.order_status = 'Completed'
GROUP BY p.name
ORDER BY total_revenue DESC
LIMIT 5;
