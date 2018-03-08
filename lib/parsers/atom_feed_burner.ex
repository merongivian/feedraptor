defmodule Feedraptor.Parser.AtomFeedBurner do
  @moduledoc """
  Feed Parser for Atom Feedburner feeds

  ## Feed properties:

  * Title
  * Description
  * Url text html
  * Url notype
  * Feed url link
  * Feed url atom10 link
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
  * Links
  """
  use Capuli

  element :title
  element :subtitle, as: :description
  element :link, as: :url_text_html, value: :href, with: [type: "text/html"]
  element :link, as: :url_notype, value: :href, with: [type: nil]
  element :link, as: :feed_url_link, value: :href, with: [type: "application/atom+xml"]
  element :"atom10:link", as: :feed_url_atom10_link, value: :href, with: [type: "application/atom+xml"]
  elements :"atom10:link", as: :hubs, value: :href, with: [rel: "hub"]
  elements :entry, as: :entries, module: Feedraptor.Parser.AtomFeedBurner.Entry

  defmodule Entry do
    alias Feedraptor.Helper

    defmodule Definition do
      use Capuli

      element :title
      element :name, as: :author
      element :"feedburner:origlink", as: :url
      element :link, as: :url, value: :href, with: [type: "text/html", rel: "alternate"]
      element :summary
      element :content

      element :"media:content", as: :image, value: :url
      element :enclosure, as: :image, value: :href

      element :published
      element :id, as: :entry_id
      element :issued, as: :published
      element :created, as: :published
      element :updated
      element :modified, as: :updated
      elements :category, as: :categories, value: :term
      elements :link, as: :links, value: :href
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
    ((xml =~ ~r/Atom/) && (xml =~ ~r/feedburner/) && !(xml =~ ~r/\<rss|\<rdf/)) || false
  end
end
