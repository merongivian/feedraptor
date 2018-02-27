defmodule Exfeed.Parser.RSS do
  alias Exfeed.Parser.RSS.Entry
  use Exfeed.Parser.XML

  defmodule Feed do
    use Exfeed.Parser.XML

    element :title
    element :description
    element :ttl
    element :language
    element :lastbuilddate, as: :last_built
    elements :item, as: :entries, module: Exfeed.Parser.RSS.Entry
    element :image, module: Exfeed.Parser.RSS.Image
  end

  defmodule Image do
    use Exfeed.Parser.XML

    element :url
    element :title
    element :link
    element :width
    element :height
    element :description
  end

  def parse(feed) do
    Feed.new(feed)
  end
end
