// ============================================================
// test_studentD.sci  —  Unit Tests for Student D
// Tests: load_data(), compute_health_index(), plot_report()
// ============================================================

base = fullfile(get_absolute_file_path('test_studentD.sci'), '..');
exec(fullfile(base, 'data_loader',    'load_data.sci'),       -1);
exec(fullfile(base, 'user_interface', 'health_dashboard.sci'),-1);

passed = 0;
failed = 0;
tol    = 1e-6;

disp('--- Test Suite: Student D (data_loader + health_dashboard) ---');

// ---- Test D1: load_data returns 4 vectors ----
data_file = fullfile(base, '..', 'pump_health_data.csv');
if ~isfile(data_file) then
    disp('  SKIP  D1/D2: pump_health_data.csv not found');
else
    [pressure, voltage, hours, vibration] = load_data(data_file);
    n = length(hours);
    if n > 10 & length(pressure) == n & length(voltage) == n & length(vibration) == n then
        mprintf('  PASS  D1: load_data returns 4 vectors of length %d\n', n);
        passed = passed + 1;
    else
        disp('  FAIL  D1: load_data vector lengths mismatch or too short');
        failed = failed + 1;
    end

    // ---- Test D2: hours are positive and increasing ----
    if min(hours) >= 0 & min(diff(hours)) > 0 then
        disp('  PASS  D2: hours are non-negative and monotonically increasing');
        passed = passed + 1;
    else
        disp('  FAIL  D2: hours are not valid (negative or non-monotone)');
        failed = failed + 1;
    end
end

// ---- Test D3: compute_health_index clamps values ----
vib3   = [0; 5; 9.5; 12; -1];
thresh = 9.5;
HI3    = compute_health_index(vib3, thresh);
expected3 = [0; 5/9.5; 1; 1; 0];
if max(abs(HI3 - expected3)) < tol then
    disp('  PASS  D3: compute_health_index clamps correctly');
    passed = passed + 1;
else
    disp('  FAIL  D3: compute_health_index clamping wrong');
    disp([HI3, expected3]);
    failed = failed + 1;
end

// ---- Test D4: HI scales linearly below threshold ----
vib4 = [1; 2; 3; 4];
HI4  = compute_health_index(vib4, 10);
exp4 = vib4 / 10;
if max(abs(HI4 - exp4)) < tol then
    disp('  PASS  D4: HI = vibration / threshold when below threshold');
    passed = passed + 1;
else
    disp('  FAIL  D4: HI does not scale correctly');
    failed = failed + 1;
end

// ---- Test D5: plot_report creates file ----
// (Smoke test only — check that no error is thrown and file is created)
if isfile(data_file) then
    vib5   = vibration;
    HI5    = compute_health_index(vib5, 9.5);
    vib_fit5 = vib5;   // identity (pass raw as fit for test)
    errmsg = '';
    try
        plot_report(hours, vib5, vib_fit5, HI5, 9.5, 4000);
        if isfile('pump_health_report_v2.png') then
            disp('  PASS  D5: plot_report runs and saves PNG');
            passed = passed + 1;
        else
            disp('  FAIL  D5: plot_report ran but PNG not found');
            failed = failed + 1;
        end
    catch
        mprintf('  FAIL  D5: plot_report threw an error: %s\n', lasterror());
        failed = failed + 1;
    end
else
    disp('  SKIP  D5: data file not available');
end

mprintf('\n  Results: %d passed, %d failed\n', passed, failed);
