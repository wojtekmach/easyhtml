# EasyHTML

[![Version](https://img.shields.io/hexpm/v/easyhtml.svg)](https://hex.pm/packages/easyhtml)
[![CI](https://github.com/wojtekmach/easyhtml/actions/workflows/ci.yml/badge.svg)](https://github.com/wojtekmach/easyhtml/actions/workflows/ci.yml)

EasyHTML makes working with HTML easy.

EasyHTML uses [LazyHTML](https://hex.pm/packages/lazy_html).

## Usage

```elixir
Mix.install([
  {:easyhtml, "~> 0.4.0-dev", github: "wojtekmach/easyhtml"}
])

doc = EasyHTML.from_fragment("<p>Hello, <em>world</em>!</p>")
#=> ~HTML[<p>Hello, <em>world</em>!</p>]

doc["em"]
#=> ~HTML[<em>world</em>]

import EasyHTML, only: :sigils
doc = ~HTML[<ul><li>foo</li><li>bar</li></ul>]
Enum.to_list(doc["li"])
#=> [~HTML[<li>foo</li>], ~HTML[<li>bar</li>]]
```
