defmodule UiWeb.DashboardController do
  use UiWeb, :controller

  import Phoenix.LiveView.Controller

  def index(conn, _params) do
    live_render(conn, UiWeb.DashboardLive)
  end
end
