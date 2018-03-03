defmodule Exfeed.Parser.AtomEntryTest do
  import Exfeed.SampleFeeds

  use ExUnit.Case, async: true

  setup do
    entry = Exfeed.Parser.Atom.parse(load_sample_atom_feed).entries
            |> List.first

    {:ok, entry: entry}
  end

  test "should parse the title", %{entry: entry} do
    assert entry.title == "AWS Job: Architect & Designer Position in Turkey"
  end

  test "should parse the url", %{entry: entry} do
    assert entry.url == "http://aws.typepad.com/aws/2009/01/aws-job-architect-designer-position-in-turkey.html"
  end

  test "should parse the author", %{entry: entry} do
    assert entry.author == "AWS Editor"
  end

  test "should parse the content", %{entry: entry} do
    assert entry.content == load_sample_atom_entry_content
  end

  test "should provide a summary", %{entry: entry} do
    assert entry.summary == "Late last year an entrepreneur from Turkey visited me at Amazon HQ in Seattle. We talked about his plans to use AWS as part of his new social video portal startup. I won't spill any beans before he's ready to..." # rubocop:disable Metrics/LineLength
  end

  @tag :pending
  test "should parse the published date", %{entry: entry} do
    #published = Time.parse_safely "Fri Jan 16 18:21:00 UTC 2009"
    #expect(entry.published).to eq published
  end

  test "should parse the categories", %{entry: entry} do
    assert entry.categories == ~w(Turkey Seattle)
  end

  @tag :pending
  test "should parse the updated date", %{entry: entry} do
    #updated = Time.parse_safely "Fri Jan 16 18:21:00 UTC 2009"
    #expect(entry.updated).to eq updated
  end

  test "should parse the id", %{entry: entry} do
    assert entry.entry_id == "tag:typepad.com,2003:post-61484736"
  end
end
