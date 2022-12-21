defmodule StordAssessment.UrlShortener.Url do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "urls" do
    field :hash, :string
    field :url, :string
    field :visits, :integer

    timestamps()
  end

  @doc false
  def changeset(url, attrs) do
    url
    |> cast(attrs, [:url, :hash, :visits])
    |> validate_required([:url, :hash, :visits])
    |> validate_url(:url)
    |> unique_constraint(:url, name: :url_unique)
  end

  def create_changeset(attrs),
    do: %__MODULE__{} |> changeset(attrs)

  def update_changeset(url, attrs) do
    url
    |> cast(attrs, [:url, :hash, :visits])
    |> validate_url(:url)
    |> unique_constraint(:url, name: :url_unique)
  end

  # Borrowed from https://dev.to/hlappa/url-shorten-er-with-elixir-and-phoenix-aol
  def validate_url(changeset, field, options \\ %{}) do
    validate_change(changeset, field, fn :url, url ->
      uri = URI.parse(url)

      cond do
        uri.scheme in [nil, ""] ->
          [{field, options[:message] || "invalid url scheme"}]

        uri.host in [nil, ""] ->
          [{field, options[:message] || "invalid url host"}]

        true ->
          []
      end
    end)
  end
end
