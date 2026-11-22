
{{config(materialized = 'table',
schema='bronze',
transient = false)}}

select 
  ORDER_ID, 
  PLANT_ID,
  ORDER_DATE, 
  PROMISED_DELIVERY_DATE,
  ORDERED_QTY 
from {{source('raw', 'ORDERS')}}