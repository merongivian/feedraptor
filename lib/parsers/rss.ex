defmodule Feedraptor.Parser.RSS do
  alias Feedraptor.Parser.XML
  import Feedraptor.Helper
  use XML

  element :title
  element :link, as: :url
  element :description
  element :ttl
  element :language
  element :lastbuilddate, as: :last_built
  elements :item, as: :entries, module: Feedraptor.Parser.RSS.Entry
  element :image, module: Feedraptor.Parser.RSSImage

  defmodule Entry do
    @date_format "RFC_1123"
    alias Feedraptor.Helper

    defmodule Definition do
      use XML

      element :title
      element :link, as: :url

      element :"dc:creator", as: :author
      element :author, as: :author
      element :"content:encoded", as: :content
      element :description, as: :summary

      element :"media:content", as: :image, value: :url
      element :enclosure, as: :image, value: :url

      element :pubdate, as: :published
      element :"dc:date", as: :published
      element :"dcterms:created", as: :published

      element :"dcterms:modified", as: :updated
      element :issued, as: :published
      elements :category, as: :categories

      element :guid, as: :entry_id
      element :"dc:identifier", as: :dc_identifier
    end

    def parse(raw_entry) do
      raw_entry
      |> Definition.parse()
      |> Helper.update_date_fields(format: @date_format)
    end
  end

  def will_parse?(xml) do
    (xml =~ ~r/\<rss|\<rdf/) && !(xml =~ ~r/feedburner/)
  end
end
