funcprot(0);

function [a, b] = linearize_vib(hours, vibration)
    if length(hours) ~= length(vibration) then
        error("linearize_vib: hours and vibration must have the same length.");
    end
    valid_idx = find(vibration > 0);
    if length(valid_idx) < 2 then
        error("linearize_vib: need at least 2 positive vibration samples.");
    end
    h = hours(valid_idx)(:);
    v = vibration(valid_idx)(:);
    n = length(h);
    w = log(v);
    Z = [ones(n, 1), h];
    c = (Z'  * Z) \ (Z' * w);
    a = exp(c(1));
    b = c(2);
endfunction

function [vib_query] = predict_vibration(a, b, h_query)
    vib_query = a .* exp(b .* h_query);
endfunction
