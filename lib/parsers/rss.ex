defmodule Exfeed.Parser.RSS do
  alias Exfeed.Parser.RSS.Entry
  import Exfeed.Parser.XML

  defmodule Feed do
    def create(feed) do
      feed
      |> element("title")
      |> element("description")
      |> element("ttl")
      |> element("language")
      |> element("lastbuilddate", as: :last_built)
      |> elements("item", as: :entries, strukt: Exfeed.Parser.RSS.Entry)
      |> element("image", strukt: Exfeed.Parser.RSS.Image)
      |> parse()
    end
  end

  defmodule Image do
    def create(image) do
      image
      |> element("url")
      |> element("title")
      |> element("link")
      |> element("width")
      |> element("height")
      |> element("description")
      |> parse()
    end
  end

  def parse(feed) do
    Feed.create(feed)
  end
end
