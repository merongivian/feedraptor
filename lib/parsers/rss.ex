defmodule Exfeed.Parser.RSS do
  alias Exfeed.Parser.XML
  use XML

  element :title
  element :link, as: :url
  element :description
  element :ttl
  element :language
  element :lastbuilddate, as: :last_built
  elements :item, as: :entries, module: Exfeed.Parser.RSS.Entry
  element :image, module: Exfeed.Parser.RSS.Image

  defmodule Image do
    use XML

    element :url
    element :title
    element :link
    element :width
    element :height
    element :description
  end

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
