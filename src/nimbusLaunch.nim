# Nimbus-launch
# Copyright (c) 2018 Status Research & Development GmbH
# Licensed under either of
#
#  * Apache License, version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
#  * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)
#
# at your option. This file may not be copied, modified, or distributed except according to those terms.

import  cligen,
        os,
        ./private/[datatypes, error_checking, cligen_extensions]

# ##############################
# Logic

proc nimbusLaunch(githubName: string,
                  nimbleName: string,
                  licenses: Licenses = {MIT, Apache2}): int =

  if not githubName.validGithub:
    error "The package name on Github must constist of lowercase ASCII, numbers and hyphens (uppercase and underscores are not allowed)."

  if not nimbleName.validIdentifier:
    error "The package name on nimble must be a valid Nim identifier: ASCII, digits, underscore (no hyphen and doesn't start by a number)."

  if githubName.existsDir:
    error "A directory with the name \"" & githubName & "\" already exists in the directory."

  echo licenses
  echo licenses.card # length (cardinality) of the set

when isMainModule:
  dispatch nimbusLaunch

