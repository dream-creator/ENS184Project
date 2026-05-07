// ============================================================
// main.sce  —  Student D Skeleton (Task D3)
// FlowGuard 5000 — Pump Health Monitoring  (Version 2)
//
// NAME: ________________________________
// ID:   ________________________________
//
// This is the MAIN SCRIPT that ties all modules together.
// Fill in the TODO sections to call functions from each module.
// Do NOT modify function signatures in other files.
//
// Run this script from the StudentD/ directory.
// ============================================================

funcprot(0);

// ---- Path Setup ----
base_dir  = get_absolute_file_path('main.sce');      // StudentD/
phm_dir   = fullfile(base_dir, '..', 'phm_project'); // phm_project/
data_file = fullfile(base_dir, '..', 'pump_health_data.csv');

// ---- Load Modules (StudentD owns load_data and health_dashboard) ----
exec(fullfile(base_dir, 'load_data.sci'),                           -1);
exec(fullfile(phm_dir,  'interpolation',  'interpolation.sci'),     -1);
exec(fullfile(phm_dir,  'differentiation','differentiation.sci'),   -1);
exec(fullfile(phm_dir,  'integration',    'integration.sci'),       -1);
exec(fullfile(base_dir, 'health_dashboard.sci'),                    -1);

THRESHOLD = 9.5;   // mm/s_rms — do not change

// ============================================================
// STEP 1 — Load Data
// ============================================================
disp('=== Step 1: Load sensor data ===');

// TODO: call load_data(data_file) to get:
//   [pressure, voltage, hours, vibration]


// ============================================================
// STEP 2 — Student A: Polynomial Fit (voltage → pressure)
// ============================================================
disp('=== Step 2: Polynomial fit (voltage → pressure, k=3) ===');

// TODO: call poly_fit(voltage, pressure, 3)  → coeff_poly
// TODO: call eval_poly(coeff_poly, voltage)  → press_poly


// ============================================================
// STEP 3 — Student B: Exponential Fit (hours → vibration)
// ============================================================
disp('=== Step 3: Exponential fit (hours → vibration) ===');

// TODO: call linearize_vib(hours, vibration)       → [a_exp, b_exp]
// TODO: call predict_vibration(a_exp, b_exp, hours) → vib_exp


// ============================================================
// STEP 4 — Student C: Metrics + Failure Hour
// ============================================================
disp('=== Step 4: Goodness-of-fit and failure hour ===');

// TODO: call goodness_of_fit(pressure, press_poly)  → [rmse_A, r2_A]
// TODO: call goodness_of_fit(vibration, vib_exp)    → [rmse_B, r2_B]
// TODO: print both RMSE and R² values

// TODO: call find_threshold_hour(hours, vib_exp, THRESHOLD) → h_star
// TODO: print h_star


// ============================================================
// STEP 5 — Student D: Health Index + Plot
// ============================================================
disp('=== Step 5: Health Index and report plot ===');

// TODO: call compute_health_index(vibration, THRESHOLD) → HI
// TODO: call plot_report(hours, vibration, vib_exp, HI, THRESHOLD, h_star)


// ============================================================
// SUMMARY REPORT — print to console
// ============================================================
disp('');
disp('==================================================');
disp('   PUMP HEALTH MONITORING  —  SUMMARY            ');
disp('==================================================');
// TODO: use mprintf to print each item on its own line, e.g.:
//   mprintf('  Data points loaded   : %d\n',       length(hours));
//   mprintf('  Exp. model           : a=%.4f, b=%.6f\n', a_exp, b_exp);
//   mprintf('  Polynomial fit R2    : %.4f  (RMSE = %.4f bar)\n', r2_A, rmse_A);
//   mprintf('  Exponential fit R2   : %.4f  (RMSE = %.4f mm/s)\n', r2_B, rmse_B);
//   if isinf(h_star)
//       disp('  Predicted failure    : threshold not reached');
//   else
//       mprintf('  Predicted failure    : h* = %.1f h\n', h_star);
//   end
//   mprintf('  Current Health Index : %.2f\n', HI($));
disp('==================================================');
