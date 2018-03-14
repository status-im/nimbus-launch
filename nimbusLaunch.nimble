packageName   = "nimbusLaunch"
version       = "0.0.1"
author        = "Status Research & Development GmbH"
description   = "Create a Status Nim project skeleton"
license       = "Apache License 2.0 or MIT"

# This is a pure binary package, only install the binary
bin           = @["src/nimbusLaunch"]
installDirs   = @[""]

### Dependencies
requires "nim >= 0.18.0", "https://github.com/c-blake/cligen#head"

### Helper functions
proc test(name: string, defaultLang = "c") =
  if not dirExists "build":
    mkDir "build"
  if not dirExists "nimcache":
    mkDir "nimcache"
  --run
  --nimcache: "nimcache"
  switch("out", ("./build/" & name))
  setCommand lang, "tests/" & name & ".nim"

### tasks
task test, "Run all tests":
  test "all_tests"
