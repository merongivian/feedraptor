defmodule Exfeed.Parser.RSS do
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

  def image_field(raw_feed, image_field) do
    raw_feed
    |> feed_field("image")
    |> node_value(image_field)
  end

  def get_entries(raw_feed) do
    Floki.find(raw_feed, "item")
  end

  def feed_field(raw_feed, feed_field) do
    raw_feed
    |> Floki.find("channel > #{feed_field}")
    |> node_value()
  end

  def node_value(node, subnode_name) do
    node
    |> Floki.find(subnode_name)
    |> node_value()
  end
  def node_value([{_, _, [value]}]) when is_binary(value), do: value
  def node_value([]), do: ""
  def node_value(value), do: value
end
