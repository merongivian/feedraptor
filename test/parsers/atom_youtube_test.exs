defmodule Feedraptor.Parser.AtomYoutubeTest do
  import Feedraptor.SampleFeeds

  use ExUnit.Case, async: true

  describe "#will_parse?" do
    test "returns true for an atom youtube feed" do
      assert Feedraptor.Parser.AtomYoutube.will_parse?(load_sample_youtube_atom_feed())
    end

    test "returns fase for an atom feed" do
      refute Feedraptor.Parser.AtomYoutube.will_parse?(load_sample_atom_feed())
    end

    test "returns false for an rss feedburner feed" do
      refute Feedraptor.Parser.AtomYoutube.will_parse?(load_sample_rss_feed_burner_feed())
    end
  end

  describe "parsing" do
    setup do
      feed = Feedraptor.Parser.AtomYoutube.parse(load_sample_youtube_atom_feed())
      {:ok, feed: feed}
    end

    test "should parse the title", %{feed: feed} do
      assert feed.title == "Google"
    end

    test "should parse the author", %{feed: feed} do
      assert feed.author == "Google Author"
    end

    test "should parse the url", %{feed: feed} do
      assert feed.url == "http://www.youtube.com/user/Google"
    end

    test "should parse the feed_url", %{feed: feed} do
      assert feed.feed_url == "http://www.youtube.com/feeds/videos.xml?user=google"
    end

    test "should parse the YouTube channel id", %{feed: feed} do
      assert feed.youtube_channel_id == "UCK8sQmJBp8GCxrOtXWBpyEA"
    end
  end
end
