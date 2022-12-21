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
        "url" => "http://example.com",
      })
      |> StordAssessment.UrlShortener.create_url()

    url
  end
end
