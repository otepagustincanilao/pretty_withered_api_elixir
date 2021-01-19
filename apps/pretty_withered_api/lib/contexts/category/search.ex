defmodule PrettyWitheredApi.Contexts.Category.Search do
  @moduledoc false
  import Ecto.Query
  alias Ecto.Changeset
  alias PrettyWitheredApi.{
    Repo,
    Schemas.Category,
    Contexts.UtilityContext
  }

  ###################################### start of validation ################################################################## 
  def is_valid_changeset?(%{valid?: true} = changeset), do: changeset.changes
  def is_valid_changeset?(%{valid?: false} = changeset), do: {:error, changeset}

  def validate_params(params, :graphql_query) do
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
    |> validate_order_by()
    |> validate_sort_by()
    |> validate_display_per_page()
    |> is_valid_changeset?()
  end

  defp validate_order_by(%{valid?: false} = changeset), do: changeset
  defp validate_order_by(changeset) do
    changeset
    |> Changeset.validate_inclusion(:order_by, ["asc", "desc", "ASC", "DESC"],
      message: "Order by is invalid: '#{changeset.changes.order_by}''. Allowed values [asc, desc]"
    )
  end

  defp validate_sort_by(%{valid?: false} = changeset), do: changeset
  defp validate_sort_by(changeset) do
    changeset
    |> Changeset.validate_inclusion(
      :sort_by,
      ["code", "name", "description", "slug", "updated_at", "inserted_at"],
      message:
        "Sort by is invalid: '#{changeset.changes.sort_by}'. Allowed values. [code, name, description, slug, updated_at, inserted_at]"
    )
  end

  defp validate_display_per_page(%{changes: %{display_per_page: display_per_page}} = changeset) do
    allowed_values = [5, 10, 20, 50, 100]

    if Enum.member?(allowed_values, display_per_page) do
      changeset
    else
      Changeset.add_error(
        changeset,
        :display_per_page,
        "Display per page is invalid: '#{changeset.changes.display_per_page}'. Allowed values [5, 10, 20, 50, 100]"
      )
    end
  end
  defp validate_display_per_page(changeset), do: changeset

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

  ###################################### end of validation ################################################################## 
  
  ###################################### start of retrieval #################################################################
  require TimeFrame
  def search_categories(params, :graphql_query) do
  TimeFrame.execute "plan code generator response time" do
    search_value = if Map.has_key?(params, :search_value), do: params.search_value, else: ""
    offset = params.page_number * params.display_per_page - params.display_per_page

    Category
    |> where(
      [c],
      ilike(c.code, ^"%#{search_value}%") or
      ilike(c.name, ^"%#{search_value}%") or
      ilike(c.description, ^"%#{search_value}%") or
      ilike(c.slug, ^"%#{search_value}%")
    )
    |> select([c], %{
      code: c.code,
      name: c.name,
      description: c.description,
      slug: c.slug      
    })
    |> offset(^offset)
    |> limit(^params.display_per_page)
    |> UtilityContext.sorting_and_order_by(params.sort_by, params.order_by)
    |> assemble_result()
  end
  end

  defp assemble_result(query) do
    result = %{categories: Repo.all(query), count: Repo.one(from c in subquery(query), select: count(c.code))}

    {:ok, result}
  end

  ###################################### start of retrieval #################################################################
end
