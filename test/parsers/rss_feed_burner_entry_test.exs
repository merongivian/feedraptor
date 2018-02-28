defmodule Exfeed.Parser.RssFeedBurnerEntryTest do
  import Exfeed.SampleFeeds

  use ExUnit.Case, async: true

  setup do
    entry = Exfeed.Parser.RSSFeedBurner.parse(load_sample_rss_feed_burner_feed).entries
            |> List.first

    {:ok, entry: entry}
  end

  test "should parse the title", %{entry: entry} do
    title = "Angie’s List Sets Price Range IPO At $11 To $13 Per Share; Valued At Over $600M" # rubocop:disable Metrics/LineLength
    assert entry.title == title
  end

  test "should parse the original url", %{entry: entry} do
    assert entry.url == "http://techcrunch.com/2011/11/02/angies-list-prices-ipo-at-11-to-13-per-share-valued-at-over-600m/" # rubocop:disable Metrics/LineLength
  end

  test "should parse the author", %{entry: entry} do
    assert entry.author == "Leena Rao"
  end

  test "should parse the content", %{entry: entry} do
    assert entry.content == load_sample_rss_feed_burner_entry_content
  end

  test "should provide a summary", %{entry: entry} do
    assert entry.summary == load_sample_rss_feed_burner_entry_description
  end

  @tag :pending
  test "should parse the published date", %{entry: entry} do
    #published = Time.parse_safely "Wed Nov 02 17:25:27 UTC 2011"
    #assert entry.published == published
  end

  test "should parse the categories", %{entry: entry} do
    assert entry.categories == ["TC", "angie\\'s list"]
  end

  test "should parse the guid as id", %{entry: entry} do
    assert entry.entry_id == "http://techcrunch.com/?p=446154"
  end
end
