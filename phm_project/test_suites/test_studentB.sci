// ============================================================
// test_studentB.sci  —  Unit Tests for Student B
// Tests: linearize_vib() and predict_vibration()
// ============================================================

exec(fullfile(get_absolute_file_path('test_studentB.sci'), '..', 'differentiation', 'differentiation.sci'), -1);

passed = 0;
failed = 0;
tol    = 1e-4;

disp('--- Test Suite: Student B (differentiation) ---');

// ---- Test B1: linearize_vib recovers known a, b ----
// True model: V(h) = 2.0 * exp(0.0003 * h)
a_true = 2.0;
b_true = 0.0003;
h1 = (100:100:1000)';
v1 = a_true .* exp(b_true .* h1);   // exact exponential, no noise
[a_got, b_got] = linearize_vib(h1, v1);
if abs(a_got - a_true) < tol & abs(b_got - b_true) < tol then
    disp('  PASS  B1: linearize_vib recovers exact a and b');
    passed = passed + 1;
else
    mprintf('  FAIL  B1: a_true=%.4f got=%.4f, b_true=%.6f got=%.6f\n', a_true, a_got, b_true, b_got);
    failed = failed + 1;
end

// ---- Test B2: predict_vibration returns correct values ----
a2 = 3.0;
b2 = 0.0005;
h2 = [0; 500; 1000];
v2_exp = a2 .* exp(b2 .* h2);
v2_got = predict_vibration(a2, b2, h2);
if max(abs(v2_got - v2_exp)) < tol then
    disp('  PASS  B2: predict_vibration computes correct values');
    passed = passed + 1;
else
    disp('  FAIL  B2: predict_vibration error');
    disp(v2_got - v2_exp);
    failed = failed + 1;
end

// ---- Test B3: linearize_vib + predict_vibration round-trip ----
a3_true = 2.1;
b3_true = 0.00035;
h3 = (500:500:5000)';
v3 = a3_true .* exp(b3_true .* h3);
[a3, b3] = linearize_vib(h3, v3);
v3_hat   = predict_vibration(a3, b3, h3);
rmse3    = sqrt(mean((v3_hat - v3) .^ 2));
if rmse3 < 1e-6 then
    disp('  PASS  B3: round-trip RMSE < 1e-6 on exact exponential data');
    passed = passed + 1;
else
    mprintf('  FAIL  B3: round-trip RMSE = %.2e\n', rmse3);
    failed = failed + 1;
end

// ---- Test B4: predict_vibration handles scalar input ----
v4 = predict_vibration(1.0, 0.001, 0);
if abs(v4 - 1.0) < tol then
    disp('  PASS  B4: predict_vibration at h=0 returns a (=1.0)');
    passed = passed + 1;
else
    mprintf('  FAIL  B4: expected 1.0, got %.6f\n', v4);
    failed = failed + 1;
end

// ---- Test B5: a > 0 and b > 0 on realistic data ----
h5 = (100:50:3000)';
v5 = 2.1 .* exp(0.00035 .* h5) + 0.05 * rand(length(h5), 1);
[a5, b5] = linearize_vib(h5, v5);
if a5 > 0 & b5 > 0 then
    disp('  PASS  B5: a > 0 and b > 0 on noisy exponential data');
    passed = passed + 1;
else
    mprintf('  FAIL  B5: a=%.4f, b=%.6f\n', a5, b5);
    failed = failed + 1;
end

mprintf('\n  Results: %d passed, %d failed\n', passed, failed);
