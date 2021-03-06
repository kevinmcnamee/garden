defmodule UiWeb.Router do
  use UiWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)

    plug(Phoenix.LiveView.Flash)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", UiWeb do
    pipe_through(:browser)

    get("/", DashboardController, :index)

    get("/image/:timestamp", ImageController, :show)
  end

  # Other scopes may use custom stacks.
  # scope "/api", UiWeb do
  #   pipe_through :api
  # end
end
