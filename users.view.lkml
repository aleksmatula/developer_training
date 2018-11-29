view: users {
  sql_table_name: public.users ;;

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
    primary_key: yes
    hidden: yes
  }

  dimension: age {
    label: "Age of user"
    group_label: "Age info"
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tiered {
    group_label: "Age info"
    type: tier
    tiers: [20, 50, 80, 100]
    sql: ${age} ;;
    style: integer
  }

  dimension: is_over_30 {
    group_label: "Age info"
    type: yesno
    sql: ${age} > 30 ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }


  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: user_location {
    type: location
    sql_latitude: ${latitude} ;;
    sql_longitude: ${longitude} ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: average_age {
    type: average
    sql: ${age} ;;
  }

  measure: count {
    type: count
  }

  measure: count_running_total {
    type: running_total
    sql: ${count} ;;
  }
}
