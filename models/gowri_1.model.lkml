connection: "orders_bq"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: gowri_1_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
  interval_trigger: "2 hour"
}

persist_with: gowri_1_default_datagroup

access_grant: users_test1 {
user_attribute: users_test
allowed_values: [ "users" ]
}
explore: inventory_items_vijaya {
  join: products {
    type: left_outer
    sql_on: ${inventory_items_vijaya.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  extends: [products]
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  #extends: [products]
}

explore: order_items {
  required_access_grants: [users_test1]
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: employee_master {}

explore: products {
  extension: required
}

explore: product_sheets {
  join: products {
    type: left_outer
    sql_on: ${product_sheets.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

#explore: pvalue {
#  join: users {
  # sql_on: ${pvalue.user_id} = ${users.id} ;;
   # relationship: many_to_one
 # }
#}

explore: users {}

explore: test_table {}

#explore: gowri_ndt1 {}
