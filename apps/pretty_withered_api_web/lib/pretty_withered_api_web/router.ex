defmodule PrettyWitheredApiWeb.Router do
  use PrettyWitheredApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth_api do
    plug :accepts, ["json", "json-api"]
    plug Auth.Guardian.AuthPipeline.JSON
  end

  scope "/", PrettyWitheredApiWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api" do
    scope "/v1" do
      pipe_through :api

      forward "/graphql", Absinthe.Plug,
        schema: PrettyWitheredApiWeb.Graphql.Schema,
        json_codec: Jason

      forward "/graphiql", Absinthe.Plug.GraphiQL,
        schema: PrettyWitheredApiWeb.Graphql.Schema,
        interface: :advanced
    end
  end

  # Other scopes may use custom stacks.
  scope "/api", PrettyWitheredApiWeb do
    scope "/v1", V1 do

      ## to follow oauth
      scope "/oauth" do
        post "/login", AuthController, :login
        get "/:provider", AuthController, :request
      end

      scope "/users" do
        scope "/no-confirmation-needed" do
          post "/create", UserController, :create_without_email_confirmation
        end
    
        post "/create", UserController, :create    
        get "/verify-link", UserController, :create    
      end

      pipe_through :auth_api

      scope "/brands" do
        post "/create", BrandController, :create
      end

      scope "/products" do
        post "/create", ProductController, :create
      end

      scope "/customers" do
        post "/create", CustomerController, :create
      end

      scope "/orders" do
        post "/create", OrderController, :create
      end

      scope "/categories" do
        post "/create", CategoriesController, :create
      end

    end
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: PrettyWitheredApiWeb.Telemetry
    end
  end
end
