defmodule AluraChallengeBackend.Repo do
  use Ecto.Repo,
    otp_app: :alura_challenge_backend,
    adapter: Ecto.Adapters.Postgres
end
