# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :ui, UiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "beFnotf4E85LugblTZ1h//OPc2nb1K4jn0OtXLFA2WycHqmR0EJQIeSAnYc+dMog",
  render_errors: [view: UiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ui.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "IIGqOEHc+Se6CBLpHeKsnhMronYMQEAw"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
