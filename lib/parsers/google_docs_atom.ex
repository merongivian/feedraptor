defmodule Feedraptor.Parser.GoogleDocsAtom do
  alias Feedraptor.Parser.XML
  use XML

  element :title
  element :subtitle, as: :description
  element :link, as: :url, value: :href, with: [type: "text/html"]
  element :link, as: :feed_url, value: :href, with: [type: "application/atom+xml"]
  elements :link, as: :links, value: :href
  elements :entry, as: :entries, module: Feedraptor.Parser.GoogleDocsAtom.Entry

  defmodule Entry do
    alias Feedraptor.Helper

    defmodule Definition do
      use XML

      element :title
      element :link, as: :url, value: :href, with: [type: "text/html", rel: "alternate"]
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

    def parse(raw_entry) do
      raw_entry
      |> Definition.parse()
      |> Helper.update_date_fields()
    end
  end
end
