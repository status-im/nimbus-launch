# Nimbus-launch
# Copyright (c) 2018 Status Research & Development GmbH
# Licensed under either of
#
#  * Apache License, version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
#  * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)
#
# at your option. This file may not be copied, modified, or distributed except according to those terms.

import macros, strformat

macro parseConstStr*(s: static[string]): untyped =
  # The strformat `$` only works on string literals
  # So we transform the identifier to its string literal value
  result = newLit(s)

template fmt_const*(s: static[string]): untyped =
  # Apply strformat on const string
  &parseConstStr(s)
