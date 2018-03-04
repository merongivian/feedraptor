defmodule Feedraptor.Parser.ItunesRSS do
  alias Feedraptor.Parser.XML
  use XML

  # RSS 2.0 elements that need including
  element :copyright
  element :description
  element :image, module: Feedraptor.Parser.RSSImage
  element :language
  element :lastbuilddate, as: :last_built
  element :link, as: :url
  element :managingeditor
  element :rss, as: :version, value: :version
  element :title
  element :ttl

  # If author is not present use managingEditor on the channel
  element :"itunes:author", as: :itunes_author
  element :"itunes:block", as: :itunes_block
  element :"itunes:image", value: :href, as: :itunes_image
  element :"itunes:explicit", as: :itunes_explicit
  element :"itunes:complete", as: :itunes_complete
  element :"itunes:keywords", as: :itunes_keywords
  element :"itunes:type", as: :itunes_type

  # New URL for the podcast feed
  element :"itunes:new_feed_url", as: :itunes_new_feed_url
  element :"itunes:subtitle", as: :itunes_subtitle

  # If summary is not present, use the description tag
  element :"itunes:summary", as: :itunes_summary

  # iTunes RSS feeds can have multiple main categories and multiple
  # sub-categories per category.
  #elements :"itunes:category", as: :_itunes_categories, module: Feedraptor.Parser.ItunesRSS.Category
  elements :"itunes:category", as: :itunes_categories, value: :text

  elements :"itunes:owner", as: :itunes_owners, class: Feedraptor.Parser.ItunesRSS.Owner
  elements :item, as: :entries, module: Feedraptor.Parser.ItunesRSS.Item

  defmodule Owner do
    use XML

    element :"itunes:name", as: :name
    element :"itunes:email", as: :email
  end

  defmodule Item do
    @date_format "RFC_1123"
    alias Feedraptor.Helper

    defmodule Definition do
      use XML

      element :author
      element :guid, as: :entry_id
      element :title
      element :link, as: :url
      element :description, as: :summary
      element :"content:encoded", as: :content
      element :pubdate, as: :published

      # If author is not present use author tag on the item
      element :"itunes:author", as: :itunes_author
      element :"itunes:block", as: :itunes_block
      element :"itunes:duration", as: :itunes_duration
      element :"itunes:explicit", as: :itunes_explicit
      element :"itunes:keywords", as: :itunes_keywords
      element :"itunes:subtitle", as: :itunes_subtitle
      element :"itunes:image", value: :href, as: :itunes_image
      element :"itunes:isclosedcaptioned", as: :itunes_closed_captioned
      element :"itunes:order", as: :itunes_order
      element :"itunes:season", as: :itunes_season
      element :"itunes:episode", as: :itunes_episode
      element :"itunes:title", as: :itunes_title
      element :"itunes:episodetype", as: :itunes_episode_type

      # If summary is not present, use the description tag
      element :"itunes:summary", as: :itunes_summary
      element :enclosure, value: :length, as: :enclosure_length
      element :enclosure, value: :type, as: :enclosure_type
      element :enclosure, value: :url, as: :enclosure_url
      #elements "psc:chapter", as: :raw_chapters, class: Feedjira::Parser::PodloveChapter
    end

    def parse(raw_entry) do
      raw_entry
      |> Definition.parse()
      |> Helper.update_date_fields(format: @date_format)
    end
  end
end
