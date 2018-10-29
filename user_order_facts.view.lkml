view: user_order_facts {
  derived_table: {
    sql: SELECT user_id
      ,SUM(sale_price) as total_revenue
      ,COUNT(order_id) as total_orders
      ,MIN(created_at) as first_order
      ,MAX(created_at) as last_order

FROM public.order_items
GROUP BY user_id
 ;;
  }

  dimension: user_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.user_id ;;
    hidden: yes
  }

  dimension: user_lifetime_revenue {
    type: number
    sql: ${TABLE}.total_revenue ;;
  }

  dimension: user_lifetime_orders {
    type: number
    sql: ${TABLE}.total_orders ;;
  }

  dimension_group: first_order {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      year
    ]
    sql: ${TABLE}.first_order ;;
  }

  dimension_group: last_order {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      year
    ]
    sql: ${TABLE}.last_order ;;
  }

  measure: average_lifetime_revenue {
    type: average
    sql: ${user_lifetime_revenue}  ;;
    value_format_name: usd
  }
}
