# ReadingTime

[![Hex pm](https://img.shields.io/hexpm/v/reading_time.svg?style=flat&color=78529a)](https://hex.pm/packages/reading_time)
[![Build Status](https://travis-ci.com/iaguirre88/reading_time.svg?branch=master)](https://travis-ci.com/iaguirre88/reading_time)

---

Medium's like reading time estimation for Elixir.
ReadingTime helps you estimate how long a text will take to be read.

This is based on [reading-time](https://github.com/ngryman/reading-time) for
JavaScript.

## Installation

This package can be installed by adding `reading_time` to your list of
dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:reading_time, "~> 0.1.0"}
  ]
end
```

## Usage

```elixir
ReadingTime.time("this is a random text")
# 1

ReadingTime.time("this_is_a-random-text",
  words_per_minute: 1,
  split_pattern: ["_", "-"]
)
# 5
```

The docs can be found at [https://hexdocs.pm/reading_time](https://hexdocs.pm/reading_time).
