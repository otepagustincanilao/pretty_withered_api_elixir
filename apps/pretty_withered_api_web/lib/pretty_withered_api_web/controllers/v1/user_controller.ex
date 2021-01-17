defmodule PrettyWitheredApiWeb.V1.UserController do
  use PrettyWitheredApiWeb, :controller

  alias PrettyWitheredApiWeb.Plugs.Guardian

  alias PrettyWitheredApiWeb.{
    V1.UserView,
    ErrorView
  }

  alias PrettyWitheredApi.Contexts.User.Create, as: UC
  alias PrettyWitheredApi.Contexts.UtilityContext


  def create_without_email_confirmation(conn, params) do
    case UC.casting_and_validation(params) do
    	{:false, changeset} ->
    		conn
		    |> put_status(400)
		    |> put_view(ErrorView)
		    |> render("error.json", error: UtilityContext.transform_error_message(changeset))

    	{true, %{changes: changes}} -> 
    		{:ok, user} = 
          changes |> UC.insert_user_creds()

        updated_conn = ## auto login
          conn
          |> Guardian.Plug.sign_in(user, %{is_oauth?: false}, ttl: {1, :day})

        updated_conn
        |> put_status(200)
        |> put_view(UserView)
        |> render("create_user_without_email_confirmation.json", 
          %{
            result: user 
            |> Map.put(:jwt, updated_conn |> Guardian.Plug.current_token()) 
            |> Map.put(:jwt_expiry, UtilityContext.add_duration_to_date(Timex.now(), 1))
        })
    end
  end

  def create(conn, params) do
    case UC.casting_and_validation(params) do
      {:false, changeset} ->
        conn
        |> put_status(400)
        |> put_view(ErrorView)
        |> render("error.json", error: UtilityContext.transform_error_message(changeset))

      {true, %{changes: changes}} -> 
        {:ok, user} = 
          changes 
          |> UC.insert_user_creds()
          |> UC.send_email()

        conn
        |> put_status(200)
        |> put_view(UserView)
        |> render("create_user.json", %{result: user})
    end
  end


end
