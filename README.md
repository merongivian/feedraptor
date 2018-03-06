# Feedraptor

[![Build Status](https://travis-ci.org/merongivian/feedraptor.svg?branch=master)](https://travis-ci.org/merongivian/feedraptor/)

Feedraptor is an Elixir library for parsing feeds, inspired by Ruby's [Feedjira](https://github.com/feedjira/feedjira). Parsing is done in pure
Elixir thanks to [Floki](https://github.com/philss/floki)

## Installation

The package can be installed by adding `Feedraptor` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:feedraptor, "~> 0.1.0"}
  ]
end
```

## Usage

```elixir
"https://spectrum.ieee.org/rss/blog/automaton/fulltext"
|> HTTPoison.get!() #You could use other alternatives like Tesla, HTTPotion, HTTPipe, etc.
|> Map.get(:body)
|> Feedraptor.parse()

# Parsed Feed

%{
  image: %{},
  title: "IEEE Spectrum Automaton Blog",
  url: "https://spectrum.ieee.org/blog/automaton",
  version: "2.0"
  entries: [
    %{
      author: "Evan Ackerman",
      categories: ["Robotics", "Robotics/Industrial_Robots"],
      content: "<?xml version=\"1.0\" encoding=\"UTF-8\"?><html>\..."
      entry_id: "https://spectrum.ieee.org/automaton/robotics/industrial-robots/doxel-ai-startup-using-lidar-equipped-robots-on-construction-sites",
      image: "https://spectrum.ieee.org/image/MzAxMTA5Ng.jpeg",
      published: #DateTime<2018-01-24 20:15:00+00:00 GMT GMT>,
      summary: "Doxel's lidar-equipped robots help track construction projects and catch mistakes as they happen",
      title: "AI Startup Using Robots and Lidar to Boost Productivity on Construction Sites",
      updated: nil,
      url: "https://spectrum.ieee.org/automaton/robotics/industrial-robots/doxel-ai-startup-using-lidar-equipped-robots-on-construction-sites"
    },
    %{author: "..", ...},
    %{author: "..", ...}
    ...
  ]
```

## Supported Feeds

* RSS
* RSS FeedBurner
* Atom
* Atom FeedBurner
* Atom Youtube
* Google Docs Atom
* Itunes RSS
* JSON Feed ----**COMING SOON**---- 😅

## Why [feedraptor]( https://github.com/merongivian/Feedraptor) instead of [feeder_ex](https://github.com/manukall/feeder_ex) ?

`feeder_ex` is a wrapper for Erlang's `feeder`. Feeder has support for a limited type
of feeds and doesn't parse all entrie's fields (like content)

## Why [floki](https://github.com/philss/floki) instead of [xmerl](https://github.com/erlang-labs/xmerl) ?

There a couple of good libraries that use `xmerl` and do a great job parsing
xml, like [Quinn](https://github.com/nhu313/Quinn). The problem with `xmerl` is
that it crashes when it receives a malformed XML. This is not ideal when fetching a bunch of
feeds that might be malformed, and crawling those trough OTP.

Also xmerl is build in Erlang. Parsing trough Floki requires a little bit more work but at least i'm using Elixir,
so i know what to expect if something goes wrong.

