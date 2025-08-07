{{ config(materialized='view') }}

select
    id as sales_id,
    date as sales_date,
    store_nbr,
    family as product_family,
    sales as sales_amount,
    onpromotion as items_on_promotion,
    extract(year from date) as sales_year,
    extract(month from date) as sales_month,
    extract(dayofweek from date) as day_of_week,
    case 
    when onpromotion >0 then true else false
    end as has_promotion
    from 
    {{ source('raw_data','RAW_TRAIN')}}
where date is not null 