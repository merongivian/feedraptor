defmodule Feedraptor.Parser.RSS do
  alias Feedraptor.Parser.XML
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
    use XML

    element :title
    element :link, as: :url
    element :author, as: :author
    element :"dc:creator", as: :author
    element :"content:encoded", as: :content
    element :description, as: :summary
    element :guid, as: :entry_id
    elements :category, as: :categories
  end
end
