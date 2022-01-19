defmodule NotecastappWeb.FolderController do
  use NotecastappWeb, :controller

  alias Notecastapp.Containers
  alias Notecastapp.Containers.Folder

  def index(conn, _params, current_user) do
    folders = Containers.list_user_folders(current_user)
    render(conn, "index.html", folders: folders)
  end

  def new(conn, _params, _current_user) do
    changeset = Containers.change_folder(%Folder{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"folder" => folder_params}, current_user) do
    case Containers.create_folder(current_user, folder_params) do
      {:ok, folder} ->
        conn
        |> put_flash(:info, "Folder created successfully.")
        |> redirect(to: Routes.folder_path(conn, :show, folder))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_user) do
    folder = Containers.get_user_folder!(current_user, id)
    documents = Containers.list_folder_documents(folder)

    if length(documents) > 0 do
      conn
      |> redirect(to: Routes.folder_document_path(conn, :show, id, List.first(documents).id, documents))
    else
      conn
      |> redirect(to: Routes.folder_document_path(conn, :new, id))
    end


    # render(conn, "show.html", folder: folder, documents: documents)
  end

  def edit(conn, %{"id" => id}, current_user) do
    folder = Containers.get_user_folder!(current_user, id)
    changeset = Containers.change_folder(folder)
    render(conn, "edit.html", folder: folder, changeset: changeset)
  end

  def update(conn, %{"id" => id, "folder" => folder_params}, current_user) do
    folder = Containers.get_user_folder!(current_user, id)

    case Containers.update_folder(folder, folder_params) do
      {:ok, folder} ->
        conn
        |> put_flash(:info, "Folder updated successfully.")
        |> redirect(to: Routes.folder_path(conn, :show, folder))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", folder: folder, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_user) do
    folder = Containers.get_user_folder!(current_user, id)
    {:ok, _folder} = Containers.delete_folder(folder)

    conn
    |> put_flash(:info, "Folder deleted successfully.")
    |> redirect(to: Routes.folder_path(conn, :index))
  end

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end
end
