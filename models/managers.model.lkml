connection: "default_bigquery_connection"

include: "/views/*.view.lkml"

explore: managers {
  label: "Account Management"
  description: "View data on account managers and their assigned accounts."
}
