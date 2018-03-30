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
[![Windows build status (Appveyor)](https://img.shields.io/appveyor/ci/jarradh/{githubName}/master.svg?label=Windows "Windows build status (Appveyor)")](https://travis-ci.org/jarradh/{githubName})
{licensesBadges(licenses)}
![Stability: experimental](https://img.shields.io/badge/stability-experimental-orange.svg)

Quick description

## Installation

You can install the developement version of the library through nimble with the following command
```
nimble install https://github.com/status-im/{githubName}@#master
```

## License

{licenseReadme(projectName, licenses)}

"""
