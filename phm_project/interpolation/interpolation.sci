// ============================================================
// interpolation.sci  —  Student A Module  [INTEGRATION COPY]
// Polynomial Calibration Fit: Pressure vs Voltage
//
// HOW TO USE THIS FILE:
//   1. Develop and test your code in  StudentA/interpolation.sci
//   2. When ready to run the test suite, COPY your finished
//      implementation into THIS file (replace the stubs below).
//   3. Run:  exec('test_suites/test_studentA.sci', -1)
//      from the phm_project/ directory.
// ============================================================

// ------------------------------------------------------------
// Function 1: poly_fit
// Input:  x (n), y (n), k (degree)
// Output: coeff [c0; c1; ...; ck]
// ------------------------------------------------------------
function [coeff] = poly_fit(x, y, k)

    // TODO — see StudentA/interpolation.sci for task details
    coeff = [];

endfunction


// ------------------------------------------------------------
// Function 2: eval_poly
// Input:  coeff (k+1), x_query (scalar or vector)
// Output: y_query (same size as x_query)
// ------------------------------------------------------------
function [y_query] = eval_poly(coeff, x_query)

    // TODO — see StudentA/interpolation.sci for task details
    y_query = [];

endfunction
