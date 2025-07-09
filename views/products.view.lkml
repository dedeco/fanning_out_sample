# views/products.view.lkml

view: products {
  sql_table_name: `demo.products` ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    label: "Product Name"
    sql: ${TABLE}.name ;;
  }

  dimension: account_name {
    label: "Account with Product"
    sql: ${TABLE}.account_name ;;
  }

  measure: product_assignments {
    description: "Total number of products assigned to accounts."
    type: count
  }

  measure: distinct_product_count {
    label: "Number of Unique Products"
    type: count_distinct
    sql: ${name} ;;
  }

  measure: customer_count {
    label: "Number of Accounts with a Product"
    type: count_distinct
    sql: ${account_name} ;;
  }
}
