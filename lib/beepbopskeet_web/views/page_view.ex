defmodule BeepbopskeetWeb.PageView do
  use BeepbopskeetWeb, :view

  def keys_to_atoms(string_key_map) when is_map(string_key_map) do

    for {key, val} <- string_key_map, into: %{}, do: {String.to_atom(key), keys_to_atoms(val)}
  end

  def keys_to_atoms(value), do: value


end


# for each map in the list I need to split the maps then take the images and create a new map from it then merge the map together
