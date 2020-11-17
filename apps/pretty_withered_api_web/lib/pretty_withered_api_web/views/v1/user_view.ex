defmodule PrettyWitheredApiWeb.V1.UserView do
  use PrettyWitheredApiWeb, :view

  def render("create_user.json", %{result: result}) do
    result 
    |> Map.from_struct()
    |> Map.delete(:__meta__)
    |> Map.delete(:deactivate_date)
    |> Map.delete(:deactivate_remarks)
    |> Map.delete(:reactivate_date)
    |> Map.delete(:reactivate_remarks)
  end

end
