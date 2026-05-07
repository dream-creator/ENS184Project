// ============================================================
// integration.sci  —  Student C Module  [INTEGRATION COPY]
// Goodness-of-Fit Metrics and Failure-Hour Prediction
//
// HOW TO USE THIS FILE:
//   1. Develop and test your code in  StudentC/integration.sci
//   2. When ready to run the test suite, COPY your finished
//      implementation into THIS file (replace the stubs below).
//   3. Run:  exec('test_suites/test_studentC.sci', -1)
//      from the phm_project/ directory.
// ============================================================

// ------------------------------------------------------------
// Function 1: goodness_of_fit
// Input:  y_actual (n), y_pred (n)
// Output: rmse (scalar), r2 (scalar)
// ------------------------------------------------------------
function [rmse, r2] = goodness_of_fit(y_actual, y_pred)

    // TODO — see StudentC/integration.sci for task details
    rmse = %inf;
    r2   = 0;

endfunction


// ------------------------------------------------------------
// Function 2: find_threshold_hour
// Input:  hours (n), vib_fit (n), threshold (scalar)
// Output: h_star (scalar)
// ------------------------------------------------------------
function [h_star] = find_threshold_hour(hours, vib_fit, threshold)

    // TODO — see StudentC/integration.sci for task details
    h_star = %inf;

endfunction
