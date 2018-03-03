defmodule Feedraptor.Parser.GoogleDocsAtomEntryTest do
  import Feedraptor.SampleFeeds

  use ExUnit.Case, async: true

  setup do
    entry = Feedraptor.Parser.GoogleDocsAtom.parse(load_sample_google_docs_list_feed()).entries
            |> List.first

    {:ok, entry: entry}
  end

  test "should have the custom checksum element", %{entry: entry} do
    assert entry.checksum == "2b01142f7481c7b056c4b410d28f33cf"
  end

  test "should have the custom filename element", %{entry: entry} do
    assert entry.original_filename == "MyFile.pdf"
  end

  test "should have the custom suggested filename element", %{entry: entry} do
    assert entry.suggested_filename == "TaxDocument.pdf"
  end
end
