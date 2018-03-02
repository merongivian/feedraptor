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

      key = extracted_element
            |> Map.keys
            |> List.first

      case extracted_element do
        %{^key => nil} -> parsed_source
        %{^key => ""}  -> parsed_source
        %{^key => []}  -> parsed_source
        _              -> Map.merge(parsed_source, extracted_element)
      end
    end
  end

  def get_element(source, name, opts \\ []) do
    value = get_value(source, name, Keyword.drop(opts, [:as]))
    %{opts[:as] || name => value}
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
             |> Enum.map(&value_matcher/1)

    %{key => values}
  end

  defp get_value(source, name, opts) do
    name = if is_binary(name), do: name, else: Atom.to_string(name)

    try_exact_find = fn(source, name) ->
      if is_list(source) do
        Enum.find(source, &(elem(&1, 0) == name))
      else
        source
      end
    end

    value = source
            |> Floki.find(String.replace(name, ":", "|"))
            # NOTE: floki.find sometimes returns more than one value
            # for example when theres another node with the same name
            # but with a namespace
            |> try_exact_find.(name)
            |> value_matcher()

    if opts[:module], do: opts[:module].parse(value), else: value
  end
  defp value_matcher({_, _, [value]}) when is_binary(value), do: value
  defp value_matcher(value), do: value
end
