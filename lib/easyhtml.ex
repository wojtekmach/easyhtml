defmodule EasyHTML do
  @moduledoc """
  EasyHTML makes working with HTML easy.

  ## Examples

      EasyHTML.from_fragment("<p>Hello, <em>world</em>!</p>")
      #=> ~HTML[<p>Hello, <em>world</em> !</p>]

      doc["em"]
      #=> ~HTML[<em>world</em>]

      import EasyHTML, only: :sigils
      doc = ~HTML[<ul><li>foo</li><li>bar</li></ul>]
      Enum.to_list(doc["li"])
      #=> [~HTML[<li>foo</li>], ~HTML[<li>bar</li>]]
  """

  defstruct [:lazy]

  @doc """
  Handles the `~HTML` sigil to create an EasyHTML struct.

  ## Examples

      ~HTML[<p>Hello, <em>World</em>!</p>]
  """
  defmacro sigil_HTML(string, modifiers)

  defmacro sigil_HTML({:<<>>, _, [binary]}, []) do
    quote do
      EasyHTML.from_fragment(unquote(binary))
    end
  end

  @doc """
  Parses an HTML document.

  ## Examples

      iex> EasyHTML.from_document("<p>Hello, <em>World</em>!</p>") |> EasyHTML.to_html()
      "<html><head></head><body><p>Hello, <em>World</em>!</p></body></html>"
  """
  def from_document(html) do
    html = String.trim(html)
    %__MODULE__{lazy: LazyHTML.from_document(html)}
  end

  @doc """
  Parses a segment of an HTML document.

  ## Examples

      iex> EasyHTML.from_fragment("<p>Hello, <em>World</em>!</p>") |> inspect()
      "~HTML[<p>Hello, <em>World</em> !</p>]"
  """
  def from_fragment(html) do
    html = String.trim(html)
    %__MODULE__{lazy: LazyHTML.from_fragment(html)}
  end

  @deprecated "Use from_document/1 or from_fragment/1 instead"
  def parse!(html) do
    %__MODULE__{lazy: LazyHTML.from_fragment(html)}
  end

  @doc false
  def fetch(%__MODULE__{} = struct, selector) when is_binary(selector) do
    with {:ok, lazy} <- LazyHTML.fetch(struct.lazy, selector) do
      {:ok, %__MODULE__{lazy: lazy}}
    end
  end

  @doc """
  Extracts text.

  ## Examples

      iex> EasyHTML.text(~HTML[<p>Hello, <em>World</em>!</p>])
      "Hello, World!"
  """
  def text(%__MODULE__{} = struct) do
    LazyHTML.text(struct.lazy)
  end

  @doc """
  Returns HTML string for the given EasyHTML struct.

    * `:skip_whitespace_nodes` - when `true`, ignores text nodes that
      consist entirely of whitespace, usually whitespace between tags.
      Defaults to `true`.

  ## Examples

      iex> EasyHTML.to_html(~HTML[<p>Hello, <em>World</em>!</p>])
      "<p>Hello, <em>World</em>!</p>"
  """
  def to_html(%__MODULE__{} = struct, options \\ []) do
    options = Keyword.put_new(options, :skip_whitespace_nodes, true)
    LazyHTML.to_html(struct.lazy, options)
  end

  @doc """
  Builds an Elixir tree data structure representing HTML data.

  ## Options

    * `:sort_attributes` - when `true`, attributes lists are sorted
      alphabetically by name. Defaults to `false`.

    * `:skip_whitespace_nodes` - when `true`, ignores text nodes that
      consist entirely of whitespace, usually whitespace between tags.
      Defaults to `true`.

  ## Examples

      iex> EasyHTML.to_tree(~HTML[<p>Hello, <em>World</em>!</p>])
      [{"p", [], ["Hello, ", {"em", [], ["World"]}, "!"]}]
  """
  def to_tree(%__MODULE__{} = struct, options \\ []) do
    options = Keyword.put_new(options, :skip_whitespace_nodes, true)
    LazyHTML.to_tree(struct.lazy, options)
  end

  @deprecated "Use text/1 instead"
  def to_string(%__MODULE__{} = struct) do
    LazyHTML.text(struct.lazy)
  end
end

defimpl Inspect, for: EasyHTML do
  import Inspect.Algebra

  def inspect(struct, opts) do
    open = "~HTML["
    close = "]"
    container_opts = [separator: "", break: :flex]

    container_doc(
      open,
      LazyHTML.to_tree(struct.lazy, skip_whitespace_nodes: true),
      close,
      opts,
      &fun/2,
      container_opts
    )
  end

  defp fun({tag, attributes, content}, opts) do
    tag_color = :map
    attribute_color = :map

    attributes =
      for {name, value} <- attributes do
        concat([
          color(" #{name}=", attribute_color, opts),
          color("\"#{value}\"", :string, opts)
        ])
      end
      |> concat()

    open =
      concat([
        color("<#{tag}", tag_color, opts),
        attributes,
        color(">", tag_color, opts)
      ])

    close = color("</#{tag}>", tag_color, opts)
    container_opts = [separator: "", break: :strict]
    container_doc(open, content, close, opts, &fun/2, container_opts)
  end

  defp fun({:comment, content}, opts) do
    color("<!-- #{content} -->", :comment, opts)
  end

  defp fun(string, opts) when is_binary(string) do
    color(String.trim(string), :string, opts)
  end

  defp fun(other, _opts) do
    raise inspect(other)
  end
end

defimpl Enumerable, for: EasyHTML do
  def count(struct), do: Enumerable.LazyHTML.count(struct.lazy)
  def member?(struct, item), do: Enumerable.LazyHTML.member?(struct.lazy, item)
  def slice(_struct), do: {:error, __MODULE__}

  def reduce(struct, acc, fun) do
    {nodes, _from_selector} = LazyHTML.NIF.nodes(struct.lazy)
    reduce_list(nodes, acc, fun)
  end

  def reduce_list(_list, {:halt, acc}, _fun), do: {:halted, acc}
  def reduce_list(list, {:suspend, acc}, fun), do: {:suspended, acc, &reduce_list(list, &1, fun)}
  def reduce_list([], {:cont, acc}, _fun), do: {:done, acc}

  def reduce_list([head | tail], {:cont, acc}, fun) do
    reduce_list(tail, fun.(%@for{lazy: head}, acc), fun)
  end
end

defimpl String.Chars, for: EasyHTML do
  def to_string(struct) do
    IO.warn(
      "String.Chars implementation for %EasyHTML{} is deprecated, use EasyHTML.text/1 instead",
      []
    )

    EasyHTML.text(struct)
  end
end
