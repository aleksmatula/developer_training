connection: "redshift"

# include all the views
include: "*.view"
datagroup: daily_caching_mechanism {
  sql_trigger: SELECT CURRENT_DATE ;;
  max_cache_age: "6 hours"
}

explore: users {
}


access_grant: access_to_user_data {
  allowed_values: ["finance", "all"]
  user_attribute: department
}



explore: order_items {
#   sql_always_where: ${users.city} IN ('{{ _user_attributes['city_1'] }}', '{{ _user_attributes['city_2'] }}') ;;
  persist_with: daily_caching_mechanism
  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: products {
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
