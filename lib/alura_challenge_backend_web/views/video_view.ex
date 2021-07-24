defmodule AluraChallengeBackendWeb.VideoView do
  use AluraChallengeBackendWeb, :view
  alias AluraChallengeBackendWeb.VideoView

  def render("index.json", %{videos: videos}) do
    %{data: render_many(videos, VideoView, "video.json")}
  end

  def render("show.json", %{video: video}) do
    %{data: render_one(video, VideoView, "video.json")}
  end

  def render("video.json", %{video: video}) do
    %{id: video.id, titulo: video.titulo, descricao: video.descricao, url: video.url}
  end
end
