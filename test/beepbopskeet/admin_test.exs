defmodule Beepbopskeet.AdminTest do
  use Beepbopskeet.DataCase

  alias Beepbopskeet.Admin

  describe "cards" do
    alias Beepbopskeet.Admin.Card

    @valid_attrs %{link: "some link", title: "some title"}
    @update_attrs %{link: "some updated link", title: "some updated title"}
    @invalid_attrs %{link: nil, title: nil}

    def card_fixture(attrs \\ %{}) do
      {:ok, card} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_card()

      card
    end

    test "list_cards/0 returns all cards" do
      card = card_fixture()
      assert Admin.list_cards() == [card]
    end

    test "get_card!/1 returns the card with given id" do
      card = card_fixture()
      assert Admin.get_card!(card.id) == card
    end

    test "create_card/1 with valid data creates a card" do
      assert {:ok, %Card{} = card} = Admin.create_card(@valid_attrs)
      assert card.link == "some link"
      assert card.title == "some title"
    end

    test "create_card/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_card(@invalid_attrs)
    end

    test "update_card/2 with valid data updates the card" do
      card = card_fixture()
      assert {:ok, %Card{} = card} = Admin.update_card(card, @update_attrs)
      assert card.link == "some updated link"
      assert card.title == "some updated title"
    end

    test "update_card/2 with invalid data returns error changeset" do
      card = card_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_card(card, @invalid_attrs)
      assert card == Admin.get_card!(card.id)
    end

    test "delete_card/1 deletes the card" do
      card = card_fixture()
      assert {:ok, %Card{}} = Admin.delete_card(card)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_card!(card.id) end
    end

    test "change_card/1 returns a card changeset" do
      card = card_fixture()
      assert %Ecto.Changeset{} = Admin.change_card(card)
    end
  end
end
