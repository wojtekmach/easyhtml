defmodule EasyHTMLTest do
  use ExUnit.Case, async: true

  test "it works" do
    html = """
    <!doctype html>
    <html>
    <body>
      <p class="headline">Hello, World!</p>
    </body>
    </html>
    """

    doc = EasyHTML.parse!(html)

    assert inspect(doc) ==
             ~s|#EasyHTML[<html><body><p class="headline">Hello, World!</p></body></html>]|

    assert inspect(doc["p.headline"]) ==
             ~s|#EasyHTML[<p class="headline">Hello, World!</p>]|

    assert to_string(doc) == "Hello, World!"
  end
end
