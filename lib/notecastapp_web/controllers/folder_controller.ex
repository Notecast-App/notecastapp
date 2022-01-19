defmodule NotecastappWeb.folderController do
  use NotecastappWeb, :controller

  alias Notecastapp.Container
  alias Notecastapp.Container.Folder

  def index(conn, _params, current_user) do
    folders = Container.list_user_folders(current_user)
    render(conn, "index.html", folders: folders)
  end

  def new(conn, _params, _current_user) do
    changeset = Container.change_folder(%Folder{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"folder" => folder_params}, current_user) do
    case Container.create_folder(current_user, folder_params) do
      {:ok, folder} ->
        conn
        |> put_flash(:info, "folder created successfully.")
        |> redirect(to: Routes.folder_path(conn, :show, folder))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_user) do
    folder = Container.get_user_folder!(current_user, id)
    episodes = Container.list_folder_episodes(folder)

    if length(episodes) > 0 do
      conn
      |> redirect(to: Routes.folder_episode_path(conn, :show, id, List.first(episodes).id, episodes))
    else
      conn
      |> redirect(to: Routes.folder_episode_path(conn, :new, id))
    end


    # render(conn, "show.html", folder: folder, episodes: episodes)
  end

  def edit(conn, %{"id" => id}, current_user) do
    folder = Container.get_user_folder!(current_user, id)
    changeset = Container.change_folder(folder)
    render(conn, "edit.html", folder: folder, changeset: changeset)
  end

  def update(conn, %{"id" => id, "folder" => folder_params}, current_user) do
    folder = Container.get_user_folder!(current_user, id)

    case Container.update_folder(folder, folder_params) do
      {:ok, folder} ->
        conn
        |> put_flash(:info, "folder updated successfully.")
        |> redirect(to: Routes.folder_path(conn, :show, folder))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", folder: folder, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_user) do
    folder = Container.get_user_folder!(current_user, id)
    {:ok, _folder} = Container.delete_folder(folder)

    conn
    |> put_flash(:info, "folder deleted successfully.")
    |> redirect(to: Routes.folder_path(conn, :index))
  end

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end
end
