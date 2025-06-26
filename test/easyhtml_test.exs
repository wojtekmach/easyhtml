defmodule EasyHTMLTest do
  use ExUnit.Case, async: true
  import EasyHTML, only: [sigil_HTML: 2]
  doctest EasyHTML

  test "it works" do
    html =
      ~HTML"""
      <!doctype html>
      <html>
      <body>
        <p class="headline">Hello, World!</p>
      </body>
      </html>
      """

    assert EasyHTML.to_tree(html["p.headline"]) ==
             EasyHTML.to_tree(~HTML[<p class="headline">Hello, World!</p>])

    assert EasyHTML.to_tree(html["#bad"]) == []
  end

  test "inspect" do
    html = ~HTML[<p id="p1">Hello, <em>world</em>!</p>]
    assert inspect(html) == ~s|~HTML[<p id="p1">Hello, <em>world</em> !</p>]|
  end

  test "enumerable" do
    html =
      ~HTML"""
      <ul>
        <li><span>A</span><span>1</span></li>
        <li><span>B</span><span>2</span></li>
      </ul>
      """

    assert Enum.map(html, &EasyHTML.to_tree/1) == [EasyHTML.to_tree(html)]

    assert Enum.map(html["li"], &EasyHTML.to_tree/1) ==
             Enum.map(
               [
                 ~HTML[<li><span>A</span><span>1</span></li>],
                 ~HTML[<li><span>B</span><span>2</span></li>]
               ],
               &EasyHTML.to_tree/1
             )
  end
end
