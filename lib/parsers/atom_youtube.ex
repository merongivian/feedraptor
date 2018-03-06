defmodule Feedraptor.Parser.AtomYoutube do
  use Capuli

  element :title
  element :link, as: :url, value: :href, with: [rel: "alternate"]
  element :link, as: :feed_url, value: :href, with: [rel: "self"]
  element :name, as: :author
  element :"yt:channelid", as: :youtube_channel_id

  elements :entry, as: :entries, module: Feedraptor.Parser.AtomYoutube.Entry

  defmodule Entry do
    alias Feedraptor.Helper

    defmodule Definition do
      use Capuli

      element :title
      element :link, as: :url, value: :href, with: [rel: "alternate"]
      element :name, as: :author
      element :"media:description", as: :content
      element :summary
      element :published
      element :id, as: :entry_id
      element :updated
      element :"yt:videoid", as: :youtube_video_id
      element :"media:title", as: :media_title
      element :"media:content", as: :media_url, value: :url
      element :"media:content", as: :media_type, value: :type
      element :"media:content", as: :media_width, value: :width
      element :"media:content", as: :media_height, value: :height
      element :"media:thumbnail", as: :media_thumbnail_url, value: :url
      element :"media:thumbnail", as: :media_thumbnail_width, value: :width
      element :"media:thumbnail", as: :media_thumbnail_height, value: :height
      element :"media:starrating", as: :media_star_count, value: :count
      element :"media:starrating", as: :media_star_average, value: :average
      element :"media:statistics", as: :media_views, value: :views
    end

    def parse(raw_entry) do
      raw_entry
      |> Definition.parse()
      |> Helper.update_date_fields()
    end
  end

  def will_parse?(xml) do
    xml =~ ~r{xmlns:yt="http://www.youtube.com/xml/schemas/2015"}
  end
end
