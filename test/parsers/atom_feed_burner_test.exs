defmodule Exfeed.Parser.AtomFeedBurnerTest do
  import Exfeed.SampleFeeds

  use ExUnit.Case, async: true

  #test "should parse hub urls", %{feed: feed} do
    #feed_with_hub = AtomFeedBurner.parse(load_sample("TypePadNews.xml"))
    #expect(feed_with_hub.hubs.count).to eq 1
  #end

  describe "parsing old style feeds" do
    setup do
      feed = Exfeed.Parser.AtomFeedBurner.parse(load_sample_feedburner_atom_feed)
      {:ok, feed: feed}
    end

    test "should parse the title", %{feed: feed} do
      assert feed.title == "Paul Dix Explains Nothing"
    end

    test "should parse the description", %{feed: feed} do
      description = "Entrepreneurship, programming, software development, politics, NYC, and random thoughts." # rubocop:disable Metrics/LineLength
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

    @tag :pending
    test "should parse no hub urls", %{feed: feed} do
      assert Enum.count(feed.hubs) == 0
    end

    test "should parse entries", %{feed: feed} do
      assert Enum.count(feed.entries) == 5
    end
  end

  describe "parsing alternate style feeds" do
    setup do
      feed = Exfeed.Parser.AtomFeedBurner.parse(load_sample_feedburner_atom_feed_alternate)
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

    @tag :pending
    test "should parse hub urls", %{feed: feed} do
      assert Enum.count(feed.hubs) == 1
    end

    test "should parse entries", %{feed: feed} do
      assert Enum.count(feed.entries) == 3
    end
  end
end
