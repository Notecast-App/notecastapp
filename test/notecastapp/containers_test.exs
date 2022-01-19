defmodule Notecastapp.ContainersTest do
  use Notecastapp.DataCase

  alias Notecastapp.Containers

  describe "folders" do
    alias Notecastapp.Containers.Folder

    import Notecastapp.ContainersFixtures

    @invalid_attrs %{}

    test "list_folders/0 returns all folders" do
      folder = folder_fixture()
      assert Containers.list_folders() == [folder]
    end

    test "get_folder!/1 returns the folder with given id" do
      folder = folder_fixture()
      assert Containers.get_folder!(folder.id) == folder
    end

    test "create_folder/1 with valid data creates a folder" do
      valid_attrs = %{}

      assert {:ok, %Folder{} = folder} = Containers.create_folder(valid_attrs)
    end

    test "create_folder/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Containers.create_folder(@invalid_attrs)
    end

    test "update_folder/2 with valid data updates the folder" do
      folder = folder_fixture()
      update_attrs = %{}

      assert {:ok, %Folder{} = folder} = Containers.update_folder(folder, update_attrs)
    end

    test "update_folder/2 with invalid data returns error changeset" do
      folder = folder_fixture()
      assert {:error, %Ecto.Changeset{}} = Containers.update_folder(folder, @invalid_attrs)
      assert folder == Containers.get_folder!(folder.id)
    end

    test "delete_folder/1 deletes the folder" do
      folder = folder_fixture()
      assert {:ok, %Folder{}} = Containers.delete_folder(folder)
      assert_raise Ecto.NoResultsError, fn -> Containers.get_folder!(folder.id) end
    end

    test "change_folder/1 returns a folder changeset" do
      folder = folder_fixture()
      assert %Ecto.Changeset{} = Containers.change_folder(folder)
    end
  end

  describe "documents" do
    alias Notecastapp.Containers.Document

    import Notecastapp.ContainersFixtures

    @invalid_attrs %{}

    test "list_documents/0 returns all documents" do
      document = document_fixture()
      assert Containers.list_documents() == [document]
    end

    test "get_document!/1 returns the document with given id" do
      document = document_fixture()
      assert Containers.get_document!(document.id) == document
    end

    test "create_document/1 with valid data creates a document" do
      valid_attrs = %{}

      assert {:ok, %Document{} = document} = Containers.create_document(valid_attrs)
    end

    test "create_document/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Containers.create_document(@invalid_attrs)
    end

    test "update_document/2 with valid data updates the document" do
      document = document_fixture()
      update_attrs = %{}

      assert {:ok, %Document{} = document} = Containers.update_document(document, update_attrs)
    end

    test "update_document/2 with invalid data returns error changeset" do
      document = document_fixture()
      assert {:error, %Ecto.Changeset{}} = Containers.update_document(document, @invalid_attrs)
      assert document == Containers.get_document!(document.id)
    end

    test "delete_document/1 deletes the document" do
      document = document_fixture()
      assert {:ok, %Document{}} = Containers.delete_document(document)
      assert_raise Ecto.NoResultsError, fn -> Containers.get_document!(document.id) end
    end

    test "change_document/1 returns a document changeset" do
      document = document_fixture()
      assert %Ecto.Changeset{} = Containers.change_document(document)
    end
  end
end
