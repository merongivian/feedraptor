defmodule Feedraptor.Parser.ItunesRSS.ItemTest do
  import Feedraptor.SampleFeeds

  use ExUnit.Case, async: true

  setup do
    item = Feedraptor.Parser.ItunesRSS.parse(load_sample_itunes_feed()).entries
           |> List.first

    {:ok, item: item}
  end

  test "should parse the title", %{item: item} do
    assert item.title == "Shake Shake Shake Your Spices"
  end

  test "should parse the itunes title", %{item: item} do
    assert item.itunes_title == "Shake Shake Shake Your Spices"
  end

  test "should parse the author", %{item: item} do
    assert item.itunes_author == "John Doe"
  end

  test "should parse the subtitle", %{item: item} do
    assert item.itunes_subtitle == "A short primer on table spices"
  end

  test "should parse the summary", %{item: item} do
    summary = "This week we talk about salt and pepper shakers, comparing and contrasting pour rates, construction materials, and overall aesthetics. Come and join the party!" # rubocop:disable Metrics/LineLength
    assert item.itunes_summary == summary
  end

  test "should parse the itunes season", %{item: item} do
    assert item.itunes_season == "1"
  end

  test "should parse the itunes episode number", %{item: item} do
    assert item.itunes_episode == "3"
  end

  test "should parse the itunes episode type", %{item: item} do
    assert item.itunes_episode_type == "full"
  end

  test "should parse the enclosure", %{item: item} do
    assert item.enclosure_length == "8727310"
    assert item.enclosure_type == "audio/x-m4a"
    assert item.enclosure_url == "http://example.com/podcasts/everything/AllAboutEverythingEpisode3.m4a"
  end

  test "should parse the guid as id", %{item: item} do
    assert item.entry_id == "http://example.com/podcasts/archive/aae20050615.m4a"
  end

  test "should parse the published date", %{item: item} do
    assert item.published.year  == 2005
    assert item.published.month == 6
    assert item.published.day   == 15
  end

  test "should parse the duration", %{item: item} do
    assert item.itunes_duration == "7:04"
  end

  test "should parse the keywords", %{item: item} do
    assert item.itunes_keywords == "salt, pepper, shaker, exciting"
  end

  test "should parse the image", %{item: item} do
    assert item.itunes_image == "http://example.com/podcasts/everything/AllAboutEverything.jpg"
  end

  test "should parse the order", %{item: item} do
    assert item.itunes_order == "12"
  end

  test "should parse the closed captioned flag", %{item: item} do
    assert item.itunes_closed_captioned == "yes"
  end

  test "should parse the encoded content", %{item: item} do
    content = "<p><strong>TOPIC</strong>: Gooseneck Options</p>"
    assert item.content == content
  end
end
