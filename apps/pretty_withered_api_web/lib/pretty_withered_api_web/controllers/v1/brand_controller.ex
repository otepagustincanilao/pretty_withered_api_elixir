defmodule PrettyWitheredApiWeb.V1.BrandController do
  use PrettyWitheredApiWeb, :controller

  alias PrettyWitheredApiWeb.V1.BrandView

  def create(conn, _params) do
    conn
    |> put_status(200)
    |> put_view(BrandView)
    |> render("brand.json", result: %{brand: "nike"})
  end
end
