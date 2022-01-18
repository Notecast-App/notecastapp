defmodule NotecastappWeb.UserView do
  use NotecastappWeb, :view

  alias Notecastapp.Accounts

  def email(%Accounts.User{email: email}) do
    email
    |> String.split(" ")
    |> Enum.at(0)
  end
end
