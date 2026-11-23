{% snapshot customer_snapshot_check %}

{{
    config(
        target_schema='SNAPSHOTS',
        unique_key='CUSTOMER_ID',
        strategy='check',
        check_cols=['CUSTOMER_NAME','CITY']
    )
}}

SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    CITY
FROM {{ source('raw','customer_master1') }}

{% endsnapshot %}