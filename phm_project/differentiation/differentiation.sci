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

    // ---- Input Validation ----
    if length(hours) ~= length(vibration) then
        error('linearize_vib: hours and vibration must have the same length.');
    end

    // Guard against non-positive vibration values.
    // log(0) = -Inf and log(negative) = NaN; either poisons the entire fit.
    valid_idx = find(vibration > 0);
    if length(valid_idx) < 2 then
        error('linearize_vib: need at least 2 positive vibration samples to fit.');
    end

    // ---- Force Column Vectors and apply valid-index mask ----
    h = hours(valid_idx)(:);       // (m x 1) column, only valid rows
    v = vibration(valid_idx)(:);   // (m x 1) column, only valid rows
    n = length(h);

    // ---- Log-Linearisation ----
    // V(h) = a * exp(b*h)  =>  ln(V) = ln(a) + b*h
    // Response:  w  = ln(V)
    // Predictor: h  (operational hours)
    w = log(v);

    // ---- Design Matrix: [1, h] ----
    Z = [ones(n, 1), h];   // (n x 2)

    // ---- Normal Equations: c = (Z'Z) \ (Z'w) ----
    c = (Z' * Z) \ (Z' * w);   // c = [c0; c1]

    // ---- Recover original parameters ----
    // c(1) = ln(a)  =>  a = exp(c(1))
    // c(2) = b      =>  b = c(2)
    a = exp(c(1));
    b = c(2);

endfunction


// ------------------------------------------------------------
// Function 2: predict_vibration
// Input:  a, b (from linearize_vib), h_query (scalar/vector)
// Output: vib_query
// ------------------------------------------------------------
function [vib_query] = predict_vibration(a, b, h_query)

    // Evaluate V(h) = a * exp(b * h) element-wise.
    // .* ensures this works for scalar, row vector, or column vector h_query.
    vib_query = a .* exp(b .* h_query);

endfunction

