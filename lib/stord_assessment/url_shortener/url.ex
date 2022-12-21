defmodule StordAssessment.UrlShortener.Url do
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
  end
end
