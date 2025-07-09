# views/managers.view.lkml

view: managers {
  sql_table_name: `demo.managers` ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    label: "Manager Name"
    sql: ${TABLE}.name ;;
  }

  dimension: account_name {
    label: "Assigned Account"
    sql: ${TABLE}.account_name ;;
  }

  measure: total_assignments {
    type: count
    description: "Count of manager-to-account assignments."
  }

  measure: distinct_manager_count {
    label: "Number of Managers"
    type: count_distinct
    sql: ${name} ;;
  }

  measure: managed_account_count {
    label: "Number of Managed Accounts"
    type: count_distinct
    sql: ${account_name} ;;
  }
}
