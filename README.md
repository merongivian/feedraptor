# Exfeed

DISCLAIMER: This is not ready yet

ExFeed is an Elixir library for parsing feeds, inspired by Ruby's [Feedjira](https://github.com/feedjira/feedjira). Parsing is done in pure
Elixir thanks to [Floki](https://github.com/philss/floki)

## Usage

```elixir
"http://www.rssboard.org/files/sample-rss-2.xml"
|> HTTPoison.get!() #You could use other alternatives like Tesla, HTTPotion, HTTPipe, etc.
|> Exfeed.parse()

# Parsed Feed

%Exfeed.Feed{
  title: "Liftoff News",
  url: "http://liftoff.msfc.nasa.gov/",
  description: "Liftoff to Space Exploration",
  language: "en-us",
  published: #DateTime<2018-02-21 14:00:14.362567Z>,
  built:, #DateTime<2018-02-21 14:00:14.362567Z>,
  entries: [
    %Exfeed.Entry{
      title: "Star City",
      link: "http://liftoff.msfc.nasa.gov/news/2003/news-starcity.asp",
      author: "John Doe",
      content: "<div>content</div>...",
      summary: "<div>summary</div>",
      published: #DateTime<2018-02-21 14:00:14.362567Z>
    },
    %Exfeed.Entry{..},
    ..
  ]
}
```

## Why [Exfeed]( https://github.com/merongivian/exfeed) instead of [FeederEx](https://github.com/manukall/feeder_ex) ?

`feeder_ex` is a wrapper for Erlang's `feeder`. Feeder has support for a limited type
of feeds and doesn't parse all entrie's fields (like content)

## Why [Floki](https://github.com/philss/floki) instead of [Xmerl](https://github.com/erlang-labs/xmerl) ?

There a couple of good libraries that use `xmerl` and do a great job parsing
xml, like [Quinn](https://github.com/nhu313/Quinn). The problem with `xmerl` is
that it boots an `application` which breaks when an invalid xml is passed, this is
not ideal when building retriable rss crawlers with OTP. Floki requires a little bit of more work to
parse but at least im using elixir, so i know what to expect if something goes wrong.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `exfeed` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:exfeed, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/exfeed](https://hexdocs.pm/exfeed).
