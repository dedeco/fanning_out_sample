# models/3_normalized_schema.model.lkml
# This model uses a normalized approach with separate Explores.
# This is generally the recommended best practice in Looker.

connection: "default_bigquery_connection"
include: "/views/*.view.lkml"

# Explore #1: Start with Accounts
explore: accounts {
  label: "Company Insights"
  description: "Explore core company data, including employee counts and account tiers. Use this for high-level business analysis."

  # Users can still access related data by joining from here.
  # The fan-out is controlled because the user chooses when to join.
  join: managers {
    type: left_outer
    relationship: one_to_many
    sql_on: ${accounts.name} = ${managers.assigned_account} ;;
  }

  join: products {
    type: left_outer
    relationship: one_to_many
    sql_on: ${accounts.name} = ${products.customer_account} ;;
  }
}

# Explore #2: Start with Managers
explore: managers {
  label: "Account Management"
  description: "View data on account managers and their assigned accounts."

  join: accounts {
    type: left_outer
    relationship: many_to_one
    sql_on: ${managers.assigned_account} = ${accounts.name} ;;
  }
}

# Explore #3: Start with Products
explore: products {
  label: "Product Adoption"
  description: "Analyze product catalog data and see which accounts are using which products."

  join: accounts {
    type: left_outer
    relationship: many_to_one
    sql_on: ${products.customer_account} = ${accounts.name} ;;
  }
}
