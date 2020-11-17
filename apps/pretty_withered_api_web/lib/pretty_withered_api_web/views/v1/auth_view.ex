defmodule PrettyWitheredApiWeb.V1.AuthView do
  use PrettyWitheredApiWeb, :view

  def render("login.json", %{result: result}) do
    result
  end

end
