defmodule Feedraptor.Parser.AtomFeedBurnerTest do
  import Feedraptor.SampleFeeds

  use ExUnit.Case, async: true

  @tag :pending
  test "should parse hub urls" do
    xml = File.read! "test/sample_feeds/TypePadNews.xml"
    feed_with_hub = Feedraptor.Parser.AtomFeedBurner.parse(xml)
    assert Enum.count(feed_with_hub.hubs) == 1
  end

  describe "will_parse?/1" do
    test "returns true for a feedburner atom feed" do
      assert Feedraptor.Parser.AtomFeedBurner.will_parse?(load_sample_feedburner_atom_feed())
    end

    test "returns false for an rdf feed" do
      refute Feedraptor.Parser.AtomFeedBurner.will_parse?(load_sample_rdf_feed())
    end

    test "returns false for a regular atom feed" do
      refute Feedraptor.Parser.AtomFeedBurner.will_parse?(load_sample_atom_feed())
    end

    test "returns false for an rss feedburner feed" do
      refute Feedraptor.Parser.AtomFeedBurner.will_parse?(load_sample_rss_feed_burner_feed())
    end
  end

  describe "parsing old style feeds" do
    setup do
      feed = Feedraptor.Parser.AtomFeedBurner.parse(load_sample_feedburner_atom_feed())
      {:ok, feed: feed}
    end

    test "should parse the title", %{feed: feed} do
      assert feed.title == "Paul Dix Explains Nothing"
    end

    test "should parse the description", %{feed: feed} do
      description = "Entrepreneurship, programming, software development, politics, NYC, and random thoughts."
      assert feed.description == description
    end

    @tag :pending
    test "should parse the url", %{feed: feed} do
      assert feed.url == "http://www.pauldix.net/"
    end

    @tag :pending
    test "should parse the feed_url", %{feed: feed} do
      assert feed.feed_url == "http://feeds.feedburner.com/PaulDixExplainsNothing"
    end

    test "should parse entries", %{feed: feed} do
      assert Enum.count(feed.entries) == 5
    end
  end

  describe "parsing alternate style feeds" do
    setup do
      feed = Feedraptor.Parser.AtomFeedBurner.parse(load_sample_feedburner_atom_feed_alternate())
      {:ok, feed: feed}
    end

    test "should parse the title", %{feed: feed} do
      assert feed.title == "Giant Robots Smashing Into Other Giant Robots"
    end

    test "should parse the description", %{feed: feed} do
      assert feed.description == "Written by thoughtbot"
    end

    @tag :pending
    test "should parse the url", %{feed: feed} do
      assert feed.url == "https://robots.thoughtbot.com"
    end

    @tag :pending
    test "should parse the feed_url", %{feed: feed} do
      assert feed.feed_url "http://feeds.feedburner.com/GiantRobotsSmashingIntoOtherGiantRobots"
    end

    test "should parse hub urls", %{feed: feed} do
      assert Enum.count(feed.hubs) == 1
    end

    test "should parse entries", %{feed: feed} do
      assert Enum.count(feed.entries) == 3
    end
  end
end
