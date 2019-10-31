# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :app_crawler,
  ecto_repos: [AppCrawler.Repo]

# Configures the endpoint
config :app_crawler, AppCrawler.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Mc6HFimqBNvl8P5GaBNw+e8EFcFABAZkRLCvbtS70J0ca/ZCoRfcnwMbT4bQ6851",
  render_errors: [view: AppCrawler.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AppCrawler.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
