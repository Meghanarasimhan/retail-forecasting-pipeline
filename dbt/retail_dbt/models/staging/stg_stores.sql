{{ config(materialized='view') }}

select
    store_nbr,
    city,
    state,
    type as store_type,
    cluster as store_cluster
from {{ source('raw_data', 'RAW_STORES') }}