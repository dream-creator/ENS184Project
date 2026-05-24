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
// Input:  vibration (n), threshold (scalar)
// Output: HI (n), values clamped to [0, 1]
// ------------------------------------------------------------
function [HI] = compute_health_index(vibration, threshold)

    // Validate threshold — must be positive
    if threshold <= 0 then
        error('compute_health_index: threshold must be positive.');
    end

    // Ensure vibration is a column vector
    vibration = vibration(:);

    // Compute Health Index: normalise by threshold
    // HI = vibration / threshold  (threshold maps to HI = 1)
    HI = vibration / threshold;

    // Clamp to [0, 1]: max(..., 0) removes negatives, min(..., 1) caps above threshold
    HI = min(max(HI, 0), 1);

endfunction


// ------------------------------------------------------------
// Function 2: plot_report
// Input:  hours, vibration, vib_fit, HI, threshold, h_star
// Output: none (saves pump_health_report_v2.png)
// ------------------------------------------------------------
function plot_report(hours, vibration, vib_fit, HI, threshold, h_star)

    // Ensure all inputs are column vectors
    hours     = hours(:);
    vibration = vibration(:);
    vib_fit   = vib_fit(:);
    HI        = HI(:);
    n         = length(hours);

    // h_known is true when h_star is a real finite hour value
    h_known = ~isinf(h_star) & ~isnan(h_star);

    // Create figure
    fig = scf(10); clf();
    fig.figure_size = [950, 720];
    fig.figure_name = 'FlowGuard 5000 -- Pump Health Report';

    // --------------------------------------------------------
    // Panel 1 (top): Vibration vs Operational Hours
    // --------------------------------------------------------
    subplot(2, 1, 1);

    scatter(hours, vibration, 18, [0.15 0.40 0.75]);        // measured data, blue
    plot(hours, vib_fit, 'r-');                              // exponential fit, red solid
    plot(hours, threshold * ones(n, 1), 'k--');              // failure threshold, black dashed

    if h_known then
        plot([h_star, h_star], [0, threshold * 1.35], 'm-.'); // vertical marker, magenta
    end

    xlabel('Operational Hours (h)');
    ylabel('Vibration Amplitude (mm/s rms)');
    title('Vibration Degradation: Data, Exponential Fit, and Failure Threshold');

    if h_known then
        legend(['Measured vibration'; 'Exponential fit'; 'Failure threshold'; 'Predicted failure h*'], 2);
    else
        legend(['Measured vibration'; 'Exponential fit'; 'Failure threshold'], 2);
    end

    xgrid(1);

    // --------------------------------------------------------
    // Panel 2 (bottom): Health Index vs Operational Hours
    // --------------------------------------------------------
    subplot(2, 1, 2);

    plot(hours, 0.75 * ones(n, 1), 'g--');   // GOOD/WARNING boundary
    plot(hours, 0.90 * ones(n, 1), 'y--');   // WARNING/CRITICAL boundary
    plot(hours, ones(n, 1),        'r--');   // failure level
    plot(hours, HI,                'b-');    // Health Index curve

    if h_known then
        plot([h_star, h_star], [0, 1.05], 'm-.');  // vertical marker, magenta
    end

    xlabel('Operational Hours (h)');
    ylabel('Health Index (HI)');
    title('Pump Health Index  [ GOOD: HI < 0.75 | WARNING: 0.75-0.90 | CRITICAL: > 0.90 ]');

    if h_known then
        legend(['HI = 0.75 (WARNING)'; 'HI = 0.90 (CRITICAL)'; 'HI = 1.0 (FAILURE)'; 'Health Index'; 'Predicted failure h*'], 2);
    else
        legend(['HI = 0.75 (WARNING)'; 'HI = 0.90 (CRITICAL)'; 'HI = 1.0 (FAILURE)'; 'Health Index'], 2);
    end

    xgrid(1);

    // Save figure
    xs2png(fig, 'pump_health_report_v2.png');
    disp('Report saved: pump_health_report_v2.png');

endfunction
