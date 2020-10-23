defmodule BeepbopskeetWeb.EmailView do
  use BeepbopskeetWeb, :view

  def get_category(followers) do
    cond do
      followers > 20000 -> 5
      followers > 15000 && followers <= 20000 -> 4
      followers > 10000 && followers <= 15000 -> 3
      followers > 5000 && followers <= 10000 -> 2
      followers <= 5000 -> 1
    end
  end

  def get_price_two_weeks(category) do
    case category do
      1 -> "$10"
      2 -> "$20"
      3 -> "$30"
      4 -> "$45"
      5 -> "$50"
    end
  end

  def get_price_one_month(category) do
    case category do
      1 -> "$20"
      2 -> "$35"
      3 -> "$45"
      4 -> "$75"
      5 -> "$85"
    end
  end

  def price_reduce(category) do
    case category do
      1 -> "$1"
      2 -> "$5"
      3 -> "$10"
      4 -> "$15"
      5 -> "$15"
    end
  end
end
