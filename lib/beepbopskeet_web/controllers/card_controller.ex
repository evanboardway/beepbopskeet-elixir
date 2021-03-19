defmodule BeepbopskeetWeb.CardController do
  use BeepbopskeetWeb, :controller

  alias Beepbopskeet.Admin
  alias Beepbopskeet.Admin.Card

  def index(conn, _params) do
    cards = Admin.list_cards()
    announcement = Admin.get_announcement!(1).body
    render(conn, "index.html", cards: cards, announcement: announcement)
  end

  def new(conn, _params) do
    changeset = Admin.change_card(%Card{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"card" => card_params}) do
    case Admin.create_card(card_params) do
      {:ok, card} ->
        conn
        |> put_flash(:info, "Card created successfully.")
        |> redirect(to: Routes.card_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    # Not used
    render(conn, "index.html")
  end

  def edit(conn, %{"id" => id}) do
    card = Admin.get_card!(id)
    changeset = Admin.change_card(card)
    render(conn, "edit.html", card: card, changeset: changeset)
  end

  def update(conn, %{"id" => id, "card" => card_params}) do
    card = Admin.get_card!(id)

    case Admin.update_card(card, card_params) do
      {:ok, card} ->
        conn
        |> put_flash(:info, "Card updated successfully.")
        |> redirect(to: Routes.card_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", card: card, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    card = Admin.get_card!(id)
    {:ok, _card} = Admin.delete_card(card)

    conn
    |> put_flash(:info, "Card deleted successfully.")
    |> redirect(to: Routes.card_path(conn, :index))
  end
end
