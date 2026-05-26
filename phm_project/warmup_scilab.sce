// ============================================================
//  warmup_scilab.sce
//  ENS 184 Mini-Project  |  Scilab Warm-Up Tutorial
//
//  PURPOSE
//  Run this script BEFORE starting your project skeleton file.
//  It demonstrates every Scilab idiom you will need, using simple
//  toy examples unrelated to pump data.  Read each section, predict
//  the output in your head, then check the console to confirm.
//
//  HOW TO RUN
//    exec('warmup_scilab.sce', -1);
//
//  EXPECTED RESULT
//  Ten labelled sections print to the console, each ending with
//  "OK".  If you see an error, something is wrong with your Scilab
//  installation or your working directory.
// ============================================================

funcprot(0);   // suppress function-redefinition warnings

// ============================================================
//  PART 1:  Variables and basic arithmetic
// ============================================================
disp('=== PART 1: Variables and basic arithmetic ===');
a = 3;
b = 4;
disp(a + b);           // expected: 7
disp(a * b);           // expected: 12
disp(a ^ 2);           // expected: 9   (scalar power)
disp(sqrt(a^2 + b^2)); // expected: 5   (Pythagorean hypotenuse)
disp('PART 1  OK');

// ============================================================
//  PART 2:  Column vectors  (the most important data type)
// ============================================================
disp('=== PART 2: Column vectors ===');
v = [10; 20; 30; 40; 50];   // semicolons create ROWS -> column vector
disp(size(v));               // expected: 5  1
disp(length(v));             // expected: 5
disp(v(1));                  // expected: 10  (1-based indexing!)
disp(v($));                  // expected: 50  ($ = last element)
disp(v(2:4));                // expected: [20; 30; 40]

// The single most useful habit: force any vector to a column.
v = v(:);                    // does nothing here, but protects against row vectors
disp('PART 2  OK');

// ============================================================
//  PART 3:  Element-wise operators  (.* and .^)
// ============================================================
disp('=== PART 3: Element-wise operators ===');
x = [1; 2; 3; 4];
y = [10; 20; 30; 40];

// NOTE: * is matrix multiply.  .* is element-wise multiply.
//       Do NOT confuse them --- it is the most common Scilab mistake.
disp(x .* y);          // expected: [10; 40; 90; 160]
disp(x .^ 2);          // expected: [1; 4; 9; 16]
disp(y ./ x);          // expected: [10; 10; 10; 10]
disp('PART 3  OK');

// ============================================================
//  PART 4:  Solving a linear system with the backslash operator
// ============================================================
disp('=== PART 4: Backslash operator (your main tool!) ===');

// Solve the 2x2 system:   3*c1 +   c2 = 7
//                            c1 + 2*c2 = 4
// Solution: c1 = 2, c2 = 1
A   = [3, 1; 1, 2];
rhs = [7; 4];
sol = A \ rhs;          // NEVER use inv(A)*rhs
disp(sol);              // expected: [2; 1]
disp(A * sol - rhs);    // expected: [0; 0]  (verify the solution)
disp('PART 4  OK');

// ============================================================
//  PART 5:  Building a design matrix and solving least-squares
// ============================================================
disp('=== PART 5: Design matrix and Normal Equations ===');

// Fit a degree-2 polynomial to 5 noisy data points.
// True model: y = 1 + 0*x + 1*x^2  (i.e., c0=1, c1=0, c2=1)
t      = [0; 1; 2; 3; 4];
y_true = 1 + 0*t + 1*t.^2;               // [1; 2; 5; 10; 17]
y_data = y_true + [0.1; -0.2; 0.15; -0.1; 0.05];  // add small noise

k = 2;                                    // polynomial degree
n = length(t);

// Build design matrix Z  (n rows, k+1 columns)
// Column j contains t raised to the power (j-1).
Z = zeros(n, k+1);
for j = 1:k+1
    Z(:, j) = t .^ (j-1);
end
disp('Design matrix Z:');
disp(Z);
// expected: [1 0 0; 1 1 1; 1 2 4; 1 3 9; 1 4 16]

// Solve the Normal Equations via backslash:
c = (Z' * Z) \ (Z' * y_data);
disp('Fitted coefficients c = [c0; c1; c2]:');
disp(c);
// expected: approximately [1; 0; 1]  (with small noise-induced deviations)

// Evaluate residuals:
y_fit = Z * c;
rmse  = sqrt(mean((y_data - y_fit).^2));
mprintf('  RMSE of fit = %.4f\n', rmse);  // expected: small number (< 0.2)
disp('PART 5  OK');

