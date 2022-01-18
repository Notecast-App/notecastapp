defmodule NotecastappWeb.PageController do
  use NotecastappWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
