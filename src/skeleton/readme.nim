# Nimbus-launch
# Copyright (c) 2018 Status Research & Development GmbH
# Licensed under either of
#  * Apache License, version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
#  * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)
# at your option. This file may not be copied, modified, or distributed except according to those terms.

# #################################################
# Generate the nimble file for Status projects

import strformat
import ../licensing/license, ../private/datatypes

proc genReadme*(projectName: string,
                githubName: string,
                nimbleName: string,
                licenses: Licenses): string =

  # 1. Project Name
  result = &"""# {projectName}

[![Build Status (Travis)](https://img.shields.io/travis/status-im/{githubName}/master.svg?label=Linux%20/%20macOS "Linux/macOS build status (Travis)")](https://travis-ci.org/status-im/{githubName})
[![Windows build status (Appveyor)](https://img.shields.io/appveyor/ci/nimbus/{githubName}/master.svg?label=Windows "Windows build status (Appveyor)")](https://ci.appveyor.com/project/nimbus/{githubName})
{licensesBadges(licenses)}![Stability: experimental](https://img.shields.io/badge/stability-experimental-orange.svg)

## Introduction

Quick description

## Installation

You can install the developement version of the library through nimble with the following command
```
nimble install https://github.com/status-im/{githubName}@#master
```

## Contributing

When submitting pull requests, please add test cases for any new features or fixes and make sure `nimble test` is still able to execute the entire test suite successfully.

## License

{licenseReadme(projectName, licenses)}

"""
