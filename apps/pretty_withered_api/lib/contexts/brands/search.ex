defmodule PrettyWitheredApi.Contexts.Brands.Search do
  @moduledoc false

  alias Ecto.Changeset
  import Ecto.Query

  def is_valid_changeset?(changeset), do: {changeset.valid?, changeset}
  def validate_params(:search, params, :graphql) do
    fields = %{
      search_value: :string,
      page_number: :integer,
      display_per_page: :integer,
      sort_by: :string,
      order_by: :string
    }

    {%{}, fields}
    |> Changeset.cast(params, Map.keys(fields))
    |> Changeset.validate_required([:page_number], message: "Enter page number")
    |> Changeset.validate_required([:display_per_page], message: "Enter display per page")
    |> Changeset.validate_required([:sort_by], message: "Enter sort by")
    |> Changeset.validate_required([:order_by], message: "Enter order by")
    |> lower_value(:sort_by)
    |> lower_value(:order_by)
    |> Changeset.validate_number(:page_number,
      greater_than: 0,
      message: "Page number should be greater than zero"
    )
    |> Changeset.validate_number(:display_per_page,
      greater_than: 0,
      message: "Display per page should be greater than zero"
    )
    |> is_valid_changeset?()
  end

  defp lower_value(changeset, key) do
    with true <- Map.has_key?(changeset.changes, key) do
      string =
        changeset.changes[key]
        |> String.split(" ")
        |> Enum.map(&String.downcase(&1))
        |> Enum.join(" ")

      changeset
      |> Changeset.put_change(key, string)
    else
      _ ->
        changeset
    end
  end
  
end
