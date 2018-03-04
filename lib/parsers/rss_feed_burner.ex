defmodule Feedraptor.Parser.RSSFeedBurner do
  alias Feedraptor.Parser.XML
  use XML

  element :title
  element :description
  element :link, as: :url
  element :lastbuilddate, as: :last_built
  elements :item, as: :entries, module: Feedraptor.Parser.RSSFeedBurner.Entry

  defmodule Entry do
    @date_format "RFC_1123"
    alias Feedraptor.Helper

    defmodule Definition do
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

    def parse(raw_entry) do
      raw_entry
      |> Definition.parse()
      |> Helper.update_date_fields(format: @date_format)
    end
  end
end
