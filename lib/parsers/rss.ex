defmodule Exfeed.Parser.RSS do
  alias Exfeed.Parser.RSS.Entry
  import Exfeed.Parser.XML

  defmodule Feed do
    defstruct [
      :feed_url,
      :version,
      :title,
      :description,
      :url,
      :ttl,
      :last_built,
      :hubs,
      :language,
      :image,
      :entries
    ]

    def create(feed) do
      %Feed{
        title: element(feed, "title"),
        description: element(feed, "description"),
        ttl: element(feed, "ttl"),
        language: element(feed, "language"),
        last_built: element(feed, "lastbuilddate"),
        entries: elements(feed, "item", strukt: Exfeed.Parser.RSS.Entry),
        image: element(feed, "image", strukt: Exfeed.Parser.RSS.Image)
      }
    end
  end

  defmodule Image do
    defstruct [
      :url,
      :title,
      :link,
      :width,
      :height,
      :description
    ]

    def create(image) do
      %Image{
        url: element(image, "url"),
        title: element(image, "title"),
        link: element(image, "link"),
        width: element(image, "width"),
        height: element(image, "height"),
        description: element(image, "description")
      }
    end
  end

  def parse(feed) do
    Feed.create(feed)
  end
end
