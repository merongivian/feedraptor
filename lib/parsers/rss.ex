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

    def parse(image) do
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
    %Feed{
      title: element(feed, "title"),
      description: element(feed, "description"),
      ttl: element(feed, "ttl"),
      language: element(feed, "language"),
      last_built: element(feed, "lastbuilddate"),
      entries: get_entries(feed),
      image: get_image(feed)
    }
  end

  def get_entries(feed) do
    feed
    |> Floki.find("item")
    |> Enum.map(&Entry.parse/1)
  end

  def get_image(feed) do
    feed
    |> element("image")
    |> Image.parse()
  end
end
