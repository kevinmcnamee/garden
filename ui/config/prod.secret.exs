# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

signing_salt =
  System.get_env("SIGNING_SALT") ||
    raise """
    environment variable SIGNING_SALT is missing.
    You can generate one by calling: mix phx.gen.secret 32
    """

config :ui, UiWeb.Endpoint,
  secret_key_base: secret_key_base,
  live_view: [signing_salt: signing_salt]

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :ui, UiWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
