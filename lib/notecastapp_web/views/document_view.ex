defmodule NotecastappWeb.DocumentView do
  use NotecastappWeb, :view

  def options(folder) do
    %{"lang1": "lang1", "lang2": "lang2"}
  end

  def language_one_hex() do
    "#D0E9F9"
  end

  def language_two_hex() do
    "#f9d7a7"
  end

end
