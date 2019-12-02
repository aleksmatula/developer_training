view: user_order_facts {
  derived_table: {
    datagroup_trigger: check_for_new_order_items
    distribution_style: all
    sql: SELECT

      user_id as user_id,
      SUM(sale_price) as user_lifetime_revenue,
      COUNT(*) as user_lifetime_items,
      COUNT(DISTINCT order_id) as user_lifetime_orders,
      MIN(created_at) as first_order_date,
      MAX(created_at) as last_order_date


      FROM

      order_items

      GROUP BY user_id
       ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: user_lifetime_revenue {
    type: number
    sql: ${TABLE}.user_lifetime_revenue ;;
  }

  dimension: user_lifetime_items {
    type: number
    sql: ${TABLE}.user_lifetime_items ;;
  }

  dimension: user_lifetime_orders {
    type: number
    sql: ${TABLE}.user_lifetime_orders ;;
  }

  dimension: days_to_first_order {
    type: duration_day
    sql_start: ${users.created_raw}  ;;
    sql_end: ${first_order_raw} ;;
  }

  dimension_group: first_order {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      month_name,
      month_num,
      year
    ]
    sql: ${TABLE}.first_order_date ;;
  }

  dimension_group: last_order {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      month_name,
      month_num,
      year
    ]
    sql: ${TABLE}.last_order_date ;;
  }

  measure: average_user_lifetime_revenue {
    type: average
    sql: ${user_lifetime_revenue} ;;
    value_format_name: eur
  }

  measure: average_days_to_first_order {
    type: average
    sql: ${days_to_first_order} ;;
    value_format_name: decimal_2
  }
}
