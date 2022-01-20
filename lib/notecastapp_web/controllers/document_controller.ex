defmodule NotecastappWeb.DocumentController do
  use NotecastappWeb, :controller

  alias Notecastapp.Containers
  alias Notecastapp.Containers.Document
  alias Notecastapp.SpeechService
  alias Notecastapp.Parse

  def index(conn, _params) do
    documents = Containers.list_documents()
    render(conn, "index.html", documents: documents)
  end

  def new(conn, %{"folder_id" => folder_id}) do
    changeset = Containers.change_document(%Document{})
    folder = Containers.get_folder!(folder_id)
    documents = Containers.list_folder_documents(folder)
    render(conn, "new.html", changeset: changeset, folder: folder, documents: documents)
  end

  def create(conn, %{"document" => document_params, "folder_id" => folder_id}) do
    folder = Containers.get_folder!(folder_id)

    case Containers.create_document(folder_id, document_params) do
      {:ok, document} ->
        document
        |> Parse.parse(folder)
        |> SpeechService.synthesise(document)

        conn
        # |> put_flash(:info, "Document created successfully.")
        |> redirect(to: Routes.folder_document_path(conn, :show, folder, document.id))

      # document
      # |> SpeechService.synthesise()

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, folder: folder)
    end
  end

  def show(conn, %{"id" => id, "folder_id" => folder_id}) do
    IO.puts("am i here")
    document = Containers.get_document!(id)
    folder = Containers.get_folder!(folder_id)
    documents = Containers.list_folder_documents(folder)
    render(conn, "show.html", document: document, folder: folder, documents: documents)
  end

  def edit(conn, %{"id" => id, "folder_id" => folder_id}) do
    document = Containers.get_document!(id)
    changeset = Containers.change_document(document)
    folder = Containers.get_folder!(folder_id)
    documents = Containers.list_folder_documents(folder)

    render(conn, "edit.html",
      document: document,
      changeset: changeset,
      folder: folder,
      documents: documents
    )
  end

  def update(conn, %{"id" => id, "document" => document_params, "folder_id" => folder}) do
    document = Containers.get_document!(id)
    folder = Containers.get_folder!(folder)

    case Containers.update_document(document, document_params) do
      {:ok, document} ->
        document
        |> Parse.parse(folder)
        |> SpeechService.synthesise(document)

        conn
        |> redirect(to: Routes.folder_document_path(conn, :show, folder, document.id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", document: document, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "folder_id" => folder_id}) do
    document = Containers.get_document!(id)
    folder = Containers.get_folder!(folder_id)

    # render(conn, "show.html", document: document, folder: folder, documents: documents)
    {:ok, _document} = Containers.delete_document(document)

    documents = Containers.list_folder_documents(folder)

    if length(documents) > 0 do
      conn
      # folder_document_path(conn_or_endpoint, :show, folder_id, id, params \\ [])
      |> redirect(
        to:
          Routes.folder_document_path(conn, :show, folder_id, List.first(documents).id, documents)
      )
    end

    conn
    |> put_flash(:info, "Document deleted successfully.")

    # |> redirect(to: Routes.folder_document_path(conn, :index, folder_id))
  end
end
