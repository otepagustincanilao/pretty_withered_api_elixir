defmodule PrettyWitheredApiWeb.Graphql.Schema do
  @moduledoc false

  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(PrettyWitheredApiWeb.Graphql.Schemas.BrandTypes)
  import_types(PrettyWitheredApiWeb.Graphql.Schemas.ProductTypes)
  
  query do
    import_fields(:brand_queries)
    import_fields(:product_queries)
  end

  mutation do
    import_fields(:brand_mutations)
    import_fields(:product_mutations)
  end

end
