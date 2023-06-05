workspace(name = "rules_symforce")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_python",
    sha256 = "cdf6b84084aad8f10bf20b46b77cb48d83c319ebe6458a18e9d2cebf57807cdd",
    strip_prefix = "rules_python-0.8.1",
    url = "https://github.com/bazelbuild/rules_python/archive/0.8.1.tar.gz",
)

load("@rules_python//python:repositories.bzl", "python_register_toolchains")

python_register_toolchains(
    name = "python3_10",
    python_version = "3.10",
)

load("@python3_10//:defs.bzl", "interpreter")
load("@rules_python//python:pip.bzl", "pip_parse")

pip_parse(
    name = "python_deps",
    extra_pip_args = [],
    python_interpreter_target = interpreter,
    requirements_lock = "//:requirements_lock.txt",
)

load("@python_deps//:requirements.bzl", "install_deps")

install_deps()

eigen = ("3.4.0", "8586084f71f9bde545ee7fa6d00288b264a2b7ac3607b974e54d13e7162c1c72")

http_archive(
    name = "eigen3",
    # build_file = "//third_party:BUILD.eigen3",
    build_file_content =
        """
# TODO(keir): Replace this with a better version, like from TensorFlow.
# See https://github.com/ceres-solver/ceres-solver/issues/337.
cc_library(
    name = 'eigen3',
    srcs = [],
    includes = ['.'],
    hdrs = glob(['Eigen/**']),
    visibility = ['//visibility:public'],
)
""",
    sha256 = eigen[1],
    strip_prefix = "eigen-{}".format(eigen[0]),
    urls = [
        "https://gitlab.com/libeigen/eigen/-/archive/{}/eigen-{}.tar.gz".format(
            eigen[0],
            eigen[0],
        ),
    ],
)
