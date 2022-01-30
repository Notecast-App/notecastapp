defmodule NotecastappWeb.UserController do
  use NotecastappWeb, :controller

  alias Notecastapp.Accounts
  alias Notecastapp.Accounts.User
  alias Notecastapp.Tutorial

  plug :authenticate_user when action in [:index, :show]

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_registration(%User{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    render(conn, "show.html", user: user)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        conn
        |> Tutorial.create_tutorial(user)
        |> NotecastappWeb.Auth.login(user)
        |> put_flash(:info, "#{user.email} created!")
        |> redirect(to: Routes.folder_path(conn, :index))


      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
