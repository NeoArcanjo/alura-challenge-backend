defmodule AluraChallengeBackendWeb.VideoControllerTest do
  use AluraChallengeBackendWeb.ConnCase

  alias AluraChallengeBackend.Acervo
  alias AluraChallengeBackend.Acervo.Video

  @create_attrs %{
    descricao: "some descricao",
    titulo: "some titulo",
    url: "some url"
  }
  @update_attrs %{
    descricao: "some updated descricao",
    titulo: "some updated titulo",
    url: "some updated url"
  }
  @invalid_attrs %{descricao: nil, titulo: nil, url: nil}

  def fixture(:video) do
    {:ok, video} = Acervo.create_video(@create_attrs)
    video
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all videos", %{conn: conn} do
      conn = get(conn, Routes.video_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create video" do
    test "renders video when data is valid", %{conn: conn} do
      conn = post(conn, Routes.video_path(conn, :create), video: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.video_path(conn, :show, id))

      assert %{
               "id" => id,
               "descricao" => "some descricao",
               "titulo" => "some titulo",
               "url" => "some url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.video_path(conn, :create), video: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update video" do
    setup [:create_video]

    test "renders video when data is valid", %{conn: conn, video: %Video{id: id} = video} do
      conn = put(conn, Routes.video_path(conn, :update, video), video: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.video_path(conn, :show, id))

      assert %{
               "id" => id,
               "descricao" => "some updated descricao",
               "titulo" => "some updated titulo",
               "url" => "some updated url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, video: video} do
      conn = put(conn, Routes.video_path(conn, :update, video), video: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete video" do
    setup [:create_video]

    test "deletes chosen video", %{conn: conn, video: video} do
      conn = delete(conn, Routes.video_path(conn, :delete, video))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.video_path(conn, :show, video))
      end
    end
  end

  defp create_video(_) do
    video = fixture(:video)
    %{video: video}
  end
end
