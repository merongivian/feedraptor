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
      title: get_value(raw_feed, "channel > title"),
      description: get_value(raw_feed, "channel > description"),
      ttl: get_value(raw_feed, "channel > ttl"),
      language: get_value(raw_feed, "channel > language"),
    }
  end

  def get_value(raw_feed, css_selector) do
    raw_feed
    |> Floki.find(css_selector)
    |> node_value()
  end

  def node_value([{_, _, [value]}]) when is_binary(value), do: value
  def node_value([]), do: ""
end
