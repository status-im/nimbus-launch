# Nimbus-launch
# Copyright (c) 2018 Status Research & Development GmbH
# Licensed under either of
#  * Apache License, version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
#  * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)
# at your option. This file may not be copied, modified, or distributed except according to those terms.

import  cligen,
        os, strutils, tables, strformat,
        ./private/[datatypes, error_checking, cligen_extensions, format],
        ./licensing/license,
        ./skeleton/[projectNimble, readme]

# ##############################
# Logic

proc nimbus_launch(projectName: string,
                  githubName: string,
                  nimbleName: string,
                  licenses: Licenses = {MIT, Apachev2},
                  ): int =

  let prjDir = githubName
  let nbLicenses = licenses.card

  # 1. Validity checks
  if projectName.len == 0 or githubName.len == 0 or nimbleName.len == 0:
    error "nimbus_launch requires 3 arguments at minimum: projectName, githubName, nimbleName.\n Run nimbleLaunch --help for more information."
  if not githubName.validGithub:
    error "The package name on Github (" & githubName & ") must consist of lowercase ASCII, numbers and hyphens (uppercase and underscores are not allowed)."
  if not nimbleName.validIdentifier:
    error "The package name on nimble (" & nimbleName & ") must be a valid Nim identifier: ASCII, digits, underscore (no hyphen and doesn't start by a number)."
  if prjDir.existsDir:
    error "A directory with the name \"" & githubName & "\" already exists in the directory."
  if nbLicenses == 0:
    error "The project must have at least one license."

  # 2. Create the folder structure
  # .
  # ├── LICENSE-APACHEv2 (if applicable)
  # ├── LICENSE-MIT (if applicable)
  # ├── README.md
  # ├── benchmarks
  # ├── build
  # ├── docs
  # ├── examples
  # ├── {nimbleName}.nimble
  # ├── src
  # │   ├── {nimbleName}.nim
  # │   └── private
  # └── tests
  #     └── all_tests.nim

  createDir(prjDir & "/benchmarks")
  createDir(prjDir & "/build")
  createDir(prjDir & "/docs")
  createDir(prjDir & "/examples")
  createDir(prjDir & "/src/private")
  createDir(prjDir & "/tests")

  # 3. Add license(s)
  if nbLicenses == 1:
    writeFile(
      prjDir & "/LICENSE",
      license(projectName, licenses.getLicense)
      )
  else:
    for license in licenses:
      writeFile(
        prjDir & "/" & licenseFileName.getOrDefault(license),
        license(projectName, license)
      )

  let licenseHeader = licenseHeader(projectName, licenses)

  # 4. Add .gitignore
  const gitignore = slurp"skeleton/gitignore.txt"
  writeFile(
    prjDir & "/.gitignore",
    gitignore
  )

  # 5. Add nimble file
  writeFile(
    prjDir & "/" & nimbleName & ".nimble",
    genNimbleFile(projectName, licenses)
  )

  # 6. Add continuous integration
  const
    confTravis = slurp"./continuous_integration/travis.yml"
    confAppveyor = slurp"./continuous_integration/appveyor.yml"

  writeFile(
    prjDir & "/.travis.yml",
    confTravis
  )
  writeFile(
    prjDir & "/.appveyor.yml",
    confAppveyor
  )

  # 7. Add the README
  writeFile(
    prjDir & "/README.md",
    genReadme(projectName, githubName, nimbleName, licenses)
  )

  # 8. Add the source and test skeleton
  writeFile(
    prjDir & "/src/" & nimbleName & ".nim",
    licenseHeader
  )

  var testString = licenseHeader
  testString &= &"""


import  unittest,
        ../src/{nimbleName}

suite "Your first test suite":
  test "Your first test":
    block: # independant block of subtest
      discard
    block:
      discard
"""

  writeFile(
    prjDir & "/tests/all_tests.nim",
    testString
  )

when isMainModule:
  dispatch nimbus_launch

