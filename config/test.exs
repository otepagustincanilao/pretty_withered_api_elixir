use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :pretty_withered_api, PrettyWitheredApi.Repo,
  username: "postgres",
  password: "postgres",
  database: "pretty_withered_api_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :pretty_withered_api_web, PrettyWitheredApiWeb.Endpoint,
  http: [port: 9002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn


config :ueberauth, Ueberauth,
  providers: [
    google: { Ueberauth.Strategy.Google, [] },
    facebook: { Ueberauth.Strategy.Facebook, [] },
    github: { Ueberauth.Strategy.Github, [] }
  ]

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")


config :pretty_withered_api_web, PrettyWitheredApiWeb.Plugs.Guardian,
  issuer: "prettyw",
  secret_key: "KLbYSAOnFH1G5PtKGmWvl1S7runZngrvWkNY5o3swW5G7PuLGhv0Mpdl+P1Vw+yT" 