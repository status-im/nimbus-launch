# Nimbus-launch
# Copyright (c) 2018 Status Research & Development GmbH
# Licensed under either of
#
#  * Apache License, version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
#  * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)
#
# at your option. This file may not be copied, modified, or distributed except according to those terms.

import cligen, argcvt # argcvt is part of cligen
import strutils

type
  License = enum
    MIT, Apache2, GPLv2, GPLv3

  Licenses = set[License]

# Add Licenses support to cligen
template argParse(dst: Licenses, key: string, val: string, help: string) =
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

proc nimbusLaunch(licenses: Licenses = {MIT, Apache2}): int =
  echo licenses
  echo licenses.card # length (cardinality) of the set

when isMainModule:
  dispatch nimbusLaunch

