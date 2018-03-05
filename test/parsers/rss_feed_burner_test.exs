defmodule Feedraptor.Parser.RSSFeedBurnerTest do
  import Feedraptor.SampleFeeds

  use ExUnit.Case, async: true

  describe "will_parse?/1" do
    test "returns true for a feedburner rss feed" do
      assert Feedraptor.Parser.RSSFeedBurner.will_parse?(load_sample_rss_feed_burner_feed())
    end

    test "returns false for a regular RSS feed" do
      refute Feedraptor.Parser.RSSFeedBurner.will_parse?(load_sample_rss_feed())
    end

    test "returns false for a feedburner atom feed" do
      refute Feedraptor.Parser.RSSFeedBurner.will_parse?(load_sample_feedburner_atom_feed())
    end

    test "returns false for an rdf feed" do
      refute Feedraptor.Parser.RSSFeedBurner.will_parse?(load_sample_rdf_feed())
    end

    test "returns false for a regular atom feed" do
      refute Feedraptor.Parser.RSSFeedBurner.will_parse?(load_sample_atom_feed())
    end
  end

  describe "parsing" do
    setup do
      feed = Feedraptor.Parser.RSSFeedBurner.parse(load_sample_rss_feed_burner_feed())
      {:ok, feed: feed}
    end

    test "should parse the title", %{feed: feed} do
      assert feed.title == "TechCrunch"
    end

    test "should parse the description", %{feed: feed} do
      description = "TechCrunch is a group-edited blog that profiles the companies, products and events defining and transforming the new web." # rubocop:disable Metrics/LineLength
      assert feed.description == description
    end

    test "should parse the url", %{feed: feed} do
      assert feed.url == "http://techcrunch.com"
    end

    test "should parse the last build date", %{feed: feed} do
      assert feed.last_built == "Wed, 02 Nov 2011 17:29:59 +0000"
    end

    @tag :pending
    test "should parse the hub urls", %{feed: feed} do
      assert List.first(feed.hubs) == "http://pubsubhubbub.appspot.com/"
      assert Enum.count(feed.hubs) == 2
    end

    test "should parse entries", %{feed: feed} do
      assert Enum.count(feed.entries) == 20
    end
  end
end
