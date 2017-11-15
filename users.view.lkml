view: users {
  sql_table_name: public.users ;;

  dimension: id {
    primary_key: yes
    type: number
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tiered {
    type: tier
    tiers: [20, 30, 50, 100]
    sql: ${age} ;;
    style: integer
  }

  dimension: is_over_60 {
    type: yesno
    sql: ${age} > 60 ;;
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
    description: "This is user's e-mail"
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: first_name {
    label: "User's First Name"
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
    group_label: "Categories"
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
    group_label: "Categories"
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
    group_label: "Categories"
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

  measure: number_of_users_over_60 {
    type: count
    filters: {
      field: is_over_60
      value: "yes"
    }
  }

  measure: percent_over_60 {
    type: number
    sql: 1.00 * ${number_of_users_over_60} / ${count} ;;
    value_format_name: percent_2
  }
}
