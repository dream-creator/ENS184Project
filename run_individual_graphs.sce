// run_individual_graphs.sce - Generates 4 individual PNGs
funcprot(0);
disp('=== Initializing All Modules ===');

// Dynamically get the current directory of this script
base_dir = get_absolute_file_path('run_individual_graphs.sce');

// Load all modules using cross-platform paths
exec(fullfile(base_dir, 'phm_project', 'data_loader', 'load_data.sci'), -1);
exec(fullfile(base_dir, 'phm_project', 'interpolation', 'interpolation.sci'), -1);
exec(fullfile(base_dir, 'phm_project', 'differentiation', 'differentiation.sci'), -1);
exec(fullfile(base_dir, 'phm_project', 'integration', 'integration.sci'), -1);
exec(fullfile(base_dir, 'phm_project', 'user_interface', 'health_dashboard.sci'), -1);

THRESHOLD = 9.5;
// Safely locate the CSV data file using fullfile
data_file = fullfile(base_dir, 'pump_health_data.csv');
[pressure, voltage, hours, vibration] = load_data(data_file);

// --- Calculations ---
coeff_poly = poly_fit(voltage, pressure, 3);
press_poly = eval_poly(coeff_poly, voltage);
v_smooth = linspace(min(voltage), max(voltage), 200)';
p_smooth = eval_poly(coeff_poly, v_smooth);
resid_A  = pressure - press_poly;

[a_exp, b_exp] = linearize_vib(hours, vibration);
vib_exp        = predict_vibration(a_exp, b_exp, hours);

h_star = find_threshold_hour(hours, vib_exp, THRESHOLD);
HI = compute_health_index(vibration, THRESHOLD);
n = length(hours);
h_known = ~isinf(h_star) & ~isnan(h_star);

disp('=== Generating Individual Graphs ===');

// --- Graph 1: Calibration ---
fig1 = scf(1); clf(); fig1.figure_size = [800, 600];
scatter(voltage, pressure, 18, [0.15 0.40 0.75]);
plot(v_smooth, p_smooth, 'r-');
xlabel('Sensor Voltage (mV)'); ylabel('Differential Pressure (bar)');
title('[Student A]  Pressure-Voltage Calibration');
legend(['Measured data'; 'Cubic fit (k=3)'], 4);
xgrid(1);
xs2png(fig1, 'graph_1_calibration.png');
disp('Saved: graph_1_calibration.png');

// --- Graph 2: Residuals ---
fig2 = scf(2); clf(); fig2.figure_size = [800, 600];
scatter(voltage, resid_A, 18, [0.15 0.40 0.75]);
plot([min(voltage), max(voltage)], [0, 0], 'k-');
xlabel('Sensor Voltage (mV)'); ylabel('Residual (bar)');
title('[Student A]  Calibration Residuals');
xgrid(1);
xs2png(fig2, 'graph_2_residuals.png');
disp('Saved: graph_2_residuals.png');

// --- Graph 3: Degradation ---
fig3 = scf(3); clf(); fig3.figure_size = [800, 600];
scatter(hours, vibration, 18, [1.0 0.55 0.15]);
plot(hours, vib_exp, 'g-');
plot(hours, THRESHOLD .* ones(n, 1), 'k--');
if h_known then plot([h_star, h_star], [0, THRESHOLD * 1.35], 'm-.'); end
xlabel('Operational Hours (h)'); ylabel('Vibration (mm/s rms)');
title('[Student B]  Vibration Degradation Model');
if h_known then legend(['Measured vibration'; 'Exponential fit'; 'Failure threshold'; 'Predicted failure h*'], 4);
else legend(['Measured vibration'; 'Exponential fit'; 'Failure threshold'], 4); end
xgrid(1);
xs2png(fig3, 'graph_3_degradation.png');
disp('Saved: graph_3_degradation.png