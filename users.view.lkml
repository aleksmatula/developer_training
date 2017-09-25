view: users {
  sql_table_name: public.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: age {
    type: number
    label: "User's age"
    sql: ${TABLE}.age ;;
  }

  dimension: age_tiered {
    type: tier
    sql: ${age} ;;
    tiers: [10, 20, 30, 40, 50, 90]
    style: integer
  }

  dimension: is_over_30 {
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

  dimension: location {
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

  measure: count {
    type: count
    drill_fields:  [first_name, last_name]
  }

  measure: average_age {
    type: average
    sql: ${age} ;;
  }

  measure: count_running_total {
    type: running_total
    sql: ${count} ;;
  }

  measure: first_minus_second {
    type: number
    sql: ${average_age} - ${count} ;;
  }

}
