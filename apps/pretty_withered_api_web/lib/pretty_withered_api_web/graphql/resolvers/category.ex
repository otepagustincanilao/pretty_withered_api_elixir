defmodule PrettyWitheredApiWeb.Graphql.Resolvers.Category do
  @moduledoc false

  alias PrettyWitheredApi.Contexts.Category.Search, as: CCS
  alias PrettyWitheredApi.Contexts.Category.Create, as: CCC

  ## for searching
  def get_categories(_root, params, _info) do
    params
    |> CCS.validate_params(:graphql_query)
    |> CCS.search_categories(:graphql_query)
  end

  ## for viewing
  def get_category(_root, params, _info) do
    :view
    |> CCC.validate_params(params)
  end

  def create(_root, params, resolution) do
    params
    |> CCC.validate_params(:graphql_mutation)
    |> CCC.create_category(resolution)
  end

end
