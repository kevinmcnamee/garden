defmodule UiWeb.ImageController do
  use UiWeb, :controller

  import Phoenix.LiveView.Controller

  require Logger

  def show(conn, _params) do
    Picam.set_size(1280, 0)
    image = Picam.next_frame()

    conn
    |> put_resp_content_type("jpeg", "utf-8")
    |> send_resp(200, image)
  end
end
