# Nimbus-launch
# Copyright (c) 2018 Status Research & Development GmbH
# Licensed under either of
#
#  * Apache License, version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
#  * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)
#
# at your option. This file may not be copied, modified, or distributed except according to those terms.

import cligen, argcvt # argcvt is part of cligen
import strutils, os, terminal

type
  License = enum
    MIT, Apache2, GPLv2, GPLv3

  Licenses = set[License]

const
  GithubChars = {'a'..'z','0'..'9','-'}
    # Set of characters allowed for Github repo name
    # Only lowercase with dash and numbers

# ##############################
# Check validity of inputs
proc validGithub(s: string): bool {.noSideEffect.}=
  for c in s:
    if c notin GithubChars:
      return false
  return true

# ##############################
# Extend cligen
template argParse(dst: Licenses, key: string, val: string, help: string) =
  # Parse license input
  let args = val.split(',')
  dst = {}
  for input_license in args:
    var isValid: bool = false
    for supported_license in low(License)..high(License):       # Interesting read: "parseEnum is slow" https://forum.nim-lang.org/t/2949
      if cmpIgnoreStyle(input_license, $supported_license) == 0:
        incl(dst, supported_license)
        isValid = true
    if not isValid:
      argRet(1, "Wrong input license(s) for param \"$1\"\n$2" %
             [key, help])

template argHelp(helpT: seq[array[0..3, string]], defVal: Licenses,
                  parNm: string, sh: string, parHelp: string) =
  helpT.add([ keys(parNm, sh), "Licenses", $defVal, parHelp ])

# ##############################
# Terminal formatting

proc error(msg: string) =
  styledWriteLine(stderr, fgRed, "Error: ", resetStyle, msg)
  quit "Quitting", QuitFailure

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

