# rules_symforce

Simplify the generation and compilation of symforce
targets.

Usage:

```py
# //:WORKSPACE
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_symforce",
    strip_prefix = "rules_symforce",
    sha256 = "e2f7f689e3a2e3c16f55d8e6a4abd79693eaf0f3",
    url = "https://github.com/matte1/rules_symforce/archive/refs/tags/v0.0.0.zip",
)
```

## Example

To see the tool in action:

1.  Clone the repository
2.  Run the example target:

        bazel run //example:test_simple