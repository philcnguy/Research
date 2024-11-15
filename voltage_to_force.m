load('data_11_13_24.mat')

close all

figure(1)
hold on
plot(tout, whole_wing_12v_11_13_24.signals.values, 'DisplayName', 'Data');
plot(tout, no_flapping_11_13_24.signals.values, 'DisplayName', 'At rest');
plot(tout, mass_0g_11_13_24.signals.values, 'DisplayName', 'No mass');

legend
xlabel("Time (s)");
ylabel("Voltage (V)");
title("Raw Data");

calibration_data = [0 mean(mass_0g_11_13_24.signals.values);
    19.7 mean(mass_19_7g_11_13_24.signals.values);
    29.7 mean(mass_29_7g_11_13_24.signals.values);
    39.7 mean(mass_39_7g_11_13_24.signals.values);
    49.7 mean(mass_49_7g_11_13_24.signals.values);
    59.7 mean(mass_59_7g_11_13_24.signals.values);
    69.7 mean(mass_69_7g_11_13_24.signals.values);
    79.7 mean(mass_79_7g_11_13_24.signals.values);
    89.7 mean(mass_89_7g_11_13_24.signals.values);];

figure(2)
scatter(calibration_data(:,1), calibration_data(:,2));

coefficients = polyfit(calibration_data(:,1), calibration_data(:,2), 1);

xFit = linspace(0, 100, 50);
yFit = polyval(coefficients , xFit);
hold on
plot(xFit, yFit);

xlabel("Mass (g)");
ylabel("Voltage (V)");

g = 9.81; % m/s^2
volt_no_mass = mean(mass_0g_11_13_24.signals.values);

x_force = xFit / 1000 * 9.81;
y_adjusted = yFit - volt_no_mass;
figure(3)
plot(x_force, y_adjusted);

xlabel("Force (N)");
ylabel("Voltage Difference (V)");

figure(4)
hold on
plot(tout, whole_wing_12v_11_13_24.signals.values - volt_no_mass, 'DisplayName', 'Data');
plot(tout, no_flapping_11_13_24.signals.values - volt_no_mass, 'DisplayName', 'At rest');
plot(tout, mass_0g_11_13_24.signals.values - volt_no_mass, 'DisplayName', 'No mass');

legend
xlabel("Time (s)");
ylabel("Calibrated Voltage (V)");
title("Calibrated Data");

b = y_adjusted(1);
m = -1 * coefficients(1) * 1000 / 9.81;

figure(5)
hold on
plot(tout, (whole_wing_12v_11_13_24.signals.values - volt_no_mass - b) / m, 'DisplayName', 'Data');
plot(tout, (no_flapping_11_13_24.signals.values - volt_no_mass - b) / m, 'DisplayName', 'At rest');
plot(tout, (mass_0g_11_13_24.signals.values - volt_no_mass - b) / m, 'DisplayName', 'No mass');

legend
xlabel("Time (s)");
ylabel("Net Force on Load Cell (N)");
title("Force on Load Cell Over Time");

sine_input = 0.7 * sin(19.5 * 2 * pi * tout);

figure(6)
hold on
plot(tout, sine_input, 'DisplayName', 'Sine Input');
plot(tout, (whole_wing_12v_11_13_24.signals.values - volt_no_mass - b) / m, 'DisplayName', 'Data');

legend
xlabel("Time (s)");
title("Sine Input and Force");