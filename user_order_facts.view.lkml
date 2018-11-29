view: user_order_facts {
  derived_table: {
#     datagroup_trigger: orders_check
#     distribution_style: all
    sql: SELECT user_id
      ,SUM(sale_price) as total_revenue
      ,COUNT(order_id) as total_orders
      ,MIN(created_at) as first_order
      ,MAX(created_at) as last_order

FROM public.order_items

WHERE {% condition order_items.created_date %} created_at {% endcondition %}

GROUP BY user_id
 ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: total_revenue {
    type: number
    sql: ${TABLE}.total_revenue ;;
  }

  dimension: total_orders {
    type: number
    sql: ${TABLE}.total_orders ;;
  }

  dimension_group: first_order {
    type: time
    sql: ${TABLE}.first_order ;;
  }

  dimension_group: last_order {
    type: time
    sql: ${TABLE}.last_order ;;
  }

  measure: average_total_user_revenue {
    type: average
    sql: ${total_revenue} ;;
    value_format_name: usd_0

  }
}
