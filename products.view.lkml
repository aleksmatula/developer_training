view: products {
  sql_table_name: public.products ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
  }

  dimension: brand_manager_email {
    type: string
    sql: CASE
              WHEN ${brand} = 'Columbia' THEN 'columnbia@somemail.com'
              WHEN ${brand} = 'Allegra K' THEN 'allegrak@somemail.com'
              WHEN ${brand} = 'Dockers' THEN 'dockers@somemail.com'
              WHEN ${brand} = 'Ray-Ban' THEN 'rayban@somemail.com'
              ELSE NULL END ;;

  }

  dimension: is_active_brand {
    type: yesno
    sql: ${brand_manager_email} IS NOT NULL  ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}.cost ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: distribution_center_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.distribution_center_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  measure: sum_retail_price {
    type: sum
    sql: ${retail_price} ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name, distribution_centers.id, distribution_centers.name, inventory_items.count]
  }
}
