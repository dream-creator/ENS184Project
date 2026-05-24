// ============================================================
// interpolation.sci  —  Student A Skeleton
// Polynomial Calibration Fit: Pressure vs Voltage
// ============================================================

funcprot(0);   // suppress redefinition warnings when re-running

// ------------------------------------------------------------
// Function 1: poly_fit
// Input:  x (n), y (n), k (degree)
// Output: coeff [c0; c1; ...; ck]
// ------------------------------------------------------------
function [coeff] = poly_fit(x, y, k)

    if length(x) ~= length(y) then
        error('poly_fit: x and y must have the same length.');
    end
    n = length(x);
    if k < 1 | k > n - 1 then
        error('poly_fit: polynomial degree k must satisfy 1 <= k <= n-1.');
    end

    // Force column vectors
    x = x(:);
    y = y(:);

    // Build Z (n x k+1) design matrix: column j holds x.^(j-1), for j = 1 to k+1
    Z = zeros(n, k + 1);
    for j = 1:(k + 1)
        Z(:, j) = x .^ (j - 1);
    end

    // Normal Equations: coeff = (Z'*Z) \ (Z'*y)
    coeff = (Z' * Z) \ (Z' * y);

endfunction


// ------------------------------------------------------------
// Function 2: eval_poly
// Input:  coeff (k+1), x_query (scalar or vector)
// Output: y_query (same size as x_query)
// ------------------------------------------------------------
function [y_query] = eval_poly(coeff, x_query)

    coeff = coeff(:);
    x_query = x_query(:);
    n_q = length(x_query);
    y_query = zeros(n_q, 1);
    k = length(coeff) - 1;

    // Horner's method to evaluate the polynomial
    for j = 1:n_q
        xq = x_query(j);
        val = coeff(k+1);
        for i = k:-1:1
            val = coeff(i) + val * xq;
        end
        y_query(j) = val;
    end

endfunction
