defmodule Feedraptor.Parser.RSSImage do
  use Capuli

  element :url
  element :title
  element :link
  element :width
  element :height
  element :description
end
