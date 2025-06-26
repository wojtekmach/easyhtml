# CHANGELOG

## v0.4.0 (2025-06-26)

  * Use LazyHTML.

  * Add `EasyHTML.from_document/1` and `EasyHTML.from_fragment/1`.

  * Deprecate `EasyHTML.parse!/1`.

  * Deprecate `EasyHTML.to_string/1`.

  * Deprecate `String.Chars` implementation for `EasyHTML`.

  * Remove ability to match e.g.: `~HTML[<p>...</p>] = ...`

## v0.3.1 (2023-12-11)

  * Make comparisons work for nested tags

## v0.3.0 (2023-06-01)

  * Add `~HTML` sigil

## v0.2.0 (2023-05-19)

  * `doc[selector]` now returns `nil` if no nodes were found.

## v0.1.1 (2022-12-22)

  * Relax Floki dependency.

## v0.1.0 (2022-08-24)

  * Initial release.
