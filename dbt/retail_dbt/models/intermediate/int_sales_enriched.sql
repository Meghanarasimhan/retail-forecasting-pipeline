-- models/intermediate/int_sales_enriched.sql
{{ config(materialized='table') }}

select
    s.sales_id,
    s.sales_date,
    s.store_nbr,
    s.product_family,
    s.sales_amount,
    s.items_on_promotion,
    s.sales_year,
    s.sales_month,
    s.day_of_week,
    
    -- Store enrichment
    st.store_type,
    st.store_cluster,
    
    -- Holiday enrichment
    h.holiday_type,
    h.is_national_holiday,
    coalesce(h.is_national_holiday, false) as is_holiday,
    
    -- Transaction enrichment
    t.transaction_count,
    
    -- Calculated metrics
    case 
        when t.transaction_count > 0 
        then s.sales_amount / t.transaction_count 
        else 0 
    end as avg_transaction_value
    
from {{ ref('stg_sales') }} s
left join {{ ref('stg_stores') }} st
    on s.store_nbr = st.store_nbr
left join {{ ref('stg_holiday_events') }} h
    on s.sales_date = h.holiday_date
left join {{ ref('stg_transactions') }} t
    on s.store_nbr = t.store_id
    and s.sales_date = t.transaction_date