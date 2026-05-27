// Dynamically get the current Windows directory of this script
base_dir = get_absolute_file_path('verify_all.sce');

// Load all modules using Windows-safe file paths
exec(fullfile(base_dir, 'data_loader', 'load_data.sci'), -1);
exec(fullfile(base_dir, 'differentiation', 'differentiation.sci'), -1);
exec(fullfile(base_dir, 'integration', 'integration.sci'), -1);
exec(fullfile(base_dir, 'user_interface', 'health_dashboard.sci'), -1);

// Load real data from the parent directory
data_file = fullfile(base_dir, '..', 'pump_health_data.csv');
[pressure, voltage, hours, vibration] = load_data(data_file);

// Student B verification
[a, b] = linearize_vib(hours, vibration);
vib_fit = predict_vibration(a, b, hours);

// Student C verification
[rmse_B, r2_B] = goodness_of_fit(vibration, vib_fit);
h_star = find_threshold_hour(hours, vib_fit, 9.5);

// Student D verification
HI = compute_health_index(vib_fit, 9.5);

// Print diagnostics
mprintf('=== NUMERICAL VERIFICATION ===\n');
mprintf('Data rows loaded : %d  (expect 120)\n', length(hours));
mprintf('hours range      : %.1f to %.1f h\n', min(hours), max(hours));
mprintf('vibration range  : %.4f to %.4f mm/s\n', min(vibration), max(vibration));
mprintf('--- Student B ---\n');
mprintf('a (scale)        : %.6f  (expect ~2.09)\n', a);
mprintf('b (growth rate)  : %.8f  (expect ~0.00035)\n', b);
mprintf('--- Student C ---\n');
mprintf('RMSE             : %.6f mm/s\n', rmse_B);
mprintf('R2               : %.6f  (expect > 0.95)\n', r2_B);
mprintf('h_star           : %.2f h  (expect 3000-6000)\n', h_star);
mprintf('--- Student D ---\n');
mprintf('HI min           : %.4f  (expect ~0.2 at start)\n', min(HI));
mprintf('HI max           : %.4f  (expect 1.0 at end)\n', max(HI));
mprintf('Negative HI      : %d  (expect 0)\n', sum(HI < 0));
mprintf('HI above 1       : %d  (expect 0)\n', sum(HI > 1));
exit;