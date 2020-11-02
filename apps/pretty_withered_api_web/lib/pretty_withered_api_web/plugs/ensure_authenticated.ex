defmodule Auth.EnsureAuthenticated do
  @moduledoc false

  import Phoenix.Controller, only: [put_flash: 3, redirect: 2, put_layout: 2]
  import Plug.Conn

  def unauthenticated(conn, _params) do
    body = Poison.encode!(%{error: %{message: "Unauthorized"}})
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, body)
  end

end
