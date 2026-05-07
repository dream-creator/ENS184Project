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
//
// Hints:
//   - Applying a natural logarithm to V(h) = a·exp(b·h) transforms it
//     into a linear equation.  Write out what that equation looks like.
//   - Once linearized, identify the predictor and the response in the
//     transformed space, then apply the same least-squares approach
//     that poly_fit uses (design matrix + Normal Equations).
//   - How many columns does the design matrix need for a linear fit?
//   - After fitting the linearized model, how do you recover the
//     original parameters a and b from the fitted coefficients?
//   - Ensure hours and vibration are column vectors.
// ------------------------------------------------------------
function [a, b] = linearize_vib(hours, vibration)

    // TODO: validate inputs — lengths match, no vibration values <= 0

    // TODO: force column vectors;  compute n = length(hours)

    // TODO: applying ln() to V(h) = a·exp(b·h) turns it into a linear
    //       equation.  What are the new predictor and response variables?
    //       Build a 2-column design matrix and apply the Normal Equations
    //       (exactly as you did in poly_fit, but for degree 1).

    // TODO: once you have the two fitted coefficients, how do you recover
    //       the original a and b from them?

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
//
// Hint:  Apply the exponential model element-wise to h_query.
// ------------------------------------------------------------
function [vib_query] = predict_vibration(a, b, h_query)

    // TODO: evaluate V(h) = a * exp(b * h) at every element of h_query.
    //       Use element-wise operators so the function accepts both
    //       scalar and vector inputs without a loop.

endfunction
