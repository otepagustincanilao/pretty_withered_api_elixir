defmodule PrettyWitheredApi.Repo do
  use Ecto.Repo,
    otp_app: :pretty_withered_api,
    adapter: Ecto.Adapters.Postgres
end
