# Nimbus-launch
# Copyright (c) 2018 Status Research & Development GmbH
# Licensed under either of
#
#  * Apache License, version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
#  * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)
#
# at your option. This file may not be copied, modified, or distributed except according to those terms.

# #################################################
# Generate the MIT license file for Status projects

import  times, strformat, macros,
        ../private/datatypes

macro parseConstStr(s: static[string]): untyped =
  # The strformat `$` only works on string literals
  # So we transform the identifier to its string literal value
  result = newLit(s)

proc license*(githubName: string, license: License, year = getTime().utc().format("yyyy"),
              copyrightHolder = "Status Research & Development GmbH"): string =

  const
    # Embed the license at compile-team so that nimbusLaunch can be used standalone
    license_MIT = slurp"./license_MIT.txt"
    license_APACHEv2 = slurp"./license_APACHEv2.txt"
    license_GPLv2 = slurp"./license_GPLv2.txt"
    license_GPLv3 = slurp"./license_GPLv3.txt"

    # Unfortunately we can't use a table {"MIT": slurp"./license_MIT.txt", ...}.toTable as the procs don't work at compile-time

  case license:
  of MIT: result = &parseConstStr(license_MIT)
  of Apache2: result = &parseConstStr(license_APACHEv2)
  of GPLv2: result = &parseConstStr(license_GPLv2)
  of GPLv3: result = &parseConstStr(license_GPLv3)
