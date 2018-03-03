defmodule Feedraptor.Parser.RSSImage do
  alias Feedraptor.Parser.XML
  use XML

  element :url
  element :title
  element :link
  element :width
  element :height
  element :description
end
