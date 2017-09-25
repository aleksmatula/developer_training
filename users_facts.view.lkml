view: users_facts {
  derived_table: {
    sql: SELECT
      user_id,
      SUM(sale_price) as total_revenue,
      COUNT(order_id) as total_orders,
      MIN(created_at) as first_order,
      MAX(created_at) as last_order

      FROM public.order_items
      GROUP BY 1
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
    hidden: yes
  }

  dimension: user_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.user_id ;;
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
    timeframes: [date, year, week]
    sql: ${TABLE}.first_order ;;
  }

  dimension_group: last_order {
    type: time
    timeframes: [date, year, week]
    sql: ${TABLE}.last_order ;;
  }

  set: detail {
    fields: [user_id, total_revenue, total_orders]
  }
}
