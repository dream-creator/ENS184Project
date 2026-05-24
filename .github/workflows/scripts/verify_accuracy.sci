// Load all modules using relative paths
exec('phm_project/data_loader/load_data.sci', -1);
exec('phm_project/differentiation/differentiation.sci', -1);
exec('phm_project/integration/integration.sci', -1);
exec('phm_project/user_interface/health_dashboard.sci', -1);

// Load real data
data_file = 'pump_health_data.csv';
if ~isfile(data_file) then
    disp('Error: pump_health_data.csv not found!');
    exit(1);
end

[pressure, voltage, hours, vibration] = load_data(data_file);

// Student B verification
[a, b] = linearize_vib(hours, vibration);
vib_fit = predict_vibration(a, b, hours);

// Student C verification
[rmse_B, r2_B] = goodness_of_fit(vibration, vib_fit);
h_star = find_threshold_hour(hours, vib_fit, 9.5);

// Student D verification
HI_raw = compute_health_index(vibration, 9.5);
HI_fit = compute_health_index(vib_fit, 9.5);

success = 1;

mprintf('=== CI NUMERICAL ACCURACY CHECK ===\n');

// 1. Check a ≈ 2.09
mprintf('a (scale)        : %.6f (expect ~2.09)\n', a);
if abs(a - 2.09) > 0.05 then
    disp('FAIL: a is not approx 2.09');
    success = 0;
else
    disp('PASS: a is approx 2.09');
end

// 2. Check b ≈ 0.00035
mprintf('b (growth rate)  : %.8f (expect ~0.00035)\n', b);
if abs(b - 0.00035) > 0.00005 then
    disp('FAIL: b is not approx 0.00035');
    success = 0;
else
    disp('PASS: b is approx 0.00035');
end

// 3. Check R^2 > 0.95
mprintf('R2               : %.6f (expect > 0.95)\n', r2_B);
if r2_B <= 0.95 then
    disp('FAIL: R2 is not > 0.95');
    success = 0;
else
    disp('PASS: R2 is > 0.95');
end

// 4. Check h* = 3000-6000
mprintf('h_star           : %.2f h (expect 3000-6000)\n', h_star);
if h_star < 3000 | h_star > 6000 then
    disp('FAIL: h* is not in range 3000-6000');
    success = 0;
else
    disp('PASS: h* is in range 3000-6000');
end

// 5. Check HI in [0, 1]
mprintf('HI_raw min       : %.4f (expect >= 0)\n', min(HI_raw));
mprintf('HI_raw max       : %.4f (expect <= 1)\n', max(HI_raw));
mprintf('HI_fit min       : %.4f (expect >= 0)\n', min(HI_fit));
mprintf('HI_fit max       : %.4f (expect <= 1)\n', max(HI_fit));
if min(HI_raw) < 0 | max(HI_raw) > 1 | min(HI_fit) < 0 | max(HI_fit) > 1 then
    disp('FAIL: HI not in [0, 1]');
    success = 0;
else
    disp('PASS: HI in [0, 1]');
end

if success == 1 then
    disp('All numerical accuracy checks passed!');
    exit(0);
else
    disp('Numerical accuracy checks failed!');
    exit(1);
end
