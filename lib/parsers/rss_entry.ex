defmodule Exfeed.Parser.RSS.Entry do
  import Exfeed.Parser.XML

  def create(entry) do
    entry
    |> element("title")
    |> element("link", as: :url)
    |> element("dc:creator", as: :author)
    |> element("content:encoded", as: :content)
    |> element("description", as: :summary)
    |> element("guid", as: :entry_id)
    |> parse()
  end
end
