"""Simple example of getting hessian and gradient of a function."""
import symforce

symforce.set_epsilon_to_number()

import symforce.symbolic as sf
from symforce_wrapper.generator import generate_linearizations


def simple(x: sf.Scalar, y: sf.Scalar) -> sf.V1:
    """Simple quadratic function."""
    return sf.V1(x * x + y * y + x + y)


generate_linearizations(simple, which_args=["x", "y"])
