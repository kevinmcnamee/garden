# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :garden_ui, GardenUiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+s6Qg+OwLjFcNqvXlXul7RDYhdxz0o8W13pVOpIVBC1GVxm4si3iJMjXpBlXK85H",
  render_errors: [view: GardenUiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GardenUi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
