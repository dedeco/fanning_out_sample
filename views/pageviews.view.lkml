view: pageviews {
  derived_table: {
    sql:
      SELECT
        -- Create a unique key for the primary key. ROW_NUMBER ensures uniqueness
        -- even if a user views the same product on the same day.
        GENERATE_UUID() as pageview_id,
        p.event_date,
        p.product,
        p.user_id,
        pr.account_name
      FROM demo.pageviews AS p
      LEFT JOIN demo.products AS pr ON p.product = pr.name
      ;;
  }

  dimension: pageview_id {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.pageview_id ;;
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
    type: count_distinct
    sql: ${pageview_id} ;;
    label: "Total Pageviews"
  }
}
