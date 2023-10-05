# swift_aoc-2022
This is my attempt at Advent of Code 2022, using only Swift in VS-Code.

## Common errors i encountered using Swift in VS-Code

### error: no such module 'PackageDescription'
This error might be caused by the SDK from X-code not being active. Solved by user
[vzsg](https://github.com/vzsg).
[sauce](https://github.com/vapor/vapor/issues/2925)


### error: no executable product available
I encountered this error right after I had gotten the Swift-extension working
and tried to run the command `swift run`. It turned out that I had wrote `swift
package init` instead of `swift package init --type=executable`, hence the
lacking executable product. Whoops...



