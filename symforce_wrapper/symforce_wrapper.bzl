"""Generate a cc library from symforce"""

load("@python_deps//:requirements.bzl", "requirement")
load("@rules_cc//cc:defs.bzl", "cc_library")
load("@rules_python//python:defs.bzl", "py_binary")

def _run_symforce_generation_impl(ctx):
    tool_as_list = [ctx.attr.tool]
    tool_inputs, tool_input_mfs = ctx.resolve_tools(tools = tool_as_list)
    outputs = []
    outputs.extend(ctx.outputs.outs)
    ctx.actions.run(
        outputs = outputs,
        tools = tool_inputs,
        executable = ctx.executable.tool,
        arguments = [output.path for output in outputs],
        progress_message = ctx.attr.progress_message if ctx.attr.progress_message else None,
        use_default_shell_env = False,
        input_manifests = tool_input_mfs,
    )

    return DefaultInfo(
        files = depset(outputs),
        runfiles = ctx.runfiles(files = outputs),
    )

_run_symforce_generation = rule(
    implementation = _run_symforce_generation_impl,
    attrs = dict({
        "outs": attr.output_list(),
        "progress_message": attr.string(),
        "tool": attr.label(
            executable = True,
            allow_files = True,
            mandatory = True,
            cfg = "target",
        ),
    }),
)

def symforce(
        name,
        generator,
        progress_message = None,
        **kwargs):
    """ Uses a python symforce codegenerator to generate a cc library

    Args:
        name: name of the symforce library
        generator: path to the python symforce codegenerator
        progress_message: optional progress message to display during generation
        **kwargs: additional arguments to pass to the symforce codegenerator
    """
    py_bin_name = "sym_{}_py".format(name)

    py_binary(
        name = py_bin_name,
        main = generator,
        srcs = [
            generator,
        ],
        visibility = ["//visibility:public"],
        deps = [
            requirement("symforce"),
            "//symforce_wrapper:generator",
        ],
    )

    cc_outs = ["{}.cc".format(name), "{}.hh".format(name)]

    _run_symforce_generation(
        name = name,
        tool = ":{}".format(py_bin_name),
        outs = cc_outs,
        progress_message = progress_message,
        **kwargs
    )

    cc_library(
        name = "sym_{}_cc".format(name),
        srcs = cc_outs,
        includes = ["."],
        visibility = ["//visibility:public"],
        deps = ["@eigen3"],
    )
