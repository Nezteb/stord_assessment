defmodule StordAssessmentWeb.UrlLive.Index do
  use StordAssessmentWeb, :live_view

  alias StordAssessment.UrlShortener
  alias StordAssessment.UrlShortener.Url

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :urls, list_urls())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Url")
    |> assign(:url, UrlShortener.get_url!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Url")
    |> assign(:url, %Url{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Urls")
    |> assign(:url, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    url = UrlShortener.get_url!(id)
    {:ok, _} = UrlShortener.delete_url(url)

    {:noreply, assign(socket, :urls, list_urls())}
  end

  defp list_urls do
    UrlShortener.list_urls()
  end
end
