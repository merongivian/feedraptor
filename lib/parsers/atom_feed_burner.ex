defmodule Exfeed.Parser.AtomFeedBurner do
  alias Exfeed.Parser.XML
  use XML

  element :title
  element :subtitle, as: :description
  #element :link, as: :url_text_html, value: :href, with: { type: "text/html"  }
  #element :link, as: :url_notype, value: :href, with: { type: nil  }
  #element :link, as: :feed_url_link, value: :href, with: { type: "application/atom+xml"  } # rubocop:disable Metrics/LineLength
  #element :"atom10:link", as: :feed_url_atom10_link, value: :href, with: { type: "application/atom+xml"  }
  #elements :"atom10:link", as: :hubs, value: :href, with: { rel: "hub"  }
  elements :entry, as: :entries, module: Exfeed.Parser.AtomFeedBurner.Entry

  defmodule Entry do
    use XML

    element :title
    element :name, as: :author
    #element :link, as: :url, value: :href, with: { type: "text/html", rel: "alternate" } # rubocop:disable Metrics/LineLength
    element :"feedburner:origlink", as: :url
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
