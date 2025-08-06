CREATE DATABASE retail_sales;
USE retail_sales;
USE retail_sales;

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

CREATE TABLE train (
    id INT PRIMARY KEY,
    date DATE,
    store_nbr INT,
    family VARCHAR(50),
    sales FLOAT,
    onpromotion INT
);
CREATE TABLE test (
    id INT PRIMARY KEY,
    date DATE,
    store_nbr INT,
    family VARCHAR(50),
    onpromotion INT
);
CREATE TABLE holiday_events (
    date DATE,
    type VARCHAR(20),
    locale VARCHAR(20),
    locale_name VARCHAR(50),
    description VARCHAR(100),
    transferred BOOLEAN
);
CREATE TABLE oil (
    date DATE PRIMARY KEY,
    dcoilwtico FLOAT
);
CREATE TABLE sample_submission (
    id INT PRIMARY KEY,
    sales FLOAT
);
CREATE TABLE stores (
    store_nbr INT PRIMARY KEY,
    city VARCHAR(50),
    state VARCHAR(50),
    type CHAR(1),
    cluster INT
);
CREATE TABLE transactions (
    date DATE,
    store_nbr INT,
    transactions INT,
    PRIMARY KEY (date, store_nbr)
);

LOAD DATA LOCAL INFILE '/Users/meghashreebl/Downloads/store-sales-time-series-forecasting/train.csv'
INTO TABLE train
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Users/meghashreebl/Downloads/store-sales-time-series-forecasting/transactions.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Users/meghashreebl/Downloads/store-sales-time-series-forecasting/test.csv'
INTO TABLE test
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Users/meghashreebl/Downloads/store-sales-time-series-forecasting/stores.csv'
INTO TABLE stores
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Users/meghashreebl/Downloads/store-sales-time-series-forecasting/oil.csv'
INTO TABLE oil
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Users/meghashreebl/Downloads/store-sales-time-series-forecasting/holiday_events.csv'
INTO TABLE holiday_events
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Users/meghashreebl/Downloads/store-sales-time-series-forecasting/sample_submission.csv'
INTO TABLE sample_submission
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


