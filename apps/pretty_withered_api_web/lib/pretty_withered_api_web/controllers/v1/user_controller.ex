defmodule PrettyWitheredApiWeb.V1.UserController do
  use PrettyWitheredApiWeb, :controller

  alias PrettyWitheredApiWeb.V1.UserView

  def create(conn, _params) do
    conn
    |> put_status(200)
    |> put_view(UserView)
    |> render("brand.json", result: %{user_id: "231"})
  end
end
