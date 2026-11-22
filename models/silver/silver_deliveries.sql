
{{config(materialized = 'table',
schema='silver',
transient = false)}}

select
    trim(DELIVERY_ID) as delivery_id,
    trim(ORDER_ID) as order_id,
    cast(ACTUAL_DELIVERY_DATE as date) as actual_delivery_date,
    cast(DELIVERED_QTY as number(18,2)) as delivered_qty,
    INGESTION_TS as ingestion_ts
from {{ ref('bronze_deliveries') }}