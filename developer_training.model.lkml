connection: "redshift"

# include all the views
include: "*.view"


datagroup: check_for_new_order_items {
  sql_trigger: SELECT CURRENT_DATE ;;
  max_cache_age: "24 hours"
}

datagroup: check_for_new_users {
  sql_trigger: SELECT COUNT(*) FROM USERS ;;
}

persist_with: check_for_new_order_items


explore: users {
  group_label: "E-commerce tuff"
  persist_with: check_for_new_users
  description: "This explore should be used to do any analysis on the users who have registered on our e-commerce platform (including the ones who have never made any purchase)"
}


explore: order_items {
  access_filter: {
    field: products.brand
    user_attribute: brand
  }

  group_label: "E-commerce tuff"
  join: users {
  view_label: "Ordering Users"
  type: full_outer
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
    view_label: "Ordering Users"
    type: left_outer
    sql_on: ${order_items.user_id} = ${user_order_facts.user_id} ;;
    relationship: many_to_one
  }
 }
