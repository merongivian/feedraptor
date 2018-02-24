defmodule Exfeed.Parser.XML do
  def element(node, subnode_name) do
    if subnode_name =~ ":" do
      node
      |> node_value()
      |> Enum.find(&(elem(&1, 0) == subnode_name))
      |> node_value()
    else
      node
      |> Floki.find(subnode_name)
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
