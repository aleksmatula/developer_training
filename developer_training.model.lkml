connection: "redshift"

# include all the views
include: "*.view"

datagroup: daily_caching_mechanism {
  sql_trigger: SELECT CURRENT_DATE ;;
#   max_cache_age: "24 hours"
}

datagroup: orders_check {
  sql_trigger: COUNT (*) FROM public.order_items ;;
  max_cache_age: "24 hours"
}



explore: users {
  persist_with: daily_caching_mechanism
  access_filter: {
    field: country
    user_attribute: country
  }
}

explore: order_items {
  persist_with: orders_check
  join: users {
    type: left_outer
    sql_on: ${users.id} = ${order_items.user_id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
    view_label: "Our Products"
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: user_order_facts {
    view_label: "Users"
    type: left_outer
    sql_on: ${user_order_facts.user_id} = ${order_items.user_id} ;;
    relationship: many_to_one
  }
}
