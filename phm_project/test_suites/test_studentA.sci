// ============================================================
// test_studentA.sci  —  Unit Tests for Student A
// Tests: poly_fit() and eval_poly()
// ============================================================

// Load the student module (adjust path if needed)
exec(fullfile(get_absolute_file_path('test_studentA.sci'), '..', 'interpolation', 'interpolation.sci'), -1);

passed = 0;
failed = 0;
tol    = 1e-6;

disp('--- Test Suite: Student A (interpolation) ---');

// ---- Test A1: poly_fit on a known linear dataset ----
// y = 3 + 2*x  →  coeff should be [3; 2]
x1 = [0; 1; 2; 3; 4];
y1 = 3 + 2 .* x1;
c1 = poly_fit(x1, y1, 1);
if abs(c1(1) - 3) < tol & abs(c1(2) - 2) < tol then
    disp('  PASS  A1: poly_fit recovers linear coefficients');
    passed = passed + 1;
else
    mprintf('  FAIL  A1: expected [3; 2], got [%.6f; %.6f]\n', c1(1), c1(2));
    failed = failed + 1;
end

// ---- Test A2: poly_fit on a known quadratic dataset ----
// y = 1 - x + 0.5*x^2
x2 = [-2; -1; 0; 1; 2; 3];
y2 = 1 - x2 + 0.5 .* x2 .^ 2;
c2 = poly_fit(x2, y2, 2);
if abs(c2(1) - 1) < tol & abs(c2(2) - (-1)) < tol & abs(c2(3) - 0.5) < tol then
    disp('  PASS  A2: poly_fit recovers quadratic coefficients');
    passed = passed + 1;
else
    mprintf('  FAIL  A2: expected [1; -1; 0.5], got [%.6f; %.6f; %.6f]\n', c2(1), c2(2), c2(3));
    failed = failed + 1;
end

// ---- Test A3: eval_poly reproduces fit values ----
coeff3 = [2; -1; 3];   // 2 - x + 3x^2
x3_q   = [0; 1; 2];
y3_exp = [2; 4; 12];
y3_got = eval_poly(coeff3, x3_q);
if max(abs(y3_got - y3_exp)) < tol then
    disp('  PASS  A3: eval_poly evaluates polynomial correctly');
    passed = passed + 1;
else
    disp('  FAIL  A3: eval_poly gave wrong values');
    disp(y3_got);
    failed = failed + 1;
end

// ---- Test A4: poly_fit then eval_poly round-trip ----
x4 = (1:8)';
y4 = 0.5 .* x4 .^ 3 - 2 .* x4 + 1;
c4 = poly_fit(x4, y4, 3);
y4_hat = eval_poly(c4, x4);
if max(abs(y4_hat - y4)) < 1e-4 then
    disp('  PASS  A4: poly_fit + eval_poly round-trip (cubic)');
    passed = passed + 1;
else
    mprintf('  FAIL  A4: max round-trip error = %.6f\n', max(abs(y4_hat - y4)));
    failed = failed + 1;
end

// ---- Test A5: eval_poly handles scalar query ----
c5  = [1; 2; 1];   // 1 + 2x + x^2 = (x+1)^2
y5  = eval_poly(c5, 3);   // (3+1)^2 = 16
if abs(y5 - 16) < tol then
    disp('  PASS  A5: eval_poly works on scalar input');
    passed = passed + 1;
else
    mprintf('  FAIL  A5: expected 16, got %.6f\n', y5);
    failed = failed + 1;
end

mprintf('\n  Results: %d passed, %d failed\n', passed, failed);
