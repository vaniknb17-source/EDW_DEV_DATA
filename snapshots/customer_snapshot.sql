{% snapshot customer_snapshot %}

{{
    config(
        target_schema='SNAPSHOTS',
        unique_key='CUSTOMER_ID',
        strategy='timestamp',
        updated_at='LAST_MODIFIED_TS'
    )
}}

SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    CITY,
    LAST_MODIFIED_TS
FROM {{ source('raw','customer_master') }}

{% endsnapshot %}