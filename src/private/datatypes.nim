# Nimbus-launch
# Copyright (c) 2018 Status Research & Development GmbH
# Licensed under either of
#
#  * Apache License, version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
#  * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)
#
# at your option. This file may not be copied, modified, or distributed except according to those terms.

type
  License* = enum
    MIT, Apachev2, GPLv2, GPLv3

  Licenses* = set[License]

  TravisConfig* = enum
    StatusDocker, Generic

const
  GithubChars* = {'a'..'z','0'..'9','-'}
    # Set of characters allowed for Github repo name
    # Only lowercase with dash and numbers

