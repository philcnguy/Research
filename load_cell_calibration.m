% close all

load('data_11_12_24.mat')
load('load_cell_calibration_data.mat')

% calibration_data =[10 mean(mass_10g.signals.values);
%     20 mean(mass_20g.signals.values);
%     30 mean(mass_30g.signals.values);
%     40 mean(mass_40g.signals.values);
%     50 mean(mass_50g.signals.values);
%     60 mean(mass_60g.signals.values);
%     70 mean(mass_70g.signals.values);
%     0 mean(mass_0g.signals.values);
%     3.19 mean(mass_3_19g.signals.values);
%     6.37 mean(mass_6_37g.signals.values);
%     9.56 mean(mass_9_56g.signals.values);
%     2.13 mean(mass_2_13g.signals.values);
%     10 mean(mass_10g_2.signals.values);
%     10 mean(mass_10g_3.signals.values)];

calibration_data = [0 mean(mass_0g.signals.values);
    19.7 mean(mass_19_7g.signals.values);
    29.7 mean(mass_29_7g.signals.values);
    39.7 mean(mass_39_7g.signals.values);
    49.7 mean(mass_49_7g.signals.values);
    59.7 mean(mass_59_7g.signals.values);
    69.7 mean(mass_69_7g.signals.values);
    79.7 mean(mass_79_7g.signals.values);
    89.7 mean(mass_89_7g.signals.values);];

figure(11)
scatter(calibration_data(:,1), calibration_data(:,2));

coefficients = polyfit(calibration_data(:,1), calibration_data(:,2), 1);

xFit = linspace(0, 100, 50);
yFit = polyval(coefficients, xFit);
hold on
plot(xFit, yFit);

xlabel("Mass (g)");
ylabel("Voltage (V)");

g = 9.81; % m/s^2

x_force = xFit / 1000 * 9.81;
y_adjusted = yFit - mean(mass_0g.signals.values);

figure(12)
plot(x_force, y_adjusted);

xlabel("Force (N)");
ylabel("Voltage Difference (V)");