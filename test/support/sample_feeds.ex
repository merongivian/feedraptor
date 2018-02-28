defmodule Exfeed.SampleFeeds do
  @feeds [
    sample_atom_middleman_feed:               "FeedjiraBlog.xml",
    sample_atom_feed:                         "AmazonWebServicesBlog.xml",
    sample_atom_entry_content:                "AmazonWebServicesBlogFirstEntryContent.xml",
    sample_rss_feed:                          "TenderLovemaking.xml",
    sample_rss_entry_content:                 "TenderLoveMakingFirstEntry.xml",
    sample_rss_feed_burner_feed:              "TechCrunch.xml",
    sample_rss_feed_burner_entry_content:     "TechCrunchFirstEntry.xml",
    sample_rss_feed_burner_entry_description: "TechCrunchFirstEntryDescription.xml"
  ]

  Enum.each @feeds, fn({sample_name, sample_file}) ->
    def unquote(:"load_#{sample_name}")() do
      File.read! "test/sample_feeds/#{unquote(sample_file)}"
    end
  end
end
