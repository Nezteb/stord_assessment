defmodule StordAssessmentWeb.PageController do
  use StordAssessmentWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
