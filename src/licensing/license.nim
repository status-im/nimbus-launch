# Nimbus-launch
# Copyright (c) 2018 Status Research & Development GmbH
# Licensed and distributed under either of
#   * Apache License, version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
#   * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)
# at your option. This file may not be copied, modified, or distributed except according to those terms.

# #################################################
# Generate the MIT license file for Status projects

import  times, strformat, macros, tables,
        ../private/datatypes

macro parseConstStr(s: static[string]): untyped =
  # The strformat `$` only works on string literals
  # So we transform the identifier to its string literal value
  result = newLit(s)

const
  # Embed the license at compile-team so that nimbusLaunch can be used standalone
  # Unfortunately we can't use a table {"MIT": slurp"./license_MIT.txt", ...}.toTable as the procs don't work at compile-time
  license_MIT = slurp"./license_MIT.txt"
  license_APACHEv2 = slurp"./license_APACHEv2.txt"
  license_GPLv2 = slurp"./license_GPLv2.txt"
  license_GPLv3 = slurp"./license_GPLv3.txt"

  licenseHeaders = {
    Apache2: "Apache v2 license (license terms in the root directory or at http://www.apache.org/licenses/LICENSE-2.0).",
    MIT: "MIT license (license terms in the root directory or at http://opensource.org/licenses/MIT).",
    GPLv2: "GPL v2 license (license terms in the root directory or at https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html).",
    GPLv3: "GPL v2 license (license terms in the root directory or at https://www.gnu.org/licenses/gpl.html)."
  }.toTable

  licenseFileName* = {
    Apache2: "LICENSE-APACHEv2",
    MIT: "LICENSE-MIT",
    GPLv2: "LICENSE-GPLv2",
    GPLv3: "LICENSE-GPLv3"
  }.toTable

proc getLicense*(licenses: Licenses): License =
  ## Extract the license from a Licenses set
  assert licenses.card == 1
  for license in licenses:
    result = license
    break

proc license*(projectName: string, license: License, year = getTime().utc().format("yyyy"),
              copyrightHolder = "Status Research & Development GmbH"): string =

  case license:
  of MIT: result = &parseConstStr(license_MIT)
  of Apache2: result = &parseConstStr(license_APACHEv2)
  of GPLv2: result = &parseConstStr(license_GPLv2)
  of GPLv3: result = &parseConstStr(license_GPLv3)

proc licenseHeader*(projectName: string, licenses: Licenses,
                    year = getTime().utc().format("yyyy"),
                    copyrightHolder = "Status Research & Development GmbH"): string =

  let nbLicenses = licenses.card
  assert nbLicenses != 0

  result =   &"# {projectName}\n"
  result.add &"# Copyright (c) {year} {copyrightHolder}\n"

  if nbLicenses == 1:
    let license = licenses.getLicense
    result.add "# Licensed and distributed under the " & licenseHeaders.getOrDefault(license)

  else:
    result.add "# Licensed and distributed under either of"

    for license in licenses:
      result.add "#   * " & licenseHeaders.getOrDefault(license) & '\n'
    result.add "# at your option. This file may not be copied, modified, or distributed except according to those terms."

