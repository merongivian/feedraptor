defmodule Feedraptor.Parser.AtomFeedBurner do
  alias Feedraptor.Parser.XML
  use XML

  element :title
  element :subtitle, as: :description
  element :link, as: :url_text_html, value: :href, with: [type: "text/html"]
  element :link, as: :url_notype, value: :href, with: [type: nil]
  element :link, as: :feed_url_link, value: :href, with: [type: "application/atom+xml"]
  element :"atom10:link", as: :feed_url_atom10_link, value: :href, with: [type: "application/atom+xml"]
  elements :"atom10:link", as: :hubs, value: :href, with: [rel: "hub"]
  elements :entry, as: :entries, module: Feedraptor.Parser.AtomFeedBurner.Entry

  defmodule Entry do
    use XML

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
end
