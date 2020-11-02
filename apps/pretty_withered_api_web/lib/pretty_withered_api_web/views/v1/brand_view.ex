defmodule PrettyWitheredApiWeb.V1.BrandView do
  use PrettyWitheredApiWeb, :view

  def render("brand.json", %{result: result}) do
    %{
      brand_id: result.brand
    }
  end

end