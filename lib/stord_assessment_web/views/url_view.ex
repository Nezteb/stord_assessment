defmodule StordAssessmentWeb.UrlView do
  use StordAssessmentWeb, :view
  alias StordAssessmentWeb.UrlView

  def render("index.json", %{urls: urls}) do
    %{data: render_many(urls, UrlView, "url.json")}
  end

  def render("show.json", %{url: url}) do
    %{data: render_one(url, UrlView, "url.json")}
  end

  def render("url.json", %{url: url}) do
    %{
      id: url.id,
      url: url.url,
      hash: url.hash,
      visits: url.visits
    }
  end
end
