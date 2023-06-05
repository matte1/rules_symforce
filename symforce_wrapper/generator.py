"""Wrapper for symforce code generation."""
import sys
import typing

from symforce.codegen import Codegen, CppConfig


def generate_linearizations(
    func: typing.Callable,
    which_args: typing.List[str],
) -> None:
    """Generate the linearizations from a symforce function."""

    # The first and second arguments are guranteed to be the cc and hh files respectively by the
    # rule.
    cc_file = sys.argv[1]
    hh_file = sys.argv[2]

    # Generate code using symforce
    codegen = Codegen.function(func, config=CppConfig())
    gen = codegen.with_linearization(which_args=which_args)

    with open(gen.generate_function().generated_files[0], encoding="utf-8") as header_file:
        generated_header = header_file.read()

        # Write generated code to files.
        with open(hh_file, "w", encoding="utf-8") as outfile:
            outfile.write(
                f"""\
// NOLINTBEGIN

{generated_header}

// NOLINTEND"""
            )

        with open(cc_file, "w", encoding="utf-8") as outfile:
            include_file = "/".join(hh_file.split("/")[3:])
            outfile.write(f'#include "{include_file}"\n')
