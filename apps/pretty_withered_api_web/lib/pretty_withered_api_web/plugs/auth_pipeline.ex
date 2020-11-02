defmodule Auth.Guardian.AuthPipeline.JSON do
  @moduledoc false

  use Guardian.Plug.Pipeline, otp_app: :pretty_withered_api_web,
  error_handler: Auth.Api.ErrorHandler,
  module: PrettyWitheredApiWeb.Plugs.Guardian

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.LoadResource, allow_blank: true
end

defmodule Auth.Guardian.AuthPipeline.GraphQL.JSON do
  @moduledoc false

  use Guardian.Plug.Pipeline, otp_app: :pretty_withered_api_web,
  error_handler: Auth.Api.ErrorHandler,
  module: PrettyWitheredApiWeb.Plugs.Guardian

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.LoadResource, allow_blank: true
end