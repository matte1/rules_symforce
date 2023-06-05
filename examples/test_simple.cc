#include "examples/simple.hh"

#include <Eigen/Dense>
#include <iostream>

int main() {
  double x = 1.0;
  double y = 2.0;

  Eigen::Matrix<double, 1, 1> res{};
  Eigen::Matrix<double, 1, 2> jacobian{};
  Eigen::Matrix<double, 2, 2> hessian{};
  Eigen::Matrix<double, 2, 1> rhs{};

  sym::SimpleFactor(x, y, &res, &jacobian, &hessian, &rhs);

  Eigen::Matrix<double, 1, 2> expected_jacobian{3.0, 5.0};

  assert(expected_jacobian.isApprox(jacobian,
                                    std::numeric_limits<double>::epsilon()) &&
         "Expected Jacobian doesn't match symforce Jacobian");

  return 0;
}