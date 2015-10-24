# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :freshivore, Freshivore.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "E6zAxvu2JnEbo/xtb9QK22fXPjZXRQ0aJtdvAUNtkQ/cvNtBThBX22yUYSpWtqWp",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Freshivore.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :extwitter, :oauth, [
   consumer_key: "jwi19j2gDCEjbVGVNJ3mGiXto",
   consumer_secret: "vBq7nsjTmrcqRQbAERe6pJvOuOXAJ6QsMXvYmlGwn0GdDhxFaf",
   access_token: "198093-hTTA17542MmxYfAPN8rT6uU0Pc17o3nXklcgemkxwLv",
   access_token_secret: "JI864MxS48Qph7Yl0RmLaeDUzSfMibfVUeQ95Okk6XYuz"
]

config :exredis, url: System.get_env("REDIS_URL")
# redis://localhost:6379

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false
