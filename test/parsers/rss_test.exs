defmodule Exfeed.Parser.RssTest do
  import Exfeed.SampleFeeds

  use ExUnit.Case, async: true

  setup do
    feed = Exfeed.Parser.RSS.parse(load_sample_rss_feed)
    {:ok, feed: feed}
  end

  @tag :pending
  test "parsing the version", %{feed: feed}  do
    assert feed.version == "2.0"
  end

  test "parsing the title", %{feed: feed} do
    assert feed.title == "Tender Lovemaking"
  end

  test "parsing the description", %{feed: feed} do
    assert feed.description == "The act of making love, tenderly."
  end

  @tag :pending
  test "parsing the url", %{feed: feed} do
    assert feed.url == "http://tenderlovemaking.com"
  end

  test "parsing the ttl", %{feed: feed} do
    assert feed.ttl == "60"
  end

  @tag :pending
  test "parsing the last build date", %{feed: feed} do
    assert feed.last_built == "Sat, 07 Sep 2002 09:42:31 GMT"
  end

  @tag :pending
  test "parsing the hub urls", %{feed: feed} do
    assert Enum.count(feed.hubs) == 1
    assert List.first(feed.hubs) == "http://pubsubhubbub.appspot.com/"
  end

  @tag :pending
  test "parses the feed url", %{feed: feed} do
    assert feed.feed_url == "http://tenderlovemaking.com/feed/"
  end

  test "parsing the language", %{feed: feed} do
    assert feed.language == "en"
  end

  test "parsing the image url", %{feed: feed} do
    assert feed.image.url == "https://tenderlovemaking.com/images/header-logo-text-trimmed.png"
  end

  test "parsing the image title", %{feed: feed} do
    assert feed.image.title == "Tender Lovemaking"
  end

  test "parsing the image link", %{feed: feed} do
    assert feed.image.link == "http://tenderlovemaking.com"
  end

  test "parsing the image width", %{feed: feed} do
    assert feed.image.width == "766"
  end

  test "parsing the image height", %{feed: feed} do
    assert feed.image.height == "138"
  end

  test "parsing the image description", %{feed: feed} do
    assert feed.image.description == "The act of making love, tenderly."
  end

  @tag :pending
  test "parsing entries", %{feed: feed} do
    assert Enum.count(feed.entries) == 10
  end
end
