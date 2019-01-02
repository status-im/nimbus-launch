# Nimbus Launch

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![License: Apache](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
![Stability: experimental](https://img.shields.io/badge/stability-experimental-orange.svg)

Jumpstart your Nim project at Status

Nimbus-launch creates a Nim project template with:

  - folders: src/tests/benchmarks/examples/docs
  - your license(s) of choice
  - a .gitignore
  - a .nimble file
  - Travis and Appveyor configuration
  - A README with
      - your continuous integration, license(s) and "stability: experimental" badges
      - An installation section with the nimble command
      - A license section with your license(s) of choice
  - A skeleton source file
  - A skeleton test file including importing the project and the unittest module

## Installation

```
nimble install https://github.com/status-im/nimbus-launch@#master
```

## How to use

```
nimbus_launch -p=projectName -g=githubName -n=nimbleName
```

For example
```
nimbus_launch -p=MyAwesomeProject -g=my-awesome-project -n=my_awesome_project
```

Options:
```
nimbus_launch --help
Usage:
  nimbus_launch [required&optional-params]
  Options(opt-arg sep :|=|spc):
  -h, --help                                             write this help to stdout
  -p=, --projectName=    string         REQUIRED         set projectName
  -g=, --githubName=     string         REQUIRED         set githubName
  -n=, --nimbleName=     string         REQUIRED         set nimbleName
  -l=, --licenses=       Licenses       {MIT, Apachev2}  set licenses
```

By default:
  - licenses are `MIT,Apachev2` and support `MIT`, `Apachev2`, `GPLv2` and `GPLv3` or any combination of those, separated by a comma and no space.

## Travis and AppVeyor setup information

Both Travis and AppVeyor builds are set up in the following way:

* Build https://github.com/status-im/Nim, and cache it
  * Should be rebuilt automatically whenever above repo changes
* (Optional) Build any dependencies that are needed for the project
  * rocksdb - some distros come without snappy and other build options enabled
* Build the project with `nimble install -y`
  * This ensures that installation works, including compiling the main binary
* Run tests with `nimble test`
  * Some projects name the test task differently for legacy reasons

Other notes about travis and appveyor:
* travis supports `ccache`, but this turned out to be less efficient than simply
  caching the whole Nim repo
* Each project is set to build both branches and pull requests
* Additionally, Travis projects are set to build daily, if no other builds have
  run
  * This helps catch downstream breakage, ie `nimbus` breacking because of
    changes in `nim-eth-common` - this is a bit of a hack


## Nim version policy

We maintain a version of Nim that's "blessed" for status use in
https://github.com/status-im/Nim. This allows us to stay independent
of the day-to-day churn and regressions that happen on the Nim devel
branch and at the same time leaves room for critical patches to be applied.

This forked version of Nim:

* Typically tracks the latest officially released version of Nim
* May in exceptional cases include addtional patches
* Is used in all CI builds to provide a stable build environment
* Is updated in a controlled manner such that all regressions are fixed
  fixed before pushing the update - in particular, active branches that
  the rest of the team are working on need to be considered as well

## License

Licensed and distributed under either of

* MIT license: [LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT

or

* Apache License, Version 2.0, ([LICENSE-APACHEv2](LICENSE-APACHEv2) or http://www.apache.org/licenses/LICENSE-2.0)

at your option. This file may not be copied, modified, or distributed except according to those terms.
