// ============================================================
// interpolation.sci  —  Student A Skeleton
// Polynomial Calibration Fit: Pressure vs Voltage
//
// NAME: ________________________________
// ID:   ________________________________
//
// You must implement TWO functions in this file.
// Do NOT change the function signatures.
//
// FORBIDDEN: Do NOT use Scilab's built-in polyfit(), reglin(), or
// any other curve-fitting builtin.  Build the design matrix and
// solve the Normal Equations yourself.
// ============================================================

funcprot(0);   // suppress redefinition warnings when re-running

// ------------------------------------------------------------
// Function 1: poly_fit
//
// Fits a degree-k polynomial to data (x, y) using a
// design matrix Z and the Normal Equations.
//
// Input:
//   x     - predictor vector (n elements), e.g. sensor_voltage
//   y     - response vector  (n elements), e.g. diff_pressure
//   k     - polynomial degree (integer >= 1)
//
// Output:
//   coeff - coefficient vector [c0; c1; ...; ck] of length k+1
//           such that  P(x) = c0 + c1*x + c2*x^2 + ... + ck*x^k
//
// Hints:
//   - Ensure x and y are column vectors before proceeding.
//   - Build a rectangular matrix Z where each column contains a
//     different power of x.  How many rows and columns should Z have?
//   - Once Z is assembled, what matrix equation must you solve to
//     minimise the sum of squared residuals?  (See the manual.)
//   - Use Scilab's backslash operator (\) to solve the resulting system.
// ------------------------------------------------------------
function [coeff] = poly_fit(x, y, k)

    // TODO: validate inputs — check length(x)==length(y) and 1<=k<=n-1

    // TODO: force column vectors: x = x(:);  y = y(:);  n = length(x);

    // TODO: build Z (n x k+1): column j holds x.^(j-1), for j = 1 to k+1
    //       Hint: initialise Z = zeros(n, k+1), then fill it in a loop.

    // TODO: form the two matrices that appear in the Normal Equations
    //       (one is (k+1)x(k+1), one is (k+1)x1), then solve the system
    //       using the backslash operator (\).

endfunction


// ------------------------------------------------------------
// Function 2: eval_poly
//
// Evaluates the fitted polynomial at one or more query points.
//
// Input:
//   coeff   - coefficient vector from poly_fit() (length k+1)
//   x_query - scalar or column vector of x-values to evaluate
//
// Output:
//   y_query - polynomial values at x_query (column vector)
//
// Hints:
//   - Naively computing c0 + c1*x + c2*x^2 + ... requires many separate
//     power calculations.  Horner's method avoids this: rewrite the
//     polynomial so that each step only multiplies by x once.
//     Trace through the degree-2 case by hand to see the pattern.
//   - Think carefully about the loop direction (which coefficient do you
//     start with, and which do you end on?).
//   - Loop over each element of x_query if it is a vector.
// ------------------------------------------------------------
function [y_query] = eval_poly(coeff, x_query)

    // TODO: ensure coeff and x_query are column vectors; allocate y_query
    //       as a zeros column vector with the same number of elements as x_query.

    // TODO: for each element of x_query, apply Horner's method:
    //       start at the highest-degree coefficient and work downward,
    //       accumulating the result one multiplication per step.
    //       Store each final result in the corresponding position of y_query.

endfunction
