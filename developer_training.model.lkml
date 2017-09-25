connection: "redshift"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

explore: users {
  description: "All about users"
  hidden: yes
}

explore: order_items {
  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
    view_label: "Users"
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

  join: users_facts {
    type: left_outer
    sql: ${order_items.user_id} = ${users_facts.user_id} ;;
    relationship: many_to_one
    view_label: "Users"
  }
}
