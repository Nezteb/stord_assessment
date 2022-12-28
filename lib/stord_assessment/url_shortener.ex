defmodule StordAssessment.UrlShortener do
  @moduledoc """
  The UrlShortener context.
  """

  import Ecto.Query, warn: false
  alias StordAssessment.Repo
  alias StordAssessment.UrlShortener.Url
  alias NimbleCSV.RFC4180, as: CSV


  @doc """
  Returns the list of urls.

  ## Examples

      iex> list_urls()
      [%Url{}, ...]

  """
  def list_urls do
    Repo.all(Url)
  end

  def urls_to_csv do
    # Map.values returns values in alphabetical order based on their key,
    # so we sort the headers to match in the resulting list for the CSV
    fields = [:url, :visits, :hash, :inserted_at] |> Enum.sort()

    urls = list_urls()
    |> Enum.map(fn url ->
      url
      |> Map.from_struct()
      |> Map.take(fields)
      |> Map.values()
    end)

    [fields | urls]
    |> dbg()
    |> CSV.dump_to_iodata()
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
    url = get_atom_or_string_key(attrs, :url, "")
    hash = Base.url_encode64(url, padding: false)
    visits = get_atom_or_string_key(attrs, :visits, 0)

    Url.create_changeset(%{
      url: url,
      hash: hash,
      visits: visits
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
    new_url = get_atom_or_string_key(attrs, :url, existing_url.url)
    hash = Base.url_encode64(new_url, padding: false)
    new_visits = get_atom_or_string_key(attrs, :visits, existing_url.visits)

    existing_url
    |> Url.update_changeset(%{
      url: new_url,
      hash: hash,
      visits: new_visits
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
    new_url = get_atom_or_string_key(attrs, :url, "")
    hash = Base.url_encode64(new_url, padding: false)
    new_visits = get_atom_or_string_key(attrs, :visits, existing_url.visits)

    existing_url
    |> Url.update_changeset(%{
      url: new_url,
      hash: hash,
      visits: new_visits
    })
  end

  defp get_atom_or_string_key(map, key, default) when is_atom(key) do
    value = Map.get(map, key, nil)

    if value == nil do
      get_atom_or_string_key(map, Atom.to_string(key), default)
    else
      value
    end
  end

  defp get_atom_or_string_key(map, key, default) when is_binary(key) do
    value = Map.get(map, key, nil)

    if value == nil do
      default
    else
      value
    end
  end
end
