defmodule Exfeed.Parser.AtomFeedBurnerTest do
  import Exfeed.SampleFeeds

  use ExUnit.Case, async: true

  setup do
    entry = Exfeed.Parser.AtomFeedBurner.parse(load_sample_feedburner_atom_feed).entries
            |> List.first

    {:ok, entry: entry}
  end

  test "should parse the title", %{entry: entry} do
    assert entry.title == "Making a Ruby C library even faster"
  end

  @tag :pending
  test "should be able to fetch a url via the 'alternate' rel if no origLink exists", %{entry: entry} do # rubocop:disable Metrics/LineLength
    #xml = File.read("#{File.dirname(__FILE__)}/../../sample_feeds/PaulDixExplainsNothingAlternate.xml") # rubocop:disable Metrics/LineLength
    #entry = Feedjira::Parser::AtomFeedBurner.parse(xml).entries.first
    #expect(entry.url).to eq("http://feeds.feedburner.com/~r/PaulDixExplainsNothing/~3/519925023/making-a-ruby-c-library-even-faster.html") # rubocop:disable Metrics/LineLength
  end

  test "should parse the url", %{entry: entry} do
    assert entry.url == "http://www.pauldix.net/2009/01/making-a-ruby-c-library-even-faster.html"
  end

  @tag :pending
  test "should parse the url when there is no alternate", %{entry: entry} do
    #xml = File.read("#{File.dirname(__FILE__)}/../../sample_feeds/FeedBurnerUrlNoAlternate.xml") # rubocop:disable Metrics/LineLength
    #entry = Feedjira::Parser::AtomFeedBurner.parse(xml).entries.first
    #expect(entry.url).to eq "http://example.com/QQQQ.html"
  end

  test "should parse the author", %{entry: entry} do
    assert entry.author == "Paul Dix"
  end

  test "should parse the content", %{entry: entry} do
    assert entry.content == load_sample_feedburner_atom_entry_content
  end

  test "should provide a summary", %{entry: entry} do
    summary = "Last week I released the first version of a SAX based XML parsing library called SAX-Machine. It uses Nokogiri, which uses libxml, so it's pretty fast. However, I felt that it could be even faster. The only question was how..." # rubocop:disable Metrics/LineLength
    assert entry.summary == summary
  end

  @tag :pending
  test "should parse the published date", %{entry: entry} do
    #published = Time.parse_safely "Thu Jan 22 15:50:22 UTC 2009"
    #expect(entry.published).to eq published
  end

  @tag :pending
  test "should parse the categories", %{entry: entry} do
    assert entry.categories == ["Ruby", "Another Category"]
  end
end
