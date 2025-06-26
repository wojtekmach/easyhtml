# EasyHTML

[![Version](https://img.shields.io/hexpm/v/easyhtml.svg)](https://hex.pm/packages/easyhtml)
[![CI](https://github.com/wojtekmach/easyhtml/actions/workflows/ci.yml/badge.svg)](https://github.com/wojtekmach/easyhtml/actions/workflows/ci.yml)

EasyHTML makes working with HTML easy.

EasyHTML uses [LazyHTML](https://hex.pm/packages/lazy_html).

## Usage

```elixir
Mix.install([
  {:easyhtml, "~> 0.4.0"}
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

## License

Copyright (c) 2022 Wojtek Mach

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
