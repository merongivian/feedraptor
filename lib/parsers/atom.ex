defmodule Exfeed.Parser.Atom do
  alias Exfeed.Parser.XML
  use XML

  element :title
  element :subtitle, as: :description
  #element :link, as: :url, value: :href, with: [type: "text/html"]
  #element :link, as: :feed_url, value: :href, with: [rel: "self"]
  #elements :link, as: :links, value: :href
  #elements :link, as: :hubs, value: :href, with: [rel: "hub"]
  elements :entry, as: :entries, module: Exfeed.Parser.Atom.Entry

  defmodule Entry do
    use XML

    element :title
    #element :link, as: :url, value: :href, with: { type: "text/html", rel: "alternate" } # rubocop:disable Metrics/LineLength
    element :name, as: :author
    element :content
    element :summary

    #element :"media:content", as: :image, value: :url
    #element :enclosure, as: :image, value: :href

    element :published
    element :id, as: :entry_id
    element :created, as: :published
    element :issued, as: :published
    element :updated
    element :modified, as: :updated
    #elements :category, as: :categories, value: :term
    #elements :link, as: :links, value: :href
  end
end
