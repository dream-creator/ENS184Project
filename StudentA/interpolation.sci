// ============================================================
// interpolation.sci  —  Student A Skeleton
// Polynomial Calibration Fit: Pressure vs Voltage
//
// NAME: JULIAN JOSH B. LADLAD
// ID: #2024-1015
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

    if length(x) ~= length(y) then
        error('Input vectors x and y must have the same length.');
    end
    if k < 1 | k >= length(x) then
        error('Polynomial degree k must be >= 1 and < length(x).');
    end

    x = x(:);  
    y = y(:);  
    n = length(x);

    Z = zeros(n, k+1);
    for j = 1:k+1
        Z(:, j) = x .^ (j-1);
    end

    coeff = (Z' * Z) \ (Z' * y);

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

    coeff = coeff(:);
    x_query = x_query(:);
    n_query = length(x_query);
    y_query = zeros(n_query, 1);
    
    n_coeff = length(coeff);

    for i = 1:n_query
        result = coeff(n_coeff); 

        for j = n_coeff-1 : -1 : 1
            result = coeff(j) + x_query(i) * result;
        end
        
        y_query(i) = result;
    end

endfunction
