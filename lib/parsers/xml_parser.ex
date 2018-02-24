defmodule Exfeed.Parser.XML do
  def element(source, name) do
    node_value(source, name)
  end
  def element(source, name, parser: parser) do
    source
    |> node_value(name)
    |> parser.parse()
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
