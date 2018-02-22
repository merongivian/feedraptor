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
    ]
  end

  def parse(raw_feed) do
    %Exfeed.Parser.RSS.Feed{
      title: get_feed_value(raw_feed, "title"),
      description: get_feed_value(raw_feed, "description"),
      ttl: get_feed_value(raw_feed, "ttl"),
      language: get_feed_value(raw_feed, "language"),
    }
  end

  def get_feed_value(raw_feed, css_selector) do
    raw_feed
    |> Floki.find("channel > #{css_selector}")
    |> node_value()
  end

  def node_value([{_, _, [value]}]) when is_binary(value), do: value
  def node_value([]), do: ""
end
