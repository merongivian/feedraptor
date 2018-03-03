defmodule Exfeed.Parser.AtomYoutubeEntryTest do
  import Exfeed.SampleFeeds

  use ExUnit.Case, async: true

  setup do
    entry = Exfeed.Parser.AtomYoutube.parse(load_sample_youtube_atom_feed).entries
            |> List.first

    {:ok, entry: entry}
  end

  test "should have the title", %{entry: entry} do
    assert entry.title == "The Google app: Questions Title"
  end

  test "should have the url", %{entry: entry} do
    assert entry.url == "http://www.youtube.com/watch?v=5shykyfmb28"
  end

  test "should have the entry id", %{entry: entry} do
    assert entry.entry_id == "yt:video:5shykyfmb28"
  end

  @tag :pending
  test "should have the published date", %{entry: entry} do
    #expect(entry.published).to eq Time.parse_safely("2015-05-04T00:01:27+00:00")
  end

  @tag :pending
  test "should have the updated date", %{entry: entry} do
    #expect(entry.updated).to eq Time.parse_safely("2015-05-13T17:38:30+00:00")
  end

  test "should have the content populated from the media:description element", %{entry: entry} do
    assert entry.content == "A question is the most powerful force in the world. It can start you on an adventure or spark a connection. See where a question can take you. The Google app is available on iOS and Android. Download the app here: http://www.google.com/search/about/download"
  end

  # TODO: return nil also when key doesnt exist in map
  @tag :pending
  test "should have the summary but blank", %{entry: entry} do
    assert entry.summary == nil
  end

  test "should have the custom youtube video id", %{entry: entry} do
    assert entry.youtube_video_id == "5shykyfmb28"
  end

  test "should have the custom media title", %{entry: entry} do
    assert entry.media_title == "The Google app: Questions"
  end

  test "should have the custom media url", %{entry: entry} do
    assert entry.media_url == "https://www.youtube.com/v/5shykyfmb28?version=3"
  end

  test "should have the custom media type", %{entry: entry} do
    assert entry.media_type == "application/x-shockwave-flash"
  end

  test "should have the custom media width", %{entry: entry} do
    assert entry.media_width == "640"
  end

  test "should have the custom media height", %{entry: entry} do
    assert entry.media_height == "390"
  end

  test "should have the custom media thumbnail url", %{entry: entry} do
    assert entry.media_thumbnail_url == "https://i2.ytimg.com/vi/5shykyfmb28/hqdefault.jpg"
  end

  test "should have the custom media thumbnail width", %{entry: entry} do
    assert entry.media_thumbnail_width == "480"
  end

  test "should have the custom media thumbnail height", %{entry: entry} do
    assert entry.media_thumbnail_height == "360"
  end

  test "should have the custom media star count", %{entry: entry} do
    assert entry.media_star_count == "3546"
  end

  test "should have the custom media star average", %{entry: entry} do
    assert entry.media_star_average == "4.79"
  end

  test "should have the custom media views", %{entry: entry} do
    assert entry.media_views == "251497"
  end
end
