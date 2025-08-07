{{ config(materialized='view') }}

select
    date as oil_date,
    dcoilwtico as oil_price,
    case 
        when dcoilwtico is null then true 
        else false 
    end as is_interpolated,
    extract(year from date) as oil_year,
    extract(month from date) as oil_month,
    extract(dayofweek from date) as oil_day_of_week
    
from {{ source('raw_data', 'RAW_OIL') }}
where date is not null