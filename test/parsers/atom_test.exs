defmodule Exfeed.Parser.AtomTest do
  import Exfeed.SampleFeeds

  use ExUnit.Case, async: true

  #test "should parse the url even when it doesn't have the type='text/html' attribute" do # rubocop:disable Metrics/LineLength
    #xml = load_sample "atom_with_link_tag_for_url_unmarked.xml"
    #feed = Atom.parse xml
    #expect(feed.url).to eq "http://www.innoq.com/planet/"
  #end

  #test "should parse the feed_url even when it doesn't have the type='application/atom+xml' attribute" do # rubocop:disable Metrics/LineLength
    #feed = Atom.parse(load_sample("atom_with_link_tag_for_url_unmarked.xml"))
    #expect(feed.feed_url).to eq "http://www.innoq.com/planet/atom.xml"
  #end

  #test "should parse the hub urls" do
    #feed_with_hub = Atom.parse(load_sample("SamRuby.xml"))
    #expect(feed_with_hub.hubs.count).to eq 1
    #expect(feed_with_hub.hubs.first).to eq "http://pubsubhubbub.appspot.com/"
  #end

  describe "parsing" do
    setup do
      feed = Exfeed.Parser.Atom.parse(load_sample_atom_feed)
      {:ok, feed: feed}
    end

    test "should parse the title", %{feed: feed} do
      assert feed.title == "Amazon Web Services Blog"
    end

    test "should parse the description", %{feed: feed} do
      assert feed.description == "Amazon Web Services, Products, Tools, and Developer Information..." # rubocop:disable Metrics/LineLength
    end

    @tag :pending
    test "should parse the url", %{feed: feed} do
      assert feed.url == "http://aws.typepad.com/aws/"
    end

    @tag :pending
    test "should parse the feed_url", %{feed: feed} do
      assert feed.feed_url == "http://aws.typepad.com/aws/atom.xml"
    end

    @tag :pending
    test "should parse no hub urls", %{feed: feed} do
      assert Enum.count(feed.hubs) == 0
    end

    test "should parse entries", %{feed: feed} do
      assert Enum.count(feed.entries) == 10
    end
  end

  describe "parsing url and feed url based on rel attribute" do
    setup do
      feed = Exfeed.Parser.Atom.parse(load_sample_atom_middleman_feed)
      {:ok, feed: feed}
    end

    @tag :pending
    test "should parse url", %{feed: feed} do
      assert feed.url == "http://feedjira.com/blog"
    end

    @tag :pending
    test "should parse feed url", %{feed: feed} do
      assert feed.feed_url == "http://feedjira.com/blog/feed.xml"
    end
  end
end
