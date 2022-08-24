# EasyHTML

EasyHTML makes working with HTML easy.

It is a tiny wrapper around [Floki](https://hex.pm/packages/floki) that adds
conveniences for HTML nodes:

  * An `Inspect` implementation to pretty-print them
  * An `Access` implementation to search them
  * A `String.Chars` implementation to convert them to text

## Usage

```elixir
Mix.install([
  {:easyhtml, "~> 0.1.0"}
])

doc = EasyHTML.parse!("<p>Hello, <em>world</em>!</p>")
#=> #EasyHTML[<p>Hello, <em>world</em>!</p>]

doc["em"]
#=> #EasyHTML[<em>world</em>]

to_string(doc)
#=> "Hello, world!"
```
