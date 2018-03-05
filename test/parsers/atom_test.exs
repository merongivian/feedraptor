defmodule Feedraptor.Parser.AtomTest do
  import Feedraptor.SampleFeeds

  use ExUnit.Case, async: true

  describe "will_parse/1" do
    test "should return true for an atom feed" do
      assert Feedraptor.Parser.Atom.will_parse?(load_sample_atom_feed())
		end

		test "should return false for an rdf feed" do
      refute Feedraptor.Parser.Atom.will_parse?(load_sample_rdf_feed())
		end

		test "should return false for an rss feedburner feed" do
      refute Feedraptor.Parser.Atom.will_parse?(load_sample_rss_feed_burner_feed())
		end

		test "should return true for an atom feed that has line breaks in between attributes in the <feed> node" do # rubocop:disable Metrics/LineLength
      assert Feedraptor.Parser.Atom.will_parse?(load_sample_atom_feed_line_breaks())
		end
  end

  describe "parsing" do
    setup do
      feed = Feedraptor.Parser.Atom.parse(load_sample_atom_feed())
      {:ok, feed: feed}
    end

    test "should parse the url" do
      feed = Feedraptor.Parser.Atom.parse load_sample_atom_url()
      assert feed.url == "http://www.innoq.com/planet/"
    end

    test "should parse the hub urls" do
      feed_with_hub = Feedraptor.Parser.Atom.parse(load_sample_atom_hub())
      assert Enum.count(feed_with_hub.hubs) == 1
      assert List.first(feed_with_hub.hubs) == "http://pubsubhubbub.appspot.com/"
    end

    test "should parse the title", %{feed: feed} do
      assert feed.title == "Amazon Web Services Blog"
    end

    test "should parse the description", %{feed: feed} do
      assert feed.description == "Amazon Web Services, Products, Tools, and Developer Information..."
    end

    test "parsing the url", %{feed: feed} do
      assert feed.url == "http://aws.typepad.com/aws/"
    end

    test "should parse the feed_url", %{feed: feed} do
      assert feed.feed_url == "http://aws.typepad.com/aws/atom.xml"
    end

    test "should parse entries", %{feed: feed} do
      assert Enum.count(feed.entries) == 10
    end
  end

  describe "parsing url and feed url based on rel attribute" do
    setup do
      feed = Feedraptor.Parser.Atom.parse(load_sample_atom_middleman_feed())
      {:ok, feed: feed}
    end

    @tag :pending
    test "should parse url", %{feed: feed} do
      assert feed.url == "http://feedjira.com/blog"
    end

    test "should parse feed url", %{feed: feed} do
      assert feed.feed_url == "http://feedjira.com/blog/feed.xml"
    end
  end
end
