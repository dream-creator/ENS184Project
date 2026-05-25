funcprot(0);

base_dir  = get_absolute_file_path('diagnostic.sce');
data_file = fullfile(base_dir, '..', 'pump_health_data.csv');

exec(fullfile(base_dir, 'data_loader',    'load_data.sci'),       -1);
exec(fullfile(base_dir, 'interpolation',  'interpolation.sci'),   -1);
exec(fullfile(base_dir, 'differentiation','differentiation.sci'), -1);
exec(fullfile(base_dir, 'integration',    'integration.sci'),     -1);
exec(fullfile(base_dir, 'user_interface', 'health_dashboard.sci'),-1);

THRESHOLD = 9.5;

[pressure, voltage, hours, vibration] = load_data(data_file);
coeff_poly = poly_fit(voltage, pressure, 3);
press_poly = eval_poly(coeff_poly, voltage);
[a_exp, b_exp] = linearize_vib(hours, vibration);
vib_exp        = predict_vibration(a_exp, b_exp, hours);
[rmse_A, r2_A] = goodness_of_fit(pressure, press_poly);
[rmse_B, r2_B] = goodness_of_fit(vibration, vib_exp);
h_star         = find_threshold_hour(hours, vib_exp, THRESHOLD);
HI             = compute_health_index(vibration, THRESHOLD);

n       = length(hours);
h_known = ~isinf(h_star) & ~isnan(h_star);

v_smooth = linspace(min(voltage), max(voltage), 200)';
p_smooth = eval_poly(coeff_poly, v_smooth);
resid_A  = pressure - press_poly;

fig2 = scf(20); clf();
fig2.figure_size = [1100, 820];
fig2.figure_name = 'FlowGuard 5000 -- Pump Health Diagnostic';

// Panel 1 — Student A: Pressure-Voltage Calibration
subplot(2, 2, 1);
scatter(voltage, pressure, 18, [0.15 0.40 0.75]);
plot(v_smooth, p_smooth, 'r-');
xlabel('Sensor Voltage (mV)');
ylabel('Differential Pressure (bar)');
title('[Student A]  Pressure-Voltage Calibration');
legend(['Measured data'; 'Cubic fit (k=3)'], 4);
xgrid(1);

// Panel 2 — Student A: Calibration Residuals
subplot(2, 2, 2);
scatter(voltage, resid_A, 18, [0.15 0.40 0.75]);
plot([min(voltage), max(voltage)], [0, 0], 'k-');
xlabel('Sensor Voltage (mV)');
ylabel('Residual (bar)');
title('[Student A]  Calibration Residuals');
xgrid(1);

// Panel 3 — Student B: Vibration Degradation
subplot(2, 2, 3);
scatter(hours, vibration, 18, [1.0 0.55 0.15]);
plot(hours, vib_exp,                  'g-');
plot(hours, THRESHOLD .* ones(n, 1), 'k--');
if h_known then
    plot([h_star, h_star], [0, THRESHOLD * 1.35], 'm-.');
end
xlabel('Operational Hours (h)');
ylabel('Vibration (mm/s rms)');
title('[Student B]  Vibration Degradation Model');
if h_known then
    legend(['Measured vibration'; 'Exponential fit'; 'Failure threshold'; 'Predicted failure h*'], 4);
else
    legend(['Measured vibration'; 'Exponential fit'; 'Failure threshold'], 4);
end
xgrid(1);

// Panel 4 — Students C+D: Health Index
subplot(2, 2, 4);
plot(hours, 0.75 .* ones(n, 1), 'g--');
plot(hours, 0.90 .* ones(n, 1), 'y--');
plot(hours, ones(n, 1),         'r--');
plot(hours, HI,                 'b-');
if h_known then
    plot([h_star, h_star], [0, 1.05], 'm-.');
end
xlabel('Operational Hours (h)');
ylabel('Health Index (HI)');
title('[Students C+D]  Health Index and Failure Prediction');
if h_known then
    legend(['GOOD/WARN (0.75)'; 'WARN/CRIT (0.90)'; 'Failure (1.0)'; 'Health Index'; 'Predicted h*'], 2);
else
    legend(['GOOD/WARN (0.75)'; 'WARN/CRIT (0.90)'; 'Failure (1.0)'; 'Health Index'], 2);
end
xgrid(1);

xs2png(fig2, 'pump_health_diagnostic_v2.png');
disp('Saved: pump_health_diagnostic_v2.png');
