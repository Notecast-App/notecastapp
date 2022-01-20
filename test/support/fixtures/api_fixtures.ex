defmodule Notecastapp.APIFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Notecastapp.API` context.
  """

  @doc """
  Generate a token.
  """
  def token_fixture(attrs \\ %{}) do
    {:ok, token} =
      attrs
      |> Enum.into(%{
        value: "some value"
      })
      |> Notecastapp.API.create_token()

    token
  end
end
