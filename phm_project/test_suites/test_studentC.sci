// ============================================================
// test_studentC.sci  —  Unit Tests for Student C
// Tests: goodness_of_fit() and find_threshold_hour()
// ============================================================

exec(fullfile(get_absolute_file_path('test_studentC.sci'), '..', 'integration', 'integration.sci'), -1);

passed = 0;
failed = 0;
tol    = 1e-6;

disp('--- Test Suite: Student C (integration) ---');

// ---- Test C1: goodness_of_fit on perfect fit ----
y1     = [1; 2; 3; 4; 5];
[r1, r2_1] = goodness_of_fit(y1, y1);
if abs(r1) < tol & abs(r2_1 - 1) < tol then
    disp('  PASS  C1: perfect fit gives RMSE=0 and R²=1');
    passed = passed + 1;
else
    mprintf('  FAIL  C1: RMSE=%.6f (exp 0), R2=%.6f (exp 1)\n', r1, r2_1);
    failed = failed + 1;
end

// ---- Test C2: goodness_of_fit known RMSE ----
// y_actual = [0,0,0,0], y_pred = [1,1,1,1]  → RMSE = 1
ya2 = [0; 0; 0; 0];
yp2 = [1; 1; 1; 1];
[rmse2, dummy] = goodness_of_fit(ya2, yp2);
if abs(rmse2 - 1) < tol then
    disp('  PASS  C2: goodness_of_fit RMSE = 1.0 on constant offset');
    passed = passed + 1;
else
    mprintf('  FAIL  C2: expected RMSE=1, got %.6f\n', rmse2);
    failed = failed + 1;
end

// ---- Test C3: goodness_of_fit known R² ----
// y_actual = [1;2;3;4;5], y_pred = mean = 3 (constant)
// SS_res = sum of ((yi - 3)^2) = 4+1+0+1+4 = 10
// SS_tot = same = 10  →  R² = 0
ya3 = [1; 2; 3; 4; 5];
yp3 = [3; 3; 3; 3; 3];
[dummy, r2_3] = goodness_of_fit(ya3, yp3);
if abs(r2_3 - 0) < tol then
    disp('  PASS  C3: predicting mean gives R² = 0');
    passed = passed + 1;
else
    mprintf('  FAIL  C3: expected R2=0, got %.6f\n', r2_3);
    failed = failed + 1;
end

// ---- Test C4: find_threshold_hour on linear ramp ----
// vib grows linearly from 5 to 10 over hours 0..1000
// threshold = 8.0  → h_star = 600 exactly
h4   = (0:100:1000)';
v4   = 5 + 0.005 .* h4;     // 5 at h=0, 10 at h=1000
thresh4 = 8.0;               // crossed at h=600
h_star4 = find_threshold_hour(h4, v4, thresh4);
if abs(h_star4 - 600) < 1.0 then   // within 1 hour
    mprintf('  PASS  C4: find_threshold_hour = %.2f (expected 600)\n', h_star4);
    passed = passed + 1;
else
    mprintf('  FAIL  C4: expected h*=600, got %.2f\n', h_star4);
    failed = failed + 1;
end

// ---- Test C5: find_threshold_hour returns Inf when never reached ----
h5   = (0:100:500)';
v5   = 2 + 0.002 .* h5;    // max 3, never reaches 9.5
h_star5 = find_threshold_hour(h5, v5, 9.5);
if isinf(h_star5) then
    disp('  PASS  C5: returns Inf when threshold never reached');
    passed = passed + 1;
else
    mprintf('  FAIL  C5: expected Inf, got %.2f\n', h_star5);
    failed = failed + 1;
end

mprintf('\n  Results: %d passed, %d failed\n', passed, failed);
