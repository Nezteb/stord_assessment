defmodule StordAssessment.UrlShortenerTest do
  use StordAssessment.DataCase

  alias StordAssessment.UrlShortener

  describe "urls" do
    alias StordAssessment.UrlShortener.Url

    import StordAssessment.UrlShortenerFixtures

    @invalid_attrs %{hash: nil, url: "asdf", visits: nil}

    test "list_urls/0 returns all urls" do
      url = url_fixture()
      assert UrlShortener.list_urls() == [url]
    end

    test "get_url!/1 returns the url with given id" do
      url = url_fixture()
      assert UrlShortener.get_url!(url.id) == url
    end

    test "create_url/1 with valid data creates a url" do
      valid_attrs = %{
        hash: "aHR0cDovL2V4YW1wbGUuY29tLzEyMw",
        url: "http://example.com/123",
        visits: 42
      }

      assert {:ok, %Url{} = url} = UrlShortener.create_url(valid_attrs)
      assert url.hash == "aHR0cDovL2V4YW1wbGUuY29tLzEyMw"
      assert url.url == "http://example.com/123"
      assert url.visits == 42
    end

    test "create_url/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UrlShortener.create_url(@invalid_attrs)
    end

    test "update_url/2 with valid data updates the url" do
      url = url_fixture()

      update_attrs = %{
        hash: "aHR0cDovL2V4YW1wbGUuY29tLzEyMw",
        url: "http://example.com/123",
        visits: 43
      }

      assert {:ok, %Url{} = url} = UrlShortener.update_url(url, update_attrs)
      assert url.hash == "aHR0cDovL2V4YW1wbGUuY29tLzEyMw"
      assert url.url == "http://example.com/123"
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
