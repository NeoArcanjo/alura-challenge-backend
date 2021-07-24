defmodule AluraChallengeBackend.AcervoTest do
  use AluraChallengeBackend.DataCase

  alias AluraChallengeBackend.Acervo

  describe "videos" do
    alias AluraChallengeBackend.Acervo.Video

    @valid_attrs %{descricao: "some descricao", titulo: "some titulo", url: "some url"}
    @update_attrs %{
      descricao: "some updated descricao",
      titulo: "some updated titulo",
      url: "some updated url"
    }
    @invalid_attrs %{descricao: nil, titulo: nil, url: nil}

    def video_fixture(attrs \\ %{}) do
      {:ok, video} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Acervo.create_video()

      video
    end

    test "list_videos/0 returns all videos" do
      video = video_fixture()
      assert Acervo.list_videos() == [video]
    end

    test "get_video!/1 returns the video with given id" do
      video = video_fixture()
      assert Acervo.get_video!(video.id) == video
    end

    test "create_video/1 with valid data creates a video" do
      assert {:ok, %Video{} = video} = Acervo.create_video(@valid_attrs)
      assert video.descricao == "some descricao"
      assert video.titulo == "some titulo"
      assert video.url == "some url"
    end

    test "create_video/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Acervo.create_video(@invalid_attrs)
    end

    test "update_video/2 with valid data updates the video" do
      video = video_fixture()
      assert {:ok, %Video{} = video} = Acervo.update_video(video, @update_attrs)
      assert video.descricao == "some updated descricao"
      assert video.titulo == "some updated titulo"
      assert video.url == "some updated url"
    end

    test "update_video/2 with invalid data returns error changeset" do
      video = video_fixture()
      assert {:error, %Ecto.Changeset{}} = Acervo.update_video(video, @invalid_attrs)
      assert video == Acervo.get_video!(video.id)
    end

    test "delete_video/1 deletes the video" do
      video = video_fixture()
      assert {:ok, %Video{}} = Acervo.delete_video(video)
      assert_raise Ecto.NoResultsError, fn -> Acervo.get_video!(video.id) end
    end

    test "change_video/1 returns a video changeset" do
      video = video_fixture()
      assert %Ecto.Changeset{} = Acervo.change_video(video)
    end
  end
end
