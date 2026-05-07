// ============================================================
// test_integration.sci  —  Full Pipeline Integration Test
// Runs all four modules in sequence and checks final outputs
// ============================================================

funcprot(0);
base = fullfile(get_absolute_file_path('test_integration.sci'), '..');

exec(fullfile(base, 'data_loader',    'load_data.sci'),      -1);
exec(fullfile(base, 'interpolation',  'interpolation.sci'),  -1);
exec(fullfile(base, 'differentiation','differentiation.sci'),-1);
exec(fullfile(base, 'integration',    'integration.sci'),    -1);
exec(fullfile(base, 'user_interface', 'health_dashboard.sci'),-1);

passed = 0;
failed = 0;

disp('--- Integration Test: Full Pipeline ---');

data_file = fullfile(base, '..', 'pump_health_data.csv');
if ~isfile(data_file) then
    disp('SKIP: pump_health_data.csv not found. Run the instructor data generator first.');
    return;
end

// ---- INT-1: load_data ----
[pressure, voltage, hours, vibration] = load_data(data_file);
if length(hours) >= 100 then
    mprintf('  PASS  INT-1: load_data -> %d rows\n', length(hours));
    passed = passed + 1;
else
    mprintf('  FAIL  INT-1: expected >=100 rows, got %d\n', length(hours));
    failed = failed + 1;
end

// ---- INT-2: poly_fit R² on voltage → pressure ----
coeff_poly = poly_fit(voltage, pressure, 3);
press_poly = eval_poly(coeff_poly, voltage);
[rmse_A, r2_A] = goodness_of_fit(pressure, press_poly);
if r2_A > 0.95 then
    mprintf('  PASS  INT-2: polynomial fit R2=%.4f\n', r2_A);
    passed = passed + 1;
else
    mprintf('  FAIL  INT-2: polynomial R2=%.4f (expected > 0.95)\n', r2_A);
    failed = failed + 1;
end

// ---- INT-3: exponential fit R² on hours → vibration ----
[a_exp, b_exp] = linearize_vib(hours, vibration);
vib_exp        = predict_vibration(a_exp, b_exp, hours);
[rmse_B, r2_B] = goodness_of_fit(vibration, vib_exp);
if r2_B > 0.95 then
    mprintf('  PASS  INT-3: exponential fit R2=%.4f\n', r2_B);
    passed = passed + 1;
else
    mprintf('  FAIL  INT-3: exponential R2=%.4f (expected > 0.95)\n', r2_B);
    failed = failed + 1;
end

// ---- INT-4: failure hour in plausible range ----
// True model: xi(h)=2.1*exp(0.00035*h), threshold=9.5  =>  h* ~ 4312 h
// Data runs ~200-5000 h so h* is WITHIN the data range.
// Accept any finite result between 3000 h and 6000 h.
THRESHOLD = 9.5;
h_star    = find_threshold_hour(hours, vib_exp, THRESHOLD);
if ~isinf(h_star) & h_star > 3000 & h_star < 6000 then
    mprintf('  PASS  INT-4: h_star=%.1f h (expected approximately 4300 h)\n', h_star);
    passed = passed + 1;
else
    mprintf('  FAIL  INT-4: h_star=%.1f (expected finite value between 3000 and 6000 h)\n', h_star);
    failed = failed + 1;
end

// ---- INT-5: HI values in [0,1] ----
HI = compute_health_index(vibration, THRESHOLD);
if min(HI) >= 0 & max(HI) <= 1 then
    mprintf('  PASS  INT-5: HI in [%.3f, %.3f]\n', min(HI), max(HI));
    passed = passed + 1;
else
    mprintf('  FAIL  INT-5: HI out of [0,1]: min=%.3f max=%.3f\n', min(HI), max(HI));
    failed = failed + 1;
end

// ---- INT-6: plot_report runs without error ----
try
    plot_report(hours, vibration, vib_exp, HI, THRESHOLD, h_star);
    disp('  PASS  INT-6: plot_report completed without error');
    passed = passed + 1;
catch
    mprintf('  FAIL  INT-6: plot_report error: %s\n', lasterror());
    failed = failed + 1;
end

mprintf('\n  Integration Results: %d passed, %d failed\n', passed, failed);
