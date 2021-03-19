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

  describe "announcements" do
    alias Beepbopskeet.Admin.Announcement

    @valid_attrs %{body: "some body"}
    @update_attrs %{body: "some updated body"}
    @invalid_attrs %{body: nil}

    def announcement_fixture(attrs \\ %{}) do
      {:ok, announcement} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_announcement()

      announcement
    end

    test "list_announcements/0 returns all announcements" do
      announcement = announcement_fixture()
      assert Admin.list_announcements() == [announcement]
    end

    test "get_announcement!/1 returns the announcement with given id" do
      announcement = announcement_fixture()
      assert Admin.get_announcement!(announcement.id) == announcement
    end

    test "create_announcement/1 with valid data creates a announcement" do
      assert {:ok, %Announcement{} = announcement} = Admin.create_announcement(@valid_attrs)
      assert announcement.body == "some body"
    end

    test "create_announcement/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_announcement(@invalid_attrs)
    end

    test "update_announcement/2 with valid data updates the announcement" do
      announcement = announcement_fixture()
      assert {:ok, %Announcement{} = announcement} = Admin.update_announcement(announcement, @update_attrs)
      assert announcement.body == "some updated body"
    end

    test "update_announcement/2 with invalid data returns error changeset" do
      announcement = announcement_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_announcement(announcement, @invalid_attrs)
      assert announcement == Admin.get_announcement!(announcement.id)
    end

    test "delete_announcement/1 deletes the announcement" do
      announcement = announcement_fixture()
      assert {:ok, %Announcement{}} = Admin.delete_announcement(announcement)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_announcement!(announcement.id) end
    end

    test "change_announcement/1 returns a announcement changeset" do
      announcement = announcement_fixture()
      assert %Ecto.Changeset{} = Admin.change_announcement(announcement)
    end
  end
end
