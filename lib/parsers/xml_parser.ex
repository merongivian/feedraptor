defmodule Exfeed.Parser.XML do
  def element({source, map}, name, as: key) do
    {source, Map.merge(map, %{key => node_value(source, name)})}
  end
  def element({source, map}, name) do
    {source, Map.merge(map, %{name => node_value(source, name)})}
  end

  def element(source, name, as: key) do
    {source, %{key => node_value(source, name)}}
  end
  def element(source, name) do
    {source, %{name => node_value(source, name)}}
  end

  #--------------------------

  def element({source, map}, name, as: key, module: module) do
    {source, Map.merge(map, %{key => node_value(source, name, module)})}
  end
  def element({source, map}, name, module: module) do
    {source, Map.merge(map, %{name => node_value(source, name, module)})}
  end

  def element(source, name, as: key, module: module) do
    {source, %{key => node_value(source, name, module)}}
  end
  def element(source, name, module: module) do
    {source, %{name => node_value(source, name, module)}}
  end

  #----------------------

  def elements({source, map}, name, as: key, module: module) do
    {source, Map.merge(map, %{key => node_values(source, name, module)})}
  end
  def elements(source, name, as: key, module: module) do
    {source, %{key => node_values(source, name, module)}}
  end

  def parse({_source, map}) do
    map
  end

  defp node_values(source, name, module) do
    source
    |> Floki.find(Atom.to_string name)
    |> Enum.map(&module.create/1)
  end

  defp node_value(source, name) do
    name = if is_binary(name), do: name, else: Atom.to_string(name)

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
  def node_value(source, name, module) do
    source
    |> node_value(Atom.to_string name)
    |> module.create()
  end
  defp node_value([{_, _, [value]}]) when is_binary(value), do: value
  defp node_value({_, _, [value]}) when is_binary(value), do: value
  defp node_value({_, _, value}), do: value
  defp node_value([]), do: ""
  defp node_value(value), do: value
end
