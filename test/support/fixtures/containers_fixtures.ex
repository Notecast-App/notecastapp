defmodule Notecastapp.ContainersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Notecastapp.Containers` context.
  """

  @doc """
  Generate a folder.
  """
  def folder_fixture(attrs \\ %{}) do
    {:ok, folder} =
      attrs
      |> Enum.into(%{

      })
      |> Notecastapp.Containers.create_folder()

    folder
  end

  @doc """
  Generate a document.
  """
  def document_fixture(attrs \\ %{}) do
    {:ok, document} =
      attrs
      |> Enum.into(%{

      })
      |> Notecastapp.Containers.create_document()

    document
  end
end
