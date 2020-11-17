defmodule PrettyWitheredApiWeb.V1.AuthController do
  use PrettyWitheredApiWeb, :controller

  alias PrettyWitheredApiWeb.{
    V1.AuthView,
    ErrorView
  }

  alias PrettyWitheredApi.Contexts.{
    AuthContext,
    UtilityContext
  }

  def login(conn, params) do
    case AuthContext.login_validation(params) do
    	{:false, changeset} ->
    		conn
		    |> put_status(400)
		    |> put_view(ErrorView)
		    |> render("error.json", error: UtilityContext.transform_error_message(changeset))

    	{true, _changeset} ->
        conn
        |> put_status(200)
        |> put_view(AuthView)
        |> render("login.json", result: %{message: "Login successful!"})
    end
  end

end
