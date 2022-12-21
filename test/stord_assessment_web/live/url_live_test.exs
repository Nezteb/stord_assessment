defmodule StordAssessmentWeb.UrlLiveTest do
  use StordAssessmentWeb.ConnCase

  import Phoenix.LiveViewTest
  import StordAssessment.UrlShortenerFixtures

  @create_attrs %{url: "http://example.com"}
  @update_attrs %{url: "http://example.com/test"}
  @invalid_attrs %{url: "asdf"}

  defp create_url(_) do
    url = url_fixture()
    %{url: url}
  end

  describe "Index" do
    setup [:create_url]

    test "lists all urls", %{conn: conn, url: url} do
      {:ok, _index_live, html} = live(conn, Routes.url_index_path(conn, :index))

      assert html =~ "Listing Urls"
      assert html =~ url.hash
    end

    test "saves new url", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.url_index_path(conn, :index))

      assert index_live |> element("a", "New Url") |> render_click() =~
               "New Url"

      assert_patch(index_live, Routes.url_index_path(conn, :new))

      assert index_live
             |> form("#url-form", url: @invalid_attrs)
             |> render_change() =~ "invalid url scheme"

      {:ok, _, html} =
        index_live
        |> form("#url-form", url: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.url_index_path(conn, :index))

      assert html =~ "Url created successfully"
      assert html =~ "aHR0cDovL2V4YW1wbGUuY29t"
    end

    test "updates url in listing", %{conn: conn, url: url} do
      {:ok, index_live, _html} = live(conn, Routes.url_index_path(conn, :index))

      assert index_live |> element("#url-#{url.id} a", "Edit") |> render_click() =~
               "Edit Url"

      assert_patch(index_live, Routes.url_index_path(conn, :edit, url))

      assert index_live
             |> form("#url-form", url: @invalid_attrs)
             |> render_change() =~ "invalid url scheme"

      {:ok, _, html} =
        index_live
        |> form("#url-form", url: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.url_index_path(conn, :index))

      assert html =~ "Url updated successfully"
      assert html =~ "aHR0cDovL2V4YW1wbGUuY29tL3Rlc3Q"
    end

    test "deletes url in listing", %{conn: conn, url: url} do
      {:ok, index_live, _html} = live(conn, Routes.url_index_path(conn, :index))

      assert index_live |> element("#url-#{url.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#url-#{url.id}")
    end
  end

  describe "Show" do
    setup [:create_url]

    test "displays url", %{conn: conn, url: url} do
      {:ok, _show_live, html} = live(conn, Routes.url_show_path(conn, :show, url))

      assert html =~ "Show Url"
      assert html =~ url.hash
    end

    test "updates url within modal", %{conn: conn, url: url} do
      {:ok, show_live, _html} = live(conn, Routes.url_show_path(conn, :show, url))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Url"

      assert_patch(show_live, Routes.url_show_path(conn, :edit, url))

      assert show_live
             |> form("#url-form", url: @invalid_attrs)
             |> render_change() =~ "invalid url scheme"

      {:ok, _, html} =
        show_live
        |> form("#url-form", url: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.url_show_path(conn, :show, url))

      assert html =~ "Url updated successfully"
      assert html =~ "aHR0cDovL2V4YW1wbGUuY29tL3Rlc3Q"
    end
  end
end
