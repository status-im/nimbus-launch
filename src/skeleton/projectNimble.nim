# Nimbus-launch
# Copyright (c) 2018 Status Research & Development GmbH
# Licensed under either of
#  * Apache License, version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
#  * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)
# at your option. This file may not be copied, modified, or distributed except according to those terms.

# #################################################
# Generate the nimble file for Status projects

import  ../private/[datatypes, format],
        ../licensing/license

const baseNimble = """
packageName   = "{projectName}"
version       = "0.0.1"
author        = "Status Research & Development GmbH"
description   = ""
license       = "{licensesDesc}"
srcDir        = "src"

### Dependencies
requires "nim >= 0.18.0"

### Helper functions
proc test(name: string, defaultLang = "c") =
  # TODO, don't forget to change defaultLang to `cpp` if the project requires C++
  if not dirExists "build":
    mkDir "build"
  --run
  switch("out", ("./build/" & name))
  setCommand defaultLang, "tests/" & name & ".nim"

### tasks
task test, "Run all tests":
  test "all_tests"
"""

proc genNimbleFile*(projectName: string, licenses: Licenses): string {.noSideEffect.} =
  let licensesDesc = licenses.genLicensesDesc

  result = fmt_const baseNimble
