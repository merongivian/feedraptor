defmodule Feedraptor.Parser.ItunesRSSTest do
  import Feedraptor.SampleFeeds

  use ExUnit.Case, async: true

  setup do
    feed = Feedraptor.Parser.ItunesRSS.parse(load_sample_itunes_feed())

    {:ok, feed: feed}
  end

  test "should parse the ttl", %{feed: feed} do
    assert feed.ttl == "60"
  end

  test "should parse the last build date", %{feed: feed} do
    assert feed.last_built == "Sat, 07 Sep 2002 09:42:31 GMT"
  end

  test "should parse the subtitle", %{feed: feed} do
    assert feed.itunes_subtitle == "A show about everything"
  end

  test "should parse the author", %{feed: feed} do
    assert feed.itunes_author == "John Doe"
  end

  test "should parse an owner", %{feed: feed} do
    assert Enum.count(feed.itunes_owners) == 1
  end

  test "should parse an image", %{feed: feed} do
    assert feed.itunes_image == "http://example.com/podcasts/everything/AllAboutEverything.jpg"
  end

  test "should parse the image url", %{feed: feed} do
    assert feed.image.url == "http://example.com/podcasts/everything/AllAboutEverything.jpg"
  end

  test "should parse the image title", %{feed: feed} do
    assert feed.image.title == "All About Everything"
  end

  test "should parse the image link", %{feed: feed} do
    assert feed.image.link == "http://www.example.com/podcasts/everything/index.html"
  end

  test "should parse the image width", %{feed: feed} do
    assert feed.image.width == "88"
  end

  test "should parse the image height", %{feed: feed} do
    assert feed.image.height == "31"
  end

  test "should parse the image description", %{feed: feed} do
    description = "All About Everything is a show about everything. Each week we dive into any subject known to man and talk about it as much as we can. Look for our Podcast in the iTunes Music Store" # rubocop:disable Metrics/LineLength
    assert feed.image.description == description
  end

  test "should parse categories", %{feed: feed} do
    assert feed.itunes_categories == [
      "Technology",
      "Gadgets",
      "TV & Film",
      "Arts",
      "Design",
      "Food",
    ]

    #TODO
    #assert feed.itunes_category_paths == [
      #~s(Technology Gadgets),
      #["TV & Film"],
      #~s(Arts Design),
      #~s(Arts Food),
    #]
  end

  test "should parse the itunes type", %{feed: feed} do
    assert feed.itunes_type == "episodic"
  end

  test "should parse the summary", %{feed: feed} do
    summary = "All About Everything is a show about everything. Each week we dive into any subject known to man and talk about it as much as we can. Look for our Podcast in the iTunes Music Store" # rubocop:disable Metrics/LineLength
    assert feed.itunes_summary == summary
  end

  test "should parse the complete tag", %{feed: feed} do
    assert feed.itunes_complete == "yes"
  end

  test "should parse entries", %{feed: feed} do
    assert Enum.count(feed.entries) == 3
  end

  test "should parse the new-feed-url", %{feed: feed} do
    assert feed.itunes_new_feed_url == "http://example.com/new.xml"
  end
end
