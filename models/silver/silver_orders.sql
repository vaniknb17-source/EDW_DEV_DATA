{{config(materialized = 'table',
schema='silver',
transient = false)}}

select
    trim(ORDER_ID) as order_id,
    trim(PLANT_ID) as plant_id,
    cast(ORDER_DATE as date) as order_date,
    cast(PROMISED_DELIVERY_DATE as date) as promised_delivery_date,
    cast(ORDERED_QTY as number(18,2)) as ordered_qty,
    INGESTION_TS as ingestion_ts
from {{ ref('bronze_orders') }}