defmodule Exfeed.Parser.XML do
  def node_value(node, subnode_name) do
    if subnode_name =~ ":" do
      node
      |> node_value()
      |> Enum.find(&(elem(&1, 0) == subnode_name))
      |> node_value()
    else
      node
      |> Floki.find(subnode_name)
      |> node_value()
    end
  end
  def node_value([{_, _, [value]}]) when is_binary(value), do: value
  def node_value({_, _, [value]}) when is_binary(value), do: value
  def node_value({_, _, value}), do: value
  def node_value([]), do: ""
  def node_value(value), do: value
end
