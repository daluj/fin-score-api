-- Insert sample businesses
INSERT INTO businesses (name, industry) VALUES
('FreshMart Supermarket', 'Grocery'),
('QuickShop Convenience', 'Grocery');

-- Insert sample assets and liabilities
INSERT INTO assets_liabilities (business_id, period, name, type, category, amount) VALUES
(1, '2024-01-01', 'Cash in Bank', 'Asset', 'Current Asset', 50000.00),
(1, '2024-01-01', 'Accounts Payable', 'Liability', 'Current Liability', 15000.00),
(1, '2024-01-01', 'Inventory', 'Asset', 'Current Asset', 30000.00),
(1, '2024-01-01', 'Store Equipment', 'Asset', 'Fixed Asset', 10000.00),
(1, '2024-01-01', 'Bank Loan', 'Liability', 'Long-Term Liability', 25000.00);

-- Insert sample financial statements
INSERT INTO financial_statements (business_id, period, total_assets, total_liabilities, retained_earnings, ebit, book_value_equity) VALUES
(1, '2024-01-01', 90000.00, 40000.00, 15000.00, 12000.00, 50000.00);

-- Insert sample transactions
INSERT INTO transactions (business_id, transaction_type, description, amount) VALUES
(1, 'Sale', 'Daily sales revenue', 2000.00),
(1, 'Expense', 'Employee salaries', 1000.00),
(1, 'Expense', 'Utility bills', 500.00);

-- Insert sample products
INSERT INTO products (business_id, name, category, price, stock_quantity, supplier_id, expiration_date) VALUES
(1, 'Apple', 'Fruits', 0.50, 200, 1, '2024-03-15'),
(1, 'Milk', 'Dairy', 1.20, 100, 2, '2024-02-28');

-- Insert sample suppliers
INSERT INTO suppliers (business_id, name, contact_person, phone, email, address) VALUES
(1, 'Fresh Farms Ltd', 'John Doe', '1234567890', 'supplier@freshfarms.com', '123 Farm Road'),
(1, 'Dairy Delights Co.', 'Jane Smith', '0987654321', 'supplier@dairydelights.com', '456 Milk Lane');

-- Insert sample orders
INSERT INTO orders (business_id, total_price, order_status, payment_status) VALUES
(1, 25.50, 'Completed', 'Paid'),
(1, 40.75, 'Pending', 'Unpaid');