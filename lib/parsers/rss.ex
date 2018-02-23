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
  end

  def parse(raw_feed) do
    %Feed{
      title: feed_field(raw_feed, "title"),
      description: feed_field(raw_feed, "description"),
      ttl: feed_field(raw_feed, "ttl"),
      language: feed_field(raw_feed, "language"),
      last_built: feed_field(raw_feed, "lastbuilddate"),
      entries: get_entries(raw_feed),
      image: %Image{
        url: image_field(raw_feed, "url"),
        title: image_field(raw_feed, "title"),
        link: image_field(raw_feed, "link"),
        width: image_field(raw_feed, "width"),
        height: image_field(raw_feed, "width"),
        description: image_field(raw_feed, "description")
      }
    }
  end

  def get_entries(raw_feed) do
    raw_feed
    |> Floki.find("item")
    |> Enum.map(&Entry.parse/1)
  end

  def image_field(raw_feed, field_name) do
    raw_feed
    |> feed_field("image")
    |> node_value(field_name)
  end

  def feed_field(raw_feed, field_name) do
    raw_feed
    |> Floki.find("channel > #{field_name}")
    |> node_value()
  end
end
