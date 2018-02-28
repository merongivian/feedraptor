defmodule Exfeed.Parser.RSSFeedBurner do
  alias Exfeed.Parser.XML
  use XML

  element :title
  element :description
  element :link, as: :url
  element :lastbuilddate, as: :last_built
  elements :item, as: :entries, module: Exfeed.Parser.RSSFeedBurner.Entry

  defmodule Entry do
    use XML

    element :title

    element :"feedburner:origlink", as: :url
    element :link, as: :url

    element :"dc:creator", as: :author
    element :author, as: :author
    element :"content:encoded", as: :content
    element :description, as: :summary

    element :pubdate, as: :published
    element :"dc:date", as: :published
    element :"dcterms:created", as: :published

    element :"dcterms:modified", as: :updated
    element :issued, as: :published
    elements :category, as: :categories

    element :guid, as: :entry_id
  end
end
