defmodule StordAssessment.UrlShortenerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `StordAssessment.UrlShortener` context.
  """

  @doc """
  Generate a url.
  """
  def url_fixture(attrs \\ %{}) do
    {:ok, url} =
      attrs
      |> Enum.into(%{
        hash: "some hash",
        url: "some url",
        visits: 42
      })
      |> StordAssessment.UrlShortener.create_url()

    url
  end
end
