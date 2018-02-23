defmodule Exfeed.Parser.RSS.Entry do
  import Exfeed.Parser.XML

  defstruct [
    :title,
    :url,
    :author,
    :content,
    :summary,
    :image,
    :published,
    :updated,
    :categories,
    :entry_id,
    :dc_identifier
  ]

  def parse(parsed_entry) do
    %Exfeed.Parser.RSS.Entry{
      title: node_value(parsed_entry, "title"),
      url: node_value(parsed_entry, "link"),
      author: node_value(parsed_entry, "dc:creator"),
      content: node_value(parsed_entry, "content:encoded"),
      summary: node_value(parsed_entry, "description"),
      entry_id: node_value(parsed_entry, "guid")
    }
  end
end
