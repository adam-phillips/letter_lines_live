defmodule LetterLinesLiveWeb.PageLiveTest do
  use LetterLinesLiveWeb.ConnCase

  import Phoenix.LiveViewTest

  @tag :skip
  test "disconnected and connected render", %{conn: conn} do
    {:ok, page_live, disconnected_html} = live(conn, "/")
    assert disconnected_html =~ "Welcome to Phoenix!"
    assert render(page_live) =~ "Welcome to Phoenix!"
  end
end

#   1 2 3 4 5 6
# 1 M C N N M
# 2         X
# 3   N M M L C
# 4   X       M
# 5   C       X
# 6 X L M N C M
