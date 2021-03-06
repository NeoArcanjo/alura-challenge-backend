defmodule AluraChallengeBackendWeb.VideoController do
  use AluraChallengeBackendWeb, :controller

  alias AluraChallengeBackend.Acervo
  alias AluraChallengeBackend.Acervo.Video

  action_fallback AluraChallengeBackendWeb.FallbackController

  def index(conn, _params) do
    videos = Acervo.list_videos()
    render(conn, "index.json", videos: videos)
  end

  def create(conn, %{"video" => video_params}) do
    with {:ok, %Video{} = video} <- Acervo.create_video(video_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.video_path(conn, :show, video))
      |> render("show.json", video: video)
    end
  end

  def show(conn, %{"id" => id}) do
    video = Acervo.get_video!(id)
    render(conn, "show.json", video: video)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    video = Acervo.get_video!(id)

    with {:ok, %Video{} = video} <- Acervo.update_video(video, video_params) do
      render(conn, "show.json", video: video)
    end
  end

  def delete(conn, %{"id" => id}) do
    video = Acervo.get_video!(id)

    with {:ok, %Video{}} <- Acervo.delete_video(video) do
      send_resp(conn, :no_content, "")
    end
  end
end
