defmodule Feedraptor.Parser.GoogleDocsAtom do
  @moduledoc """
  Feed Parser for Google Docs Atom feeds

  ## Feed properties:

  * Title
  * Description
  * Url
  * Feed url
  * Links
  * Entries

  ## Entry properties:

  * Title
  * Url
  * Author
  * Content
  * Summary
  * Published
  * Updated
  * Entry id
  * Categories
  * Links
  * Checksum
  * Original Filename
  * Suggested Filename
  """
  use Capuli

  element :title
  element :subtitle, as: :description
  element :link, as: :url, value: :href, with: [type: "text/html"]
  element :link, as: :feed_url, value: :href, with: [type: "application/atom+xml"]
  elements :link, as: :links, value: :href
  elements :entry, as: :entries, module: Feedraptor.Parser.GoogleDocsAtom.Entry

  defmodule Entry do
    @moduledoc false
    alias Feedraptor.Helper

    defmodule Definition do
      @moduledoc false
      use Capuli

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

    @doc false
    def parse(raw_entry) do
      raw_entry
      |> Definition.parse()
      |> Helper.update_date_fields()
    end
  end

  @doc false
  def will_parse?(xml) do
    xml =~ ~r{<id>https?://docs\.google\.com/.*\</id\>}
  end
end
