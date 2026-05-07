// ============================================================
// health_dashboard.sci  —  Student D Module  [INTEGRATION COPY]
// Health Index and Two-Panel Report Plot
//
// HOW TO USE THIS FILE:
//   1. Develop and test your code in  StudentD/health_dashboard.sci
//   2. When ready to run the test suite, COPY your finished
//      implementation into THIS file (replace the stubs below).
//   3. Run:  exec('test_suites/test_studentD.sci', -1)
//      from the phm_project/ directory.
// ============================================================

// ------------------------------------------------------------
// Function 1: compute_health_index
// Input:  vibration (n), threshold (scalar)
// Output: HI (n), values clamped to [0, 1]
// ------------------------------------------------------------
function [HI] = compute_health_index(vibration, threshold)

    // TODO — see StudentD/health_dashboard.sci for task details
    HI = zeros(length(vibration(:)), 1);

endfunction


// ------------------------------------------------------------
// Function 2: plot_report
// Input:  hours, vibration, vib_fit, HI, threshold, h_star
// Output: none (saves pump_health_report_v2.png)
// ------------------------------------------------------------
function plot_report(hours, vibration, vib_fit, HI, threshold, h_star)

    // TODO — see StudentD/health_dashboard.sci for task details

endfunction
