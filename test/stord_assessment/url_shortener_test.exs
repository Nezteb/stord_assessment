defmodule StordAssessment.UrlShortenerTest do
  use StordAssessment.DataCase

  alias StordAssessment.UrlShortener

  describe "urls" do
    alias StordAssessment.UrlShortener.Url

    import StordAssessment.UrlShortenerFixtures

    @invalid_attrs %{hash: nil, url: nil, visits: nil}

    test "list_urls/0 returns all urls" do
      url = url_fixture()
      assert UrlShortener.list_urls() == [url]
    end

    test "get_url!/1 returns the url with given id" do
      url = url_fixture()
      assert UrlShortener.get_url!(url.id) == url
    end

    test "create_url/1 with valid data creates a url" do
      valid_attrs = %{hash: "some hash", url: "some url", visits: 42}

      assert {:ok, %Url{} = url} = UrlShortener.create_url(valid_attrs)
      assert url.hash == "some hash"
      assert url.url == "some url"
      assert url.visits == 42
    end

    test "create_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UrlShortener.create_url(@invalid_attrs)
    end

    test "update_url/2 with valid data updates the url" do
      url = url_fixture()
      update_attrs = %{hash: "some updated hash", url: "some updated url", visits: 43}

      assert {:ok, %Url{} = url} = UrlShortener.update_url(url, update_attrs)
      assert url.hash == "some updated hash"
      assert url.url == "some updated url"
      assert url.visits == 43
    end

    test "update_url/2 with invalid data returns error changeset" do
      url = url_fixture()
      assert {:error, %Ecto.Changeset{}} = UrlShortener.update_url(url, @invalid_attrs)
      assert url == UrlShortener.get_url!(url.id)
    end

    test "delete_url/1 deletes the url" do
      url = url_fixture()
      assert {:ok, %Url{}} = UrlShortener.delete_url(url)
      assert_raise Ecto.NoResultsError, fn -> UrlShortener.get_url!(url.id) end
    end

    test "change_url/1 returns a url changeset" do
      url = url_fixture()
      assert %Ecto.Changeset{} = UrlShortener.change_url(url)
    end
  end
end
