view: last_fist_day_of_month {
  derived_table: {
    sql: SELECT
        TO_CHAR(DATE_TRUNC('month', users.created_at ), 'YYYY-MM') AS "month",
        MAX(DATE(users.created_at )) AS "max_month_date",
        MIN(DATE(users.created_at )) as "min_month_date"
      FROM public.users  AS users
      GROUP BY 1
      ORDER BY 1 DESC
       ;;
  }

  dimension: month {
    primary_key: yes
    type: string
    sql: ${TABLE}.month ;;
  }

  dimension: max_month_date {
    type: date
    sql: ${TABLE}.max_month_date ;;
  }

  dimension: min_month_date {
    type: date
    sql: ${TABLE}.min_month_date ;;
  }
}
