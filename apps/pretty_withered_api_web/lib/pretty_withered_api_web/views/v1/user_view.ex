defmodule PrettyWitheredApiWeb.V1.UserView do
  use PrettyWitheredApiWeb, :view

  def render("user.json", %{result: result}) do
    %{
      user_id: result.id
    }
  end

end
