view: test_table {
  sql_table_name: `orders.test_table` ;;

  dimension: test_column {
    type: number
    sql: ${TABLE}.test_column ;;
  }
  measure: count {
    type: count
  }
}
