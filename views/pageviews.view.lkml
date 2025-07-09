view: pageviews {
  derived_table: {
    sql:
      SELECT
        p.event_date,
        p.product,
        p.user_id,
        pr.account_name
      FROM demo.pageviews AS p
      LEFT JOIN demo.products AS pr ON p.product = pr.name
      ;;
  }

  dimension: event_date {
    type: date
    sql: ${TABLE}.event_date ;;
  }

  dimension: product {
    type: string
    sql: ${TABLE}.product ;;
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
    type: count
    label: "Total Pageviews"
  }
}
