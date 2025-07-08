connection: "default_bigquery_connection"

include: "/views/*.view.lkml"

explore: products {
  label: "Product Adoption"
  description: "Analyze product catalog data and see which accounts are using which products."
}
