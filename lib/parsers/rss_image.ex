defmodule Feedraptor.Parser.RSSImage do
  @moduledoc false
  use Capuli

  element :url
  element :title
  element :link
  element :width
  element :height
  element :description
end
