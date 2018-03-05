defmodule FeedraptorTest do
  import Feedraptor.SampleFeeds

  use ExUnit.Case, async: true

  test "parses an rdf feed" do
    feed = Feedraptor.parse(load_sample_rdf_feed())
    assert feed.title == "HREF Considered Harmful"
    assert Enum.count(feed.entries) == 10
  end

  test "parses an rss feed" do
    feed = Feedraptor.parse(load_sample_rss_feed())
    assert feed.title == "Tender Lovemaking"
    assert Enum.count(feed.entries) == 10
  end

  test "parses an atom feed" do
    feed = Feedraptor.parse(load_sample_atom_feed())
    assert feed.title == "Amazon Web Services Blog"
    assert Enum.count(feed.entries) == 10
  end

  test "parses an feedburner atom feed" do
    feed = Feedraptor.parse(load_sample_feedburner_atom_feed())
    assert feed.title == "Paul Dix Explains Nothing"
    assert Enum.count(feed.entries) == 5
  end

  test "parses an itunes feed" do
    feed = Feedraptor.parse(load_sample_itunes_feed())
    assert feed.title == "All About Everything"
    assert Enum.count(feed.entries) == 3
  end

  test "parses an feedburner rss feed" do
    feed = Feedraptor.parse(load_sample_rss_feed_burner_feed())
    assert feed.title == "TechCrunch"
    assert Enum.count(feed.entries) == 20
  end

  @tag :pending
  test "with nested dc:identifier it does not overwrite entry_id" do
    feed = "" #Feedraptor.parse(load_sample_rss_feed_huffpost_ca())
    assert String.trim(feed.title)    == "HuffPost Canada - Athena2 - All Posts"
    assert Enum.count(feed.entries)    == 2
    assert List.first(feed.entries).id == "23246627"
    assert String.trim(List.last(feed.entries).id) == "1"
  end
end
