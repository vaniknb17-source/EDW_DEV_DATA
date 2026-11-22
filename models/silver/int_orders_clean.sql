{{ config(materialized='ephemeral') }}

SELECT
    TRIM(ORDER_ID) AS ORDER_ID,
    TRIM(PLANT_ID) AS PLANT_ID,
    ORDER_DATE,
    PROMISED_DELIVERY_DATE,
    ORDERED_QTY
FROM {{ ref('bronze_orders') }}
WHERE ORDERED_QTY > 0