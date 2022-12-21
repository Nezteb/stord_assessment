defmodule StordAssessmentWeb.UrlController do
  use StordAssessmentWeb, :controller

  alias StordAssessment.UrlShortener
  alias StordAssessment.UrlShortener.Url

  action_fallback StordAssessmentWeb.FallbackController

  def index(conn, _params) do
    urls = UrlShortener.list_urls()
    render(conn, "index.json", urls: urls)
  end

  def create(conn, %{"url" => url_params}) do
    with {:ok, %Url{} = url} <- UrlShortener.create_url(url_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.url_path(conn, :show, url))
      |> render("show.json", url: url)
    end
  end

  def show(conn, %{"id" => id}) do
    url = UrlShortener.get_url!(id)
    render(conn, "show.json", url: url)
  end

  def update(conn, %{"id" => id, "url" => url_params}) do
    url = UrlShortener.get_url!(id)

    with {:ok, %Url{} = url} <- UrlShortener.update_url(url, url_params) do
      render(conn, "show.json", url: url)
    end
  end

  def delete(conn, %{"id" => id}) do
    url = UrlShortener.get_url!(id)

    with {:ok, %Url{}} <- UrlShortener.delete_url(url) do
      send_resp(conn, :no_content, "")
    end
  end
end
