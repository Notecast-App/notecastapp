defmodule NotecastappWeb.DocumentView do
  use NotecastappWeb, :view
  use Temple

  alias NotecastappWeb.Components.Sidebar
  alias NotecastappWeb.Components.Editor
  alias NotecastappWeb.Components.DocumentForm

  def options(folder) do
    %{"#{List.first(String.split(folder.language_one, ","))}": "#caf0cb", "#{List.first(String.split(folder.language_two, ","))}": "#f9d7a7"}
  end

  def language_one_hex() do
    "#D0E9F9"
  end

  def language_two_hex() do
    "#f9d7a7"
  end

end
