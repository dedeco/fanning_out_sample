# views/accounts.view.lkml

view: accounts {
  sql_table_name: `demo.accounts` ;;

  dimension: account_id {
    primary_key: yes
    hidden: yes # Hide to give users a cleaner experience
    sql: ${TABLE}.account ;;
  }

  dimension: name {
    label: "Account Name"
    sql: ${TABLE}.account ;;
    link: {
      label: "View Account Dashboard"
      url: "/dashboards/123?Account+Name={{ value | url_encode }}" # Example link to a dashboard
    }
  }

  dimension: employees {
    type: number
    value_format_name: decimal_0
    description: "Number of employees at the company."
    sql: ${TABLE}.employees ;;
  }

  dimension: account_tier {
    type: string
    case: {
      when: {
        sql: ${employees} >= 2000 ;;
        label: "Enterprise"
      }
      when: {
        sql: ${employees} >= 500 ;;
        label: "Mid-Market"
      }
      else: "SMB"
    }
  }

  measure: count {
    type: count
    label: "Total Accounts"
    drill_fields: [name]
  }

  measure: total_employees {
    type: sum
    sql: ${employees} ;;
    value_format_name: decimal_0
    label: "Total Employee Count"
  }

  measure: average_employees_per_account {
    type: average
    sql: ${employees} ;;
    value_format_name: decimal_1
  }
}
