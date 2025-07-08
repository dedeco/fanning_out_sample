# views/managers.view.lkml

view: managers {
  sql_table_name: `demo.managers` ;;

  dimension: manager_id {
    primary_key: yes
    hidden: yes
    sql: CONCAT(${TABLE}.account, '-', ${TABLE}.manager) ;; # Create a unique key
  }

  dimension: name {
    label: "Manager Name"
    sql: ${TABLE}.manager ;;
  }

  dimension: assigned_account {
    label: "Assigned Account"
    sql: ${TABLE}.account ;;
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
    sql: ${assigned_account} ;;
  }
}
