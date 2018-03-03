defmodule Feedjira.Parser.RSS.EntryTest do
  import Feedraptor.SampleFeeds

  use ExUnit.Case, async: true

  setup do
    entry = Feedraptor.Parser.RSS.parse(load_sample_rss_feed()).entries |> List.first
    {:ok, entry: entry}
  end

  test "parsing the title", %{entry: entry} do
    assert entry.title == "Nokogiri’s Slop Feature"
  end

  test "parsing the url", %{entry: entry} do
    assert entry.url == "http://tenderlovemaking.com/2008/12/04/nokogiris-slop-feature/"
  end

  test "parsing the author", %{entry: entry} do
    assert entry.author == "Aaron Patterson"
  end

  test "parsing the content", %{entry: entry} do
    assert entry.content == load_sample_rss_entry_content()
  end

  test "should provide a summary", %{entry: entry} do
    summary = "Oops!  When I released nokogiri version 1.0.7, I totally forgot to talk about Nokogiri::Slop() feature that was added.  Why is it called \"slop\"?  It lets you sloppily explore documents.  Basically, it decorates your document with method_missing() that allows you to search your document via method calls.\nGiven this document:\n\ndoc = Nokogiri::Slop&#40;&#60;&#60;-eohtml&#41;\n&#60;html&#62;\n&#160; &#60;body&#62;\n&#160; [...]" # rubocop:disable Metrics/LineLength
    assert entry.summary == summary
  end

  @tag :pending
  test "parsing the published date", %{entry: entry} do
    #published = Time.parse_safely "Thu Dec 04 17:17:49 UTC 2008"
    #assert entry.published == published
  end

  test "parsing the categories", %{entry: entry} do
    assert entry.categories == ~w(computadora nokogiri rails)
  end

  test "parsing the guid as id", %{entry: entry} do
    assert entry.entry_id == "http://tenderlovemaking.com/?p=198"
  end
end
