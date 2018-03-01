defmodule Exfeed.Parser.AtomYoutube do
  alias Exfeed.Parser.XML
  use XML

  element :title
  #element :link, as: :url, value: :href, with: { rel: "alternate" }
  #element :link, as: :feed_url, value: :href, with: { rel: "self" }
  element :name, as: :author
  element :"yt:channelid", as: :youtube_channel_id

  elements :entry, as: :entries, module: Exfeed.Parser.AtomYoutube.Entry

  defmodule Entry do
    use XML

    element :title
    #element :link, as: :url, value: :href, with: { rel: "alternate" }
    element :name, as: :author
    element :"media:description", as: :content
    element :summary
    element :published
    element :id, as: :entry_id
    element :updated
    element :"yt:videoid", as: :youtube_video_id
    element :"media:title", as: :media_title
    #element :"media:content", as: :media_url, value: :url
    #element :"media:content", as: :media_type, value: :type
    #element :"media:content", as: :media_width, value: :width
    #element :"media:content", as: :media_height, value: :height
    #element :"media:thumbnail", as: :media_thumbnail_url, value: :url
    #element :"media:thumbnail", as: :media_thumbnail_width, value: :width
    #element :"media:thumbnail", as: :media_thumbnail_height, value: :height
    #element :"media:starRating", as: :media_star_count, value: :count
    #element :"media:starRating", as: :media_star_average, value: :average
    #element :"media:statistics", as: :media_views, value: :views
  end
end
