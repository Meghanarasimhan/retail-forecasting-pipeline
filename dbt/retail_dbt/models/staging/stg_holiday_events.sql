{{ config(materialized='view') }}

select
    date as holiday_date,
    type as holiday_type,
    locale as holiday_locale,
    locale_name as holiday_locale_name,
    description as holiday_description,
    transferred as is_transferred,

    extract(year from date) as holiday_year,
    extract(month from date) as holiday_month,
    extract(dayofweek from date) as holiday_day_of_week,
    
    case 
        when type = 'National' then true 
        else false 
    end as is_national_holiday,
    
    case 
        when type = 'Regional' then true 
        else false 
    end as is_regional_holiday
    
from {{ source('raw_data', 'RAW_HOLIDAY_EVENTS') }}
where date is not null