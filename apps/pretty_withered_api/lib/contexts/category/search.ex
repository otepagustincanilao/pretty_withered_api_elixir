defmodule PrettyWitheredApi.Contexts.Category.Search do
  @moduledoc false

  alias Ecto.Changeset
  import Ecto.Query
  alias PrettyWitheredApi.Schemas.Category

  def is_valid_changeset?(%{valid?: true} = changeset), do: changeset.changes
  def is_valid_changeset?(%{valid?: false} = changeset), do: {:error, changeset}

  def validate_params(params, :graphql_query) do
    raise 1234
    fields = %{
      code: :string,
      name: :string,
      description: :string,
      slug: :string
    }

    {%{}, fields}
    |> Changeset.cast(params, Map.keys(fields))
    |> Changeset.validate_required([:code], message: "Enter brand code")
    |> Changeset.validate_required([:name], message: "Enter name")
    |> Changeset.validate_length(:name, max: 100, message: "Name only accepts value up to 100 characters")
    |> raise
    |> is_valid_changeset?()
  end

  def create_category({:error, changeset}, _resolution), do: {:error, changeset}
  def create_category(params, resolution) do
    %Category{}
    |> Category.changeset(params)
    |> Repo.insert()

    rescue
      Ecto.ConstraintError ->
        {:error, %Category{} |> Brand.changeset(params) |> Changeset.add_error(:code, "Brand code already exist!")}
  end
  
end
