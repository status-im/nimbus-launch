# Nimbus-launch
# Copyright (c) 2018 Status Research & Development GmbH
# Licensed under either of
#
#  * Apache License, version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
#  * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)
#
# at your option. This file may not be copied, modified, or distributed except according to those terms.

import  cligen,
        os, strutils,
        ./private/[datatypes, error_checking, cligen_extensions]

# ##############################
# Logic

proc nimbusLaunch(projectName: string,
                  githubName: string,
                  nimbleName: string,
                  licenses: Licenses = {MIT, Apache2}): int =

  # Validity checks
  if not githubName.validGithub:
    error "The package name on Github (" & githubName & ") must consist of lowercase ASCII, numbers and hyphens (uppercase and underscores are not allowed)."
  if not nimbleName.validIdentifier:
    error "The package name on nimble (" & nimbleName & ") must be a valid Nim identifier: ASCII, digits, underscore (no hyphen and doesn't start by a number)."
  if githubName.existsDir:
    error "A directory with the name \"" & githubName & "\" already exists in the directory."
  if licenses.card == 0:
    error "The project must have at least one license."

when isMainModule:
  dispatch nimbusLaunch

