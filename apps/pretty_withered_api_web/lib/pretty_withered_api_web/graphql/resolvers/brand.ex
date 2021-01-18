defmodule PrettyWitheredApiWeb.Graphql.Resolvers.Brand do
  @moduledoc false

  # @type resolver_output :: ok_output | error_output | plugin_output
  # @type ok_output :: {:ok, any}
  # @type error_output :: {:error, binary}
  # @type plugin_output :: {:plugin, Absinthe.Plugin.t(), term}

  alias PrettyWitheredApi.Contexts.Brand.Search, as: CBS
  alias PrettyWitheredApi.Contexts.Brand.Create, as: CBC

  def get_brands(_root, params, _info) do
    raise params
    :search
    |> CBS.validate_params(params, :graphql)
    # |> VC.valid_changeset()
    # |> BC.get_benefits(:search, :graphql)
    # |> return_result()
  end

  def get_brand(_root, params, _info) do
    :view
    |> CBS.validate_params(params)
    # |> VC.valid_changeset()
    # |> BC.get_benefit(:view, :graphql)
    # |> return_result()
  end

  def create(_root, params, resolution) do
    params
    |> CBC.validate_params(:graphql_mutation)
    |> CBC.create_brand(resolution)
    |> return_result()
  end

  defp return_result({:error, changeset}), do: {:error, changeset}
  defp return_result({:ok, result}), do: {:ok, result}
end
