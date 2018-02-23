defmodule Exfeed.SampleFeeds do
  @feeds [
    sample_rss_feed:          "TenderLovemaking.xml",
    sample_atom_feed:         "AmazonWebServicesBlog.xml",
    sample_rss_entry_content: "TenderLovemakingFirstEntry.xml"
  ]

  Enum.each @feeds, fn({sample_name, sample_file}) ->
    def unquote(:"load_#{sample_name}")() do
      File.read! "test/sample_feeds/#{unquote(sample_file)}"
    end
  end
end
