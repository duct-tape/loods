# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :loods,
  ecto_repos: [Loods.Repo]

# Configures the endpoint
config :loods, LoodsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "S+jiwuYRpQ6QB0hr+0iOVkSwdXOrk+ggyXlCKoG7SphizLZbIaGVtvB0bfb7hs51",
  render_errors: [view: LoodsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Loods.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :loods, Loods.Guardian,
  issuer: "loods_guardian",
  secret_key: "SuPerseCret_aBraCadabrA"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
