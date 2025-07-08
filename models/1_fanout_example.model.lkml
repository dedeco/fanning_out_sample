# models/2_full_outer_join.model.lkml
# This model uses the FULL OUTER JOIN ON FALSE technique to prevent fan-out.

connection: "default_bigquery_connection"
include: "/views/*.view.lkml"

explore: full_outer_join_solution {
  view_name: accounts
  label: "Full Outer Join Solution"
  description: "Prevents fan-out by joining Managers and Products using a FULL OUTER JOIN with a false condition. This allows for correct, un-fanned-out measures from all views in one Explore."

  join: managers {
    type: full_outer
    relationship: one_to_many
    # By joining on a false condition, we avoid the fan-out.
    # Looker's symmetric aggregates will handle the measure calculations correctly.
    sql_on: 1=0 ;;
  }

  join: products {
    type: full_outer
    relationship: one_to_many
    sql_on: 1=0 ;;
  }
}
