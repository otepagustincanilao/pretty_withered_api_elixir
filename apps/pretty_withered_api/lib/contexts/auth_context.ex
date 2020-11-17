defmodule PrettyWitheredApi.Contexts.AuthContext do
  @moduledoc """
  Business context for authentication
  """

  import Ecto.Query
  alias Ecto.Changeset
  alias PrettyWitheredApi.Repo

  alias PrettyWitheredApi.Schemas.User
  alias PrettyWitheredApi.Contexts.UtilityContext
  alias PrettyWitheredApi.Contexts.UserContext

  def login_validation(params) do
    fields = %{
      username_or_email: :string,
      password: :string,
      user_struct: :map
    }

    {%{}, fields}
    |> Changeset.cast(params, Map.keys(fields))
    |> Changeset.validate_required(:username_or_email, message: "Enter Username or email") 
    |> Changeset.validate_required(:password, message: "Enter Password")
    |> validate_credentials()
    |> UtilityContext.is_valid_changeset?()
  end

  defp validate_credentials(%{changes: %{username_or_email: username_or_email}} = changeset) do 
    User
    |> where([u], u.username == ^username_or_email or u.email == ^username_or_email)
    |> Repo.one()
    |> is_existing?(changeset)
  end
  defp validate_credentials(changeset), do: changeset

  defp is_existing?(nil, changeset) do
    ## do not reveal if it is invalid username or password for security purpose
    changeset
    |> Changeset.add_error(:credentials, "You have entered an invalid username/email and/or password")
  end
  defp is_existing?(%{status: status} = user, changeset) do
    changeset
    |> validate_status(status)
    |> validate_pass(user)
  end

  defp validate_status(changeset, "A"), do: changeset
  defp validate_status(changeset, "P"), do: changeset |> Changeset.add_error(:credentials, "Your email is not yet verified!")
  defp validate_status(changeset, "L"), do: changeset |> Changeset.add_error(:credentials, "Your account has been locked due to excessive tries!")
  defp validate_status(changeset, status), do: raise "Data issue for status: #{status}"

  defp validate_pass(%{valid?: true, changes: %{password: param_pass}} = changeset, %{hashed_password: hashed_password} = user) do
    if hashed_password |> :base64.decode() == param_pass do
      reset_login_attempts(user)
      changeset
    else
      {:ok, user} = add_login_attempts(user)
      changeset
      |> check_attempts_count(user)
    end
  end
  defp validate_pass(changeset, _user), do: changeset

  defp add_login_attempts(user), do: user |> UserContext.update_user(%{login_attempts: user.login_attempts + 1})
  defp reset_login_attempts(user), do: user |> UserContext.update_user(%{login_attempts: 0})

  defp check_attempts_count(%{valid?: true} = changeset, %{login_attempts: login_attempts} = user) do
    case login_attempts do
      3 ->
        UserContext.update_user(user, %{status: "L"})
        changeset
        |> Changeset.add_error(:credentials, "Your account has been locked due to excessive tries!") 
        
      _ ->
        changeset
        |> Changeset.add_error(:credentials, "You have entered an invalid username/email and/or password") 
    end
  end
  defp check_attempts_count(changeset, _user), do: changeset

end
