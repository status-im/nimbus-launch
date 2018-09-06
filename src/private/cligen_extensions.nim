# Nimbus-launch
# Copyright (c) 2018 Status Research & Development GmbH
# Licensed under either of
#
#  * Apache License, version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
#  * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)
#
# at your option. This file may not be copied, modified, or distributed except according to those terms.

import  ./datatypes, strutils,
        cligen/argcvt

# #################################################
# Add custom types support to cligen

proc argParse*(dst: var Licenses, key: string, val: string, help: string) =
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
      ERR("Wrong input license(s) for param \"$1\"\n$2, only MIT, Apachev2, GPLv2 and GPLv3 are supported." % [key, help])

proc argHelp*(dfl: Licenses, a: var ArgcvtParams): seq[string] =
  result = @[a.argKeys, "Licenses", a.argDf $dfl]
