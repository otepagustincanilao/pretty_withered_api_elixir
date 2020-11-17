defmodule PrettyWitheredApiWeb.V1.UserController do
  use PrettyWitheredApiWeb, :controller

  alias PrettyWitheredApiWeb.V1.UserView
  alias PrettyWitheredApiWeb.ErrorView
  alias PrettyWitheredApi.Contexts.UserContext
  alias PrettyWitheredApi.Contexts.UtilityContext

  def create(conn, params) do
    case UserContext.casting_and_validation(params) do
    	{:false, changeset} ->
    		conn
		    |> put_status(400)
		    |> put_view(ErrorView)
		    |> render("error.json", error: UtilityContext.transform_error_message(changeset))

    	{true, %{changes: changes}} -> 
    		{:ok, user} = changes |> UserContext.insert_user_creds()

        conn
        |> put_status(200)
        |> put_view(UserView)
        |> render("create_user.json", result: user)
    end
  end

end
