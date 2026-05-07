// ============================================================
// differentiation.sci  —  Student B Skeleton
// Exponential Vibration Model: Vibration vs Hours
//
// NAME: ________________________________
// ID:   ________________________________
//
// You must implement TWO functions in this file.
// Do NOT change the function signatures.
//
// FORBIDDEN: Do NOT use Scilab's built-in reglin(), polyfit(), or
// expfit() functions.  Derive the exponential parameters yourself
// using log-linearisation and the Normal Equations.
// ============================================================

funcprot(0);   // suppress redefinition warnings when re-running

// ------------------------------------------------------------
// Function 1: linearize_vib
//
// Fits an exponential model  V(h) = a * exp(b * h)
// to vibration vs hours data by log-linearizing and
// applying least-squares.
//
// Input:
//   hours     - operational hours vector (n elements)
//   vibration - vibration amplitude vector (n elements), all > 0
//
// Output:
//   a - scale factor  (positive scalar)
//   b - growth rate   (positive scalar)
// ------------------------------------------------------------
function [a, b] = linearize_vib(hours, vibration)

    // ---- Input Validation ----
    // Check that both vectors have the same number of elements.
    if length(hours) ~= length(vibration) then
        error('linearize_vib: hours and vibration must have the same length.');
    end

    // Guard against non-positive vibration values.
    // log(0) = -Inf and log(negative) = NaN; either poisons the entire fit.
    // Real vibration amplitudes are always physically positive, so we
    // discard any sample that is zero or negative (sensor dropout / offset error).
    valid_idx = find(vibration > 0);
    if length(valid_idx) < 2 then
        error('linearize_vib: need at least 2 positive vibration samples to fit.');
    end

    // ---- Force Column Vectors and apply valid-index mask ----
    h   = hours(valid_idx)(:);       // (m x 1) column, only valid rows
    v   = vibration(valid_idx)(:);   // (m x 1) column, only valid rows
    n   = length(h);                 // number of usable data points

    // ---- Log-Linearisation ----
    //
    // Starting model:   V(h) = a * exp(b * h)
    //
    // Take the natural logarithm of both sides:
    //   ln(V) = ln(a) + b * h
    //
    // Substituting  w = ln(V),  c0 = ln(a),  c1 = b :
    //   w = c0 + c1 * h          <-- this is now a LINEAR equation in h
    //
    // So the "response" in transformed space is w = ln(V),
    // and the "predictor" is h (operational hours).

    w = log(v);   // (m x 1) log-transformed vibration (the new response)

    // ---- Design Matrix (2 columns for a degree-1 linear fit) ----
    //
    // For the linear model  w = c0 * 1 + c1 * h  we need:
    //   Column 1: all ones  (for the intercept c0 = ln(a))
    //   Column 2: h values  (for the slope    c1 = b)
    //
    //   Z = [ 1   h(1) ]
    //       [ 1   h(2) ]
    //       [ ...      ]
    //       [ 1   h(n) ]

    Z = [ones(n, 1), h];   // (n x 2) design matrix

    // ---- Normal Equations: c = (Z'Z)^{-1} Z'w ----
    //
    // The backslash operator solves the system (Z'Z) * c = Z'w
    // without explicitly forming the inverse, which is more numerically
    // stable than writing inv(Z'*Z) * (Z'*w).

    c = (Z' * Z) \ (Z' * w);   // c is (2 x 1): [c0; c1]

    // ---- Recover Original Parameters ----
    //
    // From the substitution above:
    //   c(1) = ln(a)  =>  a = exp(c(1))
    //   c(2) = b      =>  b = c(2) directly

    a = exp(c(1));   // scale factor  (always positive because exp > 0)
    b = c(2);        // growth rate   (positive for a degrading pump)

endfunction


// ------------------------------------------------------------
// Function 2: predict_vibration
//
// Evaluates the fitted exponential model at new hour values.
//
// Input:
//   a       - scale factor from linearize_vib()
//   b       - growth rate from linearize_vib()
//   h_query - scalar or vector of hour values
//
// Output:
//   vib_query - predicted vibration values (same size as h_query)
// ------------------------------------------------------------
function [vib_query] = predict_vibration(a, b, h_query)

    // Apply the exponential model element-wise:
    //   V(h) = a * exp(b * h)
    //
    // The element-wise operator .* ensures this works whether h_query
    // is a scalar, a row vector, or a column vector — no loop needed.
    // The output shape matches h_query exactly.

    vib_query = a .* exp(b .* h_query);

endfunction
