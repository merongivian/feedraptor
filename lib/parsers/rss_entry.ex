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

  def parse(entry) do
    %Exfeed.Parser.RSS.Entry{
      title: element(entry, "title"),
      url: element(entry, "link"),
      author: element(entry, "dc:creator"),
      content: element(entry, "content:encoded"),
      summary: element(entry, "description"),
      entry_id: element(entry, "guid")
    }
  end
end
