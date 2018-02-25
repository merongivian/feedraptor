defmodule Exfeed.Parser.XML do
  def element({source, map}, name, as: key) do
    value = node_value(source, name)
    {source, Map.merge(map, %{key => value})}
  end
  def element({source, map}, name) do
    key   = String.to_atom(name)
    value = node_value(source, name)
    {source, Map.merge(map, %{key => value})}
  end

  def element(source, name, as: key) do
    value = node_value(source, name)
    {source, %{key => value}}
  end
  def element(source, name) do
    key   = String.to_atom(name)
    value = node_value(source, name)
    {source, %{key => value}}
  end

  #--------------------------

  def element({source, map}, name, as: key, strukt: strukt) do
    value = source
            |> node_value(name)
            |> strukt.create()
    {source, Map.merge(map, %{key => value})}
  end
  def element({source, map}, name, strukt: strukt) do
    key   = String.to_atom(name)
    value = source
            |> node_value(name)
            |> strukt.create()
    {source, Map.merge(map, %{key => value})}
  end

  def element(source, name, as: key, strukt: strukt) do
    value = source
            |> node_value(name)
            |> strukt.create()
    {source, %{key => value}}
  end
  def element(source, name, strukt: strukt) do
    key   = String.to_atom(name)
    value = source
            |> node_value(name)
            |> strukt.create()
    {source, %{key => value}}
  end

  #----------------------

  def elements({source, map}, name, as: key, strukt: strukt) do
    value = source
            |> Floki.find(name)
            |> Enum.map(&strukt.create/1)
    {source, Map.merge(map, %{key => value})}
  end
  def elements(source, name, as: key, strukt: strukt) do
    value = source
            |> Floki.find(name)
            |> Enum.map(&strukt.create/1)
    {source, %{key => value}}
  end

  def parse({_source, map}) do
    map
  end

  defp node_value(source, name) do
    if name =~ ":" do
      source
      |> node_value()
      |> Enum.find(&(elem(&1, 0) == name))
      |> node_value()
    else
      source
      |> Floki.find(name)
      |> List.first
      |> node_value()
    end
  end
  defp node_value([{_, _, [value]}]) when is_binary(value), do: value
  defp node_value({_, _, [value]}) when is_binary(value), do: value
  defp node_value({_, _, value}), do: value
  defp node_value([]), do: ""
  defp node_value(value), do: value
end
