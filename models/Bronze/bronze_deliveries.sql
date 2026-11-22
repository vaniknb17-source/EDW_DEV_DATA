{{config(materialized = 'table',
schema='bronze',
transient = false)}}

select 
DELIVERY_ID, 
ORDER_ID, 
ACTUAL_DELIVERY_DATE, 
DELIVERED_QTY 
from {{source('raw', 'DELIVERIES')}}