view: orders {
  derived_table: {
    sql:
      SELECT
        -- Create a unique key for the primary key
        CAST(o.order_date AS STRING) || '-' || o.product || '-' || CAST(o.user_id AS STRING) || '-' || CAST(o.amount AS STRING) as order_id,
        o.order_date,
        o.product,
        o.amount,
        o.user_id,
        pr.account_name
      FROM demo.orders AS o
      LEFT JOIN demo.products AS pr ON o.product = pr.name
      ;;
  }

  dimension: order_id {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension: order_date {
    type: date
    sql: ${TABLE}.order_date ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}.product ;;
  }

  dimension: amount {
    type: number
    value_format_name: usd
    sql: ${TABLE}.amount ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  dimension: account_name {
    type: string
    hidden: yes # Hidden because we use the one from the associated_account join
    sql: ${TABLE}.account_name ;;
  }

  measure: count {
    type: count_distinct
    sql: ${order_id} ;;
    label: "Total Orders"
  }

  measure: total_amount {
    type: sum
    sql: ${amount} ;;
    value_format_name: usd
  }
}
