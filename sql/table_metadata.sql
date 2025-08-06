use retail_sales;

CREATE TABLE etl_table_config (
         table_name VARCHAR(100) PRIMARY KEY,
     is_active BOOLEAN DEFAULT TRUE,
        s3_path VARCHAR(255)
);

INSERT INTO etl_table_config (table_name, is_active, s3_path) VALUES
    ('train', TRUE, 'raw/train.csv'),
	('stores', TRUE, 'raw/stores.csv'),
	('oil', TRUE, 'raw/oil.csv'),
    ('transactions', TRUE, 'raw/transactions.csv'),
	('holidays_events', TRUE, 'raw/holidays_events.csv');
