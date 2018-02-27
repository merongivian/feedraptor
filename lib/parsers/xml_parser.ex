defmodule Exfeed.Parser.XML do
  @callback create(String.t) :: any

  @doc false
  defmacro __using__(_) do
    quote do
      @behaviour Exfeed.Parser.XML
      import Exfeed.Parser.XML
      @before_compile Exfeed.Parser.XML

      Module.register_attribute(__MODULE__, :element_definitions, accumulate: true)
      Module.register_attribute(__MODULE__, :elements_definitions, accumulate: true)
    end
  end

  @doc false
  defmacro __before_compile__(_env) do
    quote do
      def new(source) do
        Enum.map @element_definitions, fn(element_attributes) ->
        end
      end
    end
  end

  @doc false
  defmacro element(args \\ [], opts \\ []) do
    quote bind_quoted: [args: args, opts: opts] do
      Module.put_attribute(__MODULE__, :element_definitions, [args, opts])
    end
  end

  @doc false
  defmacro elements(args \\ [], opts \\ []) do
    quote bind_quoted: [args: args, opts: opts] do
      Module.put_attribute(__MODULE__, :element_definitions, [args, opts])
    end
  end

  def do_element({source, map}, name, as: key) do
    {source, Map.merge(map, %{key => node_value(source, name)})}
  end
  def do_element({source, map}, name) do
    {source, Map.merge(map, %{name => node_value(source, name)})}
  end

  def do_element(source, name, as: key) do
    {source, %{key => node_value(source, name)}}
  end
  def do_element(source, name) do
    {source, %{name => node_value(source, name)}}
  end

  #--------------------------

  def do_element({source, map}, name, as: key, module: module) do
    {source, Map.merge(map, %{key => node_value(source, name, module)})}
  end
  def do_element({source, map}, name, module: module) do
    {source, Map.merge(map, %{name => node_value(source, name, module)})}
  end

  def do_element(source, name, as: key, module: module) do
    {source, %{key => node_value(source, name, module)}}
  end
  def do_element(source, name, module: module) do
    {source, %{name => node_value(source, name, module)}}
  end

  #----------------------

  def do_elements({source, map}, name, as: key, module: module) do
    {source, Map.merge(map, %{key => node_values(source, name, module)})}
  end
  def do_elements(source, name, as: key, module: module) do
    {source, %{key => node_values(source, name, module)}}
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
