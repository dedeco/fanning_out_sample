connection: "default_bigquery_connection"

include: "/views/*.view.lkml"

explore: accounts {
  label: "Company Insights"
  description: "Explore core company data, including employee counts and account tiers. Use this for high-level business analysis."
}
