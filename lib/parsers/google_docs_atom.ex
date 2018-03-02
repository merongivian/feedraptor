defmodule Exfeed.Parser.GoogleDocsAtom do
  alias Exfeed.Parser.XML
  use XML

  element :title
  element :subtitle, as: :description
  #element :link, as: :url, value: :href, with: { type: "text/html" }
  #element :link, as: :feed_url, value: :href, with: { type: "application/atom+xml" } # rubocop:disable Metrics/LineLength
  elements :link, as: :links, value: :href
  elements :entry, as: :entries, module: Exfeed.Parser.GoogleDocsAtom.Entry

  defmodule Entry do
    use XML

    element :title
    #element :link, as: :url, value: :href, with: { type: "text/html", rel: "alternate" } # rubocop:disable Metrics/LineLength
    element :name, as: :author
    element :content
    element :summary
    element :published
    element :id, as: :entry_id
    element :created, as: :published
    element :issued, as: :published
    element :updated
    element :modified, as: :updated
    elements :category, as: :categories, value: :term
    elements :link, as: :links, value: :href
    element :"docs:md5checksum", as: :checksum
    element :"docs:filename", as: :original_filename
    element :"docs:suggestedfilename", as: :suggested_filename
  end
end
