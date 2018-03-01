defmodule Exfeed.Parser.AtomYoutubeTest do
  import Exfeed.SampleFeeds

  use ExUnit.Case, async: true

  setup do
    feed = Exfeed.Parser.AtomYoutube.parse(load_sample_youtube_atom_feed)
    {:ok, feed: feed}
  end

  test "should parse the title", %{feed: feed} do
    assert feed.title == "Google"
  end

  test "should parse the author", %{feed: feed} do
    assert feed.author == "Google Author"
  end

  @tag :pending
  test "should parse the url", %{feed: feed} do
    assert feed.url == "http://www.youtube.com/user/Google"
  end

  @tag :pending
  test "should parse the feed_url", %{feed: feed} do
    assert feed.feed_url == "http://www.youtube.com/feeds/videos.xml?user=google"
  end

  test "should parse the YouTube channel id", %{feed: feed} do
    assert feed.youtube_channel_id == "UCK8sQmJBp8GCxrOtXWBpyEA"
  end
end
