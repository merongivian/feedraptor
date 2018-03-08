defmodule Feedraptor do
  @parsers [
    Feedraptor.Parser.RSSFeedBurner,
    Feedraptor.Parser.GoogleDocsAtom,
    Feedraptor.Parser.AtomYoutube,
    Feedraptor.Parser.AtomFeedBurner,
    Feedraptor.Parser.Atom,
    Feedraptor.Parser.ItunesRSS,
    Feedraptor.Parser.RSS
  ]

  @doc """
  Parses an xml feed. If theres no parser available
  for this feed it will raise an error

  ## Avalilable Parsers:

  * RSS
  * RSS Feedburner
  * Atom
  * Atom FeedBurner
  * Atom Youtube
  * Google Docs Atom
  * Itunes RSS
  """
  def parse(xml) do
    parser = parser_for_xml(xml)

    if is_nil(parser) do
      raise "No valid parser for XML."
    end

    parser.parse(xml)
  end

  defp parser_for_xml(xml) do
    sliced_xml = String.slice(xml, 0, 2000)

    Enum.find @parsers, fn(possible_parser) ->
      possible_parser.will_parse?(sliced_xml)
    end
  end
end
