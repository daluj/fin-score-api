CREATE TABLE businesses (
    business_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    industry VARCHAR(100) DEFAULT 'Grocery',
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE assets_liabilities (
    id SERIAL PRIMARY KEY,
    business_id INT NOT NULL,
    period DATE NOT NULL,
    name VARCHAR(255) NOT NULL,
    type ENUM('Asset', 'Liability') NOT NULL,
    category ENUM('Current Asset', 'Fixed Asset', 'Current Liability', 'Long-Term Liability') NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (business_id) REFERENCES businesses(business_id) ON DELETE CASCADE
);

CREATE TABLE financial_statements (
    id SERIAL PRIMARY KEY,
    business_id INT NOT NULL,
    period DATE NOT NULL,
    total_assets DECIMAL(15,2) NOT NULL,
    total_liabilities DECIMAL(15,2) NOT NULL,
    working_capital DECIMAL(15,2) GENERATED ALWAYS AS (
        (SELECT COALESCE(SUM(amount), 0) FROM assets_liabilities 
         WHERE business_id = financial_statements.business_id 
         AND period = financial_statements.period 
         AND type = 'Asset' 
         AND category = 'Current Asset')
        -
        (SELECT COALESCE(SUM(amount), 0) FROM assets_liabilities 
         WHERE business_id = financial_statements.business_id 
         AND period = financial_statements.period 
         AND type = 'Liability' 
         AND category = 'Current Liability')
    ) STORED,
    retained_earnings DECIMAL(15,2) NOT NULL,
    ebit DECIMAL(15,2) NOT NULL,
    book_value_equity DECIMAL(15,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (business_id) REFERENCES businesses(business_id) ON DELETE CASCADE
);

CREATE TABLE z_scores (
    id SERIAL PRIMARY KEY,
    business_id INT NOT NULL,
    period DATE NOT NULL,
    z_score DECIMAL(10,2) GENERATED ALWAYS AS (
        (6.56 * (working_capital / total_assets)) +
        (3.26 * (retained_earnings / total_assets)) +
        (6.72 * (ebit / total_assets)) +
        (1.05 * (book_value_equity / total_liabilities))
    ) STORED,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (business_id) REFERENCES businesses(business_id) ON DELETE CASCADE
);

CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    business_id INT NOT NULL,
    transaction_type ENUM('Sale', 'Expense') NOT NULL,
    description TEXT NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (business_id) REFERENCES businesses(business_id) ON DELETE CASCADE
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    business_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    supplier_id INT,
    expiration_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (business_id) REFERENCES businesses(business_id) ON DELETE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) ON DELETE SET NULL
);

CREATE TABLE suppliers (
    supplier_id SERIAL PRIMARY KEY,
    business_id INT NOT NULL,
    name VARCHAR(255) NOT NULL,
    contact_person VARCHAR(255),
    phone VARCHAR(15),
    email VARCHAR(255),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (business_id) REFERENCES businesses(business_id) ON DELETE CASCADE
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    business_id INT NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    order_status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    payment_status ENUM('Unpaid', 'Paid') DEFAULT 'Unpaid',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (business_id) REFERENCES businesses(business_id) ON DELETE CASCADE
);