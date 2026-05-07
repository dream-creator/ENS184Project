// ============================================================
// health_dashboard.sci  —  Student D Skeleton (Task D2)
// Health Index and Two-Panel Report Plot
//
// NAME: ________________________________
// ID:   ________________________________
//
// Implement TWO functions in this file.
// Do NOT change the function signatures.
// ============================================================

funcprot(0);   // suppress redefinition warnings when re-running

// ------------------------------------------------------------
// Function 1: compute_health_index
//
// Normalises vibration by the failure threshold to produce
// a Health Index (HI) between 0 and 1.
//
// Input:
//   vibration - vector of vibration readings  (n)
//   threshold - failure threshold scalar  (e.g. 9.5 mm/s_rms)
//
// Output:
//   HI - Health Index vector (same length as vibration), in [0, 1]
//
// Hints:
//   - Normalise vibration so that the failure threshold maps to HI = 1.
//   - After computing HI, clamp any values that fall outside [0, 1].
//   - Ensure vibration is a column vector first.
// ------------------------------------------------------------
function [HI] = compute_health_index(vibration, threshold)

    // TODO: validate threshold (must be positive, use error() if not)

    // TODO: ensure vibration is a column vector

    // TODO: compute the Health Index from vibration and threshold

    // TODO: clamp the Health Index so no value falls outside [0, 1]

endfunction


// ------------------------------------------------------------
// Function 2: plot_report
//
// Generates a two-panel figure and saves it as a PNG file.
//
// Input:
//   hours     - operational hours (n)
//   vibration - measured vibration (n)
//   vib_fit   - fitted vibration curve (n)
//   HI        - Health Index vector (n)
//   threshold - failure threshold scalar
//   h_star    - predicted failure hour scalar
//
// Output: none (saves 'pump_health_report_v2.png')
//
// TARGET OUTPUT: See Figure 1 in the project manual (project_manual_v2.pdf)
// for the exact appearance your figure must reproduce.
//
// Panel 1 (top):  vibration data + fitted curve + threshold line + h_star
// Panel 2 (bottom): HI vs hours + zone boundary lines + h_star marker
//
// Required figure specification — follow EXACTLY (grading is automated):
//
//   fig = scf(10); clf()
//   fig.figure_size = [950, 720]
//   fig.figure_name = 'FlowGuard 5000 -- Pump Health Report'
//   n      = length(hours)
//   h_known = ~isinf(h_star) & ~isnan(h_star)   // %T when h_star is a real hour
//
// ---- Panel 1: subplot(2, 1, 1)  —  Vibration vs Operational Hours ----
//   scatter(hours, vibration, 18, [0.15 0.40 0.75])       // measured data, blue
//   plot(hours, vib_fit, 'r-')                             // exponential fit, red solid
//   plot(hours, threshold*ones(n,1), 'k--')                // failure threshold, black dashed
//   If h_known:
//     plot([h_star, h_star], [0, threshold*1.35], 'm-.')   // vertical marker, magenta
//   xlabel('Operational Hours (h)')
//   ylabel('Vibration Amplitude (mm/s rms)')
//   title('Vibration Degradation: Data, Exponential Fit, and Failure Threshold')
//   Legend when h_known (4 items):
//     legend(['Measured vibration';'Exponential fit';'Failure threshold';'Predicted failure h*'], 2)
//   Legend when NOT h_known (3 items):
//     legend(['Measured vibration';'Exponential fit';'Failure threshold'], 2)
//   xgrid(1)
//
// ---- Panel 2: subplot(2, 1, 2)  —  Health Index vs Operational Hours ----
//   plot(hours, 0.75*ones(n,1), 'g--')   // GOOD/WARNING boundary, green dashed
//   plot(hours, 0.90*ones(n,1), 'y--')   // WARNING/CRITICAL boundary, yellow dashed
//   plot(hours, ones(n,1),      'r--')   // failure level, red dashed
//   plot(hours, HI,             'b-')    // Health Index curve, blue solid
//   If h_known:
//     plot([h_star, h_star], [0, 1.05], 'm-.')             // vertical marker, magenta
//   xlabel('Operational Hours (h)')
//   ylabel('Health Index (HI)')
//   title('Pump Health Index  [ GOOD: HI < 0.75 | WARNING: 0.75-0.90 | CRITICAL: > 0.90 ]')
//   Legend when h_known (5 items):
//     legend(['HI = 0.75 (WARNING)';'HI = 0.90 (CRITICAL)';'HI = 1.0 (FAILURE)';'Health Index';'Predicted failure h*'], 2)
//   Legend when NOT h_known (4 items):
//     legend(['HI = 0.75 (WARNING)';'HI = 0.90 (CRITICAL)';'HI = 1.0 (FAILURE)';'Health Index'], 2)
//   xgrid(1)
//
// ---- Save (EXACT filename required for automated test D5) ----
//   xs2png(fig, 'pump_health_report_v2.png')
//   disp('Report saved: pump_health_report_v2.png')
// ------------------------------------------------------------
function plot_report(hours, vibration, vib_fit, HI, threshold, h_star)

    // TODO: ensure all inputs are column vectors; compute n = length(hours)
    // TODO: compute h_known = ~isinf(h_star) & ~isnan(h_star)

    // TODO: create figure — fig = scf(10); clf()
    //       set fig.figure_size = [950, 720]
    //       set fig.figure_name = 'FlowGuard 5000 -- Pump Health Report'

    // ---- Panel 1 (top) ----
    // TODO: subplot(2, 1, 1)
    // TODO: scatter(hours, vibration, 18, [0.15 0.40 0.75])
    // TODO: plot(hours, vib_fit, 'r-')
    // TODO: plot(hours, threshold*ones(n,1), 'k--')
    // TODO: if h_known: plot([h_star,h_star],[0,threshold*1.35],'m-.')
    // TODO: xlabel, ylabel, title, legend (see specification above), xgrid(1)

    // ---- Panel 2 (bottom) ----
    // TODO: subplot(2, 1, 2)
    // TODO: plot 0.75*ones with 'g--', 0.90*ones with 'y--', ones with 'r--'
    // TODO: plot(hours, HI, 'b-')
    // TODO: if h_known: plot([h_star,h_star],[0,1.05],'m-.')
    // TODO: xlabel, ylabel, title, legend (see specification above), xgrid(1)

    // TODO: xs2png(fig, 'pump_health_report_v2.png')
    // TODO: disp('Report saved: pump_health_report_v2.png')

endfunction
