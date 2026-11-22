{{config(materialized = 'table',
schema='silver',
transient = false)}}

select
    o.order_id,
    o.plant_id,
    o.order_date,
    o.promised_delivery_date,
    o.ordered_qty,
    d.delivery_id,
    d.actual_delivery_date,
    d.delivered_qty,

    case
        when d.delivery_id is not null then 1
        else 0
    end as is_delivered,

    case
        when d.delivery_id is not null
         and d.actual_delivery_date <= o.promised_delivery_date then 1
        else 0
    end as is_on_time,

    case
        when d.delivery_id is not null
        then datediff('day', o.promised_delivery_date, d.actual_delivery_date)
        else null
    end as delivery_delay_days,

    {{ safe_divide('d.delivered_qty', 'o.ordered_qty') }} as qty_fill_pct

from {{ ref('silver_orders') }} o
left join {{ ref('silver_deliveries') }} d
    on o.order_id = d.order_id
