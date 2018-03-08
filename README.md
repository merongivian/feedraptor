# Feedraptor

[![Build Status](https://travis-ci.org/merongivian/feedraptor.svg?branch=master)](https://travis-ci.org/merongivian/feedraptor/)

Feedraptor is an Elixir library for parsing feeds, inspired by Ruby's [Feedjira](https://github.com/feedjira/feedjira). Parsing is done in pure
Elixir thanks to [Capuli](https://github.com/merongivian/capuli)

## Installation

The package can be installed by adding `Feedraptor` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:feedraptor, "~> 0.2.0"}
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
      entry_id: "https://spectrum.ieee.org/automaton/robotics/industrial-robots/doxel...",
      image: "https://spectrum.ieee.org/image/MzAxMTA5Ng.jpeg",
      published: #DateTime<2018-01-24 20:15:00+00:00 GMT GMT>,
      summary: "Doxel's lidar-equipped robots help track construction projects and catch...",
      title: "AI Startup Using Robots and Lidar to Boost Productivity on Construction Sites",
      updated: nil,
      url: "https://spectrum.ieee.org/automaton/robotics/industrial-robots/doxel-ai-startup-..."
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

## Supported Feed/Entry properties

Depends on the type of feed, for more info of supported attributes check the [hex docs](https://hexdocs.pm/feedraptor/0.2.0/api-reference.html)

## Credits

After i started this i found a similar library: [elixir feed parser](https://github.com/fdietz/elixir-feed-parser), i took
some ideas from here, particularly date parsing. I will also like to mention [feeder_ex](https://github.com/manukall/feeder_ex) and
[quinn](https://github.com/nhu313/Quinn)

## Tasks

- [x] Basic Parsers
- [ ] JSON Parser
- [ ] Ability for adding custom parsers
- [ ] **Maybe** Add elements to an existing parser (modify a parser)

## License

Feedraptor is under MIT license. Check the `LICENSE` file for more details.
