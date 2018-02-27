defmodule Exfeed.Parser.RSS.Entry do
  use Exfeed.Parser.XML

  element :title
  element :link, as: :url
  element :"dc:creator", as: :author
  element :"content:encoded", as: :content
  element :description, as: :summary
  element :guid, as: :entry_id
end
