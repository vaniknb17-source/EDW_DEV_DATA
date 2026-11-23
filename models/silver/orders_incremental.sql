{{
    config(
        materialized='incremental',
        unique_key='ORDER_ID',
        incremental_strategy='merge',
        on_schema_change='append_new_columns'
    )
}}

SELECT
    TRIM(ORDER_ID) AS ORDER_ID,
    TRIM(PLANT_ID) AS PLANT_ID,
    ORDER_DATE,
    PROMISED_DELIVERY_DATE,
    ORDERED_QTY,
    INGESTION_TS,
    CUSTOMER_NAME
FROM {{ source('raw','orders') }}

{% if is_incremental() %}

WHERE INGESTION_TS >
(
    SELECT COALESCE(MAX(INGESTION_TS),
                    '1900-01-01')
    FROM {{ this }}
)

{% endif %}