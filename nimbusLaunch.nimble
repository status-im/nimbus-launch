packageName   = "nimbusLaunch"
version       = "0.0.1"
author        = "Status Research & Development GmbH"
description   = "Create a Status Nim project skeleton"
license       = "Apache License 2.0 or MIT"
srcDir        = "src"

### Dependencies

requires "nim >= 0.18.0"

proc test(name: string, lang: string = "cpp") =
  if not dirExists "build":
    mkDir "build"
  if not dirExists "nimcache":
    mkDir "nimcache"
  --run
  --nimcache: "nimcache"
  switch("out", ("./build/" & name))
  setCommand lang, "tests/" & name & ".nim"

task test, "Run all tests":
  test "all_tests"
