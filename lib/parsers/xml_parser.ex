defmodule Exfeed.Parser.XML do
  @doc false
  defmacro __using__(_) do
    quote do
      import Exfeed.Parser.XML, only: [element: 2, element: 1, elements: 2, elements: 1]
      @before_compile Exfeed.Parser.XML

      Module.register_attribute(__MODULE__, :element_definitions, accumulate: true)
      Module.register_attribute(__MODULE__, :elements_definitions, accumulate: true)
    end
  end

  @doc false
  defmacro __before_compile__(_env) do
    quote do
      def parse(source) do
        parsed_element_definitions =
         Exfeed.Parser.XML.execute_definitions(
            source,
            @element_definitions,
            :get_element
          )

        parsed_elements_definitions =
          Exfeed.Parser.XML.execute_definitions(
            source,
            @elements_definitions,
            :get_elements
          )

        Map.merge(
          parsed_element_definitions,
          parsed_elements_definitions
        )
      end
    end
  end

  @doc false
  defmacro element(name, opts \\ []) do
    quote bind_quoted: [name: name, opts: opts] do
      Module.put_attribute(__MODULE__, :element_definitions, [name, opts])
    end
  end

  @doc false
  defmacro elements(name, opts \\ []) do
    quote bind_quoted: [name: name, opts: opts] do
      Module.put_attribute(__MODULE__, :elements_definitions, [name, opts])
    end
  end

  def execute_definitions(source, definitions, extractor) do
    Enum.reduce definitions, %{}, fn(extractor_attributes, parsed_source) ->
      extracted_element = apply(
        __MODULE__,
        extractor,
        [source | extractor_attributes]
      )

      [key | _] = extractor_attributes

      case extracted_element do
        %{^key => nil} -> parsed_source
        %{^key => ""}  -> parsed_source
        %{^key => []}  -> parsed_source
        _              -> Map.merge(parsed_source, extracted_element)
      end
    end
  end

  def get_element(source, name, as: key) do
    %{key => node_value(source, name)}
  end
  def get_element(source, name, []) do
    %{name => node_value(source, name)}
  end
  def get_element(source, name, as: key, module: module) do
    %{key => node_value(source, name, module)}
  end
  def get_element(source, name, module: module) do
    %{name => node_value(source, name, module)}
  end

  def get_elements(source, name, as: key, module: module) do
    values = source
             |> Floki.find(Atom.to_string name)
             |> Enum.map(&module.parse/1)

    %{key => values}
  end
  def get_elements(source, name, as: key) do
    values = source
             |> Floki.find(Atom.to_string name)
             |> Enum.map(&node_value/1)

    %{key => values}
  end

  def node_values(source, name, key) do
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
    |> module.parse()
  end
  defp node_value([{_, _, [value]}]) when is_binary(value), do: value
  defp node_value({_, _, [value]}) when is_binary(value), do: value
  defp node_value({_, _, value}), do: value
  defp node_value([]), do: ""
  defp node_value(value), do: value
end
