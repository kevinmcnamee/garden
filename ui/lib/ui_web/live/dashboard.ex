defmodule UiWeb.DashboardLive do
  use Phoenix.LiveView

  alias Phoenix.Socket.Broadcast

  @topic "dashboard"

  def render(assigns) do
    Phoenix.View.render(UiWeb.DashboardView, "index.html", assigns)
  end

  def mount(_assigns, socket) do
    if connected?(socket) do
      UiWeb.Endpoint.subscribe(@topic)
    end

    {:ok, assign(socket, temperature: 0.0, humidity: 0.0, timestamp: NaiveDateTime.utc_now())}
  end

  @impl true
  def handle_info(
        %Broadcast{topic: topic, payload: payload} = message,
        socket
      ) do
    {:noreply,
     assign(socket,
       timestamp: NaiveDateTime.utc_now(),
       temperature: payload.temperature,
       humidity: payload.humidity
     )}
  end
end
