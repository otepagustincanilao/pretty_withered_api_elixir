defmodule PrettyWitheredApi.Schemas.UserToken do
	@moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "user_tokens" do
    field :token, :string
    field :platform, :string

    belongs_to(:user, PrettyWitheredApi.Schemas.User)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :user_id,
      :token,
      :platform
    ])
  end
end
