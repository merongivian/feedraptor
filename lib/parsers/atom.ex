defmodule Feedraptor.Parser.Atom do
  @moduledoc """
  Feed Parser for Atom feeds

  ## Feed properties:

  * Title
  * Description
  * Url
  * Feed url
  * Links
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
  element :link, as: :url, value: :href, with: [type: "text/html"]
  element :link, as: :feed_url, value: :href, with: [rel: "self"]
  elements :link, as: :links, value: :href
  elements :link, as: :hubs, value: :href, with: [rel: "hub"]
  elements :entry, as: :entries, module: Feedraptor.Parser.Atom.Entry

  defmodule Entry do
    alias Feedraptor.Helper

    defmodule Definition do
      use Capuli

      element :title
      element :link, as: :url, value: :href, with: [type: "text/html", rel: "alternate"]
      element :name, as: :author
      element :content
      element :summary

      element :"media:content", as: :image, value: :url
      element :enclosure, as: :image, value: :href

      element :published
      element :id, as: :entry_id
      element :created, as: :published
      element :issued, as: :published
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
   xml =~ ~r{\<feed[^\>]+xmlns\s?=\s?[\"\'](http://www\.w3\.org/2005/Atom|http://purl\.org/atom/ns\#)[\"\'][^\>]*\>}
  end
end
