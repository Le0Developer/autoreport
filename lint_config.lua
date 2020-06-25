return {
  whitelist_globals = {
    ["./"] = {
      "bit",
      "callbacks",
      "client",
      "common",
      "draw",
      "engine",
      "entities",
      "file",
      "globals",
      "gui",
      "http",
      "materials",
      "network",
      "panorama",
      "input",
      "vector",
      "LoadScript",
      "UnloadScript",
      "GetScriptName"
    },
    ["tests/"] = {
      "describe",
      "it",
      "setup",
      "teardown",
      "before_each",
      "after_each"
    }
  }
}
