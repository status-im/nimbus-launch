# Nimbus Launch

[![License: Apache](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
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
nimbus_launch projectName githubName nimbleName
```

For example
```
nimbus_launch MyAwesomeProject my-awesome-project my_awesome_project
```

Options:
```
nimbus_launch --help
Usage:
  nimbus_launch [optional-params] {projectName:string} {githubName:string} {nimbleName:string}
  Options(opt-arg sep :|=|spc):
  --help, -?                                        print this help message
  -l=, --licenses=       Licenses  {MIT, Apachev2}  set licenses
  -t=, --travis_config=  Licenses  StatusDocker     set travis_config
```

By default:
  - licenses are MIT + Apache v2 and supports MIT, Apachev2, GPLv2 and GPLv3
  - travis_config is Docker with Status patches to devel.
    - The alternative is `Generic`, which tests linux, macOS and the latest stable and devel branches.
      Templates to install custom `apt-get` or `Homebrew` dependencies are included

## License

Licensed under either of

 * Apache License, Version 2.0, ([LICENSE-APACHE](LICENSE-APACHE) or http://www.apache.org/licenses/LICENSE-2.0)
 * MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

at your option.
