defmodule Notecastapp.APITest do
  use Notecastapp.DataCase

  alias Notecastapp.API

  describe "tokens" do
    alias Notecastapp.API.Token

    import Notecastapp.APIFixtures

    @invalid_attrs %{value: nil}

    test "list_tokens/0 returns all tokens" do
      token = token_fixture()
      assert API.list_tokens() == [token]
    end

    test "get_token!/1 returns the token with given id" do
      token = token_fixture()
      assert API.get_token!(token.id) == token
    end

    test "create_token/1 with valid data creates a token" do
      valid_attrs = %{value: "some value"}

      assert {:ok, %Token{} = token} = API.create_token(valid_attrs)
      assert token.value == "some value"
    end

    test "create_token/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = API.create_token(@invalid_attrs)
    end

    test "update_token/2 with valid data updates the token" do
      token = token_fixture()
      update_attrs = %{value: "some updated value"}

      assert {:ok, %Token{} = token} = API.update_token(token, update_attrs)
      assert token.value == "some updated value"
    end

    test "update_token/2 with invalid data returns error changeset" do
      token = token_fixture()
      assert {:error, %Ecto.Changeset{}} = API.update_token(token, @invalid_attrs)
      assert token == API.get_token!(token.id)
    end

    test "delete_token/1 deletes the token" do
      token = token_fixture()
      assert {:ok, %Token{}} = API.delete_token(token)
      assert_raise Ecto.NoResultsError, fn -> API.get_token!(token.id) end
    end

    test "change_token/1 returns a token changeset" do
      token = token_fixture()
      assert %Ecto.Changeset{} = API.change_token(token)
    end
  end
end
