defmodule AluraChallengeBackend.Acervo.Video do
  use Ecto.Schema
  import Ecto.Changeset

  schema "videos" do
    field :descricao, :string
    field :titulo, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(video, attrs) do
    video
    |> cast(attrs, [:titulo, :descricao, :url])
    |> validate_required([:titulo, :descricao, :url])
  end
end
