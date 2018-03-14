# Nimbus-launch
# Copyright (c) 2018 Status Research & Development GmbH
# Licensed under either of
#  * Apache License, version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
#  * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)
# at your option. This file may not be copied, modified, or distributed except according to those terms.

import  cligen,
        os, strutils, tables,
        ./private/[datatypes, error_checking, cligen_extensions],
        ./licensing/license,
        ./skeleton/[projectNimble]

# ##############################
# Logic

proc nimbusLaunch(projectName: string,
                  githubName: string,
                  nimbleName: string,
                  licenses: Licenses = {MIT, Apache2}): int =

  let prjDir = githubName
  let nbLicenses = licenses.card

  # 1. Validity checks
  if projectName.isNil or githubName.isNil or nimbleName.isNil:
    error "nimbusLaunch requires 3 arguments at minimum: projectName, githubName, nimbleName.\n Run nimbleLaunch --help for more information."
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

when isMainModule:
  dispatch nimbusLaunch

