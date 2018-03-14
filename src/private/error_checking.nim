# Nimbus-launch
# Copyright (c) 2018 Status Research & Development GmbH
# Licensed under either of
#
#  * Apache License, version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
#  * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)
#
# at your option. This file may not be copied, modified, or distributed except according to those terms.


import  terminal,
        ./datatypes

# ##############################
# Check validity of inputs
proc validGithub*(s: string): bool {.noSideEffect.}=
  for c in s:
    if c notin GithubChars:
      return false
  return true

# ##############################
# Terminal formatting

proc error*(msg: string) =
  styledWriteLine(stderr, fgRed, "Error: ", resetStyle, msg)
  quit "Quitting", QuitFailure
