defmodule PrettyWitheredApi.SchemaCase do
  @moduledoc "Base schema for tests"
  use ExUnit.CaseTemplate

  using do
    quote do
      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import PrettyWitheredApi.SchemaCase
      import PrettyWitheredApi.Factory
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(PrettyWitheredApi.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(PrettyWitheredApi.Repo, {:shared, self()})
    end

    :ok
  end
end
