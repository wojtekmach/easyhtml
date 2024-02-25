defmodule EasyHTMLTest do
  use ExUnit.Case, async: true
  import EasyHTML, only: [sigil_HTML: 2]

  test "it works" do
    html = ~HTML"""
    <!doctype html>
    <html>
    <body>
      <p class="headline">Hello, World!</p>
    </body>
    </html>
    """

    assert inspect(html) ==
             ~s|~HTML[<html><body><p class="headline">Hello, World!</p></body></html>]|

    assert inspect(html["p.headline"]) ==
             ~s|~HTML[<p class="headline">Hello, World!</p>]|

    assert ~HTML[<p class="headline">Hello, World!</p>] = html["p.headline"]
    assert ~HTML[<p>Hello, World!</p>] = html["p.headline"]

    refute html["#bad"]

    assert to_string(html) == "Hello, World!"
  end

  test "nested attributes work" do
    html = ~HTML"""
    <!doctype html>
    <html>
    <body>
      <p class="headline"><span class="abc">Hello, World!</span></p>
    </body>
    </html>
    """

    assert inspect(html) ==
             ~s|~HTML[<html><body><p class="headline"><span class="abc">Hello, World!</span></p></body></html>]|

    assert inspect(html["p.headline"]) ==
             ~s|~HTML[<p class="headline"><span class="abc">Hello, World!</span></p>]|

    assert ~HTML[<p class="headline"><span class="abc">Hello, World!</span></p>] =
             html["p.headline"]

    assert ~HTML[<p><span>Hello, World!</span></p>] = html["p.headline"]

    refute html["#bad"]

    assert to_string(html) == "Hello, World!"
  end

  @tag :skip
  test "inspect" do
    html = ~HTML[<p id="p1">Hello, <em>world</em>!</p>]
    assert inspect(html) == ~s|~HTML[<p id="p1">Hello, <em>world</em>!</p>]|
  end

  test "enumarble" do
    html = ~HTML[
      <table>
        <tr>
          <td>A</td>
          <td>1</td>
        </tr>
        <tr>
          <td>B</td>
          <td>2</td>
        </tr>
      </table>
    ]

    result =
      for tr <- html["tr"], td <- tr["td"] do
        assert is_struct(tr, EasyHTML)
        assert is_struct(td, EasyHTML)
        to_string(td)
      end

    assert result == ["A", "1", "B", "2"]
  end
end
