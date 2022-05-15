# EasyHTML

EasyHTML is a tiny wrapper around [Floki](https://hex.pm/packages/floki) that adds:

  * An `Inspect` implementation to pretty-print them
  * An `Access` implementation to search them
  * A `String.Chars` implementation to convert them to text

## Usage

```elixir
Mix.install([{:easyhtml, github: "wojtekmach/easyhtml"}])

doc = EasyHTML.parse!("<p>Hello, <em>world</em>!</p>")
#=> ~H[<p>Hello, <em>world</em>!</p>]

doc["em"]
#=> ~H[<em>world</em>]

to_string(doc)
#=> "Hello, world!"
```
