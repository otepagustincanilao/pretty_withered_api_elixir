defmodule PrettyWitheredApi.Contexts.Category.Create do
  @moduledoc false

  import Ecto.Query

  alias Ecto.Changeset
  alias PrettyWitheredApi.Schemas.Category
  alias PrettyWitheredApi.Repo

  def is_valid_changeset?(%{valid?: true} = changeset), do: changeset.changes
  def is_valid_changeset?(%{valid?: false} = changeset), do: {:error, changeset}

  def validate_params(params, :graphql_mutation) do
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
    |> Changeset.validate_length(:name, max: 150, message: "Name only accepts alphanumeric value up to 150 characters")
    |> is_valid_changeset?()
  end

  def create_category({:error, changeset}, _resolution), do: {:error, changeset}
  def create_category(params, resolution) do
    %Category{}
    |> Category.changeset(params)
    |> Repo.insert()

    rescue
      Ecto.ConstraintError ->
        {:error, %Category{} |> Category.changeset(params) |> Changeset.add_error(:code, "Category code already exist!")}
  end
  
end