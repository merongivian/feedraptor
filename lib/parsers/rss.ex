defmodule Feedraptor.Parser.RSS do
  @moduledoc """
  Feed Parser for RSS feeds

  ## Feed properties:

  * Description
  * Image
  * Language
  * Last Build date
  * Url
  * Version
  * Title
  * TTL
  * Hubs
  * Entries

  ## Entry properties:

  * Title
  * Url
  * Author
  * Content
  * Summary
  * Image
  * Published
  * Updated
  * Entry id
  * Categories
  * Dc Identifier

  ## Image properties:

  * Url
  * Title
  * Link
  * Width
  * Height
  * Description
  """
  use Capuli

  element :description
  element :image, module: Feedraptor.Parser.RSSImage
  element :language
  element :lastbuilddate, as: :last_built
  element :link, as: :url
  element :rss, as: :version, value: :version
  element :title
  element :ttl
  elements :"atom:link", as: :hubs, value: :href, with: [rel: "hub"]
  elements :item, as: :entries, module: Feedraptor.Parser.RSS.Entry


  defmodule Entry do
    @moduledoc false
    alias Feedraptor.Helper

    defmodule Definition do
      @moduledoc false
      use Capuli

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

    @doc false
    def parse(raw_entry) do
      raw_entry
      |> Definition.parse()
      |> Helper.update_date_fields()
    end
  end

  @doc false
  def will_parse?(xml) do
    (xml =~ ~r/\<rss|\<rdf/) && !(xml =~ ~r/feedburner/)
  end
end
