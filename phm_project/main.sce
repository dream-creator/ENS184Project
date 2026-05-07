// ============================================================
// main.sce  —  Pump Health Monitoring  (Version 2)
// FlowGuard 5000  |  ENS 184 Mini-Project
//
// Run this file from the phm_project/ directory.
// Fill in each STEP by calling the appropriate function.
// ============================================================

funcprot(0);

// ---- Path Setup ----
base_dir  = get_absolute_file_path('main.sce');
data_file = fullfile(base_dir, '..', 'pump_health_data.csv');

// ---- Load All Modules ----
exec(fullfile(base_dir, 'data_loader',    'load_data.sci'),      -1);
exec(fullfile(base_dir, 'interpolation',  'interpolation.sci'),  -1);
exec(fullfile(base_dir, 'differentiation','differentiation.sci'),-1);
exec(fullfile(base_dir, 'integration',    'integration.sci'),    -1);
exec(fullfile(base_dir, 'user_interface', 'health_dashboard.sci'),-1);

THRESHOLD = 9.5;   // vibration failure level [mm/s_rms] — fixed by spec

// ============================================================
// STEP 1 — Load Data  (pre-implemented for all teams)
// ============================================================
disp('=== Step 1: Load sensor data ===');

// TODO: call load_data(data_file) to get [pressure, voltage, hours, vibration]


// ============================================================
// STEP 2 — Student A: Polynomial Fit  (voltage → pressure)
// ============================================================
disp('=== Step 2: Polynomial fit (voltage → pressure, k=3) ===');

// TODO: call poly_fit(voltage, pressure, 3)  → coeff_poly
// TODO: call eval_poly(coeff_poly, voltage)  → press_poly


// ============================================================
// STEP 3 — Student B: Exponential Fit  (hours → vibration)
// ============================================================
disp('=== Step 3: Exponential fit (hours → vibration) ===');

// TODO: call linearize_vib(hours, vibration)        → [a_exp, b_exp]
// TODO: call predict_vibration(a_exp, b_exp, hours) → vib_exp


// ============================================================
// STEP 4 — Student C: Metrics + Failure Hour
// ============================================================
disp('=== Step 4: Goodness-of-fit and failure hour ===');

// TODO: call goodness_of_fit(pressure, press_poly)           → [rmse_A, r2_A]
// TODO: call goodness_of_fit(vibration, vib_exp)             → [rmse_B, r2_B]
// TODO: print rmse_A, r2_A, rmse_B, r2_B
// TODO: call find_threshold_hour(hours, vib_exp, THRESHOLD)  → h_star
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
// TODO: use mprintf to print each item, e.g.:
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
