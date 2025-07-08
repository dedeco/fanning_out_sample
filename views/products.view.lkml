# views/products.view.lkml

view: products {
  sql_table_name: `demo.products` ;;

  dimension: product_id {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.account, '-', ${TABLE}.product) ;; # Create a unique key
  }

  dimension: name {
    label: "Product Name"
    sql: ${TABLE}.product ;;
  }

  dimension: customer_account {
    label: "Account with Product"
    sql: ${TABLE}.account ;;
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
    sql: ${customer_account} ;;
  }
}
