defmodule PrettyWitheredApi.Contexts.UserContext do
  @moduledoc false

  alias Ecto.Changeset
  import Ecto.Query

  alias PrettyWitheredApi.Schemas.User

  def get_user(%{user_id: id} = params) do
    User
    |> where([u], u.id == ^id)
    |> Repo.one()
  end

end
