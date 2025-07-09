# models/1_fanout_example.model.lkml
# This model demonstrates the fan-out problem.

connection: "default_bigquery_connection"
include: "/views/*.view.lkml"

explore: fanout_example {
  view_name: accounts
  label: "Fan-Out Example"
  description: "Illustrates how joining multiple one-to-many views (Managers, Products) to a central view (Accounts) causes measures to be double-counted, leading to incorrect results."

  join: managers {
    type: left_outer
    relationship: one_to_many
    sql_on: ${accounts.name} = ${managers.account_name} ;;
  }

  join: products {
    type: left_outer
    relationship: one_to_many
    sql_on: ${accounts.name} = ${products.account_name} ;;
  }
}
