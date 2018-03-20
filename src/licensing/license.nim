# Nimbus-launch
# Copyright (c) 2018 Status Research & Development GmbH
# Licensed and distributed under either of
#   * Apache License, version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
#   * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)
# at your option. This file may not be copied, modified, or distributed except according to those terms.

# #################################################
# All things license

import  times, strformat, tables, sequtils,
        ../private/[datatypes, format]

const
  # Embed the license at compile-time so that nimbus_launch can be used standalone
  # Unfortunately we can't use a table {"MIT": slurp"./license_MIT.txt", ...}.toTable as the procs don't work at compile-time
  license_MIT = slurp"./license_MIT.txt"
  license_APACHEv2 = slurp"./license_APACHEv2.txt"
  license_GPLv2 = slurp"./license_GPLv2.txt"
  license_GPLv3 = slurp"./license_GPLv3.txt"

  licenseHeaders = {
    Apachev2: "Apache v2 license (license terms in the root directory or at http://www.apache.org/licenses/LICENSE-2.0).",
    MIT: "MIT license (license terms in the root directory or at http://opensource.org/licenses/MIT).",
    GPLv2: "GPL v2 license (license terms in the root directory or at https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html).",
    GPLv3: "GPL v2 license (license terms in the root directory or at https://www.gnu.org/licenses/gpl.html)."
  }.toTable

  licenseFileName* = {
    Apachev2: "LICENSE-APACHEv2",
    MIT: "LICENSE-MIT",
    GPLv2: "LICENSE-GPLv2",
    GPLv3: "LICENSE-GPLv3"
  }.toTable

  licenseDescNimble = {
    Apachev2: "Apache License 2.0",
    MIT: "MIT",
    GPLv2: "GPLv2",
    GPLv3: "GPLv3"
  }.toTable

  licenseBadge = {
    Apachev2: "[![License: Apache](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)",
    MIT: "[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)",
    GPLv2: "[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)",
    GPLv3: "[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)"
  }.toTable

proc getLicense*(licenses: Licenses): License {.noSideEffect.}=
  ## Extract the license from a Licenses set
  assert licenses.card == 1
  for license in licenses:
    result = license
    break

proc license*(projectName: string, license: License, year = getTime().utc().format("yyyy"),
              copyrightHolder = "Status Research & Development GmbH"): string {.noSideEffect.}=

  case license:
  of MIT: result = fmt_const license_MIT
  of Apachev2: result = fmt_const license_APACHEv2
  of GPLv2: result = fmt_const license_GPLv2
  of GPLv3: result = fmt_const license_GPLv3

proc licenseHeader*(projectName: string, licenses: Licenses,
                    year = getTime().utc().format("yyyy"),
                    copyrightHolder = "Status Research & Development GmbH"): string {.noSideEffect.}=

  let nbLicenses = licenses.card
  assert nbLicenses != 0

  result =   &"# {projectName}\n"
  result.add &"# Copyright (c) {year} {copyrightHolder}\n"

  if nbLicenses == 1:
    let license = licenses.getLicense
    result.add "# Licensed and distributed under the " & licenseHeaders.getOrDefault(license) & '\n'
    result.add "# This file may not be copied, modified, or distributed except according to those terms."

  else:
    result.add "# Licensed and distributed under either of\n"

    for license in licenses:
      result.add "#   * " & licenseHeaders.getOrDefault(license) & '\n'
    result.add "# at your option. This file may not be copied, modified, or distributed except according to those terms."

proc licenseReadme*(projectName: string, licenses: Licenses,
                    year = getTime().utc().format("yyyy"),
                    copyrightHolder = "Status Research & Development GmbH"): string {.noSideEffect.}=

  let nbLicenses = licenses.card
  assert nbLicenses != 0

  result = ""

  if nbLicenses == 1:
    let license = licenses.getLicense
    result.add "Licensed and distributed under the " & licenseHeaders.getOrDefault(license) & '\n'
    result.add "This file may not be copied, modified, or distributed except according to those terms."

  else:
    result.add "Licensed and distributed under either of\n"

    for license in licenses:
      result.add "  * " & licenseHeaders.getOrDefault(license) & '\n'
    result.add "at your option. This file may not be copied, modified, or distributed except according to those terms."

proc genLicensesDesc*(licenses: Licenses): string {.noSideEffect.}=

  result = ""
  var start = true
  for license in licenses:
    if not start:
      result.add " or "
    start = false
    result.add licenseDescNimble.getOrDefault license

proc licensesBadges*(licenses: Licenses): string {.noSideEffect.} =

  result = ""
  for license in licenses:
    result.add licenseBadge.getOrDefault license
