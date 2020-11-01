defmodule PrettyWitheredApi.Factory do
  use ExMachina.Ecto, repo: PrettyWitheredApi.Repo

  alias PrettyWitheredApi.Schemas.{
    Brand
  }

  def brand_factory do
    %Brand{}
  end

end
