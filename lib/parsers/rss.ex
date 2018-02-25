defmodule Exfeed.Parser.RSS do
  alias Exfeed.Parser.RSS.Entry
  import Exfeed.Parser.XML

  defmodule Feed do
    def create(feed) do
      feed
      |> element("title", as: :title)
      |> element("description", as: :description)
      |> element("ttl", as: :ttl)
      |> element("language", as: :language)
      |> element("lastbuilddate", as: :last_built)
      |> elements("item", as: :entries, strukt: Exfeed.Parser.RSS.Entry)
      |> element("image", as: :image, strukt: Exfeed.Parser.RSS.Image)
      |> parse()
    end
  end

  defmodule Image do
    def create(image) do
      image
      |> element("url", as: :url)
      |> element("title", as: :title)
      |> element("link", as: :link)
      |> element("width", as: :width)
      |> element("height", as: :height)
      |> element("description", as: :description)
      |> parse()
    end
  end

  def parse(feed) do
    Feed.create(feed)
  end
end
