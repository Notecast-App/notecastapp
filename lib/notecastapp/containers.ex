defmodule Notecastapp.Containers do
  @moduledoc """
  The Containers context.
  101568189041
  """

  import Ecto.Query, warn: false
  alias Notecastapp.Repo

  alias Notecastapp.Containers.Folder
  alias Notecastapp.Accounts

  @doc """
  Returns the list of folders.

  ## Examples

      iex> list_folders()
      [%Folder{}, ...]

  """
  def list_folders do
    Repo.all(Folder)
  end

  @doc """
  Gets a single folder.

  Raises `Ecto.NoResultsError` if the Folder does not exist.

  ## Examples

      iex> get_folder!(123)
      %Folder{}

      iex> get_folder!(456)
      ** (Ecto.NoResultsError)

  """
  def get_folder!(id), do: Repo.get!(Folder, id)

  @doc """
  Creates a folder.

  ## Examples

      iex> create_folder(%{field: value})
      {:ok, %Folder{}}

      iex> create_folder(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_folder(%Accounts.User{} = user, attrs \\ %{}) do
    %Folder{}
    |> Folder.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  @doc """
  Updates a folder.

  ## Examples

      iex> update_folder(folder, %{field: new_value})
      {:ok, %Folder{}}

      iex> update_folder(folder, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_folder(%Folder{} = folder, attrs) do
    folder
    |> Folder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a folder.

  ## Examples

      iex> delete_folder(folder)
      {:ok, %Folder{}}

      iex> delete_folder(folder)
      {:error, %Ecto.Changeset{}}

  """
  def delete_folder(%Folder{} = folder) do
    Repo.delete(folder)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking folder changes.

  ## Examples

      iex> change_folder(folder)
      %Ecto.Changeset{data: %Folder{}}

  """
  def change_folder(%Folder{} = folder, attrs \\ %{}) do
    Folder.changeset(folder, attrs)
  end

  def list_user_folders(%Accounts.User{} = user) do
    Folder
    |> user_folders_query(user)
    |> Repo.all()
  end

  def get_user_folder!(%Accounts.User{} = user, id) do
    Folder
    |> user_folders_query(user)
    |> Repo.get!(id)
  end

  defp user_folders_query(query, %Accounts.User{id: user_id}) do
    from(v in query, where: v.user_id == ^user_id)
  end

  alias Notecastapp.Containers.Document

  def list_folder_documents(%Folder{} = folder) do
    Document
    |> folder_documents_query(folder)
    |> Repo.all()
  end

  defp folder_documents_query(query, %Folder{id: folder_id}) do
    from(v in query, where: v.folder_id == ^folder_id)
  end

  @doc """
  Returns the list of documents.

  ## Examples

      iex> list_documents()
      [%Document{}, ...]

  """
  def list_documents do
    Repo.all(Document)
  end

  @doc """
  Gets a single document.

  Raises `Ecto.NoResultsError` if the Document does not exist.

  ## Examples

      iex> get_document!(123)
      %Document{}

      iex> get_document!(456)
      ** (Ecto.NoResultsError)

  """
  def get_document!(id), do: Repo.get!(Document, id)

  @doc """
  Creates a document.

  ## Examples

      iex> create_document(%{field: value})
      {:ok, %Document{}}

      iex> create_document(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_document(folder_id, attrs \\ %{}) do
    folder = get_folder!(folder_id)

    %Document{}
    |> Document.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:folder, folder)
    |> Repo.insert()
  end

  @doc """
  Updates a document.

  ## Examples

      iex> update_document(document, %{field: new_value})
      {:ok, %Document{}}

      iex> update_document(document, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_document(%Document{} = document, attrs) do
    document
    |> Document.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a document.

  ## Examples

      iex> delete_document(document)
      {:ok, %Document{}}

      iex> delete_document(document)
      {:error, %Ecto.Changeset{}}

  """
  def delete_document(%Document{} = document) do
    Repo.delete(document)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking document changes.

  ## Examples

      iex> change_document(document)
      %Ecto.Changeset{data: %Document{}}

  """
  def change_document(%Document{} = document, attrs \\ %{}) do
    Document.changeset(document, attrs)
  end

  alias Notecastapp.API.Token

  @doc """
  Returns the list of tokens.

  ## Examples

      iex> list_tokens()
      [%Token{}, ...]

  """
  def list_tokens do
    Repo.all(Token)
  end

  @doc """
  Gets a single token.

  Raises `Ecto.NoResultsError` if the Token does not exist.

  ## Examples

      iex> get_token!(123)
      %Token{}

      iex> get_token!(456)
      ** (Ecto.NoResultsError)

  """
  def get_token!(id), do: Repo.get!(Token, id)

  @doc """
  Creates a token.

  ## Examples

      iex> create_token(%{field: value})
      {:ok, %Token{}}

      iex> create_token(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_token(attrs \\ %{}) do
    %Token{}
    |> Token.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a token.

  ## Examples

      iex> update_token(token, %{field: new_value})
      {:ok, %Token{}}

      iex> update_token(token, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_token(%Token{} = token, attrs) do
    token
    |> Token.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a token.

  ## Examples

      iex> delete_token(token)
      {:ok, %Token{}}

      iex> delete_token(token)
      {:error, %Ecto.Changeset{}}

  """
  def delete_token(%Token{} = token) do
    Repo.delete(token)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking token changes.

  ## Examples

      iex> change_token(token)
      %Ecto.Changeset{data: %Token{}}

  """
  def change_token(%Token{} = token, attrs \\ %{}) do
    Token.changeset(token, attrs)
  end

  def get_active_token() do
    List.first(Repo.all(Token))
  end
end
