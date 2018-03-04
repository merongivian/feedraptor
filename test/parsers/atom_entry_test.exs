defmodule Feedraptor.Parser.AtomEntryTest do
  import Feedraptor.SampleFeeds

  use ExUnit.Case, async: true

  setup do
    entry = Feedraptor.Parser.Atom.parse(load_sample_atom_feed()).entries
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
    assert entry.content == load_sample_atom_entry_content()
  end

  test "should provide a summary", %{entry: entry} do
    assert entry.summary == "Late last year an entrepreneur from Turkey visited me at Amazon HQ in Seattle. We talked about his plans to use AWS as part of his new social video portal startup. I won't spill any beans before he's ready to..." # rubocop:disable Metrics/LineLength
  end

  test "should parse the published date", %{entry: entry} do
    assert entry.published.year  == 2009
    assert entry.published.month == 1
    assert entry.published.day   == 16
  end

  test "should parse the categories", %{entry: entry} do
    assert entry.categories == ~w(Turkey Seattle)
  end

  test "should parse the updated date", %{entry: entry} do
    assert entry.updated.year  == 2009
    assert entry.updated.month == 1
    assert entry.updated.day   == 16
  end

  test "should parse the id", %{entry: entry} do
    assert entry.entry_id == "tag:typepad.com,2003:post-61484736"
  end
end
