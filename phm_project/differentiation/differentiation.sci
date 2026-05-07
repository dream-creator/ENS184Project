// ============================================================
// differentiation.sci  —  Student B Module  [INTEGRATION COPY]
// Exponential Vibration Model: Vibration vs Hours
//
// HOW TO USE THIS FILE:
//   1. Develop and test your code in  StudentB/differentiation.sci
//   2. When ready to run the test suite, COPY your finished
//      implementation into THIS file (replace the stubs below).
//   3. Run:  exec('test_suites/test_studentB.sci', -1)
//      from the phm_project/ directory.
// ============================================================

// ------------------------------------------------------------
// Function 1: linearize_vib
// Input:  hours (n), vibration (n)
// Output: a (scale), b (rate)
// ------------------------------------------------------------
function [a, b] = linearize_vib(hours, vibration)

    // TODO — see StudentB/differentiation.sci for task details
    a = 0;
    b = 0;

endfunction


// ------------------------------------------------------------
// Function 2: predict_vibration
// Input:  a, b (from linearize_vib), h_query (scalar/vector)
// Output: vib_query
// ------------------------------------------------------------
function [vib_query] = predict_vibration(a, b, h_query)

    // TODO — see StudentB/differentiation.sci for task details
    vib_query = zeros(size(h_query, 1), size(h_query, 2));

endfunction
