defmodule PrettyWitheredApiWeb.Plugs.Guardian do
  @moduledoc """
  Implementation module for Guardian and functions for authentication.
  """
  use Guardian, otp_app: :pretty_withered_api_web
  alias PrettyWitheredApi.Schemas.{Users}

  def subject_for_token(resource, _claims) do
    {:ok, to_string(resource.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Users.get_user(id) do
      nil -> {:error, :resource_not_found}
      account -> {:ok, account}
    end
  end
end