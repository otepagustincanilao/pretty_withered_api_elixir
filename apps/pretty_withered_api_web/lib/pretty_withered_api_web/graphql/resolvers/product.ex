defmodule PrettyWitheredApiWeb.Graphql.Resolvers.Product do
  @moduledoc false

  alias PrettyWitheredApi.Contexts.Product.Create

  def get_products(_root, params, _info) do
    raise params
    :search
    |> ProductContext.validate_params(params, :graphql)
    # |> VC.valid_changeset()
    # |> BC.get_benefits(:search, :graphql)
    # |> return_result()
  end

  def get_product(_root, params, _info) do
    :view
    |> ProductContext.validate_params(params)
    # |> VC.valid_changeset()
    # |> BC.get_benefit(:view, :graphql)
    # |> return_result()
  end

  def create(_root, params, _info) do
    params
    |> Create.validate_params(:graphql_mutation)
    # |> VC.valid_changeset()
    # |> BC.get_benefit(:view, :graphql)
    # |> return_result()
  end

  defp return_result({:error, changeset}), do: {:error, changeset}
  defp return_result(result), do: {:ok, result}
end
