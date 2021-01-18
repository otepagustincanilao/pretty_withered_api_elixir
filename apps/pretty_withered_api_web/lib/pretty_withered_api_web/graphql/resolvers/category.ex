defmodule PrettyWitheredApiWeb.Graphql.Resolvers.Category do
  @moduledoc false

  # @type resolver_output :: ok_output | error_output | plugin_output
  # @type ok_output :: {:ok, any}
  # @type error_output :: {:error, binary}
  # @type plugin_output :: {:plugin, Absinthe.Plugin.t(), term}

  alias PrettyWitheredApi.Contexts.Category.Search, as: CCS
  alias PrettyWitheredApi.Contexts.Category.Create, as: CCC

  def get_categories(_root, params, _info) do
    params
    |> CCS.validate_params(params, :graphql_query)
    # |> VC.valid_changeset()
    # |> BC.get_benefits(:search, :graphql)
    # |> return_result()
  end

  def get_category(_root, params, _info) do
    :view
    |> CCC.validate_params(params)
    # |> VC.valid_changeset()
    # |> BC.get_benefit(:view, :graphql)
    # |> return_result()
  end

  def create(_root, params, resolution) do
    params
    |> CCC.validate_params(:graphql_mutation)
    |> CCC.create_brand(resolution)
    |> return_result()
  end

  defp return_result({:error, changeset}), do: {:error, changeset}
  defp return_result({:ok, result}), do: {:ok, result}
end
