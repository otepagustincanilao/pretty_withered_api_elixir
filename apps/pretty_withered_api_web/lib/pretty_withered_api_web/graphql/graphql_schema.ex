defmodule PrettyWitheredApiWeb.Graphql.Schema do
  @moduledoc false

  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(PrettyWitheredApiWeb.Graphql.Schemas.BrandTypes)
  
  query do
    import_fields(:brand_queries)
  end

  mutation do
    import_fields(:brand_mutations)
  end

end
