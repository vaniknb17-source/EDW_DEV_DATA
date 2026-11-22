select
    plant_id,
    count(*) as total_orders,
    sum(is_delivered) as delivered_orders,
    sum(is_on_time) as on_time_orders,
    round({{ safe_divide('sum(is_on_time)', 'count(*)') }} * 100, 2) as on_time_pct,
    sum(ordered_qty) as ordered_qty,
    sum(coalesce(delivered_qty, 0)) as delivered_qty,
    round({{ safe_divide('sum(coalesce(delivered_qty, 0))', 'sum(ordered_qty)') }} * 100, 2) as fill_rate_pct
from {{ ref('silver_order_delivery') }}
group by plant_id
order by plant_id