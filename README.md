# EasyHTML

[![Version](https://img.shields.io/hexpm/v/easyhtml.svg)](https://hex.pm/packages/easyhtml)
[![CI](https://github.com/wojtekmach/easyhtml/actions/workflows/ci.yml/badge.svg)](https://github.com/wojtekmach/easyhtml/actions/workflows/ci.yml)

EasyHTML makes working with HTML easy.

It is a tiny wrapper around [Floki](https://hex.pm/packages/floki) that adds
conveniences for HTML nodes:

  * An `Inspect` implementation to pretty-print them
  * An `Access` implementation to search them
  * A `String.Chars` implementation to convert them to text

## Usage

```elixir
Mix.install([
  {:easyhtml, "~> 0.3.0"}
])

doc = EasyHTML.parse!("<p>Hello, <em>world</em>!</p>")
#=> ~HTML[<p>Hello, <em>world</em>!</p>]

doc["em"]
#=> ~HTML[<em>world</em>]

to_string(doc)
#=> "Hello, world!"
```
