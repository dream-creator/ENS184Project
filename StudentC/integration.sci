// ============================================================
// integration.sci  —  Student C Skeleton
// Goodness-of-Fit Metrics and Failure-Hour Prediction
//
// NAME: Terence Jay C. Eborda
// ID:   2024 -0746
//
// You must implement TWO functions in this file.
// Do NOT change the function signatures.
//
// FORBIDDEN: Do NOT use Scilab's built-in fsolve(), roots(), or any
// root-finding builtin for find_threshold_hour.  Implement bisection
// from scratch as described in the manual.
// ============================================================

funcprot(0);   // suppress redefinition warnings when re-running

// ------------------------------------------------------------
// Function 1: goodness_of_fit
//
// Computes two model-accuracy metrics: RMSE and R².
//
// Input:
//   y_actual - vector of observed (measured) values    (n)
//   y_pred   - vector of model-predicted values        (n)
//
// Output:
//   rmse - Root-Mean-Square Error  (scalar, lower = better)
//   r2   - Coefficient of Determination  (scalar, closer to 1 = better)
//
// Hints:
//   - RMSE measures the typical size of prediction errors.  Start by
//     computing each residual (actual minus predicted), then build the
//     "root mean square" from those residuals.
//   - R² compares your model's total squared error against the baseline
//     error of simply predicting the mean of y_actual.  Write out both
//     sums explicitly before coding them.
//   - Consider what R² should equal when all observed values are identical
//     (SS_tot = 0) and handle that case explicitly.
// ------------------------------------------------------------
function [rmse, r2] = goodness_of_fit(y_actual, y_pred)
    
    // Number of data points
    n = length(y_actual);
    
    // 1. Calculate RMSE (Root-Mean-Square Error)
    // Formula: sqrt( 1/n * sum( (actual - predicted)^2 ) )
    mse = sum((y_actual - y_pred).^2) / n;
    rmse = sqrt(mse);

    // 2. Calculate R^2 (Coefficient of Determination)
    y_mean = mean(y_actual);
    
    // SST: Total Sum of Squares (variance of the actual data)
    SST = sum((y_actual - y_mean).^2); 
    
    // SSE: Sum of Squared Errors (unexplained variance)
    SSE = sum((y_actual - y_pred).^2); 

    // Edge Case Handling: Prevent "Divide by Zero" crash
    // If SST is exactly 0, it means the actual data is a flat line.
    if SST == 0 then
        r2 = 0;
    else
        r2 = 1 - (SSE / SST);
    end

endfunction


// ------------------------------------------------------------
/// Function 2: find_threshold_hour
//
// Uses bisection to find the hour h* at which the fitted
// vibration curve first crosses the failure threshold.
//
// Input:
//   hours     - sorted hour vector (from load_data)           (n)
//   vib_fit   - fitted vibration vector (from predict_vibration) (n)
//   threshold - failure vibration level (scalar, e.g. 9.5)
//
// Output:
//   h_star - predicted failure hour (scalar)
//            Returns Inf if vibration never reaches threshold.
//
// Hints:
//   - First handle the edge case: what should the function return if
//     vibration never reaches the threshold?
//   - Scan vib_fit to find a consecutive pair of points that "straddle"
//     the threshold (one below, the next at or above).  This gives your
//     starting bracket [h_lo, h_hi].
//   - Apply bisection: halve the bracket repeatedly, keeping whichever
//     half still contains the crossing.  Stop when the bracket width
//     is less than 0.5 h.
//   - Inside the bracket you have only the two endpoint values of
//     vib_fit.  How can you estimate vib_fit at any interior hour
//     without calling predict_vibration again?
//   - A for-loop with up to 100 iterations is plenty for convergence.
// ------------------------------------------------------------
function [h_star] = find_threshold_hour(hours, vib_fit, threshold)
    
    n = length(hours);
    idx = -1;

    // 1. The Bracket Scan
    // Loop through the vector to find where vibration crosses the threshold
    for i = 1:(n - 1)
        if vib_fit(i) < threshold & vib_fit(i+1) >= threshold then
            idx = i;
            break; // We found the crossing, stop scanning
        end
    end

    // If the loop finishes and idx is still -1, no crossing was found
    if idx == -1 then
        h_star = %inf;
        return; // Exit function early
    end

    // 2. Setup for Bisection Method
    hL = hours(idx);
    hR = hours(idx+1);
    vL = vib_fit(idx);
    vR = vib_fit(idx+1);
    
    // Stopping condition: when the bracket is extremely small (e.g., 0.001 hours)
    tol = 1e-3; 
    
    // 3. The Bisection Loop
    while (hR - hL) > tol
        // Calculate the midpoint hour
        h_mid = (hL + hR) / 2;
        
        // Because vib_fit is an array of discrete points, we must interpolate
        // to evaluate the vibration function g(h) at our new h_mid.
        slope = (vR - vL) / (hR - hL);
        v_mid = vL + slope * (h_mid - hL);

        // Check which side of the threshold the midpoint falls on
        if v_mid < threshold then
            // The crossing is to the right of the midpoint
            hL = h_mid;
            vL = v_mid; // Update boundary vibration
        else
            // The crossing is to the left of (or exactly on) the midpoint
            hR = h_mid;
            vR = v_mid; // Update boundary vibration
        end
    end

    // Return the final narrowed hour
    h_star = (hL + hR) / 2;

endfunction
