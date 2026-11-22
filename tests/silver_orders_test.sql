select order_id
from {{ ref('bronze_orders') }}
group by order_id
having count(*) > 1