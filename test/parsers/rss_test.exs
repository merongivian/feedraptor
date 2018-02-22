defmodule Exfeed.Parser.RssTest do
  import Exfeed.SampleFeeds

  use ExUnit.Case, async: true

  test "checking files" do
    assert load_sample_rss_feed == "something"
  end
end
