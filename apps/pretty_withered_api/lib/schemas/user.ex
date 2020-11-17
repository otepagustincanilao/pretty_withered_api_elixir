defmodule PrettyWitheredApi.Schemas.User do
	@moduledoc false
  use PrettyWitheredApi.Schema
  import Ecto.Changeset

  alias __MODULE__

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "users" do
    field :username, :string
    field :hashed_password, :string
    field :email, :string
    field :mobile, :string
    field :is_verified, :boolean, default: false
    field :is_first_time, :boolean, default: true
    field :login_attempts, :integer

    field :deactivate_date, :utc_datetime
    field :deactivate_remarks, :string

    field :reactivate_date, :utc_datetime
    field :reactivate_remarks, :string

    field :status, :string ## asof 11/17/2020 10pm

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [
      :username,
      :hashed_password,
      :email,
      :mobile,
      :is_verified,
      :is_first_time,
      :login_attempts,
      :deactivate_date,
      :deactivate_remarks,
      :reactivate_date,
      :reactivate_remarks,
      :status
    ])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
  end
end
