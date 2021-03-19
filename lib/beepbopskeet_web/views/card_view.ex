defmodule BeepbopskeetWeb.CardView do
  use BeepbopskeetWeb, :view
  alias Beepbopskeet.Admin

  def filter_cards(cards, category) do
    Enum.filter(cards, fn x -> x.category == category end)
  end
end
