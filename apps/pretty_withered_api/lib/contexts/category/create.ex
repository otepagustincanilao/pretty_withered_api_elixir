defmodule PrettyWitheredApi.Contexts.Category.Create do
  @moduledoc false

  import Ecto.Query

  alias Ecto.Changeset
  alias PrettyWitheredApi.Schemas.Brand
  alias PrettyWitheredApi.Repo

  def is_valid_changeset?(%{valid?: true} = changeset), do: changeset.changes
  def is_valid_changeset?(%{valid?: false} = changeset), do: {:error, changeset}

  def validate_params(params, :graphql_mutation) do
    fields = %{
      code: :string,
      name: :string,
      description: :string
    }

    {%{}, fields}
    |> Changeset.cast(params, Map.keys(fields))
    |> Changeset.validate_required([:code], message: "Enter brand code")
    |> Changeset.validate_required([:name], message: "Enter name")
    |> Changeset.validate_length(:name, max: 150, message: "Name only accepts alphanumeric value up to 150 characters")
    |> is_valid_changeset?()
  end

  def create_brand({:error, changeset}, _resolution), do: {:error, changeset}
  def create_brand(params, resolution) do
    %Brand{}
    |> Brand.changeset(params)
    |> Repo.insert()

    rescue
      Ecto.ConstraintError ->
        {:error, %Brand{} |> Brand.changeset(params) |> Changeset.add_error(:code, "Category code already exist!")}
  end
  
end