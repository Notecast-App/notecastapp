defmodule NotecastappWeb.DocumentController do
  use NotecastappWeb, :controller

  alias Notecastapp.Container
  alias Notecastapp.Container.Document
  alias Notecastapp.SpeechService
  alias Notecastapp.Parse

  def index(conn, _params) do
    documents = Container.list_documents()
    render(conn, "index.html", documents: documents)
  end

  def new(conn, %{"folder_id" => folder_id}) do
    changeset = Container.change_document(%Document{})
    folder = Container.get_folder!(folder_id)
    documents = Container.list_folder_documents(folder)
    render(conn, "new.html", changeset: changeset, folder: folder, documents: documents)
  end

  def create(conn, %{"document" => document_params, "folder_id" => folder_id}) do
    folder = Container.get_folder!(folder_id)

    case Container.create_document(folder_id, document_params) do
      {:ok, document} ->
        document
        |> Parse.parse(folder)
        |> SpeechService.synthesise(document)

        conn
        # |> put_flash(:info, "document created successfully.")
        |> redirect(to: Routes.folder_document_path(conn, :show, folder, document.id))

      # document
      # |> SpeechService.synthesise()

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, folder: folder)
    end
  end

  def show(conn, %{"id" => id, "folder_id" => folder_id}) do
    IO.puts "am i here"
    document = Container.get_document!(id)
    folder = Container.get_folder!(folder_id)
    documents = Container.list_folder_documents(folder)
    render(conn, "show.html", document: document, folder: folder, documents: documents)
  end

  def edit(conn, %{"id" => id, "folder_id" => folder_id}) do
    document = Container.get_document!(id)
    changeset = Container.change_document(document)
    folder = Container.get_folder!(folder_id)
    documents = Container.list_folder_documents(folder)
    render(conn, "edit.html", document: document, changeset: changeset, folder: folder, documents: documents)
  end

  def update(conn, %{"id" => id, "document" => document_params, "folder_id" => folder}) do
    document = Container.get_document!(id)
    folder = Container.get_folder!(folder)

    case Container.update_document(document, document_params) do
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
    document = Container.get_document!(id)
    folder = Container.get_folder!(folder_id)


    # render(conn, "show.html", document: document, folder: folder, documents: documents)
    {:ok, _document} = Container.delete_document(document)

    documents = Container.list_folder_documents(folder)

    if length(documents) > 0 do
      conn
        # folder_document_path(conn_or_endpoint, :show, folder_id, id, params \\ [])
      |> redirect(to: Routes.folder_document_path(conn, :show, folder_id, List.first(documents).id, documents))
    end

    conn
    |> put_flash(:info, "document deleted successfully.")
    # |> redirect(to: Routes.folder_document_path(conn, :index, folder_id))
  end
end
