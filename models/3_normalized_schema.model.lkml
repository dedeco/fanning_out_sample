# models/3_normalized_schema.model.lkml
# This model uses a normalized approach with separate Explores.
# This is generally the recommended best practice in Looker.

connection: "default_bigquery_connection"
include: "/views/*.view.lkml"

explore: advanced_coalesce_solution {
  # We start from a dummy view, or any view, it doesn't matter.
  # The real data comes from the joins.
  from: accounts
  label: "Advanced Coalesce Solution"
  description: "The most robust solution. Prevents fan-out and allows dimensions from associated tables to be used correctly with measures from any fact table."

  # Step 1: Bring in the fact tables with FULL OUTER JOIN on a false condition.
  # These are hidden because users will get data from the associated views below.
  join: managers_base {
    from: managers
    type: full_outer
    relationship: one_to_many
    sql_on: 1=0 ;;
  }

  join: products_base {
    from: products
    type: full_outer
    relationship: one_to_many
    sql_on: 1=0 ;;
  }

  # Step 2: Join the dimension tables using COALESCE to link to the fact tables.
  # This is the key trick.
  join: associated_account {
    from: accounts
    type: left_outer
    relationship: many_to_one
    # Look for an account name in either of the base fact tables.
    sql_on: ${associated_account.name} = COALESCE(
        ${managers_base.account_name},
        ${products_base.account_name}
      ) ;;
  }
}