// ============================================================
//  PART 6:  log and exp  (needed for exponential regression)
// ============================================================
disp('=== PART 6: log and exp ===');

// Simulate exponential degradation: vib = 0.5 * exp(0.002 * h)
h   = [100; 500; 1000; 2000; 3000];
vib = 0.5 .* exp(0.002 .* h);     // true exponential model
disp(vib);

// Linearise: w = ln(vib)  =>  w = ln(0.5) + 0.002 * h
w = log(vib);     // log() is the NATURAL logarithm in Scilab
disp(w);
// Verify round-trip:
disp(exp(w) - vib);   // expected: all zeros (within floating-point precision)
disp('PART 6  OK');

// ============================================================
//  PART 7:  Loops and Horner's method
// ============================================================
disp('=== PART 7: Loops and Horner''s method ===');

// Evaluate p(x) = 1 + 2*x + 3*x^2  at x = 2  (answer = 1+4+12 = 17)
coeff  = [1; 2; 3];   // [c0; c1; c2] --- constant term FIRST
x_val  = 2;

// Naive method (for comparison):
p_naive = 0;
for j = 1:length(coeff)
    p_naive = p_naive + coeff(j) * x_val^(j-1);
end
mprintf('  Naive result = %.1f  (expected 17)\n', p_naive);

// Horner's method (same result, fewer multiplications):
result = coeff(length(coeff));               // start at HIGHEST-degree coeff
for j = length(coeff)-1 : -1 : 1            // loop DOWNWARD to c0
    result = coeff(j) + x_val * result;
end
mprintf('  Horner result = %.1f  (expected 17)\n', result);
disp('PART 7  OK');

// ============================================================
//  PART 8:  Handling special values and conditional logic
// ============================================================
disp('=== PART 8: Special values and conditionals ===');

h_star = %inf;   // %inf is Scilab's infinity (not Inf or math.inf)

if isinf(h_star)
    disp('  h_star is infinite: no threshold crossing in data range.');
else
    mprintf('  Predicted failure at h* = %.1f hours\n', h_star);
end

// isinf and isnan work element-wise on vectors:
v = [1; %inf; -3; %nan; 0];
disp(isinf(v));   // [%f; %t; %f; %f; %f]
disp(isnan(v));   // [%f; %f; %f; %t; %f]

// Scilab does not have any() in all versions.  Use sum() instead:
if sum(v < 0) > 0
    disp('  v contains at least one negative value.');
end
disp('PART 8  OK');

// ============================================================
//  PART 9:  Reading a CSV file (simplified)
// ============================================================
disp('=== PART 9: Reading CSV data ===');

// We simulate what load_data() does with the real file.
// read_csv() returns a MATRIX OF STRINGS, not numbers.
// You must use evstr() to convert to numeric.
// (We skip the actual file read here since the path depends on your setup.)

example_strings = ['1.5', '3.2'; '2.1', '4.7'; '3.0', '5.9'];
numeric_data    = evstr(example_strings);   // convert strings to numbers
disp(numeric_data);
// expected: [1.5 3.2; 2.1 4.7; 3.0 5.9]  as doubles

// The real call looks like:
//   raw  = read_csv(fname, ',');
//   data = evstr(raw(2:$, :));   // skip row 1 (the header line)
disp('PART 9  OK');

// ============================================================
//  PART 10:  A simple plot
// ============================================================
disp('=== PART 10: Plotting ===');

h_plot   = linspace(0, 5000, 200)';        // column vector of hours
vib_plot = 0.5 .* exp(0.0008 .* h_plot);  // exponential model
thresh   = 4.5;                            // failure threshold

fig = scf(99); clf();                      // open figure 99, clear it
plot(h_plot, vib_plot, 'b-');             // blue solid line
plot(h_plot, thresh * ones(length(h_plot), 1), 'r--');  // red dashed threshold
xgrid();
xlabel('Operational hours (h)');
ylabel('Vibration (mm/s)');
title('Warm-up: sample exponential degradation');
legend(['Model: v = 0.5 exp(0.0008 h)'; 'Threshold'], 4);

disp('  Figure displayed in Scilab graphics window 99.');
disp('  Close it when done --- it does not auto-close.');
disp('PART 10  OK');

// ============================================================
disp('');
disp('=================================================');
disp('  Warm-up complete. All 10 parts passed.');
disp('  You are ready to start your project file!');
disp('=================================================');
