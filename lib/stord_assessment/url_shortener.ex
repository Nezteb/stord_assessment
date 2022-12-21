defmodule StordAssessment.UrlShortener do
  @moduledoc """
  The UrlShortener context.
  """

  import Ecto.Query, warn: false
  alias StordAssessment.Repo

  alias StordAssessment.UrlShortener.Url

  @doc """
  Returns the list of urls.

  ## Examples

      iex> list_urls()
      [%Url{}, ...]

  """
  def list_urls do
    Repo.all(Url)
  end

  @doc """
  Gets a single url.

  Raises `Ecto.NoResultsError` if the Url does not exist.

  ## Examples

      iex> get_url!(123)
      %Url{}

      iex> get_url!(456)
      ** (Ecto.NoResultsError)

  """
  def get_url!(id), do: Repo.get!(Url, id)

  def get_url_by_hash(hash), do: Repo.get_by(Url, hash: hash)

  @doc """
  Creates a url.

  ## Examples

      iex> create_url(%{field: value})
      {:ok, %Url{}}

      iex> create_url(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_url(attrs \\ %{}) do
    url = Map.get(attrs, "url", "")
    hash = Base.url_encode64(url, padding: false)

    Url.create_changeset(%{
      url: url,
      hash: hash,
      visits: 0
    })
    |> Repo.insert()
  end

  @doc """
  Updates a url.

  ## Examples

      iex> update_url(url, %{field: new_value})
      {:ok, %Url{}}

      iex> update_url(url, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_url(%Url{} = existing_url, attrs) do
    new_url = Map.get(attrs, "url", existing_url.url)
    hash = Base.url_encode64(new_url, padding: false)

    existing_url
    |> Url.changeset(%{
      url: new_url,
      hash: hash,
      visits: attrs.visits
    })
    |> Repo.update()
  end

  @doc """
  Deletes a url.

  ## Examples

      iex> delete_url(url)
      {:ok, %Url{}}

      iex> delete_url(url)
      {:error, %Ecto.Changeset{}}

  """
  def delete_url(%Url{} = url) do
    Repo.delete(url)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking url changes.

  ## Examples

      iex> change_url(url)
      %Ecto.Changeset{data: %Url{}}

  """
  def change_url(%Url{} = existing_url, attrs \\ %{}) do
    new_url = Map.get(attrs, "url", "")
    hash = Base.url_encode64(new_url, padding: false)

    existing_url
    |> Url.changeset(%{
      url: new_url,
      hash: hash,
      visits: existing_url.visits
    })
  end
end
