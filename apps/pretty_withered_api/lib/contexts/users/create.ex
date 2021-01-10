defmodule PrettyWitheredApi.Contexts.Users.Create do
  @moduledoc false

  alias Ecto.Changeset
  alias PrettyWitheredApi.Repo
  import Ecto.Query

  alias PrettyWitheredApi.Schemas.User
  alias PrettyWitheredApi.Contexts.UtilityContext

  def get_user(%{user_id: id} = params) do
    User
    |> where([u], u.id == ^id)
    |> Repo.one()
  end

  def casting_and_validation(params) do
    fields = %{
      email: :string,
      username: :string,
      password: :string,
      confirm_password: :string,
      hashed_password: :string ## for latest ecto version, it requires to be existing in castings
    }

    {%{}, fields}
    |> Changeset.cast(params, Map.keys(fields))
    |> Changeset.validate_required(:username, message: "Enter Username")
    |> Changeset.validate_required(:password, message: "Enter Password")
    |> Changeset.validate_format(:password, ~r/(?=.*?[0-9])/, message: "Password must have at least 1 numeric character")
    |> Changeset.validate_format(:password, ~r/(?=.*?[A-Z])/, message: "Password must have at least 1 upper case letter")
    |> Changeset.validate_format(:username, ~r/(^[A-Za-z0-9\\_\\@#$%]*$)/, message: "Username has invalid format")
    |> Changeset.validate_length(:username, min: 7, message: "Username must be at least 7 alphanumeric characters")
    |> Changeset.validate_length(:username, max: 100, message: "Username must be at most 100 alphanumeric characters")
    |> Changeset.validate_format(:password, ~r/(?=.*?[#?!@$%^&*-])/, message: "Password must have at least 1 special character")
    |> Changeset.validate_length(:password, min: 8, max: 20, message: "New password must be 8 to 20 characters long")
    |> validate_pass_confirmation()
    |> validate_if_uniq(:username)
    |> validate_if_uniq(:email)
    |> is_pass_field_has_error?()
    |> UtilityContext.is_valid_changeset?()
  end

  defp is_pass_field_has_error?(%{errors: errors, changes: %{password: password}} = changeset) do
    password_error? = 
      errors
      |> Enum.filter(fn({key, tuple}) -> 
        key == :password
      end)
    
    if Enum.empty?(password_error?) do
      changeset
      |> Changeset.put_change(:hashed_password, Argon2.hash_pwd_salt(password))
    else
      changeset
    end
  end

  defp validate_pass_confirmation(%{changes: %{password: pass, confirm_password: cp}} = changeset) when pass == cp, do: changeset
  defp validate_pass_confirmation(changeset), do: changeset |> Changeset.add_error(:password, "Password field and confirm password field doesn't matched")

  defp validate_if_uniq(%{changes: %{username: username}} = changeset, key) when key == :username do
    msg = "Username already exist!"
    User
    |> where([u], u.username == ^username)
    |> select([u], u.username)
    |> Repo.one()
    |> is_existing?(changeset, {key, msg})
  end
  defp validate_if_uniq(%{changes: %{email: email}} = changeset, key) when key == :email do
    msg = "Email already exist!"
    User
    |> where([u], u.email == ^email)
    |> select([u], u.email)
    |> Repo.one()
    |> is_existing?(changeset, {key, msg})
  end

  defp is_existing?(nil, changeset, {_key, _msg}), do: changeset
  defp is_existing?(_result, changeset, {key, msg}), do: changeset |> Changeset.add_error(key, msg)
  
  def insert_user_creds(valid_changes) do
    %User{}
    |> User.changeset(valid_changes |> Map.put(:status, "P") |> Map.put(:login_attempts, 0))
    |> Repo.insert()
  end

  def update_user(user_struct, params) do
    user_struct
    |> User.changeset(params)
    |> Repo.update()
  end

  def send_email(user) do
    
  end

end
