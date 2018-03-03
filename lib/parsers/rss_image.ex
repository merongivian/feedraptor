defmodule Exfeed.Parser.RSSImage do
  alias Exfeed.Parser.XML
  use XML

  element :url
  element :title
  element :link
  element :width
  element :height
  element :description
end
