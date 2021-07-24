# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :alura_challenge_backend,
  ecto_repos: [AluraChallengeBackend.Repo]

# Configures the endpoint
config :alura_challenge_backend, AluraChallengeBackendWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ARjZyhz3jZJDRnkfU7ZHm1Rm5EfWwhnR5CqjvCGg+bniWwyJMKSElNTpvsIlpKPw",
  render_errors: [view: AluraChallengeBackendWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: AluraChallengeBackend.PubSub,
  live_view: [signing_salt: "OsssQNAn"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

if Mix.env() != :prod do
  config :git_hooks,
    verbose: true,
    hooks: [
      pre_commit: [
        tasks: [
          "mix format",
          "mix clean",
          "mix compile --warning-as-errors",
          # "mix credo --strict",
          # "mix doctor --summary",
          # "mix test --trace"
        ]
      ]
    ]
end

config :new_relic_agent,
  app_name: "AluraChallengeBackend; AluraChallengeBackendWeb",
  license_key: "d92936755a27594fc4485866a84f278d0bc2NRAL",
  infinite_tracing_trace_observer_host: "trace-observer.host",
  logs_in_context: :direct

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
