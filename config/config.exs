# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :discuss,
  ecto_repos: [Discuss.Repo]

# Configures the endpoint
config :discuss, DiscussWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PEII3RtAgUjH0nApWi61PHpzaaeG3o+gvw/5m2LSmQDsN9WJstXY4Zj0k5048bJk",
  render_errors: [view: DiscussWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Discuss.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :ueberauth, Ueberauth,
  providers: [
    github: { Ueberauth.Strategy.Github, [] }
  ]
# config :ueberauth, Ueberauth.Strategy.Github.OAuth,
#   client_id: System.get_env("GITHUB_CLIENT_ID"),
#   client_secret: System.get_env("GITHUB_CLIENT_SECRET")
config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "e7e348d877e5556c7184",
  client_secret: "9112e043712a511ce7956bf2690da7466b720d94"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
