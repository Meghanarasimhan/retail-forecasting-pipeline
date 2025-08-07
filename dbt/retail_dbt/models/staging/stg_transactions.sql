{{ config(materialized='view') }}

select
    store_nbr as store_id,
    date as transaction_date,
    transactions as transaction_count,
    extract(year from date) as transaction_year,
    extract(month from date) as transaction_month,
    extract(dayofweek from date) as transaction_day_of_week
    
from {{ source('raw_data', 'RAW_TRANSACTIONS') }}
where date is not null