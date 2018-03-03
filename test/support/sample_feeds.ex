defmodule Exfeed.SampleFeeds do
  @feeds [
    sample_atom_middleman_feed:               "FeedjiraBlog.xml",
    sample_atom_feed:                         "AmazonWebServicesBlog.xml",
    sample_atom_entry_content:                "AmazonWebServicesBlogFirstEntryContent.xml",
    sample_atom_hub:                          "SamRuby.xml",
    sample_atom_url:                          "atom_with_link_tag_for_url_unmarked.xml",
    sample_feedburner_atom_feed:              "PaulDixExplainsNothing.xml",
    sample_feedburner_atom_feed_alternate:    "GiantRobotsSmashingIntoOtherGiantRobots.xml",
    sample_feedburner_atom_entry_content:     "PaulDixExplainsNothingFirstEntryContent.xml",
    sample_youtube_atom_feed:                 "youtube_atom.xml",
    sample_google_docs_list_feed:             "GoogleDocsList.xml",
    sample_itunes_feed:                       "itunes.xml",
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
