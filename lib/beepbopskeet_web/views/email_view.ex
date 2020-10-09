defmodule BeepbopskeetWeb.EmailView do
  use BeepbopskeetWeb, :view

  def get_category(followers) do
    cond do
      followers > 20000 && followers <= 30000 -> 4
      followers > 10000 && followers <= 20000 -> 3
      followers > 5000 && followers <= 10000 -> 2
      followers <= 5000 -> 1
    end
  end

  def get_price_two_weeks(category) do
    case category do
      1 -> "$25"
      2 -> "$30"
      3 -> "$65"
      4 -> "$85"
    end
  end

  def get_price_one_month(category) do
    case category do
      1 -> "$35"
      2 -> "$50"
      3 -> "$100"
      4 -> "$120"
    end
  end

  def price_reduce(category) do
    case category do
      1 -> "$5"
      2 -> "$5"
      3 -> "$10"
      4 -> "$15"
    end
  end
end
